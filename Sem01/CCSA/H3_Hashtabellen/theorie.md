# Samenvatting Hoofdstuk 3: Hashtabellen

## 3.1 Hashtabellen

- **Beschrijving**:
  - Een **hashtabel** is een datastructuur die gebruikt wordt om gegevens op een efficiënte manier op te slaan en op te zoeken.
  - Het maakt gebruik van een **hashfunctie** om een sleutel om te zetten in een index in een array. De gegevens worden opgeslagen op deze index, wat zorgt voor snelle toegang.

- **Voordelen**:
  - Ze bieden **constante toegangstijd** (`O(1)`) voor zoek-, invoeg- en verwijderoperaties, in het ideale geval.
  - Ze zijn zeer efficiënt voor het opslaan van grote hoeveelheden gegevens met een veelheid aan unieke sleutels.

- **Werking**:
  - De sleutel wordt door de hashfunctie geleid om een hashcode te genereren.
  - De hashcode wordt vervolgens omgezet naar een array-index, waar de waarde kan worden opgeslagen of opgezocht.

---

## 3.2 Verwerken van de Overlappingen

Wanneer twee sleutels dezelfde hashcode genereren, ontstaat een **botsing (collision)**. Er zijn verschillende technieken om hiermee om te gaan:

### 3.2.1 Gesloten Hashing

- **Beschrijving**:
  - Bij gesloten hashing wordt de botsing opgelost door de volgende beschikbare index in de array te gebruiken (ook wel **probing** genoemd).
  - Er zijn verschillende probingmethoden zoals **lineaire probing**, **kwadratische probing**, en **dubbele hashing**.

- **Voorbeeld (Lineaire Probing)**:
  - Als we de sleutel `k` hashcode `h(k)` berekenen en de index `h(k)` al bezet is, zoeken we naar de volgende vrije index door de array lineair door te lopen (volgende index).

  ```python
  def gesloten_hashing(tabel, sleutel, waarde):
      index = hash(sleutel) % len(tabel)
      while tabel[index] is not None:
          index = (index + 1) % len(tabel)
      tabel[index] = waarde
  ```

### 3.2.2 Open Hashing

- **Beschrijving**:
  - Bij open hashing (ook wel **gescheiden chaining** genoemd) worden botsingen opgelost door een extra datastructuur (zoals een gelinkte lijst) te gebruiken om alle elementen die dezelfde hashcode hebben op te slaan.
  - Dit betekent dat elk element in de hasharray een verwijzing kan bevatten naar een lijst van elementen die dezelfde hashcode delen.

- **Voorbeeld**:
  - Stel dat je een hasharray hebt waarin elke index een gelinkte lijst bevat:

  ```python
  class HashTabel:
      def __init__(self, grootte):
          self.tabel = [[] for _ in range(grootte)]

      def voeg_toe(self, sleutel, waarde):
          index = hash(sleutel) % len(self.tabel)
          for item in self.tabel[index]:
              if item[0] == sleutel:
                  item[1] = waarde  # Update bestaande waarde
                  return
          self.tabel[index].append((sleutel, waarde))
  ```

---

## 3.3 Keuze van Hashcode en Hashfunctie

- **Beschrijving**:
  - De keuze van een goede **hashfunctie** is cruciaal voor de efficiëntie van de hashtabel.
  - Een goede hashfunctie verdeelt de sleutels gelijkmatig over de tabel om botsingen te minimaliseren.
  
- **Criteria voor een goede hashfunctie**:
  - **Efficiëntie**: De hashfunctie moet snel zijn.
  - **Gelijke spreiding**: De sleutels moeten goed verdeeld worden over de beschikbare array-indexen.
  - **Minimale botsingen**: De hashfunctie moet botsingen zoveel mogelijk voorkomen.

- **Voorbeeld van een eenvoudige hashfunctie**:
  - Een simpele hashfunctie kan de ASCII-waarde van de tekens in een string nemen en deze optellen:

  ```python
  def eenvoudige_hashfunctie(sleutel):
      return sum(ord(c) for c in sleutel)
  ```

---

## 3.4 Oefeningen

1. **Implementeer een Hashtabel**:
   - Maak een eenvoudige hashtabel die een lijnprobeermethode gebruikt om botsingen op te lossen. Voeg methoden toe voor het invoegen, zoeken en verwijderen van elementen.

2. **Gebruik Open Hashing**:
   - Implementeer open hashing (gescheiden chaining) in een hashtabel. Zorg ervoor dat botsingen correct worden afgehandeld met een gelinkte lijst.

3. **Hashfunctie Optimalisatie**:
   - Test de prestaties van verschillende hashfuncties voor een reeks van sleutels. Vergelijk bijvoorbeeld de prestaties van een eenvoudige hashfunctie met een meer complexe hashfunctie, zoals de **MurmurHash**.

4. **Geavanceerde Oefening**:
   - Implementeer een hashtabel met dubbele hashing als probingmethode en test de prestaties bij grote hoeveelheden gegevens.

---

Deze samenvatting biedt een overzicht van **Hoofdstuk 3: Hashtabellen**, met uitleg over de werking van hashtabellen, botsingen, verschillende technieken voor het oplossen van botsingen, en hoe een goede hashfunctie kan worden gekozen. De oefeningen helpen je de concepten verder te begrijpen en toe te passen.

This version keeps the markdown format clean and organized, providing explanations, examples, and exercises, just as requested!
