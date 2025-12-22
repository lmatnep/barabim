; --- Diretivas Gerais ---
#SingleInstance Force       ; Evita múltiplas instâncias
#Persistent                 ; Mantém o script ativo mesmo sem hotkeys
#MaxThreadsPerHotkey 1      ; Impede hotkeys duplicadas em paralelo
#HotkeyInterval 2000        ; Intervalo para contagem de hotkeys (ms)
#MaxHotkeysPerInterval 200  ; Permite muitas hotkeys em loops
#WinActivateForce

; --- Ajustes de Velocidade ---
SetBatchLines, -1           ; Executa na velocidade máxima
SendMode Input              ; Modo de envio mais rápido e confiável
SetTitleMatchMode, 2        ; Permite identificar janelas por parte do título

; --- Ajustes de Delay (ajuste conforme o sistema alvo) ---
SetKeyDelay, 50, 50         ; Tempo entre teclas
SetControlDelay, 50         ; Delay em controles
SetMouseDelay, 30           ; Delay entre cliques
SetWinDelay, 100            ; Delay em comandos de janela
SetDefaultMouseSpeed, 0     ; Delay no movimento da seta do mouse


F9::
SoundBeep, 750
Reload
return


#IfWinActive, ahk_class RAIL_WINDOW
^1:: ; Ctrl + 1 - EDUCACIONAL
    SendInput, {F10}         ; Pressiona F10
    Sleep, 100         
    SendInput, a             ; Digita "A"
    Sleep, 100
    SendInput, p             ; Digita "P"
    Sleep, 100
    SendInput, e             ; Digita "E"
    Sleep, 100
    SendInput, e             ; Digita "E" novamente
return

#IfWinActive, ahk_class RAIL_WINDOW
^2:: ; Ctrl + 2 - FINANCEIRO
    SendInput, {F10}
    Sleep, 100
    SendInput, a
    Sleep, 100
    SendInput, p
    Sleep, 100
    SendInput, b
    Sleep, 100
    SendInput, g
    Sleep, 100
    SendInput, s
return

#IfWinActive, ahk_class RAIL_WINDOW
^3:: ; Ctrl + 3 - ESTOQUES
    SendInput, {F10}
    Sleep, 100
    SendInput, a
    Sleep, 100
    SendInput, p
    Sleep, 100
    SendInput, b
    Sleep, 100
    SendInput, g
    Sleep, 100
    SendInput, e
return

#IfWinActive, ahk_class RAIL_WINDOW
!c:: ; Alt + C - ALTERAR CONTEXTO
{
    SendInput, {F10}
    Sleep, 100
    SendInput, c
    Sleep, 100
    SendInput, n
    Sleep, 100
    SendInput, !y

}
return

#IfWinActive, ahk_class RAIL_WINDOW
!b:: ; BAIXAS DO LANÇAMENTO
{
    SendInput, ^{Enter}
    Sleep, 2000
        Loop
        {
            ; Tenta ativar a janela
            IfWinExist, Parcela
            {
                WinActivate, Parcela
                ; Aguarda a janela ficar ativa
                WinWaitActive, Parcela, , 15
                if ErrorLevel
                {
                    ; Se não ficou ativa em 15 segundos, continua tentando
                    Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                    continue
                }
                else
                {
                    ; Se a janela ficou ativa, sai do loop
                    break
                }
            }
            else
            {
                ; Se a janela não existir, espera um pouco e tenta de novo
                Sleep, 1000 ; Espera 1 segundo
            }
        }

    Click, 371, 79
    Sleep, 1000

    ; !! PONTO CRÍTICO !!
    Click, 358, 248, 2
    Sleep, 3000

    Loop
        {
            ; Tenta ativar a janela
            IfWinExist, Lançamento:
            {
                WinActivate, Lançamento:
                ; Aguarda a janela ficar ativa
                WinWaitActive, Lançamento:, , 15
                if ErrorLevel
                {
                    ; Se não ficou ativa em 15 segundos, continua tentando
                    Sleep, 1000 ; Espera 1 segundo antes de tentar novamente
                    continue
                }
                else
                {
                    ; Se a janela ficou ativa, sai do loop
                    break
                }
            }
            else
            {
                ; Se a janela não existir, espera um pouco e tenta de novo
                Sleep, 1000 ; Espera 1 segundo
            }
    }

    ; !! PONTO CRÍTICO !!
    Click, 295, 45
    Sleep, 300

    Loop, 9 {
        SendInput, {Down}
        Sleep, 50
    }

    SendInput, {Enter}
}
Return