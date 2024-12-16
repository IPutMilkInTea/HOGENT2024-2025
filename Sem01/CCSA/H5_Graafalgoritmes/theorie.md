# Samenvatting Hoofdstuk 5: Graafalgoritmes

## 5.1 Terminologie m.b.t. Grafen

- **Beschrijving**:
  - Een **graaf** is een verzameling van knopen (vertices) en verbindingen (edges) tussen deze knopen.
  - Grafen worden gebruikt om relaties tussen objecten te modelleren, zoals netwerken of verbindingen.

- **Soorten grafen**:
  - **Gerichte graaf (directed graph)**: De verbindingen hebben een richting.
  - **Ongerichte graaf (undirected graph)**: De verbindingen hebben geen richting.
  - **Gewogen graaf (weighted graph)**: Elke verbinding heeft een gewicht.
  - **Niet-gewogen graaf**: Verbindingen hebben geen gewicht.

- **Belangrijke termen**:
  - **Grens (edge)**: Een verbinding tussen twee knopen.
  - **Grenslijst**: De lijst van alle verbindingen in een graaf.
  - **Adjacente knopen**: Twee knopen die direct verbonden zijn door een grens.
  - **Graden (degree)**:
    - Voor een ongerichte graaf: het aantal verbindingen van een knoop.
    - Voor een gerichte graaf: het aantal inkomende (indegree) of uitgaande (outdegree) verbindingen.

---

## 5.2 Datastructuren voor Grafen

### 5.2.1 De Adjacentiematrix

- **Beschrijving**:
  - Een matrix waar elke rij en kolom een knoop voorstelt, en het element op positie `(i, j)` aangeeft of er een verbinding is tussen knoop `i` en knoop `j`.
  - Voor gewogen grafen bevat het element het gewicht van de verbinding.

- **Voorbeeld**:
  - Ongedirected graaf:

    ```
    0: A -> B, C
    1: B -> A, C
    2: C -> A, B
    ```

    Adjacentiematrix:

    ```
    A B C
    A 0 1 1
    B 1 0 1
    C 1 1 0
    ```

- **Voordelen**:
  - Eenvoudig en snel om verbindingen te controleren.
  - Geschikt voor dichte grafen.

- **Nadelen**:
  - Inefficiënt qua geheugen voor zeer grote en schaars gevulde grafen.

---

### 5.2.2 De Adjacentielijst

- **Beschrijving**:
  - Voor elke knoop wordt een lijst bijgehouden van alle knopen waarmee deze verbonden is.
  - Voor gewogen grafen bevat elke lijst ook het gewicht van de verbinding.

- **Voorbeeld**:
  - Ongedirected graaf:

    ```
    A: [(B, 1), (C, 1)]
    B: [(A, 1), (C, 1)]
    C: [(A, 1), (B, 1)]
    ```

- **Voordelen**:
  - Geheugenefficiënt, vooral voor schaars gevulde grafen.
  - Gemakkelijk om alle verbindingen van een knoop op te halen.

- **Nadelen**:
  - Iets trager dan een matrix voor het controleren van verbindingen.

---

### 5.2.3 Oefeningen

1. **Implementeer een Adjacentiematrix**:
   - Bouw een graf met behulp van een matrixvoorstelling en implementeer methoden om verbindingen toe te voegen en te controleren.

2. **Implementeer een Adjacentielijst**:
   - Bouw een graf met behulp van een lijstvoorstelling en implementeer methoden om verbindingen toe te voegen en te controleren.

---

## 5.3 Zoeken in Grafen

### 5.3.1 Generiek Zoeken

- **Beschrijving**:
  - Algoritmen die knopen in een graaf doorzoeken, gebaseerd op bepaalde criteria.

---

### 5.3.2 Breedte-Eerst Zoeken (BFS)

- **Beschrijving**:
  - Doorloop de graaf niveau per niveau, beginnend vanaf een startknoop.
  - Implementatie maakt gebruik van een wachtrij (queue).

- **Tijdcomplexiteit**: `O(V + E)` (waarbij `V` het aantal knopen en `E` het aantal verbindingen is).

- **Voorbeeld**:

  ```python
  def bfs(graaf, start):
      bezocht = set()
      wachtrij = [start]
      while wachtrij:
          huidige = wachtrij.pop(0)
          if huidige not in bezocht:
              print(huidige)
              bezocht.add(huidige)
              wachtrij.extend(graaf[huidige])
  ```

---

### 5.3.3 Diepte-Eerst Zoeken (DFS)

- **Beschrijving**:
  - Doorloop de graaf dieper in een tak voordat andere takken worden verkend.
  - Kan worden geïmplementeerd met recursie of een stapel (stack).

- **Tijdcomplexiteit**: `O(V + E)`.

- **Voorbeeld**:

  ```python
  def dfs(graaf, knoop, bezocht=None):
      if bezocht is None:
          bezocht = set()
      print(knoop)
      bezocht.add(knoop)
      for buur in graaf[knoop]:
          if buur not in bezocht:
              dfs(graaf, buur, bezocht)
  ```

---

### 5.3.4 Toepassing: Topologisch Sorteren

- **Beschrijving**:
  - Een manier om de knopen van een gerichte graaf te ordenen, zodat elke verbinding `(u, v)` inhoudt dat `u` vóór `v` komt.
  - Werkt alleen op **gerichte acyclische grafen (DAGs)**.

- **Voorbeeld**:

  - Taken afhankelijkheden:
  ```
    1 -> 2
    1 -> 3
    3 -> 4
  ```
    Topologische volgorde: `1, 2, 3, 4`.

---

### 5.3.5 Oefeningen

1. **Implementeer BFS en DFS**:
   - Schrijf functies voor BFS en DFS op een graaf, en test deze op een voorbeeldgraaf.

2. **Topologisch Sorteren**:
   - Implementeer topologisch sorteren en test dit op een DAG.

---

## 5.4 Kortste Pad Algoritmen

### 5.4.1 Kortste Pad in een Ongewogen Graaf

- **Beschrijving**:
  - Gebruik BFS om het kortste pad in termen van het aantal verbindingen te vinden.

---

### 5.4.2 Dijkstra's Algoritme

- **Beschrijving**:
  - Algoritme om het kortste pad te vinden in een gewogen graaf zonder negatieve gewichten.
  - Gebruikt een prioriteitswachtrij om knopen met de laagste kosten eerst te verwerken.

- **Tijdcomplexiteit**: `O((V + E) log V)`.

- **Voorbeeld**:

  ```python
  import heapq

  def dijkstra(graaf, start):
      afstanden = {knoop: float('inf') for knoop in graaf}
      afstanden[start] = 0
      pq = [(0, start)]

      while pq:
          huidige_afstand, huidige_knoop = heapq.heappop(pq)

          for buur, gewicht in graaf[huidige_knoop]:
              afstand = huidige_afstand + gewicht
              if afstand < afstanden[buur]:
                  afstanden[buur] = afstand
                  heapq.heappush(pq, (afstand, buur))
      return afstanden
  ```

---

### 5.4.3 Oefeningen

1. **Implementeer BFS voor Kortste Paden**:
   - Gebruik BFS om het kortste pad te vinden in een ongewogen graaf.

2. **Dijkstra's Algoritme**:
   - Implementeer Dijkstra’s algoritme en test het op een gewogen graaf.

---

## 5.5 Minimale Kost Opspannende Bomen

### 5.5.1 Definitie

- **Beschrijving**:
  - Een opspannende boom verbindt alle knopen in een graaf met het minimale totale gewicht van de verbindingen.

---

### 5.5.2 Prim's Algoritme

- **Beschrijving**:
  - Begin met een willekeurige knoop en voeg telkens de goedkoopste verbinding toe die een nieuwe knoop verbindt.
  - Gebruikt een prioriteitswachtrij.

---

### 5.5.3 Kruskal's Algoritme

- **Beschrijving**:
  - Sorteer alle verbindingen op gewicht, en voeg ze toe zolang ze geen cyclus vormen.

---

### 5.5.4 Oefeningen

1. **Prim's Algoritme**:
   - Implementeer Prim’s algoritme en test het op een gewogen graaf.

2. **Kruskal's Algoritme**:
   - Implementeer Kruskal’s algoritme en vergelijk de resultaten met Prim.

---

## 5.6 Het Handelsreizigersprobleem (TSP)

- **Beschrijving**:
  - Vind de kortste route die alle knopen in een graaf bezoekt en terugkeert

 naar de start.
 Moeilijk probleem, vaak opgelost met benaderingsalgoritmen of heuristieken.

---

## Samenvatting

- Grafen zijn veelzijdige datastructuren voor het modelleren van netwerken en relaties.
- BFS en DFS zijn fundamenteel voor graafdoorzoeking.
- Kortste pad-algoritmen zoals Dijkstra's en minimale opspannende boom-algoritmen zoals Prim’s zijn belangrijk voor geoptimaliseerde verbindingen.
- Het handelsreizigersprobleem blijft een uitdaging, meestal aangepakt met heuristieken.

This markdown version includes all the key points, explanations, examples, and exercises for **Chapter 5: Graafalgoritmes**.
