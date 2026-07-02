[Setup]
; REMARQUE : La valeur de AppId identifie l'application. Ne la modifiez pas si vous publiez des mises à jour !
AppId={{9C9E1B23-C2A8-4395-8F12-88E6A6A5E3E7}
AppName=Blender Imagery
AppVersion=1.0.4
AppPublisher=VIV
; Installation au niveau utilisateur pour éviter l'UAC (nécessaire pour les MAJ automatiques silencieuses)
DefaultDirName={userpf}\BlenderImagery
DefaultGroupName=VIV Formation
SetupIconFile=windows\runner\resources\app_icon.ico
PrivilegesRequired=lowest
OutputDir=Output
OutputBaseFilename=blender_imagery_setup_v1.0.4
Compression=lzma
SolidCompression=yes
; Force la fermeture de l'application Flutter en cours d'exécution
CloseApplications=force

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "build\windows\x64\runner\Release\viv_formation_toolbox.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{autoprograms}\Blender Imagery"; Filename: "{app}\viv_formation_toolbox.exe"
Name: "{autodesktop}\Blender Imagery"; Filename: "{app}\viv_formation_toolbox.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\viv_formation_toolbox.exe"; Description: "{cm:LaunchProgram,Blender Imagery}"; Flags: nowait postinstall skipifsilent
