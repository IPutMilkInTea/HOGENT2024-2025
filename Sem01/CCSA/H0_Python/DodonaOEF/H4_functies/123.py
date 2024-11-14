def even_oneven(n):
    even = 0
    oneven = 0
    for digit in str(n):
        if int(digit) % 2 == 0:
            even += 1
        else:
            oneven += 1
    return even, oneven
    
def volgende(n):
    even, oneven = even_oneven(n)
    totaal = len(str(n))
    nieuw_getal = int(f"{even}{oneven}{totaal}")
    return nieuw_getal

def stappen(n):
    aantal_stappen = 0
    while n != 123:
        n = volgende(n)
        aantal_stappen += 1
    return aantal_stappen
