import threading
import time
import pyautogui
import pyperclip
from pynput import keyboard
from pystray import Icon, MenuItem, Menu
from PIL import Image, ImageDraw
import sys
import os


# Trigger phrases and completions
triggers = {

"Integralizado": "Plano de pagamento do aluno já consta integralizado, não restam parcelas a serem geradas. Favor seguir.",
"Negociar": "Boleto disponibilizado em tempo hábil para pagamento. Favor tratar diretamente com a negociação financeira.",
"Reajuste anual": "Para ingressantes a partir do semestre letivo de 2021.2, o reajuste anual é previsto em cláusula contratual para os cursos de graduação com duração superior a 18 meses. Caso deseje obter cópias dos contratos educacionais, estes estão publicados no site institucional - no menu acadêmico, na opção de documentos.",
"Boleto": "Boleto disponível no portal do aluno.",
"Verificar": "Favor verificar solicitação do aluno.",
"Valores": "Valores requisitados disponíveis na tabela. Esses valores são válidos para o período, matriz e turno requerido no chamado. Obs: Disciplinas optativas não incorrem em custos ao aluno na primeira vez sendo cursadas.",
"Tradicional": "Discente de modalidade tradicional, cobrado por créditos. Valor das parcelas calculado automaticamente pelo sistema de acordo com as disciplinas matriculadas.",
"Ajustado": "Plano de pagamento devidamente ajustado.",
"Disciplinas": "Favor inserir as disciplinas que deseja consultar os valores.",
"Fora do prazo": "Por ter sido realizada a matrícula fora do prazo, o sistema parcelou automaticamente a mensalidade em três vezes (sem juros, com base no valor do primeiro vencimento), de forma a não lesar o aluno. Cabe ao aluno optar por pagar parcelado ou de uma vez.",
"Sem saldo": "Na modalidade tradicional, cobrado por créditos, o sistema calcula automaticamente o valor das parcelas de acordo com as disciplinas que estão matriculadas no momento da geração. Nesse caso, se é feita alguma alteração nas disciplinas matriculadas, é possível que não restem créditos financeiros suficientes para compor mais parcelas.",

}

buffer = ""
max_trigger_length = max(len(k) for k in triggers)
listener = None
icon = None
running = True


def paste_completion(completion):
    time.sleep(0.05)
    pyperclip.copy(completion)  # Copy the new sentence to the clipboard
    pyautogui.hotkey("ctrl", "a")  # Select all text (Ctrl+A)
    pyautogui.hotkey("ctrl", "v")  # Paste the new sentence (Ctrl+V)



def on_press(key):
    global buffer, running
    if not running:
        return False

    try:
        if hasattr(key, 'char') and key.char is not None:
            buffer += key.char
            buffer = buffer[-max_trigger_length:]  # Limit the buffer size to the longest trigger

            for trigger, completion in triggers.items():
                if buffer.lower().endswith(trigger.lower()):  # Case-insensitive comparison
                    threading.Thread(target=paste_completion, args=(completion,)).start()
                    buffer = ""  # Clear the buffer
                    break

        elif key == keyboard.Key.space or key == keyboard.Key.enter:
            buffer += " "
        elif key == keyboard.Key.backspace:
            buffer = buffer[:-1]

    except Exception as e:
        print("Erro:", e)


import sys
import os
from PIL import Image

def get_icon_path(filename):
    if getattr(sys, 'frozen', False):
        return os.path.join(sys._MEIPASS, filename)
    return os.path.join(os.path.dirname(__file__), filename)

def create_icon_image():
    return Image.open(get_icon_path("fat.png"))  # change to your actual file name



def exit_program(icon_obj, item):
    global running
    running = False
    icon_obj.stop()
    if listener:
        listener.stop()


def run_tray_icon():
    global icon
    menu = Menu(MenuItem('Sair', exit_program))
    icon = Icon("Respostas", create_icon_image(), "Respostas Chamados", menu)
    icon.run()


def main():
    global listener
    # Start keyboard listener
    listener = keyboard.Listener(on_press=on_press)
    listener.start()

    # Start tray icon in main thread
    run_tray_icon()

if __name__ == "__main__":
    main()
