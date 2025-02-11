# Labo-nota's Linux Mint VM

## 1.4.1 Configuratie

### Toetsenbordinstelling wijzigen

1. Open de instellingen van Linux Mint.
2. Ga naar **Toetsenbordindeling**.
3. Voeg **Belgisch (AZERTY)** toe en stel deze in als standaard.

### Screensaver en Screen Lock uitschakelen

1. Open de instellingen en navigeer naar **Schermbeveiliging**.
2. Schakel **Screensaver** en **Screen Lock** uit.

### Gedeeld klembord instellen

1. In het VirtualBox-venster: **Apparaten > Gedeeld klembord > Bidirectioneel**.

### Firefox bookmarks instellen

1. Start Firefox.
2. Log in op **Chamilo** en **GitHub**.
3. Voeg bookmarks toe voor:
   - Chamilo cursus
   - GitHub-repository van de labo's.

### SSH-sleutelpaar aanmaken en registreren op GitHub

1. Genereer een SSH-sleutelpaar:

   ```bash
   ssh-keygen -t rsa -b 4096 -C "jouw_email@voorbeeld.com"
   ```

2. Voeg de publieke sleutel toe aan GitHub:

   - Kopieer de sleutel:

     ```bash
     cat ~/.ssh/id_rsa.pub
     ```

   - Ga naar **Settings > SSH and GPG keys**.
   - Klik op **New SSH key**, plak de sleutel en geef een naam.

---

## 1.4.2 Package Management

### Lijst van updates tonen

```bash
sudo apt update
sudo apt list --upgradable
```

### Eén package updaten

Bijvoorbeeld Firefox:

```bash
sudo apt install --only-upgrade firefox
```

### Software installeren

1. **Grafische interface:** Gebruik de **Softwarebeheer**-app.
2. **Command-line:**

   ```bash
   sudo apt install git jq shellcheck vim vim-gtk3
   ```

### Visual Studio Code installeren

1. Download de `.deb`-variant van de [VSCode-website](https://code.visualstudio.com/).
2. Installeer met:

   ```bash
   sudo dpkg -i code_*.deb
   sudo apt --fix-broken install
   ```

3. Installeer plugins:
   - Markdown All In One
   - Markdownlint
   - ShellCheck
   - GitLens
   - Git Graph

### Package sl installeren

1. Download de package:

   ```bash
   wget https://packages.ubuntu.com/focal/amd64/sl/download
   ```

2. Installeer met:

   ```bash
   sudo dpkg -i sl_*.deb
   ```

3. Test het commando:

   ```bash
   sl
   ```

### Package cavepacker installeren

Volg dezelfde stappen als voor **sl**, maar download de **cavepacker** package.

### Package informatie opvragen

```bash
dpkg -s cavepacker
```

### Configuratiebestand uit package halen

1. Download package:

   ```bash
   wget http://ftp.de.debian.org/debian/pool/main/i/isc-dhcp/isc-dhcp-common_4.4.3-P1-5_s390x.deb
   ```

2. Bekijk de inhoud:

   ```bash
   dpkg -c isc-dhcp-common_*.deb
   ```

3. Extraheer `dhcpd.conf`:

   ```bash
   dpkg-deb -x isc-dhcp-common_*.deb ./
   ```

### Ongebruikte software verwijderen

```bash
sudo apt remove --purge hypnotix rhythmbox
```

---

## 1.4.3 Snapshot nemen

1. In VirtualBox: **Machine > Snapshot maken**.
2. Geef de snapshot een naam, bijv. **Na installatie**.

---

## 1.4.4 Curl

### Publiek IP-adres opvragen

```bash
curl icanhazip.com
```

### URL ophalen en opslaan

```bash
curl https://hmpg.net/ > pagina.html
```

- **Opnieuw downloaden:** Reeds bestaande bestanden worden overschreven tenzij de `-O` optie wordt gebruikt.
- **Zonder `https://`:** Je krijgt een foutmelding of een andere uitvoer.

### HTTP headers tonen

```bash
curl -I https://hmpg.net/
```

### Redirects automatisch volgen

```bash
curl -L https://hmpg.net/
```

### FTP-bestand downloaden

```bash
curl ftp://ftp.belnet.be/debian/README
curl -u anonymous: ftp://ftp.belnet.be/debian/README
```

### REST API gebruiken

1. Haal een willekeurige Wikipedia-pagina op:
   ```bash
   curl -L https://en.wikipedia.org/api/rest_v1/page/random/summary | jq
   ```
2. Verberg de progress bar:
   ```bash
   curl -s ...
   ```

### Real-time data Gentse fietsenstallingen

```bash
curl "https://data.stad.gent/api/v2/resource/..." -o "fietsenstallingen-$(date +%Y%m%d-%H%M%S).json"
```

---

## 1.4.5 VM afsluiten

### Veilige afsluitmethoden

1. **Machine opslaan:** VirtualBox > Machine > **Staat van de machine opslaan**.
2. **Linux Mint-menu:** Rode knop > **Shut Down**.
3. **Terminal:**

   ```bash
   poweroff
   ```
