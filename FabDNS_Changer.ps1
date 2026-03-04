<#
    FabDNS Changer v2.0
    Author: Fabianator Edition
    Stable UI + Tooltips + Glow Title
#>

Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

# ================== DNS ==================
$DNS_LIST = [ordered]@{
    "AdGuard Ads"                = @("94.140.14.14","94.140.15.15")
    "AdGuard Family"             = @("94.140.14.15","94.140.15.16")
    "CleanBrowsing"              = @("185.228.168.9","185.228.169.9")
    "Cloudflare"                 = @("1.1.1.1","1.0.0.1")
    "Google"                     = @("8.8.8.8","8.8.4.4")
    "Ibrido Google + Cloudflare" = @("8.8.8.8","1.1.1.1")
    "OpenDNS"                    = @("208.67.222.222","208.67.220.220")
    "Quad9"                      = @("9.9.9.9","149.112.112.112")
}

# ================== DESCRIZIONI ==================
$DNS_DESC = @{
    "Cloudflare"                 = "DNS veloce e orientato alla privacy (no log)"
    "Google"                     = "DNS globale, affidabile e stabile"
    "Ibrido Google + Cloudflare" = "Affidabilita' Google + velocita' Cloudflare (Consigliato da Fabianator)"
    "Quad9"                      = "Blocco malware e domini malevoli"
    "OpenDNS"                    = "Protezione base e controllo parentale"
    "CleanBrowsing"              = "Filtri famiglia e sicurezza DNS"
    "AdGuard Ads"                = "Blocco pubblicita' e tracker"
    "AdGuard Family"             = "Protezione famiglia + SafeSearch"
}

# ================== BACKUP ==================
$BackupPath = "$env:USERPROFILE\FabDNS_Backup"
$BackupFile = "$BackupPath\dns_backup.json"

function Get-ActiveAdapter {
    Get-NetAdapter | Where-Object Status -eq 'Up' |
    ForEach-Object {
        $cfg = Get-NetIPConfiguration -InterfaceIndex $_.InterfaceIndex
        if ($cfg.IPv4DefaultGateway) { $_ }
    } | Select-Object -First 1
}

function Get-CurrentDNS($index) {
    (Get-DnsClientServerAddress -InterfaceIndex $index -AddressFamily IPv4).ServerAddresses
}

function Backup-DNS($adapter) {
    New-Item -ItemType Directory -Path $BackupPath -Force | Out-Null
    @{
        Interface = $adapter.Name
        Index     = $adapter.InterfaceIndex
        DNS       = Get-CurrentDNS $adapter.InterfaceIndex
    } | ConvertTo-Json | Set-Content $BackupFile
}

function Restore-DNS {
    if (!(Test-Path $BackupFile)) { return $false }
    $data = Get-Content $BackupFile | ConvertFrom-Json
    Set-DnsClientServerAddress -InterfaceIndex $data.Index -ServerAddresses $data.DNS
    return $true
}

# ================== UI ==================
$IconPath = Join-Path $PSScriptRoot "FabDNS_Changer.ico"

$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        Title="FabDNS Changer v2.0"
        Width="520" Height="720"
        WindowStartupLocation="CenterScreen"
        ResizeMode="NoResize"
        Background="#121212"
        Icon="$IconPath">

    <Grid Margin="20">
        <Border Background="#1E1E1E" CornerRadius="18">
            <Border.Effect>
                <DropShadowEffect BlurRadius="28" ShadowDepth="0" Color="#00E5FF" Opacity="0.25"/>
            </Border.Effect>

            <StackPanel Margin="22">

                <!-- TITOLO CON GLOW SOFT -->
                <TextBlock Text="FabDNS Changer v2.0"
                           FontSize="30"
                           FontWeight="Bold"
                           Foreground="#00E5FF"
                           HorizontalAlignment="Center">
                    <TextBlock.Effect>
                        <DropShadowEffect Color="#00FFFF"
                                          BlurRadius="22"
                                          ShadowDepth="0"
                                          Opacity="0.75"/>
                    </TextBlock.Effect>
                </TextBlock>

                <Rectangle Height="2" Margin="0,15" Fill="#00E5FF" Opacity="0.4"/>

                <TextBlock Text="Seleziona DNS:" Foreground="White" FontSize="14"/>

                <StackPanel Name="DnsPanel" Margin="0,10"/>

                <CheckBox Name="chkAuto" Content="Ripristina DNS automatici (DHCP)"
                          Foreground="#FFA726" Margin="0,10"/>

                <CheckBox Name="chkBackup" Content="Backup DNS attuali"
                          Foreground="#81C784"/>

                <CheckBox Name="chkRestore" Content="Ripristina DNS da backup"
                          Foreground="#EF5350"/>

                <TextBox Name="LogBox"
                         Height="105"
                         Margin="0,15"
                         Background="#111"
                         Foreground="#DDD"
                         IsReadOnly="True"
                         TextWrapping="Wrap"/>

                <Button Name="BtnApply"
                        Content="APPLICA DNS"
                        Height="50"
                        FontSize="17"
                        FontWeight="Bold"
                        Foreground="White"
                        Background="#FF7043"/>
            </StackPanel>
        </Border>
    </Grid>
</Window>
"@

$UI = [System.Windows.Markup.XamlReader]::Load(
    [System.Xml.XmlReader]::Create([System.IO.StringReader]$xaml)
)

$DnsPanel    = $UI.FindName("DnsPanel")
$BtnApply    = $UI.FindName("BtnApply")
$LogBox     = $UI.FindName("LogBox")
$chkAuto    = $UI.FindName("chkAuto")
$chkBackup  = $UI.FindName("chkBackup")
$chkRestore = $UI.FindName("chkRestore")

# ================== RADIO BUTTONS ==================
$RadioButtons = @{}
foreach ($name in $DNS_LIST.Keys) {
    $rb = New-Object System.Windows.Controls.RadioButton
    $rb.Content    = "$name ($($DNS_LIST[$name] -join ' / '))"
    $rb.Foreground = "White"
    $rb.Margin     = "0,4"
    $rb.ToolTip    = $DNS_DESC[$name]
    $DnsPanel.Children.Add($rb)
    $RadioButtons[$name] = $rb
}

# ================== LOAD INFO ==================
$LogBox.Text = "Ricerca interfaccia attiva..."

$UI.Dispatcher.BeginInvoke([action]{
    $script:adapter = Get-ActiveAdapter
    $dnsNow = Get-CurrentDNS $adapter.InterfaceIndex
    $LogBox.Text =
"Interfaccia attiva: $($adapter.Name)
DNS attuali:
$($dnsNow -join "`n")"
})

# ================== APPLY ==================
$BtnApply.Add_Click({

    if ($chkBackup.IsChecked) {
        Backup-DNS $script:adapter
        $LogBox.Text += "`nBackup DNS salvato."
    }

    if ($chkRestore.IsChecked) {
        if (Restore-DNS) {
            $LogBox.Text += "`nDNS ripristinati da backup."
        } else {
            $LogBox.Text += "`nBackup non trovato."
        }
    }
    elseif ($chkAuto.IsChecked) {
        Set-DnsClientServerAddress -InterfaceIndex $script:adapter.InterfaceIndex -ResetServerAddresses
        $LogBox.Text += "`nDNS automatici (DHCP) ripristinati."
    }
    else {
        foreach ($k in $RadioButtons.Keys) {
            if ($RadioButtons[$k].IsChecked) {
                Set-DnsClientServerAddress -InterfaceIndex $script:adapter.InterfaceIndex -ServerAddresses $DNS_LIST[$k]
                $LogBox.Text += "`nDNS applicati: $k"
            }
        }
    }

    Clear-DnsClientCache
    $LogBox.Text += "`n--- OPERAZIONE COMPLETATA ---"
})

$UI.ShowDialog() | Out-Null
