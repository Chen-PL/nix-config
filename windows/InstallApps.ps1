#Requires -RunAsAdministrator

$winGetApps = @(
    # Browsers
    "Google.Chrome",
    "Mozilla.Firefox",
    
    # Text Editors
    "Microsoft.VisualStudioCode",
    "SublimeHQ.SublimeText.4",
    "SublimeHQ.SublimeMerge",
    
    # Messaging
    "Tencent.QQ",
    "Tencent.WeChat",
    "Telegram.TelegramDesktop",
    "SlackTechnologies.Slack",
    
    # Gaming
    "Valve.Steam",
    "Libretro.RetroArch",

    # Streaming
    "OBSProject.OBSStudio",
    "Elgato.4KCaptureUtility",
    "BandicamCompany.Bandicut",

    # Authentication
    "GnuPG.Gpg4win",
    "AgileBits.1Password",
    "Yubico.YubikeyManager",
    "Yubico.YubiKeyPersonalizationTool",

    # Hardwares
    "Logitech.LogiBolt",
    "Logitech.OptionsPlus",
    
    # Useful Tools
    "7zip.7zip",
    "RARLab.WinRAR",
    "Rufus.Rufus",
    "Balena.Etcher",
    "Microsoft.PowerToys",
    "voidtools.Everything",
    
    # Others
    "Zoom.Zoom",
    "Spotify.Spotify",
    "GitHub.GitHubDesktop",
    "Microsoft.Office",
    "MullvadVPN.MullvadVPN"
);

Write-Output "Installing Apps using WinGet..."
Foreach ($app in $winGetApps) {
    $listApp = winget list --exact -q $app
    if (![String]::Join("", $listApp).Contains($app)) {
        Write-host "Installing: " $app
        winget install -e -h --accept-source-agreements --accept-package-agreements --id $app 
    }
    else {
        Write-host "Skipping: " $app " (already installed)"
    }
}

If (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Output "Scoop is already installed."
} else {
    Write-Output "Installing Scoop..."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
}

Write-Output "Installing Apps using Scoop..."
scoop bucket add versions
scoop install sudo git python snipaste-beta
