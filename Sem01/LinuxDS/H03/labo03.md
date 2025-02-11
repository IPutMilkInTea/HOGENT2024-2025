### 3.4.1. Gebruikers en groepen aanmaken

#### Wat is het commando om de huidige directory op te vragen? In welke map bevind je jou nu?
**Commando:**  
```bash
pwd
```  
**Uitvoer:**  
De exacte map is afhankelijk van waar de sessie begon, vaak is dit `/home/hogent` als je bent ingelogd als `hogent`.

---

#### Wat is het UID van deze gebruiker, wat is de GID?
**Commando:**  
```bash
id hogent
```  
**Uitvoer:**  
Bijvoorbeeld:  
```plaintext
uid=1000(hogent) gid=1000(hogent) groups=1000(hogent),27(sudo)
```
- **UID:** 1000  
- **GID:** 1000  

---

#### Maak een nieuwe gebruiker aan met de naam `alice` zonder specifieke opties
**Commando:**  
```bash
sudo adduser alice
```  
**Uitvoer:**  
Het systeem vraagt een wachtwoord voor `alice` en optioneel aanvullende informatie (zoals volledige naam en telefoonnummer). Een standaard homedirectory wordt aangemaakt: `/home/alice`.

---

#### Configuratiebestanden voor gebruikersbeheer
1. **In welk bestand kan je de UID, gebruikersnaam, homedirectory, enz. van alle gebruikers terugvinden?**  
   Bestand: `/etc/passwd`

2. **In welk configuratiebestand kan je al de bestaande gebruikersgroepen nakijken, en ook de gebruikers die lid zijn van elke groep?**  
   Bestand: `/etc/group`

3. **In welk configuratiebestand vind je de wachtwoorden van alle gebruikers?**  
   Bestand: `/etc/shadow`

---

#### Gebruikersgroepen aanmaken
1. **Maak een groep aan met de naam `sporten`**  
   **Commando:**  
   ```bash
   sudo groupadd sporten
   ```

2. **In welk configuratiebestand vind je het GID van deze groep terug?**  
   Bestand: `/etc/group`

3. **Wat zal het GID zijn van de groepen `zwemmen` en `judo` als je deze nu onmiddellijk zou aanmaken?**  
   Dit is het volgende beschikbare GID. Controleer met:
   ```bash
   sudo groupadd zwemmen
   sudo groupadd judo
   grep 'zwemmen\|judo' /etc/group
   ```
   **Uitvoer:**  
   Bijvoorbeeld:  
   ```plaintext
   zwemmen:x:1001:
   judo:x:1002:
   ```

4. **Voeg de gebruiker `alice` toe aan de groepen `sporten` en `zwemmen`**  
   **Commando:**  
   ```bash
   sudo usermod -aG sporten,zwemmen alice
   ```

5. **Log in als `alice` en stel `sporten` in als primaire groep**
   **Commando's:**  
   ```bash
   su - alice
   newgrp sporten
   ```

---

#### Gebruikers aanmaken met primaire en secundaire groepen
Gebruik het volgende commando om gebruikers aan te maken:
```bash
sudo adduser --ingroup sporten --groups judo bob
sudo adduser --ingroup sporten --groups zwemmen carol
sudo adduser --ingroup sporten --groups judo daniel
sudo adduser --ingroup sporten --groups zwemmen eva
```
Controleer de lidmaatschappen:
```bash
id bob
id carol
id daniel
id eva
```

---

#### Verwijder de groep `alice` en controleer
**Commando's:**  
```bash
sudo groupdel alice
grep alice /etc/group
```

---

#### Tijdelijke uitschakeling van gebruiker `daniel`
**Commando:**  
```bash
sudo usermod -L daniel
```
**Controle:**  
Controleer `/etc/shadow`, waar een `!` voor het gehashte wachtwoord verschijnt:
```bash
grep daniel /etc/shadow
```

---

#### Verwijder gebruiker `eva` en haar homedirectory
**Commando:**  
```bash
sudo deluser --remove-home eva
```

---

#### Test toegang tussen gebruikers
1. **Controleer `carol`'s homedirectory**  
   ```bash
   cd ~carol
   touch test
   ```
2. **Probeer als `carol` naar `alice`'s homedirectory te navigeren**
   ```bash
   cd ~alice
   ```
   Als de permissies standaard zijn, heeft `carol` geen toegang vanwege de rechten `drwx------` op de home van `alice`.

3. **Maak een bestand in `alice`'s directory als `carol`**
   Dit lukt niet door de beperkte rechten.

---

#### Permissies voor gezamenlijke bestanden in directories
Om bestanden van elkaar niet te verwijderen, gebruik de sticky-bit:
```bash
sudo chmod +t /srv/groep/zwemmen
sudo chmod +t /srv/groep/judo
```

---

### 3.4.3 Reflectievragen

#### Verschil tussen `su -` en `sudo su -`
- **`su -`** gebruikt het wachtwoord van de gebruiker `root`.
- **`sudo su -`** gebruikt het wachtwoord van de huidige gebruiker, die lid moet zijn van de `sudo`-groep.

---

#### Drie manieren om een gebruiker tijdelijk uit te schakelen
1. **Account vergrendelen:**  
   ```bash
   sudo usermod -L username
   ```
2. **Shell wijzigen naar `/usr/sbin/nologin`:**  
   ```bash
   sudo usermod -s /usr/sbin/nologin username
   ```
3. **Wachtwoord verwijderen:**  
   ```bash
   sudo passwd -l username
   ```