# Samenvatting Hoofdstuk 4: Bomen

## 4.1 Terminologie m.b.t. Bomen

- **Beschrijving**:
  - Een **boom** is een datastructuur die bestaat uit knopen (nodes) en verbindingen (edges) tussen deze knopen.
  - De bovenste knoop wordt de **wortel (root)** genoemd, en de knopen zonder kinderen worden **bladeren**.
  - Elke knoop heeft maximaal één ouderknoop en nul of meer kindknopen.

- **Belangrijke termen**:
  - **Diepte (depth)** van een knoop: Aantal verbindingen van de wortel naar de knoop.
  - **Hoogte (height)** van een knoop: Aantal verbindingen van de knoop naar de verste bladknop.
  - **Grootte (size)** van een boom: Aantal knopen in de boom.
  - **Bladeren**: Knopen zonder kinderen.

---

## 4.2 Datastructuren voor Bomen

### 4.2.1 Array-van-kinderen voorstelling

- **Beschrijving**:
  - In de **array-van-kinderen** voorstelling worden de kinderen van een knoop opgeslagen in een array, waarbij elke index een kind van de ouderknop representeert.
  
- **Voordelen**:
  - Simpel om te implementeren voor bomen met een beperkt aantal kinderen per knoop.

- **Voorbeeld**:

  ```python
  class Boom:
      def __init__(self, waarde):
          self.waarde = waarde
          self.kinderen = []

      def voeg_kind_toe(self, kind):
          self.kinderen.append(kind)
  ```

---

### 4.2.2 Eerste-kind-volgende-broer voorstelling

- **Beschrijving**:
  - Bij de **eerste-kind-volgende-broer** voorstelling wordt elk knoopobject twee verwijzingen bevatten:
    - Een naar het **eerste kind**.
    - Een naar de **volgende broer** (de volgende knoop op hetzelfde niveau).

- **Voordelen**:
  - Zeer efficiënt voor bomen waar knopen verschillende aantallen kinderen kunnen hebben.

- **Voorbeeld**:

  ```python
  class Knoop:
      def __init__(self, waarde):
          self.waarde = waarde
          self.eerste_kind = None
          self.volgende_broer = None
  ```

---

### 4.2.3 Oefeningen

1. **Implementeer een Boom**:
   - Maak een eenvoudige implementatie van een boom met de array-van-kinderen voorstelling. Voeg methoden toe om kinderen toe te voegen en de structuur van de boom weer te geven.

2. **Gebruik de Eerste-kind-Volgende-broer voorstelling**:
   - Implementeer de boomstructuur met de eerste-kind-volgende-broer voorstelling en vergelijk de prestaties met de array-van-kinderen voorstelling.

---

## 4.3 Recursie op Bomen

- **Beschrijving**:
  - Recursie wordt vaak gebruikt bij het doorlopen van bomen, omdat elke subboom ook een boom is.
  - Door een boom recursief te doorlopen, kunnen we eenvoudige algoritmen voor bomen zoals zoeken en traverseren schrijven.

- **Voorbeelden van Recursieve Operaties**:
  1. **Alle toppen van een boom bezoeken** (Preorder traversal).
  2. **Eenvoudige berekeningen op bomen**: Bijvoorbeeld het berekenen van de som van de waarden in een binaire boom.

- **Voorbeeld**: Preorder Traversal:

  ```python
  def preorder(bom):
      if bom is not None:
          print(bom.waarde)
          for kind in bom.kinderen:
              preorder(kind)
  ```

---

### 4.3.1 Alle Toppen van een Boom Bezoeken

- **Beschrijving**:
  - Dit verwijst naar het **traverseren van de boom**, dat wil zeggen het bezoeken van elke knoop in een specifieke volgorde.
  - **Preorder traversal**: Bezoek de knoop eerst, daarna de kinderen.

- **Voorbeeld**:

  - Boom:

    ```
         A
        / \
       B   C
      /     \
     D       E
    ```

  - **Preorder Traversal**: A, B, D, C, E

---

### 4.3.2 Eenvoudige Berekeningen op Bomen

- **Beschrijving**:
  - Recursie wordt vaak gebruikt voor berekeningen zoals het **berekenen van de som van waarden** in een boom.

- **Voorbeeld**:

  ```python
  def som_bomen(bom):
      if bom is None:
          return 0
      return bom.waarde + sum(som_bomen(kind) for kind in bom.kinderen)
  ```

---

### 4.3.3 Oefeningen

1. **Implementatie van Preorder Traversal**:
   - Schrijf een functie voor preorder traversal van een boom en test deze op een boom die je zelf hebt gemaakt.

2. **Bereken de Som van een Boom**:
   - Implementeer een functie die de som van de waarden van alle knopen in een boom berekent.

---

## 4.4 Binaire Bomen

- **Beschrijving**:
  - Een **binaire boom** is een type boom waarbij elke knoop maximaal twee kinderen heeft, meestal aangeduid als de linker- en rechterkinderen.
  
- **Eigenschappen**:
  - **Volledige binaire boom**: Alle knopen, behalve de bladeren, hebben precies twee kinderen.
  - **Perfecte binaire boom**: Alle interne knopen hebben precies twee kinderen en alle bladeren bevinden zich op hetzelfde niveau.

---

### 4.4.1 Definitie en Eigenschappen

- **Beschrijving**:
  - Een binaire boom is een boom waarin elke knoop maximaal twee kinderen heeft, wat betekent dat de kinderen van een knoop worden opgeslagen in twee subbomen (linker en rechter).

---

### 4.4.2 Voorstelling van een Binaire Boom

- **Beschrijving**:
  - Binaire bomen kunnen worden geïmplementeerd door knopen die een waarde bevatten en twee verwijzingen naar hun kinderen (links en rechts).
  
- **Voorbeeld**:

  ```python
  class BinaireKnoop:
      def __init__(self, waarde):
          self.waarde = waarde
          self.linker = None
          self.rechter = None
  ```

---

### 4.4.3 Alle Toppen van een Binaire Boom Bezoeken

- **Beschrijving**:
  - **Preorder**: Bezoek de wortel, dan het linker kind, dan het rechter kind.
  - **Inorder**: Bezoek het linker kind, dan de wortel, dan het rechter kind.
  - **Postorder**: Bezoek het linker kind, dan het rechter kind, dan de wortel.

---

### 4.4.4 Oefeningen

1. **Implementatie van Preorder Traversal op een Binaire Boom**:
   - Implementeer de preorder traversal op een binaire boom en test deze.

2. **Implementeer Inorder en Postorder Traversal**:
   - Implementeer en test de inorder en postorder traversals.

---

## 4.5 Binaire Zoekbomen

- **Beschrijving**:
  - Een **binaire zoekboom (BST)** is een binaire boom met de eigenschap dat de waarde van elke knoop in de linker subboom kleiner is dan de waarde van de ouderknoop, en de waarde van elke knoop in de rechter subboom groter is.

- **Operaties**:
  1. **Zoeken**: Zoek naar een bepaalde waarde in de boom.
  2. **Invoegen**: Voeg een nieuwe waarde in op de juiste plaats in de boom.
  3. **Verwijderen**: Verwijder een waarde uit de boom en herstructureer de boom indien nodig.

---

### 4.5.1 Opzoeken van een Sleutel in een Binaire Zoekboom

- **Beschrijving**:
  - Het opzoeken van een sleutel gebeurt door de boom van de wortel af naar beneden te doorlopen, waarbij we links of rechts kiezen op basis van de waarde van de sleutel.
  
- **Voorbeeld**:

  ```python
  def zoek_binaire_zoekboom(bom, sleutel):
      if bom is None or bom.waarde == sleutel:
          return bom
      if sleutel < bom.waarde:
          return zoek_binaire_zoekboom(bom.linker, sleutel)
      return zoek_binaire_zoekboom(bom.rechter, sleutel)
  ```

---

### 4.5.2 Toevoegen van een Sleutel aan een Binaire Zoekboom

- **Beschrijving**:
  - Bij het invoegen wordt de sleutel op de juiste plaats geplaatst door de boom te doorlopen volgens de binaire zoekboomregels.

---

### 4.5.3 Verwijderen van een Sleutel uit een Binaire Zoekboom

- **Beschrijving**:
  - Het verwijderen van een knoop vereist drie gevallen:
    1. De knoop heeft geen kinderen.
    2. De knoop heeft één kind.
    3. De knoop heeft twee kinderen.

---

### 4.5.4 Tijdscomplexiteit van de Bewerking

- **Beschrijving**:
  - De tijdscomplexiteit voor zoek-, invoeg- en verwijderoperaties in een gebalanceerde binaire zoekboom is `O(log n)`.
  - In een niet-gebalanceerde boom kan dit oplopen tot `O(n)` in het slechtste geval.

---

### 4.5.5 Oefeningen

1. **Zoekfunctie voor Binaire Zoekboom**:
   - Implementeer de zoekfunctie voor een binaire zoekboom en test deze.

2. **Invoegen en Verwijderen in een Binaire Zoekboom**:
   - Implementeer de functies voor het invoegen en verwijderen van sleutels in een binaire zoekboom.

---

## 4.6 Binaire Hopen

- **Beschrijving**:
  - Een **binaire hoop (heap)** is een speciale binaire boom die de heap-eigenschap volgt: de waarde van elke ouderknoop is groter (max heap) of kleiner (min heap) dan de waarden van zijn kinderen.

- **Toepassingen**:
  - Binaire hopen worden vaak gebruikt om een **prioriteitswachtrij** te implementeren.

---

### 4.6.1 Prioriteitswachtrij

- **Beschrijving**:
  - Een prioriteitswachtrij is een datastructuur waarin elk element een prioriteit heeft en waarbij de elementen met de hoogste prioriteit eerst worden verwerkt.

- **Voorbeeld**:
  - In een **max heap** komt het element met de grootste waarde bovenaan de heap.

---

### 4.6.2 Implementatie als Binaire Hoop

- **Beschrijving**:
  - Een binaire hoop kan worden geïmplementeerd als een dynamische array, waarbij de ouders en kinderen van een knoop zich op bepaalde indices bevinden.

- **Voorbeeld**:

  ```python
  class BinaireHoop:
      def __init__(self):
          self.heap = []

      def voeg_toe(self, waarde):
          self.heap.append(waarde)
          self._heapify_op(self.size() - 1)

      def _heapify_op(self, index):
          parent = (index - 1) // 2
          if index > 0 and self.heap[index] > self.heap[parent]:
              self.heap[index], self.heap[parent] = self.heap[parent], self.heap[index]
              self._heapify_op(parent)
  ```

---

### 4.6.3 Oefeningen

1. **Implementeer een Max Heap**:
   - Implementeer een max heap in Python en voeg methoden toe voor het toevoegen van elementen en het verwijderen van de wortel.

2. **Prioriteitswachtrij Implementeren**:
   - Maak een prioriteitswachtrij met behulp van een binaire heap en test deze met verschillende prioriteiten.

---

This markdown version provides a detailed explanation of **Chapter 4: Bomen**, including tree terminology, implementations, traversal methods, binary search trees, and binary heaps. The exercises ensure a deeper understanding of the concepts discussed in the chapter.
