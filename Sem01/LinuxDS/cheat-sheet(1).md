# Cheat sheet en checklists

Naam student: Ibrahim Asio


## uitleg over elke labo
# Curl 1.4.4

Het curl-commando is een veelgebruikt command-line tool waarmee je HTTP-verzoeken kunt doen naar webservers en data kunt ophalen of versturen. Het wordt vaak gebruikt om te communiceren met webservices, APIs, of om bestanden van het internet te downloaden.

| Taak                                        | Commando                  |
| :---                                        | :---                      |
| Je eigen Ip adres opvragen vanop  icanhazip           | `curl icanhazip.com`              |
| om de URL https://hmpg.net/ op te halent | `curl https://hmpg.net/`         |
| Sla de pagina op in een bestand, `-o` is om de inhoud van de website op te slaan                       | `curl -o hmpg.html https://hmpg.net/` |
| dMet e `-L` optie zorg je dat curl automatisch de redirect volgt en de uiteindelijke inhoud van de juiste URL ophaalt (Met `https://`)              | `curl -L hmpg.net`                |
| Om een bestand to downloaden van een ftp server en --output README geeft aan dat het bestand opgeslagen wordt in de huidige directory met als naam README    | `curl ftp://<example.com> --output README` |
| `-u anonymous` Verwijst naar de gebruikersnaam  anonymous | `curl -u anonymous: ftp://ftp.belnet.be/debian/README --output README_ANON`    |
|  `\|jq `  Een handige tool voor het werken met JSON, dit formatteert de JSON-uitvoer zodat het makkelijker te lezen is.           | `curl -L https://en.wikipedia.org/api/rest_v1/page/random/summary \| jq .`              |
| Voortgangsbalk verbergen  gebruiken wij de `-s` optie met `curl` | `curl -s -L https://en.wikipedia.org/api/rest_v1/page/random/summary --output voorbeeld` |




### <center> Bestand naam geven </center>

Commando: `curl -L "https://data.stad.gent/explore/?disjunctive.keyword&disjunctive.theme&sort=modified" \  --output "fietsenstallingen-$(date +%Y%m%d-%H%M%S).json"` <br><br>
 Uitleg: <br>
 `curl -L "https://data.stad.gent/explore/?disjunctive.keyword&disjunctive.theme&sort=modified"` : haalt de inhoud  van de opgegeven URL, en `-L` is voor redirect <br>
`--output "fietsenstallingen-$(date +%Y%m%d-%H%M%S).json"` : `--output` is om een naam voor een bestand toe te kennen, en `$` is command substitution om een varabel <br>
te plaatsen tussen de opgegeven tekst. `date` wordt gebruikt om de datum op te halen en `%Y%m%d` Dit geeft het jaar, de maand en de dag in een formaat zoals `20241001`. En `%H%M%S` Dit voegt het uur, de minuten en de seconden toe, zodat je iets krijgt als -`143512`
<br><br>


# I/O Redirection en filters  2.4.1

 Taak                                        | Commando                  |
| :---                                        | :---                      |
|een lijst van geïnstalleerde software opvragen  | `apt list --installed`|
| de `less` of de `more` zorgt ervoor dat je 1 pagina krijgt in de termianl, en telkens op spatie klikken, word er een nieuwe pagina getoond| `apt list --installed \| less` OR `apt list --installed \|more`|
|  De optie `>`  zorgt ervoor dat de output opgelslagen wordt in packages.txt in de huidige directory|   `apt list --installed > packages.txt` |
| De optie `2>&1` zorgt ervoor dat zowel de stadout als de stderr in packages.txt  geschreven worden en nie in de de terminal | `apt list --installed 2>&1 packages.txt `   |
| Gebruike de commando `head` om het eerste aantal rijen te tonen  |  `head -n 10 packages.txt` |
| De `ail -n +2` zrogt ervoor dat het begint met het weergeven vanaf de tweede regel.  |  `apt list --installed 2>/dev/null \| tail -n +2 > packages.txt` |
| `wc` is voor word count, en `l` staat voor lines, en `<` is om te zeggen dat de input is de `filename`, dus tel het aantal lijen in een bepaalde file | `wc -l < filename`  |
|   `-c` staat voor count, Wanneer je deze optie gebruikt, telt uniq het aantal opeenvolgende gelijke regels en geeft dit aantal weer voor elke unieke regel.| ` uniq -c \`  |
|Sorteer alfabetisch | `sort`|
| `-n` Deze optie zorgt ervoor dat de sortering op basis van numerieke waarden gebeurt in plaats van als tekst. `-r` zorgt voor een omgeveerd sortering| `sort -nr`|
| aalt de derde kolom uit het bestand, waarin de architectuur staat.| `awk '{print $3}' filename`|
| De grep commando zoekt op een "woord" in de file  |`grep "woord" file` |
|  De pipe (\|) stuurt de uitvoer van het apt list commando naar het volgende command, grep python: Dit filtert de uitvoer, zodat alleen de regels die "python" bevatten, worden weergegeven.  | `apt list --all-versions \| grep python`|
|  Dit gebruikt `/` als delimiter en pakt het eerste veld, dat de naam van het package bevat.| `cut -d'/' -f1 package naam` |
| Dit schrijft de unieke package-namen naar een bestand genaamd unique-packages.txt bijvoorbeeld [Vraag 11 van  de labo van HS2] | `> unique-packages.txt` |


<br><br>
### De `cut` commando: 
De `cut` commando wordt gebruikt om delen van een tekstbestand te extraheren. 
Dit kan handig zijn wanneer je alleen specifieke kolommen of velden van gegevens wilt isoleren.
- `-d' teken` ' : Deze optie geeft aan dat de delimiter (scheidingsteken) voor de velden de gegeven `teken` is, dus bijvoorbeeld -d '\' betekent dat de velden gescheiden zullen worden obv de `\`.

- `-f1`: Dit betekent dat we het eerste veld (de gegevens vóór de eerste `/`) willen selecteren (kan ook `f2`, `f3`).



# Variabelen  2.4.2



- PATH: Deze variabele bevat een lijst van directories (paden) waarnaar het systeem zoekt om uitvoerbare bestanden te vinden wanneer een opdracht in de shell wordt ingevoerd.
  <br>  <br>
- HISTSIZE: Deze variabele bepaalt het aantal opdrachten dat wordt opgeslagen in de geschiedenis van de shell.
  <br>  <br>
- UID: Dit is de User ID van de gebruiker die momenteel is ingelogd.
   <br>  <br>
-  HOME: Het pad naar de home directory van de ingelogde gebruiker.
   <br>  <br>
- HOSTNAME: De naam van de computer of host waarop je werkt.
   <br>  <br>
- LANG:   De taal en landinstellingen van de shell-omgeving.
   <br>  <br>
-  USER:  De gebruikersnaam van de ingelogde gebruiker.
   <br>  <br>
-  OSTYPE: Het type besturingssysteem dat wordt gebruikt.
 <br>  <br>
-  PWD: De huidige directory 
   <br>  <br>

# Variabelen in scripts 2.4.3


## Wat is SHEBANG?
- De shebang is een speciale tekenreeks aan het begin van een scriptbestand die aangeeft welke interpreter gebruikt moet worden om het script uit te voeren. Het bestaat uit een hekje `#` gevolgd door een uitroepteken `!`, dus #!, gevolgd door het pad naar de interpreter (bijvoorbeeld `/bin/bash` voor Bash, `/usr/bin/python3` voor Python), 
  Dus in ons geval hier `#!/usr/bin/bash`

## wat doet `set -o nounset`

-De opdracht `set -o nounset` in een shellscript (zoals een .sh bestand) is een manier om de shell aan te geven dat je wilt dat deze een foutmelding genereert wanneer je probeert een niet-gedefinieerde variabele te gebruiken. Dit helpt om bugs te voorkomen die voortkomen uit typfouten of het vergeten te initialiseren van variabelen.

#### De variabele met de login-naam van de gebruiker is niet gedefinieerd in het script zelf. Hoe heet dit soort variabelen?
  - Variabelen zoals `$USER` heten `omgevingsvariabelen`. Dit zijn variabelen die in de shell-omgeving zijn gedefinieerd en toegankelijk zijn door alle processen die vanuit die shell worden gestart. 


### Het definieren van een variabele in de command line
- het gebeurt vi ade volgende stappen in de command line: 
    - `variabele = waarde` 
    - `export variabele` 
- Hier hebben wij de variabele gemaakt en wij kunnen het gebruiken in de script.
  dus bijvroobeeld: 
    - `person = ibra`
    - `export person`
- Dan kunnen wij ook in de script de volgende regel uitvoeren `echo Hallo ${person}`
  en het zal `Hallo ibra` geven, omdat person is al gedefinieerd en geexporteerd.
- Om de variabele te verwijderen dan gebruiken wij `unset`, dus bv bij `unset person` zal de variabele verwederd worden.
- Wij kunnen ook de variabele definieren en de script uitvoeren in 1 lijn, als volgt: <br>
  
`person=ibra ./script.sh` en dat zal geven `Hallo ibra` als de script  `echo Hallo ${person}` heeft.

### Voor vraag 2 in 2.4.4:
 De oplossing is `#!/bin/bashawk -F: '$3 < 1000 {print $1}' /etc/passwd | sort`, en hier is de uitleg: <br>

Dit gebruikt awk om te filteren. Het `-F`: maakt : tot scheidingsteken, `$3 < 1000`selecteert rijen waar het derde veld (UID) kleiner is dan 1000, en `{print $1}` geeft alleen de gebruikersnaam (eerste veld) weer.
`sort`: Sorteert de gebruikersnamen alfabetisch. <br> <br>



### Voor vraag 3 in 2.4.4:
- `#!/bin/bash history | awk '{print $2}' | sort | uniq -c | sort -rn | head -10` <br>



- `history`: Geeft de lijst van uitgevoerde commando's in je shell-historiek.
- `awk '{print $2}'`: Haalt het eerste woord (commando) van elke regel op.
- `sort`: Sorteert de commando's alfabetisch, zodat dezelfde commando's bij elkaar - staan.
- `uniq -c`: Telt het aantal keren dat elk commando voorkomt.
- `sort -rn`: Sorteert de resultaten numeriek en omgekeerd, zodat de meest gebruikte commando’s bovenaan staan.
- `head -10`: Toont alleen de bovenste 10 commando's.

- Notatie: Wij moeten hier `source topcmd.sh` of `. topcmd.sh` zodat de script in de huidige shell uitgevoerd wordt en niet in een apparte sub shell, omdat als het in een apparte sub shell uitgevoerd wordt kijkgen wij een lege lijst omdat daar zijn er geen commando's uitgevoerd. 



# Curl 3.4.1.






 Taak                                        | Commando                  |
| :---                                        | :---                      |
|  om de UID en de GUI op te vragen   |    `id 'user'` |
|   Nieuwe gebruiekr toe te voegen  |   `sudo adduser ....`  |
|   Met `grep` kunnen wij een bepaalde patroon opzoeken in een belaapde bestand, dus hier wij zoeken de GID van de groep sporten in eht bestand `/etc/group`  |   `grep sporten /etc/group`  |
|  Voegt de gebruiker toe in een secundaire groep, `-a` staat voro append (toevoegen) en `G` staat voor group   |  `sudo usermod -aG sporten alice`   |
| Om in te loggen als `user`    |  `su - user`   |
|  om de `group` als primaire groep van `username` in te stellen |   `sudo usermod -g group username`  |
| ok een user uit te schakelen, `-L` staat voor flag, dat aangeeft dat de gebruiker vergrendeld moet worden    |    `sudo usermod -L user` |
|  Wij verifieren als de `user` vergrendeld wordt, als wij `!` zien voor het wachtwoord, dan betekent dat dat de gebruiker vergrendeld is.   |  `sudo grep user /etc/shadow`   |
|  de `user` opnieuw inschakelen in het systeem    | `sudo usermod -U user`    |
| om de `user` inclusief met zijn home directory te verwijderen     |  `sudo deluser --remove-home user`   |


### In welk bestand kan je de UID, gebruikersnaam, homedirectory, enz. van alle gebruikers terugvinden?

`/etc/passwd` :  In dit bestand vind je de informatie van alle gebruikers, zoals gebruikersnaam, UID (User ID), GID (Group ID), homedirectory en de standaard shell.
Met volgende structuur: <br>

`gebruikersnaam:x:UID:GID:commentaar:homedirectory:shell`   bv   `hogent:x:1001:1001::/home/hogent:/bin/bash`

### In welk configuratiebestand kan je al de bestaande gebruikersgroepen nakijken, en ook de gebruikers die lid zijn van elke groep?
`/etc/group` : Dit bestand bevat alle groepen op het systeem en toont ook welke gebruikers lid zijn van elke groep.
Met volgende structuur: <br>
`groepsnaam:x:GID:gebruikerslijst` bv `sudo:x:27:hogent,alice`

### In welk configuratiebestand vind je de wachtwoorden van alle gebruikers?
`/etc/shadow` : In dit bestand staan de wachtwoorden van alle gebruikers. De wachtwoorden worden gehashed en zijn alleen toegankelijk voor de root-gebruiker of gebruikers met superuser-rechten.


#### 3.4.1 - 5.7.4: Probeer nu als carol onder de “thuismap” van alice ook een bestand test te maken. Lukt dit? Kan je dit verklaren?
Nee, wij krijgen `Permission denied`,De toegang tot de thuismap van alice is waarschijnlijk beperkt tot alleen alice en de root-gebruiker. Normaal gesproken zijn de permissies voor de home-directory van een gebruiker ingesteld op 700 (rwx------), wat betekent dat alleen de eigenaar toegang heeft.


### 3.4.1 - 6.1 Bekijk de eerste regels van het bestand /etc/shadow. Wat bemerk je bij de gebruiker root?
Een `!` wat beteknt dat de `root` geen geldige wachtwoord heeft. 
Maar na het instellen van het wachtwoord, wordt de `!` verdwijnt, wat betekent dat de root een geldige wachtworod heeft.

### 3.4.1 - 7.2 Bewerk /etc/passwd zodat je ook bash gebruikt als default shell.
- Open het bestand /etc/passwd in een teksteditor (bijvoorbeeld `nano` of `vi`):
  -  sudo nano /etc/passwd
- Zoek naar de regel die je nieuwe gebruiker beschrijft. Deze zal eruitzien als:
  - `<jouw_loginnaam>:x:<UID>:<GID>:,,,:/home/<jouw_loginnaam>:/bin/sh`
- Verander de laatste kolom van /bin/sh naar /bin/bash:
  -  `<jouw_loginnaam>:x:<UID>:<GID>:,,,:/home/<jouw_loginnaam>:/bin/bash` 


### 3.4.1 - 7.4 Nu wil je jezelf eveneens adminstrator van het systeem maken, zodat je met sudo beheerstaken kan uitvoeren. Aan welke groep voeg je jezelf hiervoor toe?

- m jezelf admin-rechten te geven, moet je jezelf toevoegen aan de sudo-groep. Dit is de groep die gebruikers toestaat om sudo-commando's uit te voeren. Voer het volgende commando uit:
  - `sudo usermod -aG sudo <jouw_loginnaam>`
- Om te verifiëren dat je succesvol bent toegevoegd aan de sudo-groep, kun je het volgende commando uitvoeren:
  - `groups <jouw_loginnaam>`
  

### 3.4.2 - 1. Wijzig de eigenaar en groepseigenaar
- Gebruik het chown-commando om de eigenaar en groepseigenaar in te stellen voor de directories
  - sudo chown carol:zwemmen /srv/groep/zwemmen
  - sudo chown bob:judo /srv/groep/judo
  
### 3.4.2 - 6. Zorg er nu voor dat de groepseigenaar van de directory zwemmen automatisch de groepseigenaar wordt van alle bestanden en directories die onder zwemmengemaakt worden. Doe hetzelfde voor de directory judo. 
- `sudo chmod g+s /srv/groep/zwemmen`
- `sudo chmod g+s /srv/groep/judo`
- Het commando `sudo chmod g+s /srv/groep/...` is bedoeld om de setgid (set group ID) bit in te stellen op de directory `/srv/groep/....`.
  - `g`: Dit staat voor "group" en verwijst naar de groepspermissies.
  - `+s`: Dit voegt de setgid bit toe aan de groepspermissies 
- De setgid-bit zorgt ervoor dat wanneer een bestand of een directory wordt uitgevoerd of geopend, de groeps-ID van het bestand of de directory wordt overgenomen in plaats van de groeps-ID van de gebruiker die het bestand aanmaakt. 
  

  ### 3.4.2 - 7. Zorg er nu voor dat de gebruikers elkaars bestanden niet kunnen verwijderen. Als de gebruiker echter eigenaar is van het betreffende bestand mag dit wel. Leg uit hoe je dit doet en controleer. Schrijf je gevolgde procedure op.
- Om ervoor te zorgen dat gebruikers elkaars bestanden niet kunnen verwijderen, maar dat de eigenaar dat wel kan, moeten we de permissies van de directories wijzigen naar rwxrwx--- (770):
  - sudo chmod 770 /srv/groep/zwemmen
  - sudo chmod 770 /srv/groep/judo 
    - Met deze permissies kunnen alleen de eigenaren en de leden van de groep de bestanden bekijken en aanpassen.
  

  ### 3.4.3 - 1.
  - `su -` : Bij het gebruik van het commando su - gebruik je het wachtwoord van de root-gebruiker. <br><br>
  - `sudo su -` : Bij het gebruik van sudo su - gebruik je het wachtwoord van de huidige gebruiker die het commando uitvoert. Dit is de gebruiker die momenteel is ingelogd en die moet zijn opgenomen in de sudoers-groep (of een andere groep met sudo-rechten).
- ### 3.4.3 - 2.
  
- Lock het account:
  - `sudo usermod -L <gebruikersnaam>` : 
    - Dit voegt een ! toe aan het begin van het wachtwoord in het /etc/shadow-bestand, waardoor de gebruiker niet meer kan inloggen.
- Stel de shell in op `/sbin/nologin`:
  - `sudo usermod -s /sbin/nologin <gebruikersnaam>`
    - Je kunt de shell van de gebruiker wijzigen naar /sbin/nologin, wat betekent dat de gebruiker niet kan inloggen.
- Verander de groepslidmaatschappen: 
    - sudo gpasswd -d <gebruikersnaam> <groep>  
      -  Door de gebruiker uit een groep te verwijderen, kunnen ze mogelijk geen toegang meer krijgen tot bepaalde bestanden of systemen die aan die groep zijn toegewezen. <br><br>

 
  
# Webserver opzetten  4.4.1.


Taak                                        | Commando                  |
| :---                                        | :---                      |
|  `sudo apt install apache2`     |   installeert de Apache webserver.    |
|  `sudo systemctl start apache2`     |  start de Apache webserver.     |
|   `sudo systemctl enable apache2`    |   orgt ervoor dat Apache automatisch start bij het opstarten van de VM.    |
|  `http://localhost` of `http://127.0.0.1`     |    Om te controleren als apache2 correct werkt   |
|  `sudo apt install php libapache2-mod-php`     |   installeert zowel PHP als de module die Apache in staat stelt om PHP-scripts uit te voeren.    |
|    `sudo apt install mariadb-server`   |    mariadb server installeren   |
| `sudo mysql_secure_installation`      | Dit commando zorgt ervoor om het root-wachtwoord in te stellen en andere beveiligingsopties te configureren      |
|    `sudo mysql < testScript`   |   Voert het script `testScript` via mysql commando    |



- De standaard locatie voor de Apache2 server op onze VM is  `/var/www/html`, dus wij makne daar een `.php` bestand om te testen als het correct werkt, 
  En nadat wij het bestand invullen kunnen dat testen via `http://localhost/info.php`, `info.php` in de naam van het bestand dat gecreeerd wordt in `/var/www/html`

  
#  Scripting oefeningen '102'  4.4.2.

Taak                                        | Commando                  |
| :---                                        | :---                      |
| `${0}`  | Naam script afprinten  |
|  `${1}, ${2}, …` |   Eerste, tweede, … argument|
|  `${10}` |   Tiende argument (accolades verplicht!)|
|  `${*}` | Alle argumenten: ${1} ${2} ${3}...  |
| `${*}`  |  Alle argumenten: "${1}" "${2}" "${3}"... |
| `${#}`| Aantal positionele parameters |
| `shift`  | hift de parameters drie plaatsen naar linkss   |
|  `echo "Param 1:    ${1:-}"` |  Print het eerste argument of niets als het argument niet bestaat.  |
|  `seq 2 2 20` | wordt gebruikt in `for`-loop en wordt gelezen als  `seq START INCREMENT END` |


- `shift`: <br>  commando shift schuift positionele parameters op naar links:

    `${1} verdwijnt` <br>
    `${2} wordt ${1}` <br>
    `${3} wordt ${2}` <br>
    enz.
- Itereren over lijnen in een bestand: <br>
  via:<br>
   `while read -r line; do`<br>
    `# process "${line}"`<br>
      `done < file.txt` <br>
    - De while-lus wordt herhaald zolang er nieuwe regels te lezen zijn.
   - De opdracht `read -r line` leest een regel van de standaardinvoer en slaat deze op in de variabele line.

       - `-r` voorkomt dat de backslashes in de invoer worden geïnterpreteerd als escape-tekens. Dit betekent dat als er een backslash in de tekst staat, deze als een normale karakter wordt behandeld en niet als een speciaal teken.
   - `# process "${line}"` : 
       - Dit is de sectie waarin je de verwerking van de gelezen regel zou doen. In plaats van # process "${line}" kun je hier een andere opdracht of functie plaatsen die je wilt uitvoeren met de inhoud van line.
    - `done < file.txt`: 
      - De < file.txt aan het einde van de done-regel betekent dat de while-lus zijn invoer haalt uit het bestand file.txt in plaats van de standaardinvoer (zoals het toetsenbord).
  
  ### Syntax van For - While...
- `for i in {2..20..2}; do`<br>
  `echo "${i}"`<br>
`done`<br>

  - `for i in {2..20..2}; do` : <br>
      - `{START..END..INCREMENT}`

<br><br>
- `for i in $(seq 2 2 20); do`<br>
  `echo "${i}"`<br>
`done`<br>
  - `for i in $(seq 2 2 20); do`:
    -  `seq START INCREMENT END`
  <br><br>
 - `for ((i=0; i<=10; i++)); do`<br>
  `echo "${i}"`<br>
`done`<br>
  - Gewone for-lus
 <br><br>

- `while [ "$#" -gt 0 ]; do`<br>
 ` printf 'Arg: %s\n' "${1}"`<br>
 ` # ...`<br>
 ` shift`<br>
`done`<br>

  - Uitleg: 
    - De while-lus blijft draaien zolang de voorwaarde waar is.<br><br>
    - "$#" is een speciale variabele in Bash die het aantal argumenten dat aan het script is doorgegeven weergeeft.<br><br>
    - De voorwaarde `-gt 0` betekent "groter dan 0", wat betekent dat de lus zal blijven draaien zolang er argumenten zijn om te verwerken.<br><br>
    - `printf 'Arg: %s\n' "${1}"` : Dit commando drukt het eerste argument af dat aan het script is doorgegeven.<br><br>
    - `${1}` is de eerste positionele parameter (het eerste argument).<br><br>
    - `printf` is een meer geavanceerde manier om tekst af te drukken dan `echo`, en biedt meer controle over de opmaak.<br><br>
    - In dit geval wordt het eerste argument afgedrukt met de prefix `"Arg: "`.<br><br>
    - `shift` : shift is een Bash-opdracht die alle positionele parameters naar links verschuift. Dit betekent dat ${1} (het eerste argument) wordt verwijderd en de rest van de argumenten wordt opnieuw genummerd.<br><br>
      -  Na shift wordt `${2}` het nieuwe `${1}`, `${3}` wordt `${2}`, enzovoort.<br><br>
          - Hierdoor kan de while-lus opnieuw controleren of er nog argumenten zijn en deze afdrukken.<br><br>
          - 
 - `for arg in "${@}"; do`<br>
  `printf 'Arg: %s\n' "${arg}"`<br>
  `# ...`<br>
`done`<br>

    - `${@}` is een speciale variabele in Bash die verwijst naar alle positionele parameters (argumenten) die aan het script zijn doorgegeven. Dit is belangrijk om te weten, omdat het elk argument apart doorgeeft aan de lus, zelfs als er spaties in de argumenten staan.
<br><br><br><br>
  

# Globbing 5.4.1 

- Om een aantal bestanden te creeren met naam file$ waarbij de $ een getal van 1 tem 20 is  kunnen wij de volgende gebruiken in de terminal: 
    - for i in {1..19}; do touch "file${i}"; do


1. Alle bestanden die beginnen met file ==> `ls file*`
2. Alle bestanden die beginnen met file, gevolgd door één letterteken (cijfer of letter) ==> `ls file?`
3. Alle bestanden die beginnen met file, gevolgd door één letter, maar geen cijfer ==> `ls file[a-zA-Z]` (Enkel 1 letter)
4. Alle bestanden die beginnen met file, gevolgd door één cijfer, maar geen letter ==> `ls file[0-9]`
5. De bestanden file12 t/m file16 ==> `ls file1[2-6]` 
6. Bestandern die beginnen met file, niet gevolgd door een  ==> `ls file[^1]*`


# AWK 5.4.2 
1.  Omzetten van `cat /etc/passwd | grep bash | awk -F: '{print $1}'` om enkel AWK te gebruiken gebeurt als volgt: `awk -F: '/bash$/ {print $1}' /etc/passwd`
2. `curl -o <url>`  
3. `awk 'NR > 1 relanders.csv'` : Hier wordt alleen de data afgedrukt vanaf de tweede regel (`NR > 1` betekent “alle regels behalve de eerste”).
4. `awk -F, 'NR > 1 {if (min == "" || $(NF-2) < min) min = $(NF-2); if ($(NF-2) > max) max = $(NF-2)} END {print "Min:", min, "Max:", max}' rlanders.csv` en hier is de uitleg van de commando: 


- `awk -F,`:

    - `awk` is een krachtige tekstverwerkings-tool in Unix/Linux.
    `-F,` stelt de scheidingsteken in op een komma (,), wat betekent dat awk de invoer als een CSV-bestand interpreteert (Comma-Separated Values).

- `NR > 1`:

    `NR` is een ingebouwde variabele in awk die het huidige regelnummer bijhoudt.
    `NR > 1` betekent dat de actie binnen de accolades alleen wordt uitgevoerd voor regels na de eerste regel (de header). Dit zorgt ervoor dat de header van het CSV-bestand wordt overgeslagen.

- `{if (min == "" || $(NF-2) < min) min = $(NF-2); if ($(NF-2) > max) max = $(NF-2)}`:

    - Dit is het actieblok dat wordt uitgevoerd voor elke regel die voldoet aan de voorwaarde (NR > 1).
    - `$(NF-2)` verwijst naar de op twee na laatste kolom van de huidige regel:
        NF is een andere ingebouwde variabele in awk die het aantal velden (kolommen) in de huidige regel bijhoudt.
        `$(NF-2)` geeft de waarde van de op twee na laatste kolom.
    - De eerste if-voorwaarde: if (min == "" || $(NF-2) < min):
        Deze controleert of de variabele min nog niet is ingesteld (d.w.z. als het nog een lege string is) of of de waarde van de op twee na laatste kolom kleiner is dan de huidige min. Als dat zo is, wordt min bijgewerkt naar de waarde van de op twee na laatste kolom.
    - De tweede if-voorwaarde: `if ($(NF-2) > max)`:
        Dit controleert of de waarde van de op twee na laatste kolom groter is dan de huidige max. Als dat zo is, wordt max bijgewerkt naar de waarde van de op twee na laatste kolom.

- `END {print "Min:", min, "Max:", max}`:

    Dit blok wordt uitgevoerd nadat alle regels zijn verwerkt.
    Hier worden de waarden van min en max afgedrukt met een label (`"Min:"` en `"Max:"`).


5.  `awk -F, '{sum += $6} END {print sum}' rlanders` : 
- `END:` Dit is een speciaal blok in awk dat betekent "aan het einde van de input".
 <center>Opmerking</center>


1. Wij hebben 2 oplossingen: 
      1. `awk 'NR > 1 && $2 == "Female" {sum += $6} END {print sum}' rlanders.csv` : 
        - Hier gebruiken wij geef if statement, en het levert exact hetzelfde resutlaat
      2. `awk 'NR > 1 { if ($2 == "Female") { sum += $7 } } END { print sum }' rlanders.csv` : 
        - Heir maken wij gebruik van de if statement, het kan opgelost worden met alle 2 maneiren.

- Wij kunnen ook een script scrhijven om aan te geven dat wij niet de kolom nummer # willen optellen, maar de kolom met naam ,,,. 
  Het voordeel hiervan is dat is dat als in de toekomst een andere kolom toegevoegd  wordt voor de gewenste kolom, dan schuift de kolom 1 naar rechts dus als het kolom 6 was, na het toevoegen van een niewue kolom wordt het kolom 7, en zo krijgen wij een foute resutlaat. Maar bij het aangeven van de kolomnaam, wij garanderen altijd dat het programma onder deze kolom gaat opzoeken. 
  De script kan als volgt eruit zien: 

```
  awk -F, '
BEGIN {
    # Initialiseer de indexen als ongedefinieerd
    months_idx = -1
    count_idx = -1
}
NR == 1 {
    # Lees de header en sla de indexen op
    for (i = 1; i <= NF; i++) {
        if ($i == "Months") months_idx = i
        if ($i == "Count") count_idx = i
    }
    next # Ga naar de volgende regel
}
# Voor alle andere regels, bereken de som van Count voor Female
$2 == "Female" {sum += $count_idx}
END {
    print sum
}' rlanders.csv
```
<br><br><br>
6. `awk -F, 'NR > 1 {count[$8]++} END {for (i = 1; i <= 5; i++) printf "%d\t%d\n", i, count[i]}' rlanders.csv`

- `-F,`: Dit geeft aan dat de velden in het CSV-bestand door komma's gescheiden zijn.

- `NR > 1`: Dit zorgt ervoor dat de headerregel wordt overgeslagen.

- `count[$8]++`: Dit telt het aantal voorkomens van elke waarde in de kolom Survey (de achtste kolom).

- `END {for (i = 1; i <= 5; i++) printf "%d\t%d\n", i, count[i]}`: Dit drukt voor elke waarde van 1 tot 5 het aantal af met tab-gescheiden outpu<br><br>

7. `awk 'NR > 1 {sum += $3; n++} END {print sum / n}' rlanders.csv` <br><br>

8. `awk 'NR > 1 {sum[$2] += $3; count[$2]++} END {for (gender in sum) print gender ":", sum[gender] / count[gender]}' rlanders.csv`
- Een woordje uitleg: <br>
Hoe werkt het? het belangrijkste deel hier is  `{sum[$2] += $3; count[$2]++}`, en dat werk asl volgt: Hier wordt de waarde van de derde kolom (`$3`, dat de Money-waarde is) toegevoegd aan de array sum, waarbij de sleutel de waarde van `$2` (het geslacht) is.
Als `$2` bijvoorbeeld `"Male"` is, wordt de waarde van `$3` (bijvoorbeeld 500) opgeteld bij `sum["Male"]`.
Voor `"Female"` zou het ook gelden: `sum["Female"]` wordt met de waarde van `$3` verhoogd.<br><br>
- In de END-sectie, wordt door de sum array gelopen met for (gender in sum). Hier is gender een variabele die telkens een sleutel van de sum array aanneemt, dat zijn de unieke geslachten (bijvoorbeeld "Male" en "Female"). Voor elke iteratie drukt het commando het gemiddelde uit: `sum[gender] / count[gender]`. Dit geeft het gemiddelde geldbedrag per geslacht.  
9. Het script ziet er als volgt uit: <br>
```
awk 'NR > 1 {
    for (i = 3; i <= 7; i++) {
        sum[i] += $i
        count[i]++
    }
} 
END {
    for (i = 3; i <= 7; i++) {
        print "Gemiddelde kolom", i, ":", sum[i] / count[i]
    }
}' rlanders.csv
```
<br><br>

- `sum[i]` : De waarden van sum[i] zijn de totale sommen van de waarden in elke kolom van het CSV-bestand voor de kolommen 3 t/m 7. Als de waarde in kolom 3 (Money) van de eerste regel 500 is, dan wordt sum[3] 500 na die regel.
- `$i` : De variabele `i` in het script is een iterator die in de loop door de waarden 3 t/m 7 gaat. Dus, als i 3 is, dan is `$i` gelijk aan `$3`, wat de waarde van de derde kolom (Money) in de huidige regel betekent. Wanneer i 4 is, dan is $i gelijk aan $4 (Days), enzovoort.


# JQ 5.4.3.

2. om `jq` te gebruiken voeren wij de volgende uit: <br>
`cat Bestand | ja`, op deze manier wordt de inhoud mooi weergegeven.<br><br>


# Scripting "103" - opgaves 6.4.1.
## Oefening 1 Safe remove 
<br><br>

Taak                                        | Commando                  |
| :---                                        | :---                      |
|  `set -o errexit` | Het script stopt bij niet-nul exitstatus van een commando.  |
| `set -o nounset`  | Het script stopt bij gebruik van niet-gedefinieerde variabelen.  |
| `set -o pipefail`  |  Het script stopt als een commando binnen een pipeline faalt. |



- Om te controleren als een direcotry bestaat: <br>
  -  `-d "DIRECTORY"`
- Als wij `mkdir` gebruiken en wij willen geen foutmelding krijgen als de gemaakte directory bestaat, dan voegen wij de optie `-p` toe:
  - `mkdir -p "DIRECTORY"` : <br> 
    - `-p` zorgt ervoor dat:
    - Als de map al bestaat, er geen foutmelding komt.
    - Eventueel benodigde bovenliggende mappen ook aangemaakt worden.
### Een voorbeeld functie van hoe een deel van oef 1 werkt: 
```
function clean_old_files {
    echo "Cleaning up old files..."
    find "$TRASH_DIR" -type f -mtime +$DAYS_THRESHOLD -print -exec rm -v {} \;
}
```
<br><br>

- `find "$TRASH_DIR" -type f -mtime +$DAYS_THRESHOLD -print -exec rm -v {} ;` <br>
  Deze regel gebruikt het `find`-commando om bestanden te zoeken en verwijderen die ouder zijn dan een bepaalde periode. Laten we elk deel van dit commando opbreken:
    - `find "$TRASH_DIR"` <br>
    Het `find`-commando zoekt in de directory die wordt aangegeven door de variabele `$TRASH_DIR`, wat standaard de directory `~/.trash` is (waar het script "verwijderde" bestanden opslaat). De waarde van `$TRASH_DIR` wordt ingesteld in het hoofdgedeelte van het script.
  - `type f`
    - Dit gedeelte zorgt ervoor dat `find` alleen naar gewone bestanden zoekt (`-type f `staat voor "file"). Hierdoor worden andere bestandssoorten, zoals directories of symbolische links, genegeerd.

  - `mtime +$DAYS_THRESHOLD`
    - Het argument `-mtime` staat voor "modification time" (wijzigingstijd). Met `-mtime +$DAYS_THRESHOLD` worden bestanden geselecteerd die langer dan `$DAYS_THRESHOLD` dagen geleden zijn gewijzigd.

    De variabele `$DAYS_THRESHOLD` is ingesteld op 14 in het script, wat betekent dat alle bestanden die meer dan 14 dagen oud zijn worden geselecteerd voor verwijdering. Dit maakt het mogelijk om alleen oudere bestanden op te ruimen en recentere bestanden ongemoeid te laten.

  - print
    - Dit deel zorgt ervoor dat `find` de naam van elk gevonden bestand afdrukt. Hierdoor krijgt de gebruiker een overzicht van welke bestanden gevonden zijn en verwijderd zullen worden.
  <br><br>

  - `exec rm -v {} ;`
    - De -`exec`-optie van find voert een specifiek commando uit voor elk bestand dat aan de zoekcriteria voldoet. In dit geval is het commando rm -v {}, wat het volgende doet:

        - `rm -v` verwijdert het bestand en geeft daarbij een gedetailleerde uitvoer (`-v` staat voor "verbose"). Dit betekent dat elke verwijderde bestandsnaam naar de standaarduitvoer (meestal het scherm) wordt geschreven, zodat de gebruiker precies kan zien welke bestanden zijn verwijderd.
        - `{}` is een tijdelijke aanduiding voor de naam van het bestand dat `find `gevonden heeft. Voor elk bestand dat aan de criteria voldoet, vervangt `find` `{}` door de bestandsnaam.
        - `\;` sluit de `-exec`-expressie af. Dit teken is vereist zodat `find` weet dat het `rm -v`-commando klaar is.
<br><br>

- `if [[ $# -eq 0 ]]; then`: 
  - `[[ ... ]]` is een syntaxis voor testexpressies in Bash. Het wordt vaak gebruikt om condities te evalueren, zoals of een variabele een bepaalde waarde heeft of of een bestand bestaat.
  - In dit geval wordt `[[ $# -eq 0 ]]` gebruikt om te controleren of er geen argumenten zijn meegegeven bij het starten van het script.

  - `$#`:

    - `$#` is een speciale variabele in Bash die het aantal argumenten bevat dat aan het script is doorgegeven.
    - Bijvoorbeeld, als het script wordt uitgevoerd met `./srm.sh file1.txt file2`.txt,  dan is `$#` gelijk aan 2, omdat er twee argumenten zijn (`file1.txt` en `file2.txt`).

### De for-lus van de scripting: 
```
for file in "$@"; do
    # Check if it's a regular file
    if [[ -f "$file" ]]; then
        # Compress and move file to trash directory
        gzip -c "$file" > "$TRASH_DIR/$(basename "$file").gz"
        rm -v "$file"
        echo "renamed '$(basename "$file").gz' -> '$TRASH_DIR/$(basename "$file").gz'"
    else
        echo "$file is not a file! Skipping..."
    fi
done
```

-  De speciale variabele `"$@"` bevat alle argumenten (bestandsnamen) die aan het script zijn meegegeven, waarbij elk bestand afzonderlijk wordt behandeld: 
   - `$@` staat voor alle argumenten die aan het script zijn meegegeven, elk als een afzonderlijke waarde. Dus als je het script bijvoorbeeld uitvoert met meerdere bestandsnamen als argumenten, zoals `./srm.sh file1.txt file2.txt`, dan bevat `$@` de waarden `"file1.txt"` en `"file2.txt"`.
   <br><br>
  
   -  `"$@"` zorgt ervoor dat elk argument als een afzonderlijk item wordt behandeld, zelfs als er spaties in de bestandsnamen staan. Als een bestandsnaam spaties bevat, zorgt `"$@"` ervoor dat Bash deze correct als één item herkent. Zonder de dubbele quotes zou Bash de bestandsnaam splitsen op de spatie, wat fouten zou veroorzaken.
<br><br>

    - Voorbeeld: Stel dat we het script aanroepen als `./srm.sh "file 1.txt" file2.txt`.
    Met for file in `"$@"` zal de lus file één keer toewijzen aan `"file 1.txt"` en daarna aan `"file2.txt"`, zonder de spatie te splitsen.
    Zonder de dubbele quotes (dus for file in `$@`), zou Bash `"file 1.txt"` splitsen in `"file"`, `"1.txt"`, en `"file2.txt"`, wat niet de bedoeling is
<br><br>

- `if [[ -f "$file" ]]; then` : 
  - Deze regel controleert of het opgegeven bestand een regulier bestand is met behulp van `[[ -f "$file" ]]`.
  - `-f` is een testoptie die waar is als `$file` een regulier bestand is (geen directory, link, enz.). Als `$file` een regulier bestand is, gaat het script door naar de volgende stap. <br><br>

- `gzip -c "$file" > "$TRASH_DIR/$(basename "$file").gz"`: <br><br>
  - `gzip -c "$file"`: Het commando `gzip -c` comprimeert het bestand zonder het origineel te verwijderen. De `-c` optie betekent "compress to standard output", wat betekent dat de uitvoer van `gzip` (de gecomprimeerde inhoud) naar de standaarduitvoer gaat in plaats van naar een nieuw bestand op dezelfde locatie.
  <br><br>
  - `> "$TRASH_DIR/$(basename "$file").gz"`: De gecomprimeerde uitvoer wordt omgeleid (`>`) naar een nieuw bestand in de prullenbak-directory (`$TRASH_DIR`). De naam van het bestand wordt bepaald door `$(basename "$file").gz`, wat de oorspronkelijke bestandsnaam neemt, de padinformatie verwijdert (met basename), en .gz toevoegt aan het einde: <br><br>
    - `basename "$file"` geeft alleen de bestandsnaam zelf terug, zonder het pad. Dus als file bijvoorbeeld `/path/to/file1.txt` is, dan geeft `basename "$file"` alleen `file1.txt`.<br><br>
    - We willen in dit geval alleen de bestandsnaam, omdat het doel is om het gecomprimeerde bestand in de prullenbakmap (`$TRASH_DIR`) te zetten zonder dat er onnodige directory-structuren worden aangemaakt.
  <br><br>
  - Bijvoorbeeld, als het bestand `file1.txt` heet, wordt het gecomprimeerd naar `$TRASH_DIR/file1.txt.gz`.


## Oefening 2 Analyseer Github repo

 - For-loop om door bestanden in de root van de repository te lopen
```
for item in "$REPO_DIR"/*; do
    # Controleer of het een directory is
    if [[ -d "$item" ]]; then
        echo "$(basename "$item") is een directory en wordt overgeslagen"
        continue
    fi

    # Controleer of het een speciaal bestand is
    if [[ -b "$item" || -c "$item" ]]; then
        echo "$(basename "$item") is een speciaal bestand, hoort deze thuis in de repository?"
        continue
    fi

    # Controleer het bestandstype
    file_type=$(file "$item")
    if [[ $file_type == *"ASCII text, with CRLF line terminators"* ]]; then
        echo "$(basename "$item") heeft DOS regeleindes, zet om met dos2unix"
    elif [[ $file_type == ELF* ]]; then
        echo "$(basename "$item") is een binaire executable, hoort deze thuis in de repository?"
    fi
done
```
<br><br>

### Uitleg: 

- `for-loop`

    - Beschrijving: Deze for-loop doorloopt alle bestanden en mappen in de root van de opgegeven repository-directory ($REPO_DIR).
    - Werking:
        - `$REPO_DIR/*` geeft een lijst van alle bestanden en directories in de opgegeven map.
        - Elk item in deze lijst wordt aan de variabele `item` toegekend, en de `for`-loop voert de opgegeven acties uit voor elk item.
<br><br>

- `if [[ -d "$item" ]]`

    - Beschrijving: Controleert of het huidige `item` een directory is.
    - Werking:
        - `-d "$item"` is waar als `item` een directory is.
        - Actie: Als het `item` een directory is, drukt het script een bericht af dat de directory wordt overgeslagen.
        - Reden: Het script moet alleen bestanden controleren; directories worden overgeslagen om te voorkomen dat de `for`-loop recursief in subdirectories gaat.
        - Continue-statement: `continue` zorgt ervoor dat het script doorgaat naar de volgende iteratie van de `for`-loop, zonder verdere controles voor dit `item`.
<br><br>

- `if [[ -b "$item" || -c "$item" ]]` : 

    - Beschrijving: Controleert of het huidige `item` een "block special" of "character special" bestand is (bijvoorbeeld apparaatbestanden).<br><br>
    - Werking:
        - `-b "$item"` controleert of het een "block special" bestand is, en `-c "$item"` controleert of het een "character special" bestand is.<br><br>
        - Actie: Als één van deze waar is, geeft het script een melding dat het een speciaal bestand is.<br><br>
        - Reden: Speciale bestanden horen meestal niet thuis in een Git-repository.<br><br>
        - Continue-statement: Door `continue` te gebruiken, gaat het script door naar de volgende iteratie, zonder verdere checks voor dit `item`.<br><br>
      
- `file_type=$(file "$item")` en `if`-structuur voor bestandstype: 

    - Beschrijving: Het file-commando geeft informatie over het bestandstype terug.
        De uitvoer wordt opgeslagen in de variabele `file_type`.<br><br>
    - Werking:
        De volgende `if`-statements controleren specifieke bestandstypen op basis van de uitvoer van file.<br><br>

- `if [[ $file_type == *"ASCII text, with CRLF line terminators"* ]]` : 

    - Beschrijving: Controleert of het bestand DOS-stijl regeleindes bevat.
    - Werking:
        - `*` is een wildcard, zodat `file_type` wordt gecontroleerd op de aanwezigheid van de volledige tekst `"ASCII text, with CRLF line terminators"`.<br><br>
        - Actie: Als dit klopt, geeft het script een melding dat het bestand moet worden omgezet naar Unix-stijl regeleindes.<br><br>
        - Reden: CRLF-regeleindes (DOS-stijl) kunnen ongewenst zijn in een Unix-omgeving. `dos2unix` converteert het naar Unix-stijl regeleindes.<br><br>
- elif [[ $file_type == ELF* ]]

    - Beschrijving: Controleert of het bestand een ELF-binaire executable is..<br><br>
    - Werking:
        - `ELF*` zoekt naar bestanden waarvan de uitvoer begint met `ELF`, wat typisch is voor Linux-uitvoerbare bestanden..<br><br>
        - Actie: Als het een ELF-executable is, geeft het script een waarschuwing..<br><br>
        - Reden: Executables horen vaak niet thuis in een repository, omdat ze vaak afgeleid zijn van broncode en opslag van binaries de repository kan verzwaren.
.<br><br>

```
find "$REPO_DIR" -maxdepth 1 -type f -name "*.sh" | while read -r script; do
    if [[ ! -x "$script" ]]; then
        echo "Shellscript $(basename "$script") is niet uitvoerbaar, maak het uitvoerbaar met chmod +x $(basename "$script")"
    fi
done

```

### Uitleg

- `find`-commando

    - Beschrijving: Het `find`-commando zoekt naar shellscripts (`*.sh`) in de root van de repository..<br><br>
    - Werking:
        - `-maxdepth 1` zorgt ervoor dat `find` alleen bestanden in de root directory zoekt, niet in subdirectories..<br><br>
        - `-type f` beperkt de zoekresultaten tot gewone bestanden..<br><br>
        - `-name "*.sh"` zoekt specifiek naar bestanden die eindigen op `.sh` (typisch voor shellscripts)..<br><br>
        - Pijp naar `while`-lus: De uitvoer van `find` wordt doorgegeven aan een `while`-lus die elk gevonden bestand (`script`) controleert..<br><br>

- `if [[ ! -x "$script" ]]`

    - Beschrijving: Controleert of het bestand niet uitvoerbaar is.
    - Werking: .<br><br>
        - `! -x "$script"` is waar als het bestand niet uitvoerbaar is..<br><br>
        - Actie: Als het bestand niet uitvoerbaar is, geeft het script een aanbeveling om het uitvoerbaar te maken met `chmod +x`..<br><br>
        - Reden: Shellscripts moeten uitvoerbaar zijn om ze direct vanuit de commandoregel te kunnen starten, wat handig is voor scripts in een Git-repository.


# . Scripting "201" 7.4.1

- In het script van `passpharse.sh`: <br>
- `set -euo pipefail` : 
  - `set -e`: Stopt het script als een van de commando's een niet-nul (fout) exitstatus geeft.
  - `set -u`: Stopt het script als een niet-gedefinieerde variabele wordt gebruikt.
  - `set -o` pipefail: (optioneel, hier niet van toepassing) Stopt het script als een fout optreedt in een van de commando’s binnen een pijplijn.
<br><br>

- `process_cli_args "${@}"` : De functieaanroep `process_cli_args "${@}"` in het script betekent dat alle command-line argumenten die aan het script zijn meegegeven, doorgegeven worden aan de functie process_cli_args. <br><br>
- `shuf -n "${num_words}" "${word_list}" | tr '\n' ' ' | sed 's/ $/\n/'`: 
  - `shuf`: Een commando dat de regels in een bestand door elkaar schudt en willekeurig een selectie maakt <br><br>
  - `-n "${num_words}"`: Dit specificeert het aantal regels dat moet worden geselecteerd. <br><br>
  - `"${word_list}"`: Dit is het bestand waaruit shuf de regels kiest. 
  - `| tr '\n' ' '`:  <br><br>
    - `|` (Pipe): Pijpt (stuur de uitvoer van `shuf` door naar) het volgende commando (`tr`).
    - `tr '\n' ' '`: Het commando `tr` ("translate") vervangt elk nieuwregelkarakter (`\n`) in de uitvoer door een spatie (`' '`), zodat de woorden op één regel verschij
  - `| sed 's/ $/\n/'` :  
    - `s/ $/\n/`:

        - `s`: Dit is de "substitute" (vervang) opdracht in `sed`. Het zoekt naar een bepaalde patroon in de tekst en vervangt deze door iets anders.
        - `$`: Dit patroon zoekt naar een spatie (` `) aan het einde van de regel. De `$` betekent "einde van de regel" in reguliere expressies.
        - `\n`: Dit is het vervangende patroon. Hier vervangen we de spatie aan het einde van de regel door een nieuwe regel (`\n`), zodat de uitvoer netjes eindigt zonder een extra spatie. <br><br>
- `if [[ "$#" -gt 2 ]];` :  <br><br><br><br>
- 
```
-h|--help)
  usage
  exit 0
  ;;
```
  - `-h|--help`: Dit patroon betekent dat als arg gelijk is aan -h of --help, de bijbehorende acties worden uitgevoerd.
  - Acties:

    - `usage`: Roept de `usage`-functie aan, die de gebruiksinformatie voor het script afdrukt.
    - `exit 0`: Stopt het script met een exit-status van `0`, wat aangeeft dat het script succesvol is uitgevoerd. Dit betekent dat het script gewoon de helpinformatie moet weergeven en verder niets hoeft te doen. <br><br><br>
- 
```

-*)
  echo "Unknown option: ${arg}" >&2
  usage
  exit 1
  ;;
 ```
 - `-*`: Dit patroon betekent dat als `arg` begint met een - (wat betekent dat het waarschijnlijk een optie is), de bijbehorende acties worden uitgevoerd.

    - Deze controle vangt alle andere opties op die niet `-h` of `--help` zijn (bijvoorbeeld `-v` of `-z`).<br><br>
 - Acties: <br><br>
   - `echo "Unknown option: ${arg}" >&2`: Print een foutmelding naar stderr om de gebruiker te informeren dat een onbekende optie is ingevoerd.
  - `usage`: Roept de `usage`-functie aan om de gebruiksinformatie weer te geven, zodat de gebruiker kan zien welke opties wel geldig zijn.
  - `exit 1`: Stopt het script met een exit-status van `1`, wat aangeeft dat er een fout is opgetreden. <br><br><br>
- 
```
*)
  if [[ -f "${arg}" ]]; then
    word_list="${arg}"
  else
    num_words="${arg}"
  fi
  ;;

```
  - `*`: Dit patroon vangt alle andere argumenten op die niet met een `-` beginnen. In dit script gaan we ervan uit dat deze argumenten ofwel een bestand zijn ofwel een getal (het aantal woorden).<br><br>
  - `if [[ -f "${arg}" ]]; then ... else ... fi`: Controleert of het argument een bestaand bestand is.
    - `-f "${arg}"`: Dit controleert of arg een bestand is.
    - Als arg een bestand is:<br><br>
      - `word_list="${arg}"`: Stelt `word_list` in op dit bestand, omdat we aannemen dat het een alternatieve woordenlijst is.<br><br>

  - Als `arg` geen bestand is:<br><br>

     -  `num_words="${arg}"`: Stelt `num_words` in op dit argument, ervan uitgaande dat het een getal is dat aangeeft hoeveel woorden in de wachtwoordzin moeten worden gebruikt.<br><br><br>
-  `grep '^##' "$0" | sed 's/^##//'` : 
   -  `grep '^##' "$0"`: <br><br>

    - `grep` is een commando dat tekstpatronen zoekt in bestanden of uitvoer.
    `'^##'`: Dit patroon zegt dat we op zoek zijn naar regels die beginnen met `##`,
    `^` geeft het begin van de regel aan. <br><br>
    - `"$0"`: `$0` is een speciale variabele in Bash die de naam van het script bevat. Door `$0` door te geven aan `grep`, zoekt `grep` binnen het script zelf. <br><br>
    - `sed 's/^##//'`: Dit `sed`-commando verwijdert het `##`-patroon aan het begin van elke regel die door `grep` is gevonden.

      - `s/`: Dit is het "substitute"-commando in `sed`, wat betekent "vervang".
      - `^##`: Het patroon dat we willen verwijderen. Hier betekent `^` opnieuw "begin van de regel" en `##` is het te verwijderen tekstpatroon.
      - `//`: Dit vervangt het patroon door "niets", oftewel verwijdert het patroon. <br><br><br><br>

- `backup.sh` script: 
- 
```
 case "${param}" in
      -h|--help|-?)  # Als het argument -h, --help, of -? is, print de usage en beëindig het script
        usage
        exit 0
        ;;
      -d|--destination)  # Als het argument -d of --destination is, stel de bestemming in
        destination="$1"
        shift
        ;;
      -*)
        echo "Unknown option: ${param}" >&2   # Fout als het een onbekende optie is
        usage
        exit 1
        ;;
      *)
        source="${param}"  # Anders wordt de directory om een backup van te maken ingesteld
        ;;
    esac
  done
``` 
<br><br><br>

  - `case`: Dit blok controleert het huidige argument (`param`) en handelt het af afhankelijk van wat het is:

    - Als het `-h`, `--help`, of `-?` is, wordt de functie `usage` aangeroepen en stopt het script met een exit-code 0. <br><br>
    - Als het `-d` of `--destination` is, wordt de volgende waarde (die de bestemmingsdirectory is) aan de variabele `destination` toegewezen. <br><br>
    - Als het een onbekende optie is (begin met een `-` maar geen van de bekende opties), wordt er een foutmelding weergegeven en stopt het script met een exit-status 1. <br><br>
    - Als het geen van deze opties is, wordt aangenomen dat het de directory is waar de backup van moet worden gemaakt, en deze waarde wordt aan de variabele source toegewezen.  <br><br>
- De `usage` functie:  <br><br>
  - `$0"`: Dit is een speciale variabele die de naam van het script bevat. Dus als het script `backup.sh` heet, zou `"$0"` de waarde `backup.sh` bevatten. <br><br>
  - De usage functie toont dus de helptekst die in het script is opgeslagen, die in dit geval in de vorm van commentaar is geschreven (regels die beginnen met `##`). Wanneer de gebruiker het script uitvoert met de optie `-h` of `--help`, wordt de `usage` functie aangeroepen om deze informatie weer te geve
<br><br><br><br>

# Containervirtualisatie (Docker) 8.4.2.
- Om de docker commando's te gebruiken zonder altijd `sudo` te schrijven doen wij het volgende: 
  - `sudo usermod -aG docker $(whoami)`
  - `newgrp docker`<br><br>
- om een docker container te verwijderen gebruiken wij: `docker rmi <container-name>` of als de docker klaacht omdat het aan het draaien is dan gebruiken wij `docker rm <ID>` de `id` is te vinden ook via `docker ps`<br><br>
- Start bestaande container via `docker start <container naam>`<br><br>
- `docker exec -t alpine /bin/hostname` : Dit voert het commando `/bin/hostname` uit binnen de draaiende alpine-container. Het toont de hostname van de container.
- `docker exec -t alpine /sbin/ip a` : Dit voert het commando `/sbin/ip` a uit binnen de container. Dit toont de netwerkconfiguratie van de container, inclusief het `IP`-adres dat de container heeft gekregen.<br><br>
- `docker exec -i -t alpine /bin/sh` : Dit opent een interactieve shell (/bin/sh) binnen de draaiende alpine-container. Hiermee kun je commando’s uitvoeren alsof je direct binnen de container werkt.<br><br>
- Docker volume creeeren: `docker volume create <Volume-name>`<br><br>
- Opties met `dcoker` opdracht: 
  - `-d` : start de container in `detached` mode (in de achtergrond)
  - `-v` : Sla de content op van de docker volume binnen de container in de path, dus het verwijderen, blijft de contect consistent opgeslagen, bv : `v mysql-data:/var/lib/mysql`
- 