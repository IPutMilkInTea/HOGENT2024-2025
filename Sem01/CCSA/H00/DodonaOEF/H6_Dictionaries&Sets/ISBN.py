def bereken_controlecijfer(isbn):
    """
    Berekent het controlecijfer voor de eerste 12 cijfers van een ISBN-13 code.
    """
    o = sum(int(isbn[i]) for i in range(0, 12, 2))
    e = sum(int(isbn[i]) for i in range(1, 12, 2))
    controlecijfer = (10 - (o + 3 * e) % 10) % 10
    return controlecijfer

def geldig_isbn(isbn):
    """
    Controleert of een ISBN-13 code geldig is: begint met 978 of 979 en heeft correct controlecijfer.
    """
    if len(isbn) != 13 or not isbn.isdigit() or isbn[:3] not in {'978', '979'}:
        return False
    return int(isbn[-1]) == bereken_controlecijfer(isbn)

def overzicht(codes):
    """
    Geeft een overzicht van het aantal ISBN-13 codes per registratiegroep.
    """
    groepen = {
        'Engelstalige landen': 0,
        'Franstalige landen': 0,
        'Duitstalige landen': 0,
        'Japan': 0,
        'Russischtalige landen': 0,
        'China': 0,
        'Overige landen': 0,
        'Fouten': 0
    }
    
    for isbn in codes:
        if not geldig_isbn(isbn):
            groepen['Fouten'] += 1
        else:
            landcode = isbn[3]
            if landcode in {'0', '1'}:
                groepen['Engelstalige landen'] += 1
            elif landcode == '2':
                groepen['Franstalige landen'] += 1
            elif landcode == '3':
                groepen['Duitstalige landen'] += 1
            elif landcode == '4':
                groepen['Japan'] += 1
            elif landcode == '5':
                groepen['Russischtalige landen'] += 1
            elif landcode == '7':
                groepen['China'] += 1
            else:
                groepen['Overige landen'] += 1

    # Print het overzicht
    for groep, aantal in groepen.items():
        print(f"{groep}: {aantal}")
