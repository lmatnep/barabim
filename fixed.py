import tkinter as tk
from tkinter import filedialog, ttk, messagebox
import os
import re
import shutil

# Define your renaming patterns in a dictionary with longer patterns first
renaming_patterns = {
"p7": "Mat. Graduação P7",
"p7ead": "Mat. Graduação EAD P7",
"p7semi": "Mat. de Semipresencial P7",
"p7semiflex": "Mat. de Semipresencial Flex P7",
"ortecnicoead": "O.R - Ensino Técnico EAD",
"FATURAMENTODEMATRICULATÉCNICOEAD": "Mat. de Ensino Técnico EAD",
"FATURAMENTODEMATRICULATÉCNICO": "Mat. de Ensino Técnico",
"FATURAMENTODEMATRICULAMESTRADO": "Mat. de Mestrado",
"FATURAMENTODEMATRICULADOUTORADO": "Mat. de Doutorado",
"FATURAMENTODEMATRICULAGRADUAÇÃO": "Mat. Graduação P1",
"FATURAMENTODEMENSALIDADESTÉCNICO*": "Mens. de Ensino Técnico",
"FATURAMENTODEMENSALIDADESMESTRADO": "Mens. de Mestrado",
"FATURAMENTODEMENSALIDADESDOUTORADO": "Mens. de Doutorado",
"FATURAMENTODEMATRICULAEADGRADUAÇÃO": "Mat. Graduação EAD P1",
"FATURAMENTODEMATRICULAPÓSGRADUAÇÃO": "Mat. de Pós-Graduação",
"FATURAMENTODEMENSALIDADESGRADUAÇÃO": "Mens. de Graduação",
"FATURAMENTODEMENSALIDADESTÉCNICOEAD": "Mens. de Ensino Técnico EAD",
"FATURAMENTODEMATRICULASEMIPRESENCIAL": "Mat. de Semipresencial P1",
"FATURAMENTODEMENSALIDADESEADGRADUAÇÃO": "Mens. de Graduação EAD",
"FATURAMENTODEMENSALIDADESPÓSGRADUAÇÃO": "Mens. de Pós-Graduação",
"FATURAMENTODEMATRICULAEADPÓSGRADUAÇÃO": "Mat. de Pós-Graduação EAD",
"FATURAMENTO DE OUTRAS RECEITAS TÉCNICO": "O.R - Ensino Técnico",
"FATURAMENTO DE OUTRAS RECEITAS MESTRADO": "O.R - Mestrado",
"FATURAMENTODEMENSALIDADESSEMIPRESENCIAL": "Mens. de Semipresencial",
"FATURAMENTODEMATRICULAPOSGRADUACAOREMOTA": "Mat. de Pós-Graduação Remota",
"FATURAMENTODEMATRICULASEMIPRESENCIALFLEX": "Mat. de Semipresencial Flex P1",
"FATURAMENTO DE OUTRAS RECEITAS GRADUAÇÃO": "O.R - Graduação",
"FATURAMENTODEMENSALIDADESEADPOSGRADUAÇÃO": "Mens. de Pós-Graduação EAD",
"FATURAMENTO DE OUTRAS RECEITAS DOUTORADO": "O.R - Doutorado",
"FATURAMENTODEMENSALIDADESPOSGRADUACAOREMOTA": "Mens. de Pós-Graduação Remota",
"FATURAMENTODEMENSALIDADESSEMIPRESENCIALFLEX": "Mens. de Semipresencial Flex",
"FATURAMENTO DE OUTRAS RECEITAS POS GRADUACAO": "O.R - Pós-Graduação",
"FATURAMENTO DE OUTRAS RECEITAS EAD GRADUAÇÃO": "O.R - Graduação EAD",
"FATURAMENTO DE OUTRAS RECEITAS SEMIPRESENCIAL": "O.R - Semipresencial",
"FATURAMENTODEOUTRASRECEITASSEMIPRESENCIALFLEX": "O.R - Semipresencial Flex",
"FATURAMENTODEOUTRASRECEITASPOSGRADUACAOREMOTA": "O.R - Pós-Graduação Remota",
"FATURAMENTODEMENSALIDADESFORMAÇÃOPROFISSIONAL": "Mens. de Form. Prof",
"FATURAMENTODEMATRÍCULAPÓSGRADUAÇÃOSEMIPRESENCIAL": "Mat. de Pós-Semi",
"FATURAMENTO DE OUTRAS RECEITAS EAD PÓS GRADUAÇÃO": "O.R - Pós-Graduação EAD",
"FATURAMENTODEMENSALIDADESPÓSGRADUAÇÃOSEMIPRESENCIAL": "Mens. de Pós-Semi",
"FATURAMENTO DE OUTRAS RECEITAS FORMAÇÃO PROFISSIONAL": "O.R - Form. Prof.",
"FATURAMENTODEOUTRASRECEITASPÓSCONVÊNIOPORDATADEBAIXA": "Mens. de Pós-Convênio"

}


file_types = {
    'Mat. de Doutorado',
    'Mat. de Ensino Técnico EAD',
    'Mat. de Ensino Técnico',
    'Mat. de Mestrado',
    'Mat. de Pós-Graduação EAD',
    'Mat. de Pós-Graduação Remota',
    'Mat. de Pós-Graduação',
    'Mat. de Pós-Semi',
    'Mat. de Semipresencial Flex P1',
    'Mat. de Semipresencial Flex P7',
    'Mat. de Semipresencial P1',
    'Mat. de Semipresencial P7',
    'Mat. Graduação EAD P1',
    'Mat. Graduação EAD P7',
    'Mat. Graduação P1',
    'Mat. Graduação P7',
    'Mens. de Doutorado',
    'Mens. de Ensino Técnico EAD',
    'Mens. de Ensino Técnico',
    'Mens. de Form. Prof.',
    'Mens. de Mestrado',
    'Mens. de Pós-Convênio',
    'Mens. de Pós-Graduação EAD',
    'Mens. de Pós-Graduação Remota',
    'Mens. de Pós-Graduação',
    'Mens. de Pós-Semi',
    'Mens. de Semipresencial Flex',
    'Mens. de Semipresencial',
    'Mens. de Graduação EAD',
    'Mens. de Graduação',
    'O.R - Doutorado',
    'O.R - Ensino Técnico EAD',
    'O.R - Ensino Técnico',
    'O.R - Form. Prof.',
    'O.R - Graduação EAD',
    'O.R - Graduação',
    'O.R - Mestrado',
    'O.R - Pós-Graduação EAD',
    'O.R - Pós-Graduação Remota',
    'O.R - Pós-Graduação',
    'O.R - Semipresencial Flex',
    'O.R - Semipresencial',
    'RECEITAS DE CLÍNICA'
}


def select_folder():
    folder_path = filedialog.askdirectory()
    folder_path_var.set(folder_path)

def select_split_folder():
    split_folder_path = filedialog.askdirectory()
    split_folder_path_var.set(split_folder_path)

def update_progress_bar(value, max_value):
    progress_bar["value"] = value
    progress_bar["maximum"] = max_value
    root.update_idletasks()

def show_confirmation_dialog():
    messagebox.showinfo("Sucesso!", "Deu tudo certo, aparentemente.")
    reset_progress_bar()

def reset_progress_bar():
    progress_bar["value"] = 0
    progress_bar["maximum"] = 100
    progress_frame.pack_forget()

def show_progress_bar():
    progress_frame.pack()
    progress_bar["value"] = 0
    progress_bar["maximum"] = 100

def validate_rename_paths():
    main_folder = folder_path_var.get()

    if not main_folder:
        messagebox.showerror("Erro", "Tá faltando o caminho pra pasta principal, bença")
        return False

    return True

def validate_split_paths():
    main_folder = folder_path_var.get()
    split_folder = split_folder_path_var.get()

    if not main_folder:
        messagebox.showerror("Erro", "Tá faltando o caminho pra pasta principal, bença")
        return False
    elif not split_folder:
        messagebox.showerror("Erro", "Tá faltando o caminho pra pasta de destino, bença")
        return False

    return True

def rename_files(main_folder, patterns):
    show_progress_bar()  # Show the progress bar at the start of the process

    total_files = sum(len(files) for _, _, files in os.walk(main_folder))
    processed_files = 0

    # Iterate through subfolders and rename files
    for root, _, files in os.walk(main_folder):
        for file_name in files:
            base_name, extension = os.path.splitext(file_name)

            # Extract the part of the base name before any dash or underscore
            base_name_prefix = re.split(r'[-_]', base_name)[0]

            for pattern, replacement in patterns.items():
                # Modify the pattern to match the extracted prefix
                if re.fullmatch(pattern, base_name_prefix):
                    # Create the new file name
                    new_base_name = f"{os.path.basename(root)} - {replacement}"
                    new_file_name = f"{new_base_name}{extension}"

                    # Check if the new filename already exists in the subfolder
                    new_path = os.path.join(root, new_file_name)
                    if not os.path.exists(new_path):
                        # Rename the file inside its subfolder
                        old_path = os.path.join(root, file_name)
                        os.rename(old_path, new_path)

                    processed_files += 1
                    update_progress_bar(processed_files, total_files)

    show_confirmation_dialog()



def move_files():
    if not validate_split_paths():
        return

    show_progress_bar()  # Show the progress bar at the start of the process
    main_folder = folder_path_var.get()
    destination_folder = split_folder_path_var.get()

    total_files = sum(len(files) for _, _, files in os.walk(main_folder))
    processed_files = 0

    # Sort file_types by length in descending order
    file_types.sort(key=lambda x: len(x), reverse=True)

    # Iterate through subfolders inside the main folder
    for root_folder, _, files in os.walk(main_folder):
        for file_name in files:
            for file_type in file_types:
                # Check if the file type is in the file name
                if file_type in file_name:
                    # Create a subfolder for the file type if it doesn't exist
                    pattern_folder_name = file_type
                    destination_folder_path = os.path.join(destination_folder, pattern_folder_name)

                    # Ensure that the destination folder exists
                    os.makedirs(destination_folder_path, exist_ok=True)

                    source_file = os.path.join(root_folder, file_name)
                    destination_file = os.path.join(destination_folder_path, file_name)

                    if os.path.exists(source_file):
                        try:
                            shutil.move(source_file, destination_file)
                        except Exception as e:
                            # Handle any exceptions that may occur during move
                            pass  # Do nothing, move failed
                    else:
                        # File doesn't exist, so no need to move
                        pass

                    processed_files += 1
                    update_progress_bar(processed_files, total_files)

    show_confirmation_dialog()




# Create the main GUI window
root = tk.Tk()
root.title("Renomear & Separar")

# Set the size of the GUI window (width x height)
root.geometry("340x340")  # Adjust the width and height as needed

# Create and configure GUI elements
folder_path_var = tk.StringVar()
folder_label = tk.Label(root, text="Pasta principal:")
folder_label.pack(pady=2)
folder_entry = tk.Entry(root, textvariable=folder_path_var, width=50)
folder_entry.pack(pady=2)
folder_button = tk.Button(root, text="Encontrar", command=select_folder)
folder_button.pack(pady=2)
folder_button.config(width=10, height=1)

tk.Label(root, text="").pack()

split_folder_path_var = tk.StringVar()
split_folder_label = tk.Label(root, text="Pasta destino:")
split_folder_label.pack(pady=2)
split_folder_entry = tk.Entry(root, textvariable=split_folder_path_var, width=50)
split_folder_entry.pack(pady=2)
split_folder_button = tk.Button(root, text="Encontrar", command=select_split_folder)
split_folder_button.pack(pady=2)
split_folder_button.config(width=10, height=1)



rename_button = tk.Button(root, text="Renomear", command=lambda: rename_files(folder_path_var.get(), renaming_patterns))
rename_button.pack(pady=3)
rename_button.config(width=20, height=2)

file_types = list(renaming_patterns.values())

split_button = tk.Button(root, text="Separar", command=move_files)
split_button.pack(pady=3)
split_button.config(width=20, height=2)

progress_frame = ttk.Frame(root)

progress_bar = ttk.Progressbar(progress_frame, orient="horizontal", length=320, mode="determinate")
progress_bar.pack(pady=10)

version_label = tk.Label(root, text="2.2.0", foreground="gray", padx=5, pady=2)
version_label.pack(side="bottom", anchor="se")

# Start the GUI main loop
root.mainloop()