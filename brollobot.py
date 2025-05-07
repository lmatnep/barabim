import os
import openpyxl
import tkinter as tk
from tkinter import filedialog, messagebox, ttk
from datetime import datetime
import threading
import time

def replace_value(line, key, new_value):
    if f"{key}=" in line:
        parts = line.split(f"{key}=")
        formatted_value = f"{float(new_value):.2f}"
        parts[1] = f"{formatted_value}|" + "|".join(parts[1].split("|")[1:])
        return f"{key}=".join(parts)
    return line

def process_files(txt_file_path, excel_file_path, progress_bar, status_label):
    try:
        # Load Excel
        wb = openpyxl.load_workbook(excel_file_path)
        sheet = wb.active

        data_map = {}
        for row in sheet.iter_rows(min_row=2, values_only=True):
            num_rps = str(row[0])
            valor_para = str(row[1])
            valor_iss = str(row[2])
            data_map[num_rps] = {"ValorPARA": valor_para, "ValorISS": valor_iss}

        with open(txt_file_path, "r", encoding="utf-8") as file:
            lines = file.readlines()

        total_lines = len(lines)
        output_lines = []
        i = 0
        step = 100 / total_lines if total_lines else 1

        while i < total_lines:
            line = lines[i]
            if "numeroRps=" in line:
                num_rps_full = line.split("=")[1].split("|")[0]
                matching_key = next((key for key in data_map if key in num_rps_full), None)
                if matching_key:
                    if i + 16 < total_lines:
                        lines[i + 16] = replace_value(lines[i + 16], "baseCalculo", data_map[matching_key]["ValorPARA"])
                    if i + 17 < total_lines:
                        lines[i + 17] = replace_value(lines[i + 17], "valorIss", data_map[matching_key]["ValorISS"])
                    if i + 22 < total_lines:
                        lines[i + 22] = replace_value(lines[i + 22], "valorServicos", data_map[matching_key]["ValorPARA"])
                    if i + 92 < total_lines:
                        lines[i + 92] = replace_value(lines[i + 92], "valorUnitario", data_map[matching_key]["ValorPARA"])
                    if i + 93 < total_lines:
                        lines[i + 93] = replace_value(lines[i + 93], "valorTotal", data_map[matching_key]["ValorPARA"])
            output_lines.append(line)
            i += 1

            # Update progress every 50 lines to keep it responsive and fast
            if i % 50 == 0 or i == total_lines:
                progress_bar["value"] = min(100, (i / total_lines) * 100)
                progress_bar.update_idletasks()


        now = datetime.now()
        timestamp = now.strftime("%Y-%m-%d %H-%M")
        base_dir = os.path.dirname(txt_file_path)
        new_file_name = f"RPS - Correção {timestamp}.txt"
        new_file_path = os.path.join(base_dir, new_file_name)

        with open(new_file_path, "w", encoding="utf-8") as file:
            file.writelines(output_lines)

        progress_bar["value"] = 100
        status_label.config(text="Concluído com sucesso!")

    except Exception as e:
        status_label.config(text="Erro durante o processamento.")
        messagebox.showerror("Erro", str(e))

def run_threaded(txt_path, excel_path, progress_bar, status_label, progress_frame):
    # Reset status and progress
    status_label.config(text="")
    progress_bar["value"] = 0
    progress_frame.pack(pady=10)
    thread = threading.Thread(target=process_files, args=(txt_path.get(), excel_path.get(), progress_bar, status_label))
    thread.start()

def browse_file(entry_widget, filetypes):
    file_path = filedialog.askopenfilename(filetypes=filetypes)
    if file_path:
        entry_widget.delete(0, tk.END)
        entry_widget.insert(0, file_path)

# GUI Setup
root = tk.Tk()
root.title("Brollo Bot")
root.iconbitmap("bbiconwhite.ico")
root.geometry("400x300")

# File selectors
tk.Label(root, text="Arquivo MSAF:").pack(pady=(10, 0))
txt_path = tk.Entry(root, width=60)
txt_path.pack()
tk.Button(root, text="Procurar .txt", command=lambda: browse_file(txt_path, [("Text files", "*.txt")])).pack(pady=5)

tk.Label(root, text="Planilha Correção:").pack(pady=(10, 0))
excel_path = tk.Entry(root, width=60)
excel_path.pack()
tk.Button(root, text="Procurar .xlsx", command=lambda: browse_file(excel_path, [("Excel files", "*.xlsx")])).pack(pady=5)

# Progress frame (initially hidden)
progress_frame = tk.Frame(root)
progress = ttk.Progressbar(progress_frame, orient="horizontal", length=350, mode="determinate")
progress.pack()
status = tk.Label(progress_frame, text="")
status.pack()

# Run button
tk.Button(
    root,
    text="Executar Correção",
    command=lambda: run_threaded(txt_path, excel_path, progress, status, progress_frame),
    bg="#4CAF50", fg="white", padx=10, pady=5
).pack(pady=10)

root.mainloop()
