## VirusLnkCorrection
# 🛠 Description des scripts 
# RetrieveFile.ps1
Ce script PowerShell automatise la récupération de fichiers cachés sur une clé USB 
# DetectVirus.ps1 
Ce script agit comme un scanner basique de menaces connues sur un système Windows. Il vérifie plusieurs points d’entrée utilisés par certains malwares

# 🔒 PowerShell Utilities for USB Cleaning & Virus Detection

Ce dépôt contient deux scripts PowerShell conçus pour :
1. Nettoyer automatiquement les clés USB infectées.
2. Scanner et supprimer des vecteurs d’infection classiques sur Windows.

---

## 🧼 Script 1 : RetrieveFile.ps1

### Description
Ce script :
- Détecte automatiquement les clés USB insérées.
- Supprime les fichiers de raccourci `.lnk`.
- Supprime le virus .js de la clé.
- Rétablit les attributs normaux (non-cachés, non-système) des dossiers cachés.

### Utilisation
```powershell
.\RetrieveFile.ps1
```

## 🧼 DetectVirus.ps1

### Description
Ce script PowerShell effectue une inspection manuelle de certains points d’entrée critiques souvent exploités par des malwares. Il est conçu pour aider à désinfecter rapidement un poste Windows sans antivirus complexe.

✅ Fonctionnalités :
🔍 Clé de registre Run : Vérifie si une valeur malveillante (4SI4HR5LNI) est enregistrée au démarrage. Si trouvée, elle est supprimée.

🗓 Tâche planifiée : Recherche une tâche nommée DropBox, utilisée par certains malwares pour persister. Elle est supprimée si détectée.

📂 Dossier Startup : Scanne le dossier de démarrage de l'utilisateur à la recherche de fichiers .js suspects. Supprime automatiquement ceux détectés.

🧑‍💻 Dossier utilisateur : Recherche des fichiers .js suspects directement dans le dossier utilisateur (C:\Users\<Nom>). Supprime ceux détectés.

### Exemple d'utilisation
```powershell
.\DetectVirus.ps1
```

##### ⚠️ Avertissements
Ces scripts modifient/suppriment des fichiers ( avec confirmation utilisateur ). Utilisez-les en connaissance de cause.

Nécessitent des droits suffisants pour accéder aux dossiers utilisateurs, registre et planificateur de tâches.

## ✅ Requis
Windows avec PowerShell (v5+)

Exécution en tant qu’administrateur recommandée

📄 Licence
Ce projet est sous licence MIT. Vous êtes libre de l’utiliser, modifier et distribuer avec mention du créateur.
