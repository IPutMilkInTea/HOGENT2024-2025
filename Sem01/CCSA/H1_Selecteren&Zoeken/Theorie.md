# Hoofdstuk 1: Zoeken & Selecteren

## 1.1 Zoeken in een Array

### Lineair Zoeken (Sequentieel Zoeken)

- **Beschrijving**:
  - Controleer elk element in een array één voor één totdat de gezochte waarde wordt gevonden of het einde van de array is bereikt.
  - Eenvoudig te implementeren, geschikt voor ongesorteerde arrays.

- **Tijdcomplexiteit**: `O(n)` (lineair).

- **Voorbeeld**:
  - Array: `[4, 7, 2, 9, 1]`
  - Zoek naar `9`:
    - Controleer `4`, `7`, `2`, en uiteindelijk `9` (gevonden op index 3).

---

### Binair Zoeken

- **Beschrijving**:
  - Alleen toepasbaar op gesorteerde arrays.
  - Verdeel de array telkens in twee en bepaal in welk deel de waarde ligt. Herhaal totdat de waarde is gevonden of er niets meer overblijft.
  - Kan zowel iteratief als recursief worden geïmplementeerd.

- **Tijdcomplexiteit**: `O(log n)` (logaritmisch).

- **Voorbeeld**:
  - Gesorteerde array: `[2, 4, 7, 9, 12, 15]`
  - Zoek naar `9`:
    1. Midden van de array: `7` (te klein).
    2. Zoek in de rechterhelft: `[9, 12, 15]`.
    3. Midden: `12` (te groot).
    4. Zoek in de linkerhelft: `[9]` (gevonden op index 3).

---

### Vergelijking Lineair vs. Binair Zoeken

- **Lineair Zoeken**: Eenvoudiger, maar minder efficiënt voor grote gesorteerde arrays.
- **Binair Zoeken**: Sneller voor grote gesorteerde datasets, maar vereist vooraf sorteren.

---

## 1.2 Sorteren van een Array

### Selectiesort

- **Beschrijving**:
  - Zoek het grootste (of kleinste) element in de array en verwissel het met het laatste (of eerste) element. Herhaal dit voor de resterende array.
  - Eenvoudig te begrijpen, maar inefficiënt voor grote datasets.

- **Tijdcomplexiteit**: `O(n^2)`.

- **Voorbeeld**:
  - Ongesorteerde array: `[44, 55, 12, 42, 94, 18, 6, 67]`
    - Iteratie 1: Zoek grootste (`94`), verwissel met laatste: `[44, 55, 12, 42, 6, 18, 67, 94]`.
    - Iteratie 2: Zoek grootste (`67`), verwissel met voorlaatste: `[44, 55, 12, 42, 6, 18, 67, 94]`.
    - Ga door tot array is gesorteerd.

---

### Insertiesort

- **Beschrijving**:
  - Begin met het tweede element, voeg dit op de juiste plaats in in het gesorteerde deel van de array. Herhaal voor alle elementen.
  - Efficiënt voor bijna gesorteerde arrays.

- **Tijdcomplexiteit**:
  - Slechtste geval: `O(n^2)` (omgekeerde volgorde).
  - Beste geval: `O(n)` (reeds gesorteerde input).

- **Voorbeeld**:
  - Ongesorteerde array: `[44, 55, 12, 42]`
    - Iteratie 1: `[44]` gesorteerd, voeg `55` toe: `[44, 55]`.
    - Iteratie 2: Voeg `12` toe: `[12, 44, 55]`.
    - Iteratie 3: Voeg `42` toe: `[12, 42, 44, 55]`.

---

### Mergesort

- **Beschrijving**:
  - Deel de array recursief in kleinere arrays totdat elke array uit één element bestaat. Voeg vervolgens de arrays samen in gesorteerde volgorde.
  - Veel efficiënter voor grote datasets.

- **Tijdcomplexiteit**: `O(n log n)`.

- **Voorbeeld**:
  - Ongesorteerde array: `[44, 55, 12, 42, 94, 18, 6, 67]`
    - Splits: `[44, 55, 12, 42]` en `[94, 18, 6, 67]`.
    - Sorteer elke helft: `[12, 42, 44, 55]` en `[6, 18, 67, 94]`.
    - Voeg samen: `[6, 12, 18, 42, 44, 55, 67, 94]`.

---

## Praktijkvoorbeelden

### Zoeken

1. Gebruik een lijst van namen, zoek een specifieke naam.
2. Test lineair zoeken en binair zoeken op een gesorteerde lijst van namen.

---

### Sorteren

1. Maak een lijst van willekeurige getallen, sorteer deze met alle drie de methoden (selectie-, insertie- en mergesort).
2. Vergelijk de uitvoertijd voor kleine (n=10) en grote (n=1000) arrays.

---

### Analyseer Tijdcomplexiteit

1. Voer binair zoeken uit op gesorteerde arrays met verschillende lengtes (bijvoorbeeld 100, 1000, 10.000 elementen).
2. Test de efficiëntie van mergesort versus insertiesort op grote arrays.
