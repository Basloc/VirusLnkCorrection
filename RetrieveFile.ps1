Write-Host "---------- Recuperation des fichiers en cours ----------" -ForegroundColor Green

# Detection automatique de la lettre de la cle USB (amovible et prete)
$usbDrives = Get-WmiObject Win32_LogicalDisk | Where-Object {
    $_.DriveType -eq 2 -and $_.VolumeName -ne $null -and $_.DriveType -eq 2
}

foreach ($drive in $usbDrives) {
    $usbLetter = $drive.DeviceID
    Write-Host "Cle USB detectee : $usbLetter" -ForegroundColor Magenta

    # Supprimer les raccourcis .lnk et fichier .js qui peuvent correspondre au virus
    $lnkFiles = Get-ChildItem -Path "$usbLetter\" -Filter "*.lnk"
    $jsFiles = Get-ChildItem -Path "$usbLetter\" -Force -Filter "*.js"
    foreach ($lnk in $lnkFiles) {
        try {
            Remove-Item $lnk.FullName -Force -Confirm
            Write-Host "raccourci .lnk supprime : $($lnk.Name)" -ForegroundColor Red
        } catch {
            Write-Host "Erreur lors de la suppression de : $($lnk.Name)" -ForegroundColor Red
        }
    }
    Write-Host "Pas de raccourci .lnk trouve sur la cle -> $usbLetter" -ForegroundColor Blue

    foreach ($js in $jsFiles) {
        try {
            Remove-Item $js.FullName -Force -Confirm
            Write-Host "fichier js supprime : $($js.Name)" -ForegroundColor Red
        } catch {
            Write-Host "Erreur lors de la suppression de : $($js.Name)" -ForegroundColor Red
        }
    }
    Write-Host "Pas de fichier js trouve sur la cle -> $usbLetter" -ForegroundColor Blue


    # Rendre visibles les dossiers caches et proteges
    $hiddenFolders = Get-ChildItem -Path "$usbLetter\" -Force 
    foreach ($folder in $hiddenFolders) {
        try {
            
            # Enlever les attributs Hidden et System si presents
            if (($folder.Attributes -band [System.IO.FileAttributes]::Hidden -or 
                $folder.Attributes -band [System.IO.FileAttributes]::System) -and $folder.Name -ne "System Volume Information") {

                $folder.Attributes = $folder.Attributes `
                    -band (-bnot [System.IO.FileAttributes]::Hidden) `
                    -band (-bnot [System.IO.FileAttributes]::System)

                Write-Host "Dossier retrouve : $($folder.Name)" -ForegroundColor Green
            }
        } catch {
            Write-Host "Erreur sur : $($folder.FullName)" -ForegroundColor Red
        }
    }
}

Write-Host "---------- Nettoyage termine ----------" -ForegroundColor Green


