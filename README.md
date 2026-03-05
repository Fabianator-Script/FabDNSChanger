# 🛡️ FabDNS Changer v2.0
### *Modern, Open Source & Lightweight DNS Switcher for Windows*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PowerShell](https://img.shields.io/badge/Language-PowerShell-blue.svg)](https://microsoft.com/powershell)
[![Windows](https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011-0078d4.svg)]()

Ciao a tutti! Vi presento **FabDNS Changer v2.0**, un progetto nato dalla filosofia **Fabianator**: potenza, trasparenza e un'interfaccia moderna. È un DNS Changer scritto interamente in PowerShell con una GUI in WPF pulita e reattiva.

> [!IMPORTANT]
> **Il progetto è 100% OPEN SOURCE**: Niente EXE, niente codice offuscato, nessun tracker o telemetria. Solo codice leggibile e verificabile riga per riga.

---

## ✨ Caratteristiche Principali

* 🎨 **Interfaccia Moderna:** GUI in WPF con tema scuro ed effetti glow soft.
* 🚀 **Performance:** Avvio rapido con ricerca delle interfacce di rete asincrona (niente lag).
* 👻 **Modalità Stealth:** Avvio tramite launcher VBS per nascondere la finestra di PowerShell.
* 🛡️ **Privilegi Elevati:** Gestione automatica dell'esecuzione come Amministratore.
* 🔄 **Manutenzione:** Pulizia automatica della cache DNS (Flush) ad ogni cambio.

---

## 🌐 DNS Supportati

Scegli il profilo ideale con un click (include descrizioni informative nei tooltip):

| Provider | Focus | Caratteristiche |
| :--- | :--- | :--- |
| **Cloudflare** | ⚡ Velocità | Senza log, prestazioni globali al top. |
| **Google** | 🌍 Stabilità | Il più affidabile e resiliente al mondo. |
| **Ibrido** | 🏆 **Consigliato** | Unisce l'affidabilità di Google alla velocità di Cloudflare. |
| **Quad9** | 🔒 Sicurezza | Blocco automatico di domini malevoli e phishing. |
| **AdGuard Ads** | 🚫 No Ads | Blocca pubblicità e tracker a livello DNS. |
| **AdGuard Family** | 👨‍👩‍👧 Famiglia | Include SafeSearch e blocco contenuti per adulti. |
| **CleanBrowsing** | 🛡️ Filtri | Ottimo per la protezione dei minori. |
| **OpenDNS** | ⚙️ Controllo | Protezione base con filtri personalizzabili. |

---

## ⚡ Quick Start (PowerShell One-Liner)

Non vuoi scaricare l'intero repository? Copia e incolla questo comando in **PowerShell (come Amministratore)** per avviare la versione standalone:

```powershell
iex (Invoke-RestMethod [https://raw.githubusercontent.com/Fabianator-Script/FabDNSChanger/main/FabDNS_Changer.ps1](https://raw.githubusercontent.com/Fabianator-Script/FabDNSChanger/main/FabDNS_Changer.ps1))
