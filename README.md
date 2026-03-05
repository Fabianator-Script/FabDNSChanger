# FabDNS Changer v2.0 – DNS Changer Open Source (PowerShell)

---

Ciao a tutti,
vorrei condividere con la community un mio progetto personale chiamato **FabDNS Changer v2.0**, un DNS Changer scritto interamente in PowerShell, con interfaccia grafica WPF moderna, pulita e stabile.

**Il progetto è completamente OPEN SOURCE**
- ✅ Nessun file EXE
- ✅ Codice leggibile e verificabile
- ✅ Nessun codice maligno, tracker o telemetria

---

### Caratteristiche principali

- Interfaccia grafica WPF moderna
- Compatibile con **Windows 10 e Windows 11**
- Avvio con privilegi elevati (tramite launcher VBS opzionale)
- Nessuna finestra PowerShell visibile
- Avvio rapido (UI immediata, ricerca interfaccia asincrona)
- Nessun loop, nessun crash

### DNS supportati

- **Cloudflare** – DNS veloce e orientato alla privacy, senza log e con ottime prestazioni globali.
- **Google** – DNS pubblico globale, molto affidabile e stabile, ideale per compatibilità e resilienza.
- **Ibrido Google + Cloudflare** – Combinazione tra affidabilità Google e velocità Cloudflare. **Consigliato per uso quotidiano.**
- **Quad9** – DNS focalizzato sulla sicurezza, blocca automaticamente domini malevoli e phishing.
- **OpenDNS** – Protezione base con possibilità di controllo parentale e filtri di sicurezza.
- **CleanBrowsing** – DNS pensato per famiglie, con filtri automatici contro contenuti non adatti.
- **AdGuard Ads** – Blocca pubblicità, tracker e domini di tracciamento direttamente a livello DNS.
- **AdGuard Family** – Protezione completa per la famiglia, con SafeSearch e blocco contenuti per adulti.

> Ogni servizio DNS include una **descrizione informativa (tooltip)** visibile al passaggio del mouse.

### Funzioni avanzate

- Backup DNS attuali
- Ripristino DNS da backup
- Ripristino DNS automatici (DHCP)
- Pulizia cache DNS automatica
- Log operazioni integrato

### Interfaccia

- Tema scuro moderno
- Effetti glow soft e non invasivi
- Icona personalizzata (visibile anche con ALT+TAB)
- Pulsanti leggibili e layout stabile
- Finestra a dimensione fissa

### Sicurezza & Trasparenza

Questo progetto nasce con una filosofia molto chiara:

> **Niente EXE, niente offuscamenti, niente comportamenti sospetti.**

- Script scritto in PowerShell puro
- Codice leggibile riga per riga
- Nessuna operazione nascosta

### Distribuzione

Il progetto viene distribuito come:

- File `.ps1` (script principale)
- Launcher `.vbs` opzionale (avvio elevato + finestra nascosta)
- Icona personalizzata

Oppure: Copia e incolla questo comando in PowerShell (eseguito come Amministratore) Versione ridotta, senza icona e senza launcher vbscript:

iex (Invoke-RestMethod https://raw.githubusercontent.com/Fabianator-Script/FabDNSChanger/main/FabDNS_Changer.ps1)


### Screenshot

<img width="426" height="600" alt="Screenshot-02" src="https://github.com/user-attachments/assets/5d110d80-1fc7-45af-8ce9-9c97f8994161" />
<img width="426" height="600" alt="Screenshot-01" src="https://github.com/user-attachments/assets/5a4e92a1-65a3-4103-b1e3-aae37eb43921" />
