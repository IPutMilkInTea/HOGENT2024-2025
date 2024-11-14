# Hoofdstuk 2

## 2.1 Gelinkte Lijsten

Een **gelinkte lijst** is een dynamische datastructuur die bestaat uit knooppunten, waarbij elk knooppunt bevat:

- **Gegevens**: De waarde die in het knooppunt is opgeslagen.
- **Volgende**: Een referentie (of pointer) naar het volgende knooppunt in de lijst.

Gelinkte lijsten bieden voordelen ten opzichte van arrays, waaronder dynamische grootte en gemakkelijke invoer/verwijdering. Toegang tot knooppunten vereist echter doorlopen van de lijst vanaf het hoofd knooppunt, wat leidt tot een lineaire tijdcomplexiteit voor operaties zoals het vinden van het laatste element.

**Operaties**:

- **Invoegen**: Knooppunten kunnen aan het begin, het einde of op een gespecificeerde positie worden toegevoegd.
- **Verwijderen**: Knooppunten kunnen van elke positie worden verwijderd door de verwijzingen van de omliggende knooppunten aan te passen.
- **Doorlopen**: Het itereren door de lijst maakt toegang tot de gegevens van elk knooppunt mogelijk.

## 2.2 Toepassingen van Gelinkte Lijsten

Gelinkte lijsten zijn veelzijdig en worden gebruikt voor:

- Het implementeren van stacks en queues.
- Het beheren van dynamisch geheugen, vooral in gevallen waarin de grootte van de datastructuur vaak kan veranderen.
- Het creëren van complexe datastructuren zoals grafen en bomen.

## 2.3 Dubbel-Gelinkte Lijsten

Een **dubbel-gelinkte lijst** verbetert de enkel-gelinkte lijst door in elk knooppunt twee referenties te onderhouden:

- Eén naar het **volgende** knooppunt.
- Een andere naar het **vorige** knooppunt.

Deze bidirectionele navigatie vergemakkelijkt operaties zoals:

- Efficiënte invoer en verwijdering van beide uiteinden.
- Directe toegang tot zowel het eerste als het laatste knooppunt, wat de prestaties verbetert.

Een lege dubbel-gelinkte lijst kan worden geïdentificeerd door te controleren of de `volgende` referentie van het eerste knooppunt gelijk is aan de `vorige` referentie van het laatste knooppunt.

## 2.4 Implementatie van Stacks

Een **stack** is een lineaire datastructuur die het Last-In-First-Out (LIFO) principe volgt. Het enige toegankelijke element is het **bovenste** element, wat het vergelijkbaar maakt met een stapel boeken waarbij alleen het bovenste boek bereikbaar is.

**Kernoperaties**:

- **Constructor (`Stack()`)**: Initialiseert een lege stack.
- **`empty()`**: Retourneert een boolean die aangeeft of de stack leeg is.
- **`push(x)`**: Voegt element `x` bovenop de stack toe.
- **`pop()`**: Verwijdert en retourneert het bovenste element van de stack.
- **`peek()`**: Retourneert het bovenste element zonder het te verwijderen.

**Stack als een Gelinkte Lijst**:
Stacks kunnen worden geïmplementeerd met een enkel-gelinkte lijst waarbij alleen het bovenste knooppunt wordt verwezen. De interne klasse `Node` vertegenwoordigt elk element in de stack, met de volgende kenmerken:

- `data`: De waarde van het knooppunt.
- `next`: Een referentie naar het volgende knooppunt (het knooppunt eronder in de stack).

**Stack Operaties in Pseudocode**:

1. **Constructor**:

   ```plaintext
   function STACK
       t ← null
   end function
   ```

2. **Controleer of de stack leeg is**:

   ```plaintext
   function EMPTY
       return t = null
   end function
   ```

3. **Voeg een element toe aan de stack**:

   ```plaintext
   function PUSH(x)
       hulp ← new Node()
       hulp.data ← x
       hulp.next ← t
       t ← hulp
   end function
   ```

4. **Verwijder het bovenste element**:

   ```plaintext
   function POP
       x ← t.data
       t ← t.next
       return x
   end function
   ```

5. **Bekijk het bovenste element**:

   ```plaintext
   function PEEK
       return t.data
   end function
   ```

## 2.5 Toepassingen van Stacks

1. **Validatie van Haakjes**: Stacks zijn essentieel bij het verifiëren dat haakjes in programmeercode correct zijn gematcht. Het algoritme omvat:
   - Het initialiseren van een lege stack.
   - Het itereren door elk teken; als het een openingssymbool is, wordt het op de stack geplaatst. Als het een sluitingssymbool is, controleert het algoritme op een bijbehorend openingssymbool door de pop-operatie te gebruiken.
   - Aan het einde, als de stack niet leeg is, geeft dit aan dat er ongepaste openingssymbolen zijn.

   **Pseudocode voor Haakjesvalidatie**:

   ```plaintext
   function CHECK_PARENTHESIS(expression)
       s ← STACK()
       for i = 0 to expression.length - 1
           symbol ← expression[i]
           if symbol is opening then
               s.PUSH(symbol)
           else if symbol is closing then
               if s.EMPTY() then
                   PRINT("Te veel sluitingssymbolen")
               else
                   previous ← s.POP()
                   if symbol and previous do not correspond then
                       PRINT("Fout symbool:", symbol)
           end if
       end for
       if not s.EMPTY() then
           PRINT("Te veel openingssymbolen.")
       end if
   end function
   ```

2. **Evaluatie van Aritmetische Expressies**: Stacks worden ook gebruikt om aritmetische expressies in **postfixnotatie** (Reverse Polish Notation) te evalueren. In postfixnotatie volgen operatoren hun operand, wat een eenvoudige evaluatie zonder rekening te houden met de operatorprioriteit mogelijk maakt.

   Voorbeeld: De postfixexpressie `3 4 *` evalueert naar `3 * 4 = 12`, wat demonstreert hoe operanden worden verwerkt met hun operatoren.

---
