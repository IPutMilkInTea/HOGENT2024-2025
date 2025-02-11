Hier is een gedetailleerde aanpak voor de gegeven taken, verdeeld in verschillende onderdelen zoals gevraagd:

---

### **4.4.1. Webserver opzetten**

#### **Apache Webserver Installeren**
1. **Installeer Apache:**
   ```bash
   sudo apt update
   sudo apt install apache2 -y
   ```
2. **Controleer of Apache draait:**
   ```bash
   systemctl status apache2
   ```
3. **Open een browser en ga naar:** `http://127.0.0.1`. Je zou een standaard Apache-pagina moeten zien.

#### **PHP Installeren**
1. **Installeer PHP:**
   ```bash
   sudo apt install php libapache2-mod-php -y
   ```
2. **Test PHP:**
   Maak een bestand aan in `/var/www/html` genaamd `info.php` met de inhoud:
   ```php
   <?php phpinfo(); ?>
   ```
   Navigeer naar `http://127.0.0.1/info.php` en controleer of de PHP-informatiepagina correct wordt weergegeven.

---

#### **MariaDB Installeren**
1. **Installeer MariaDB:**
   ```bash
   sudo apt install mariadb-server -y
   ```
2. **Voer de beveiligingsscript uit:**
   ```bash
   sudo mysql_secure_installation
   ```
   Volg de stappen om een root-wachtwoord in te stellen en beveiligingsopties te activeren.
3. **Maak een database en gebruiker aan:**
   Maak een bestand `setup.sql` met de inhoud:
   ```sql
   DROP DATABASE IF EXISTS www_db;
   DROP USER IF EXISTS www_user;

   CREATE DATABASE www_db;
   CREATE TABLE www_db.todo_list (
     item_id INT AUTO_INCREMENT,
     content VARCHAR(255),
     PRIMARY KEY(item_id)
   );
   INSERT INTO www_db.todo_list (content)
   VALUES
     ("Buy milk"),
     ("Update world domination plans"),
     ("Call mom");

   GRANT ALL ON www_db.* TO 'www_user'@'localhost' IDENTIFIED BY 'letmein';
   FLUSH PRIVILEGES;
   ```
   Voer dit script uit:
   ```bash
   sudo mysql < setup.sql
   ```

#### **PHP-script Configureren**
1. **Plaats het volgende script in `/var/www/html/todo.php`:**
   ```php
   <head><title>TODO</title></head>
   <body>
   <h1>TODO</h1>
   <?php
   $conn=new mysqli("localhost","www_user","letmein","www_db");
   $result=$conn->query("select * from todo_list;");
   $data=$result->fetch_all();
   ?>

   <table>
     <tr><th>Num</th><th>Content</th></tr>
   <?php foreach ($data as $row): ?>
     <tr>
       <td><?= $row[0]?></td>
       <td><?= $row[1]?></td>
     </tr>
   <?php endforeach ?>
   </table>
   </body>
   ```
2. **Controleer of het script werkt:**
   Navigeer naar `http://127.0.0.1/todo.php`.

---

#### **Webpagina Bereikbaar Maken op Host**
1. **Configureer Port Forwarding:**
   - Ga in VirtualBox naar de instellingen van de VM.
   - Onder `Netwerk` → `Adapter 1` → `Geavanceerd` → `Poortdoorsturing`.
   - Voeg een regel toe:
     - **Host IP:** `127.0.0.1`
     - **Host Port:** `8080`
     - **Guest IP:** `10.0.2.15`
     - **Guest Port:** `80`
2. **Controleer Bereikbaarheid:**
   Open in je hostbrowser `http://127.0.0.1:8080`.

---

### **4.4.2. Scripting Oefeningen '102'**

#### **1. params.sh**
```bash
#!/bin/bash
echo "Script name: $0"
echo "num params: $#"
echo "Param 1: ${1:-}"
echo "Param 3: ${3:-}"
echo "Param 10: ${10:-}"

if [ $# -gt 3 ]; then
  shift 3
fi

echo "num params: $#"
echo "Remaining: $*"
```

#### **2. all-params.sh**
```bash
#!/bin/bash
if [ $# -eq 0 ]; then
  echo "Geen argumenten opgegeven!"
  exit 1
fi

for param in "$@"; do
  echo "$param"
done
exit 0
```

#### **3. sort-passwd.sh**
```bash
#!/bin/bash
file="/etc/passwd"
sort_type="-k"

if [[ $# -eq 0 ]]; then
  column -t "$file"
  exit 0
fi

if ! [[ $1 =~ ^[1-7]$ ]]; then
  echo "Please enter a number between 1 and 7 (included)"
  exit 1
fi

if [[ $1 -eq 3 || $1 -eq 4 ]]; then
  sort_type="-n -k"
fi

sort $sort_type"$1" "$file" | column -t
```
