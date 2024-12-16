# Hoofdstuk 2: Gelinkte Lijsten

## 2.1 Specificatie van Gelinkte Lijsten

- **Beschrijving**:
  - Een **gelinkte lijst** is een lineaire datastructuur waarin de elementen (knopen) niet op opeenvolgende geheugenlocaties staan, maar elk element wijst naar het volgende element in de lijst.
  - Dit wordt mogelijk gemaakt door het gebruik van **referenties (pointers)** naar het volgende element in de lijst.

- **Voordelen**:
  - Dynamisch geheugenbeheer: het kan eenvoudig worden aangepast (bijvoorbeeld knopen kunnen toegevoegd of verwijderd worden zonder de hele lijst opnieuw te alloceren).
  - Geschikt voor het geval de grootte van de dataset niet van tevoren bekend is.

---

## 2.2 Implementatie van een Gelinkte Lijst

### 2.2.1 Implementatie van een Knoop

- **Beschrijving**:
  - Een knoop bevat twee elementen: de **waarde** van het element en een verwijzing (pointer) naar de **volgende** knoop in de lijst.

- **Voorbeeld**:
  - Knoop: `waarde -> pointer`
  - Een knoop kan als volgt worden geïmplementeerd in Python:

    ```python
    class Knoop:
        def __init__(self, waarde):
            self.waarde = waarde
            self.volgende = None
    ```

---

### 2.2.2 Implementatie van een Gelinkte Lijst

- **Beschrijving**:
  - Een gelinkte lijst wordt geïmplementeerd door het koppelen van knopen. Elke knoop bevat een waarde en een verwijzing naar de volgende knoop.
  - De lijst heeft een **referentie** naar de eerste knoop, de zogenaamde **kop** (head).

- **Voorbeeld**:
  - Een eenvoudige implementatie van een gelinkte lijst in Python:

    ```python
    class GelinkteLijst:
        def __init__(self):
            self.kop = None

        def voeg_toe(self, waarde):
            nieuwe_knoop = Knoop(waarde)
            nieuwe_knoop.volgende = self.kop
            self.kop = nieuwe_knoop
    ```

---

### 2.2.3 Het Gebruik van Ankercomponenten

- **Beschrijving**:
  - **Ankercomponenten** worden vaak gebruikt in gelinkte lijsten om de toegang tot knopen te vergemakkelijken.
  - Een **anker** kan een extra verwijzing zijn, zoals een nulwaarde of een sentinel die het begin of einde van de lijst markeert.

- **Voorbeeld**:
  - Een anker kan worden gebruikt om de lijst makkelijker te beheren zonder dat we speciale gevallen hoeven te behandelen voor lege lijsten.

---

## 2.3 Dubbelgelinkte Lijsten

- **Beschrijving**:
  - In een **dubbelgelinkte lijst** heeft elke knoop twee verwijzingen:
    - Een naar de **volgende** knoop.
    - Een naar de **vorige** knoop.
  - Dit maakt het mogelijk om de lijst zowel van voren als van achteren door te lopen.

- **Voordelen**:
  - Je kunt de lijst efficiënter doorlopen in beide richtingen.
  - Verwijderingen kunnen sneller worden uitgevoerd omdat we toegang hebben tot de vorige knoop.

- **Voorbeeld**:
  - In een Python-implementatie van een dubbelgelinkte lijst:

    ```python
    class DubbeleKnoop:
        def __init__(self, waarde):
            self.waarde = waarde
            self.volgende = None
            self.vorige = None
    ```

---

## 2.4 Beschrijving en Implementatie van Stapels

### 2.4.1 Beschrijving van een Stapel

- **Beschrijving**:
  - Een **stapel** is een abstracte datastructuur die werkt volgens het **LIFO-principe** (Last In, First Out).
  - Elementen worden toegevoegd (gepushd) en verwijderd (gepopt) vanaf dezelfde kant, de **top** van de stapel.

- **Toepassingen**:
  - Veel gebruikt bij het beheren van functie-aanroepen in een programma (bijvoorbeeld de call stack).
  - Toepassingen zoals haakjescontrole, terugkeer in browsergeschiedenis, enz.

---

### 2.4.2 Implementatie van een Stapel

- **Beschrijving**:
  - Een stapel kan worden geïmplementeerd met behulp van een gelinkte lijst of een array.
  - In de gelinkte lijst implementatie wordt de top van de stapel eenvoudig geïmplementeerd als de kop van de lijst.

- **Voorbeeld**:
  - Python-implementatie van een stapel:

    ```python
    class Stapel:
        def __init__(self):
            self.top = None

        def is_leeg(self):
            return self.top is None

        def push(self, waarde):
            nieuwe_knoop = Knoop(waarde)
            nieuwe_knoop.volgende = self.top
            self.top = nieuwe_knoop

        def pop(self):
            if not self.is_leeg():
                waarde = self.top.waarde
                self.top = self.top.volgende
                return waarde
            else:
                return None
    ```

---

### 2.4.3 Toepassingen van Stapels

- **Haakjescontrole**:
  - Stapels kunnen worden gebruikt om te controleren of haakjes goed gesloten zijn in een expressie.
  - **Voorbeeld**: Controleer de string `"(a + b) * (c + d)"` om te zien of de haakjes correct genest zijn.

  - Python-voorbeeld:

    ```python
    def controleer_haakjes(uitdrukking):
        stapel = Stapel()
        voor teken in uitdrukking:
            if teken == "(":
                stapel.push(teken)
            elif teken == ")":
                if stapel.is_leeg():
                    return False
                stapel.pop()
        return stapel.is_leeg()
    ```

- **Postfix Evaluatie**:
  - Stapels kunnen ook worden gebruikt voor het evalueren van rekenkundige expressies in **postfix-notatie** (bijvoorbeeld `2 3 + 5 *`).

  - Python-voorbeeld:

    ```python
    def eval_postfix(uitdrukking):
        stapel = Stapel()
        voor symbool in uitdrukking.split():
            if symbool.isdigit():
                stapel.push(int(symbool))
            anders:
                b = stapel.pop()
                a = stapel.pop()
                if symbool == "+":
                    stapel.push(a + b)
                elif symbool == "*":
                    stapel.push(a * b)
        return stapel.pop()
    ```

---

## 2.5 Oefeningen

1. **Implementatie van een Gelinkte Lijst**:
   - Implementeer een gelinkte lijst in Python met de basismethoden (`voeg_toe`, `verwijder`, `doorloop`).
   - Test de lijst door elementen toe te voegen en ze te verwijderen.

2. **Dubbelgelinkte Lijst**:
   - Implementeer een dubbelgelinkte lijst en test de functionaliteit voor het toevoegen en verwijderen van knopen aan zowel het begin als het einde.

3. **Stapel Implementeren**:
   - Maak een stapel met de methoden `push`, `pop`, en `is_leeg`.
   - Test de stapel door elementen toe te voegen en te verwijderen.
   - Implementeer de haakjescontrole met behulp van de stapel en test deze op een paar rekenkundige uitdrukkingen.

4. **Postfix Evaluatie**:
   - Implementeer de postfix-evaluatie van een wiskundige uitdrukking.
   - Test de functie met een reeks van postfix-expressies.

---

Deze samenvatting biedt een overzicht van **Hoofdstuk 2: Gelinkte Lijsten** met gedetailleerde uitleg en voorbeelden. De oefeningen helpen je om de concepten verder te begrijpen en toe te passen.
