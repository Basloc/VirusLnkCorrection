Write-Host "---------- Scan en cours ----------" -ForegroundColor Green
Start-Sleep -Seconds 2

$Users = $env:USERNAME

# 1. Clé de registre 
$cle = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$valeur = Get-ItemProperty -Path $cle -Name "4SI4HR5LNI" -ErrorAction SilentlyContinue

if ($valeur) {
    Write-Host "ALERTE : Valeur trouvee : $($valeur.'4SI4HR5LNI')" -ForegroundColor Red
    Remove-ItemProperty -Confirm -Path $cle -Name "4SI4HR5LNI"
    Write-Host "##### Supression effcetue #####" -ForegroundColor Yellow
} else {
    Write-Host "OK : Valeur non trouvee." -ForegroundColor Blue
}

# 2. Tâche planifiée
$task = schtasks /query /tn "DropBox" 2>$null
if ($task) {
    Write-Host "ALERTE : Tache planifiee 'DropBox' detectee" -ForegroundColor Red
    Unregister-ScheduledTask -Confirm "DropBox"
    Write-Host "##### Supression effcetue #####" -ForegroundColor Yellow
} else {
    Write-Host "OK : Aucune tache planifie 'DropBox'" -ForegroundColor Blue
}

# 3. Dossier StartUp
$StartUpPath = "C:\Users\$Users\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
$StartUpFile = Get-ChildItem -Force $StartUpPath
foreach($file in $StartUpFile) {
    if ($file -match ".js$") {
        Write-Host "ALERTE : Fichier JS suspect detecte -> $StartUpPath\$file" -ForegroundColor Red
        Remove-Item -Confirm -Force -Path "$StartUpPath\$file"
        Write-Host "##### Supression effcetue #####" -ForegroundColor Yellow
    }
}

# 4. Dossier Utilisteur

$UserDir = "C:\Users\$Users"
$UserFile = Get-ChildItem -Force $UserDir
foreach($file in $UserFile) {
    if ($file -match ".js$") {
        Write-Host "ALERTE : Fichier JS suspect detecte -> $UserDir\$file" -ForegroundColor Red
        Remove-Item -Confirm -Force -Path "$UserDir\$File"
        Write-Host "##### Supression effcetue #####" -ForegroundColor Yellow
    }
    
}


Write-Host "---------- Scan fini ----------" -ForegroundColor Green
Start-Sleep -Seconds 10
