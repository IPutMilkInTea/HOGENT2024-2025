# Samenvatting Hoofdstuk 6: Zoekalgoritmes

## 6.1 Inleiding tot Zoekalgoritmes

- **Beschrijving**:
  - Zoekalgoritmes worden gebruikt om het pad of de oplossing te vinden in een gegeven probleemruimte, zoals een doolhof, een grafenstructuur of een puzzel.
  - Ze kunnen worden onderverdeeld in:
    - **Blinde zoekmethoden**: Verkennen de probleemruimte zonder enige kennis.
    - **Geïnformeerde zoekmethoden**: Gebruiken heuristieken om de zoekruimte efficiënter te doorzoeken.

---

## 6.2 Blinde Zoekmethoden

### 6.2.1 Breedte-Eerst Zoeken (BFS)

- **Beschrijving**:
  - Doorloopt de probleemruimte niveau voor niveau, beginnend bij de startpositie.
  - Past goed bij problemen waar de oplossing dicht bij de startpositie ligt.

- **Voorbeeld**:

  ```python
  def bfs(graaf, start, doel):
      bezocht = set()
      wachtrij = [(start, [start])]  # Elke positie bevat de huidige knoop en het pad.
      while wachtrij:
          huidige, pad = wachtrij.pop(0)
          if huidige == doel:
              return pad
          bezocht.add(huidige)
          for buur in graaf[huidige]:
              if buur not in bezocht:
                  wachtrij.append((buur, pad + [buur]))
  ```

- **Tijdcomplexiteit**: `O(V + E)`.

---

### 6.2.2 Diepte-Eerst Zoeken (DFS)

- **Beschrijving**:
  - Doorloopt de probleemruimte door dieper te verkennen voordat het andere paden onderzoekt.
  - Geschikt voor problemen waar diepe oplossingen bestaan of waarbij de hele ruimte moet worden doorzocht.

- **Voorbeeld**:

  ```python
  def dfs(graaf, huidige, doel, pad=None, bezocht=None):
      if pad is None:
          pad = [huidige]
      if bezocht is None:
          bezocht = set()
      if huidige == doel:
          return pad
      bezocht.add(huidige)
      for buur in graaf[huidige]:
          if buur not in bezocht:
              resultaat = dfs(graaf, buur, doel, pad + [buur], bezocht)
              if resultaat:
                  return resultaat
  ```

- **Tijdcomplexiteit**: `O(V + E)`.

---

### 6.2.3 Vergelijking

| Kenmerk        | BFS              | DFS              |
|----------------|------------------|------------------|
| **Strategie**  | Niveau voor niveau | Diepgaand verkennen |
| **Tijdcomplexiteit** | `O(V + E)`     | `O(V + E)`         |
| **Geheugen**   | Groter (wachtrij)  | Kleiner (stapel/recursie) |
| **Geschikt voor** | Dichtbijgelegen oplossingen | Diepe oplossingen |

---

## 6.3 Geïnformeerde Zoekmethoden

### 6.3.1 Heuristieken

- **Beschrijving**:
  - Een **heuristiek** is een schatting van de kosten om een bepaalde knoop naar het doel te bereiken.
  - Een goede heuristiek kan de zoekruimte aanzienlijk verkleinen.

---

### 6.3.2 Gulzige Beste-Eerst Zoeken

- **Beschrijving**:
  - Gebruikt een heuristiek om altijd de knoop te verkennen die het dichtst bij het doel lijkt te liggen.
  - Kan leiden tot suboptimale oplossingen, omdat het geen rekening houdt met al gemaakte kosten.

- **Voorbeeld**:

  ```python
  import heapq

  def gulzig_zoek(graaf, start, doel, heuristiek):
      pq = [(heuristiek[start], start, [start])]  # Prioriteitswachtrij
      while pq:
          _, huidige, pad = heapq.heappop(pq)
          if huidige == doel:
              return pad
          for buur, kosten in graaf[huidige]:
              heapq.heappush(pq, (heuristiek[buur], buur, pad + [buur]))
  ```

---

### 6.3.3 A*-Algoritme

- **Beschrijving**:
  - Combineert de voordelen van BFS en heuristieken door gebruik te maken van de formule:
  
    ```
    f(n) = g(n) + h(n)
    ```

    Waarbij:
    - `g(n)`: De kosten om de huidige knoop te bereiken.
    - `h(n)`: De geschatte kosten om van de huidige knoop naar het doel te komen.

- **Voorbeeld**:

  ```python
  def a_ster(graaf, start, doel, heuristiek):
      pq = [(0 + heuristiek[start], 0, start, [start])]  # (f, g, huidige, pad)
      while pq:
          f, g, huidige, pad = heapq.heappop(pq)
          if huidige == doel:
              return pad
          for buur, kosten in graaf[huidige]:
              nieuwe_g = g + kosten
              nieuwe_f = nieuwe_g + heuristiek[buur]
              heapq.heappush(pq, (nieuwe_f, nieuwe_g, buur, pad + [buur]))
  ```

- **Tijdcomplexiteit**: `O(E log V)`.

---

## 6.4 Vergelijking van Zoekmethoden

| Algoritme              | Optimale oplossing? | Compleet? | Gebruik Heuristiek | Tijdcomplexiteit   |
|------------------------|---------------------|-----------|--------------------|--------------------|
| **BFS**               | Ja                  | Ja        | Nee                | `O(V + E)`         |
| **DFS**               | Nee                 | Nee       | Nee                | `O(V + E)`         |
| **Gulzig Beste-Eerst**| Nee                 | Nee       | Ja                 | `O(E log V)`       |
| **A***                | Ja                  | Ja        | Ja                 | `O(E log V)`       |

---

## 6.5 Toepassingen van Zoekalgoritmes

- **Navigatie**:
  - A*-algoritme wordt vaak gebruikt in navigatiesystemen om de snelste route te berekenen.
  
- **Spel AI**:
  - Gulzige zoekmethoden en A* worden gebruikt om paden te zoeken in bordspellen en strategieën.
  
- **Netwerkoptimalisatie**:
  - BFS en DFS worden gebruikt om paden en verbindingen in netwerken te analyseren.

---

## 6.6 Oefeningen

1. **Implementatie van BFS en DFS**:
   - Implementeer BFS en DFS op een graaf en zoek het kortste pad tussen twee knopen.

2. **Gulzig Beste-Eerst Zoeken**:
   - Implementeer het gulzige zoekalgoritme met een gegeven heuristiek en test het op een voorbeeldgraaf.

3. **A*-Algoritme**:
   - Schrijf een implementatie van A* en test deze op een gewogen graaf.

4. **Vergelijking van Algoritmes**:
   - Test BFS, DFS, Gulzig Beste-Eerst, en A* op een complexe graaf en analyseer de verschillen in prestaties en oplossingen.

---

## Samenvatting

- Zoekalgoritmes zijn essentieel voor het vinden van paden of oplossingen in probleemruimten.
- Blinde methoden zoals BFS en DFS verkennen de ruimte zonder heuristieken, terwijl geïnformeerde methoden zoals Gulzig Beste-Eerst en A* heuristieken gebruiken om efficiënter te zoeken.
- A* is vaak de beste keuze als een optimale oplossing vereist is en een goede heuristiek beschikbaar is.

This markdown version provides a comprehensive overview of **Chapter 6: Zoekalgoritmes**, including explanations, examples, comparisons, and exercises for better understanding.
