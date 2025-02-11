Hier is een overzicht van hoe je elke oefening kan aanpakken, inclusief Markdown-notities voor je labo's.

---

## **2.4.1. I/O Redirection en filters**

### **Apt lijst in pagina’s weergeven**
```bash
apt list --installed | less
```

### **Resultaat wegschrijven naar een bestand**
```bash
apt list --installed > packages.txt 2>/dev/null
```
- `2>/dev/null`: Zorgt dat waarschuwingen niet zichtbaar zijn.

### **Eerste tien lijnen tonen**
```bash
head -n 10 packages.txt
```

### **Eerste lijn uitsluiten en herschrijven**
```bash
apt list --installed | tail -n +2 > packages.txt
```
Controleer:
```bash
head packages.txt
```

### **Aantal geïnstalleerde pakketten tellen**
```bash
wc -l < packages.txt
```

### **Unieke architecturen sorteren**
```bash
cut -d '/' -f 2 packages.txt | sort | uniq -c
```

### **Packages met "python" zoeken**
```bash
grep -c 'python' packages.txt
```

### **Alle versies met python filteren**
```bash
apt list --all-versions | grep 'python' | tail -n +2 | grep -v '^$' > python-packages.txt
```

### **Aantal packages en geïnstalleerde versies tellen**
```bash
wc -l < python-packages.txt
grep -c 'installed' python-packages.txt
```

### **Dubbels verwijderen**
```bash
cut -d '/' -f 1 python-packages.txt | sort | uniq | wc -l
```

---

## **2.4.2. Variabelen**

### **Belangrijke shell-variabelen**
```bash
echo $PATH       # Paden voor uitvoerbare bestanden
echo $HISTSIZE   # Aantal commando's in de geschiedenis
echo $UID        # Gebruikers-ID
echo $HOME       # Home-directory van de gebruiker
echo $HOSTNAME   # Hostnaam van het systeem
echo $LANG       # Taalinstellingen
echo $USER       # Huidige gebruiker
echo $OSTYPE     # Type besturingssysteem
echo $PWD        # Huidige werkdirectory
```

---

## **2.4.3. Variabelen in scripts**

### **Script `hello.sh`**
```bash
#!/bin/bash
echo "Hallo $USER"
```
Maak uitvoerbaar:
```bash
chmod +x hello.sh
```

### **Variabelen in scripts**
- **Lege variabele gebruiken:**
  ```bash
  #!/bin/bash
  echo "Hallo ${person}"
  ```
  Uitvoer zonder definitie: "Hallo".

- **Met `set -o nounset`:**
  Toevoegen:
  ```bash
  set -o nounset
  ```
  Foutmelding als `${person}` niet gedefinieerd is.

- **Variabele definiëren in CLI:**
  ```bash
  person="Jan" ./hey.sh
  ```

- **Variabele exporteren:**
  ```bash
  export person="Jan"
  ./hey.sh
  ```

- **Variabele verwijderen:**
  ```bash
  unset person
  ```

---

## **2.4.4. Filters in scripts**

### **Script `list-users.sh`**
```bash
#!/bin/bash
cut -d ':' -f 1 /etc/passwd | sort
```

### **Script `list-system-users.sh`**
```bash
#!/bin/bash
awk -F: '$3 < 1000 { print $1 }' /etc/passwd | sort
```

### **Script `topcmd.sh`**
```bash
#!/bin/bash
history | awk '{print $2}' | sort | uniq -c | sort -nr | head -n 10
```

Uitvoeren:
```bash
source topcmd.sh
```

---

## **2.4.5. Gebruikersnamen en wachtwoorden**

### **Gebruikersnamen en wachtwoorden genereren**

#### **Download `employees.csv`**
```bash
wget http://157.193.215.171/employees.csv
```

#### **Wachtwoorden genereren**
```bash
num_employees=$(wc -l < employees.csv)
apg -n $((num_employees - 1)) -m 15 -x 15 -a 1 > passwords.txt
```

#### **Gebruikersnamen genereren**
```bash
tail -n +2 employees.csv | awk -F, '{ print tolower($2 substr($3, 1, 1)) }' | iconv -f utf8 -t ascii//translit > usernames.txt
```

#### **Gebruikersnamen en wachtwoorden combineren**
```bash
paste -d ',' usernames.txt passwords.txt > user-pass.csv
```

#### **Script `user-pass.sh`**
```bash
#!/bin/bash
set -o nounset
set -o errexit

input_file="employees.csv"
output_file="user-pass.csv"
usernames_file="usernames.txt"
passwords_file="passwords.txt"

num_employees=$(tail -n +2 $input_file | wc -l)

# Wachtwoorden genereren
apg -n $num_employees -m 15 -x 15 -a 1 > $passwords_file

# Gebruikersnamen genereren
tail -n +2 $input_file | awk -F, '{ print tolower($2 substr($3, 1, 1)) }' | iconv -f utf8 -t ascii//translit > $usernames_file

# Combineren
paste -d ',' $usernames_file $passwords_file > $output_file

# Opruimen
rm $usernames_file $passwords_file
```
Maak uitvoerbaar:
```bash
chmod +x user-pass.sh
```

Uitvoeren:
```bash
./user-pass.sh
```