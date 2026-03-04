' Lancia_FabCleaner.vbs
' Avvia FCleaner by Fabianator con privilegi elevati e finestra nascosta

Option Explicit

Dim objFSO, objShell
Dim strScriptPath, strFolder, strPSFile
Dim strCommand

' Creazione oggetti sistema
Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objShell = CreateObject("Shell.Application")

' 1. Ottieni il percorso della cartella dove si trova questo script
strScriptPath = WScript.ScriptFullName
strFolder = objFSO.GetParentFolderName(strScriptPath)

' 2. Costruisci il percorso del file PowerShell
' Assicurati che il nome del file qui sotto sia ESATTAMENTE quello del tuo script
strPSFile = strFolder & "\FabDNS_Changer.ps1"

' 3. CONTROLLO DEBUG: Verifica se il file esiste
If Not objFSO.FileExists(strPSFile) Then
    MsgBox "ERRORE CRITICO!" & vbCrLf & vbCrLf & _
           "Impossibile trovare il file script in:" & vbCrLf & _
           strPSFile & vbCrLf & vbCrLf & _
           "Assicurati che questo file .vbs e fcleaner.ps1 siano nella stessa cartella.", 16, "FabCleaner Launcher"
    WScript.Quit
End If

' 4. Configura il comando PowerShell
' -WindowStyle Hidden: Nasconde la finestra blu/nera
' -NoProfile: Avvio più veloce
' -ExecutionPolicy Bypass: Evita blocchi di sicurezza
strCommand = "-WindowStyle Hidden -NoProfile -ExecutionPolicy Bypass -File """ & strPSFile & """"

' 5. Esegui come Amministratore (runas)
' Il parametro finale '0' serve a nascondere la finestra del CMD genitore
objShell.ShellExecute "powershell.exe", strCommand, "", "runas", 0