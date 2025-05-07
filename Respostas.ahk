
I_Icon = C:\Users\010129987\Desktop\bbb.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%

NumpadAdd:: Send {Volume_Up}
NumpadSub:: Send {Volume_Down}
;Pause::Send {Volume_Mute}
Return

^F12::
Run, "C:\Users\010129987\AppData\Roaming\Microsoft\Excel\XLSTART\PERSONAL.xlsb"
Return

^F11::
Run, "N:\FINANCEIRO\01 - FATURAMENTO AO RECEBIMENTO\02 - FATURAMENTO\999- USUÁRIOS\010129987 - Luís Mateus\Compêndio mágico do faturamento.xlsm"
Return

!1::
SendInput, Prezado(a) aluno(a), favor inserir as disciplinas que deseja consultar os valores.
Return

;!2::
SendInput, Prezados, plano de pagamento do aluno já sofreu ajuste anteriormente para refletir dispensas de disciplinas. Conforme procedimento estabelecido, não poderá ser reajustado. Favor seguir.
Return

!3::
SendInput, Plano de pagamento do aluno já consta integralizado, não restam parcelas a serem geradas. Favor seguir.
Return

!4::
SendInput, Discente de modalidade tradicional, cobrado por créditos. Não exige ajustes financeiros.
Return

Capslock::Click, 2
Return

^Capslock::
SendInput, Plano de pagamento ajustado.
Return

+Capslock::
SendInput, Boleto disponibilizado em tempo hábil para pagamento. Favor tratar diretamente com a negociação financeira.
Return

;+Capslock::
SendInput, Para ingressantes a partir do semestre letivo de 2021.2, o reajuste anual é previsto em cláusula contratual para os cursos de graduação com duração superior a 18 meses. Caso deseje obter cópias dos contratos educacionais, estes estão publicados no site institucional - no menu acadêmico, na opção de documentos.
Return

;+Capslock::
SendInput, Aluno sem contexto 20232.
Return

;^1::
SendInput, ^a{Backspace}
SendInput, 01/01/1900
Send {Tab}
SendInput, 28/02/2025
Return

;^2::
SendInput, ^a{Backspace}
SendInput, 01/02/2025
Send {Tab 2}
SendInput, ^a{Backspace}
SendInput, 28/02/2025
Return

^1::
SendInput, Boleto(s) de reposição disponível no portal do aluno.
Return

^2::
SendInput, Boleto disponível no portal do aluno.
Return

^3::
SendInput, Favor verificar solicitação do aluno.
Return

^4::
SendInput, Valores requisitados disponíveis na tabela. Esses valores são válidos para o período, matriz e turno requerido no chamado. Obs: Disciplinas optativas não incorrem em custos ao aluno na primeira vez sendo cursadas.
Return

!2::
SendInput, Na modalidade tradicional, cobrado por créditos, o sistema calcula automaticamente o valor das parcelas de acordo com as disciplinas que estão matriculadas no momento da geração. Nesse caso, se é feita alguma alteração nas disciplinas matriculadas, é possível que não restem créditos financeiros suficientes para compor mais parcelas.
Return

^5::
SendInput, Por ter sido realizada a matrícula fora do prazo, o sistema parcelou automaticamente a mensalidade em três vezes (sem juros, com base no valor do primeiro vencimento), de forma a não lesar o aluno. Cabe ao aluno optar por pagar parcelado ou de uma vez.
Return

^+1::
SendInput, Discente de modalidade tradicional, cobrado por créditos. Valor das parcelas calculado automaticamente pelo sistema de acordo com as disciplinas matriculadas.
Return

