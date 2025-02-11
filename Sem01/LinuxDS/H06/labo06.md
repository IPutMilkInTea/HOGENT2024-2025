Hier zijn de oplossingen voor beide opdrachten: **srm.sh** (veilige verwijdering) en **analyse-github-repo.sh** (analyse van een GitHub-repository). De scripts voldoen aan de eisen, inclusief uitbreidingen.

---

### **Oef 1: srm.sh**
```bash
#!/bin/bash

# Script instellingen
set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

TRASH_DIR="$HOME/.trash"

# Functie om bestanden ouder dan 14 dagen te verwijderen
cleanup_old_files() {
    echo "Cleaning up old files"
    find "$TRASH_DIR" -type f -mtime +14 -print -exec rm -v {} \;
}

# Controleer of minstens één argument is opgegeven
if [ "$#" -eq 0 ]; then
    echo "Error: Expected at least one argument!"
    exit 1
fi

# Zorg dat de trash directory bestaat
if [ ! -d "$TRASH_DIR" ]; then
    mkdir -p "$TRASH_DIR"
    echo "Created trash folder $TRASH_DIR"
fi

# Opruimen van oude bestanden
cleanup_old_files

# Verwerken van opgegeven bestanden
for file in "$@"; do
    if [ ! -e "$file" ]; then
        echo "Error: File '$file' does not exist! Skipping..."
        continue
    fi

    if [ ! -f "$file" ]; then
        echo "Error: '$file' is not a regular file! Skipping..."
        continue
    fi

    # Bestand comprimeren en verplaatsen
    gzip -c "$file" > "$TRASH_DIR/$(basename "$file").gz"
    rm -v "$file"
    echo "Moved and compressed '$file' to $TRASH_DIR"
done
```

---

### **Oef 2: analyse-github-repo.sh**
```bash
#!/bin/bash

# Script instellingen
set -o errexit
set -o nounset
set -o pipefail

# Controleer het aantal argumenten
if [ "$#" -ne 1 ]; then
    echo "Error: Expected exactly one argument!"
    exit 1
fi

REPO_DIR="$1"

# Controleer of de argumenten een directory zijn
if [ ! -d "$REPO_DIR" ]; then
    echo "Error: '$REPO_DIR' is not a directory!"
    exit 1
fi

# Controleer of het een GitHub-repository is
if [ ! -d "$REPO_DIR/.git" ]; then
    echo "Error: '$REPO_DIR' is not a GitHub repository!"
    exit 1
fi

# Functie om commando's binnen de repository uit te voeren
cd "$REPO_DIR"

# Aantal commits
COMMIT_COUNT=$(git log --oneline | wc -l)
if [ "$COMMIT_COUNT" -eq 0 ]; then
    echo "📢 Komaan, niet wachten, maak een eerste commit!"
elif [ "$COMMIT_COUNT" -eq 1 ]; then
    echo "✔️ Alvast 1 commit, goed begonnen!"
elif [ "$COMMIT_COUNT" -le 10 ]; then
    echo "🎉 Je hebt al $COMMIT_COUNT commits gemaakt, doe zo verder!"
else
    echo "🌟 Fantastisch werk, al $COMMIT_COUNT commits!"
fi

# Controleer lokale wijzigingen
if [ -z "$(git status -s)" ]; then
    echo "✔️ Geen lokale wijzigingen, goed bezig!"
else
    echo "⚠️ Je hebt nog lokale wijzigingen, commit ze zo snel mogelijk!"
fi

# Controleer op README.md
if [ -f "README.md" ]; then
    echo "✔️ README.md bestaat, goed zo!"
else
    echo "⚠️ README.md bestaat niet, maak er één aan met wat uitleg over je project!"
fi

# Controleer op LICENSE.md
if [ -f "LICENSE.md" ]; then
    echo "✔️ LICENSE.md bestaat, goed zo!"
else
    echo "⚠️ LICENSE.md bestaat niet, voeg een licentie toe!"
fi

# Controleer op .gitignore
if [ -f ".gitignore" ]; then
    echo "✔️ .gitignore bestaat, goed zo!"
else
    echo "⚠️ .gitignore bestaat niet, voeg er een toe!"
fi

# Loop door bestanden in de root van de repo
for file in *; do
    if [ -d "$file" ]; then
        echo "📂 $file is een directory, wordt overgeslagen."
    elif [ -b "$file" ] || [ -c "$file" ]; then
        echo "⚠️ $file is een speciaal bestand, hoort dit thuis in de repository?"
    else
        TYPE=$(file "$file")
        if [[ "$TYPE" == *"CRLF line terminators"* ]]; then
            echo "⚠️ $file heeft DOS-regeleindes, zet om met dos2unix!"
        elif [[ "$TYPE" == ELF* ]]; then
            echo "⚠️ $file is een binaire executable, hoort dit thuis in de repository?"
        fi
    fi
done

# Zoek naar shellscripts en controleer uitvoerbaarheid
for script in *.sh; do
    if [ ! -x "$script" ]; then
        echo "⚠️ Shellscript $script is niet uitvoerbaar, maak het uitvoerbaar met chmod +x $script"
    else
        echo "✔️ Shellscript $script is uitvoerbaar, goed zo!"
    fi
done
```
