# H02: Functional Requirements

## 1. Inleiding

Zoals gezien tijdens het opleidingsonderdeel **Software Analysis** zijn *requirements* of behoeften de eisen van de klant waaraan een product moet voldoen. Er werd toen ook een onderscheid gemaakt tussen **functionele requirements** en **niet-functionele requirements**. Deze functionele behoeften beschrijven welke functionaliteiten het systeem moet bevatten en die dus door een actor moeten kunnen worden uitgevoerd op het systeem. Deze functionaliteiten zullen we vastleggen en éénduidig definiëren in *use cases*.

## 2. Use Case Diagram

Een overzicht van alle beschikbare functionaliteiten wordt weergegeven in een **use case diagram**. Enerzijds hebben we in dat schema een overzicht van alle rollen die toegang hebben tot het systeem. Daarnaast toont een use case diagram ook welke rol gebruik kan maken van welke functionaliteit op het systeem. Het kan echter zijn dat voor het uitvoeren van een bepaalde functionaliteit steeds een andere nodig is; in dat geval gebruiken we het mechanisme van **“include”**. Het schema kan ook gebruikmaken van een **“extends”** tussen twee use cases als de ene functionaliteit soms nood heeft aan een andere bij het uitvoeren.

## 3. Use Cases

### 3.1 Inleiding

Een *use case* bevat het uitgeschreven verhaal van een primary actor die het systeem zal gebruiken om een bepaald doel te bereiken. Deze verhalen zijn in zo eenvoudig mogelijke taal opgesteld (zonder technisch jargon) met als belangrijkste doel: **duidelijke communicatie**. Enerzijds is er communicatie naar de klant toe, zodat we het uitgeschreven verhaal aan de klant kunnen voorleggen om te verifiëren of we het verhaal hebben beschreven zoals hij het bedoelt. Anderzijds dient een use case om te communiceren met de mensen uit het IT-team om het product verder te ontwikkelen.

Een use case is een visie op het systeem met een bepaalde scope en een afgebakend doel, waarin bepaalde belanghebbende partijen in interactie treden met het systeem om dat doel te bereiken. Deze verhalen zijn kort van aard, omdat ze als duidelijk communicatiemiddel moeten dienen, en worden dan ook per scenario beperkt tot een halve pagina.

#### Hoe weten we nu welke verhalen we gaan uitwerken als use case?

Daarvoor gaan we op zoek naar de elementaire businessprocessen die een user goal voorstellen.

### 3.2 Elementaire Business Processen

Elementaire businessprocessen zijn op te delen in drie verschillende categorieën. Enerzijds hebben we de hogere doelen van een bedrijf die een verzameling zijn van aparte doelen. Dit noemen we **“summary goals”**.

### 3.3 Onderdelen

Een use case bevat de volgende elementen:

- **Primary actor**
- **Stakeholder(s)**
- **Preconditie(s)**
- **Postconditie(s)**
- **Normaal verloop**
- **Alternatieve verlopen**
- **Domeinspecifieke regels**
- **Op te klaren punten** (optioneel)

#### 3.3.1 Primary Actor & Stakeholders

De **primary actor** is de persoon die het verhaaltje activeert; hij is degene die de functionaliteit wenst uit te voeren op het systeem. Een **stakeholder** of belanghebbende is een persoon die er belang bij heeft dat de primary actor zijn doel kan realiseren, maar zal zelf niet actief deelnemen aan het verhaal.

#### 3.3.2 Precondities & Postcondities

In de **precondities** vermelden we de niet-triviale voorwaarden die moeten zijn voldaan voordat een use case kan starten. Dit zijn voorwaarden die door het systeem kunnen worden gevalideerd voordat het verhaal begint. Het is dan ook niet meer nodig die nadien nog af te toetsen tijdens een scenario van de use case. In veel gevallen zal hier een verwijzing naar een externe use case voorkomen.

Bij de **postcondities** geef je vervolgens aan wat er door het systeem is vervuld na het uitvoeren van een scenario. Hierin staan de bereikte wijzigingen van het systeem ten opzichte van de status van het domeinmodel vóór het starten van de use case. Niet elk alternatief scenario zal deze postcondities bereiken.

#### 3.3.3 Normaal Verloop & Alternatief Verloop

Het **normale verloop** van een use case beschrijft de *main success story*. Dit is een uitgeschreven stappenplan van hoe de use case het meeste wordt gebruikt. Het is een chronologische en oplopend genummerde volgorde van actiestappen waarbij een wisselwerking tussen de primary actor en het systeem wordt beschreven.

In één stap kan het niet zo zijn dat de primary actor **én** het systeem iets doen! Vermijd het uitschrijven van UI-acties. We gaan ervan uit dat de primary actor de stappen wil uitvoeren, dus bevestigingen en annulaties zijn overbodig tenzij deze een speciaal verloop hebben.

Mogelijke stappen zijn:

- Primary actor voert actie uit
- Systeem registreert interne wijziging
- Systeem voert validatie of actie uit
- Systeem vraagt naar gegevens
- Systeem toont een melding en/of stuurt een melding

Bij de **alternatieve verlopen** worden de verhalen beschreven wanneer een stap uit het normale verloop of een ander alternatief verloop afwijkt van het verhaal. Elk alternatief verloop heeft als nummering de stap van het oorspronkelijke scenario waar de afwijking start, aangevuld met een alfabetische nummering van alternatieve verlopen voor die stap.

Binnen het alternatief verloop zelf wordt dan de nummering aangevuld met een oplopend nummer (start opnieuw bij 1) van chronologisch opeenvolgende deelstappen. Een alternatief verloop kan op de volgende manieren eindigen:

- Verhaal keert terug naar een stap in het normaal verloop
- Verhaal keert terug naar een stap in een ander alternatief verloop
- Er wordt een externe use case opgeroepen
- De huidige use case wordt stopgezet. Vermeld hierbij steeds de bereikte postcondities.

#### 3.3.4 Domeinspecifieke Regels & Op te Klaren Punten

Dit onderdeel bevat een opsomming van alle relevante regels die te maken hebben met het domein van het probleem. Hier vermeld je ook alle technische gegevens die later nodig zijn voor de ontwerper, ontwikkelaar of tester. Bijvoorbeeld: het wachtwoord moet minstens 8 tekens lang zijn en minstens een hoofdletter bevatten. De naamgeving per regel is steeds **DR_naam**. De `<naam>` is vrij te kiezen, maar zorg voor een passende en duidelijke naam.

Onder **op te klaren punten** worden alle zaken die nog onduidelijk waren bij het opstellen van de use case opgesomd. Deze sectie is vooral bedoeld om te communiceren met de klant. Aan het einde van de analysefase tijdens het software-ontwikkelingsproces is deze sectie dan ook leeg en overbodig geworden, omdat je dan alle info van de klant zou moeten hebben verkregen.
