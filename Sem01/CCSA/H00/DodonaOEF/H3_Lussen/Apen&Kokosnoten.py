aantal_piraten = int(input())
totaal_kokosnoten = int(input())

def piratenkokosnotenverdeling(aantal_piraten, totaal_kokosnoten):
    for piraat_nummer in range(1, aantal_piraten + 1):
        aantal_kokosnoten_nacht = totaal_kokosnoten
        aantal_kokosnoten_verstopt = aantal_kokosnoten_nacht // aantal_piraten
        kokosnoten_aap = aantal_kokosnoten_nacht % aantal_piraten
        totaal_kokosnoten = aantal_kokosnoten_nacht - aantal_kokosnoten_verstopt - kokosnoten_aap

        print(f"{nootvorm(aantal_kokosnoten_nacht)} = {nootvorm(aantal_kokosnoten_verstopt)} voor piraat#{piraat_nummer} en {nootvorm(kokosnoten_aap)} voor de aap")

    per_piraat = totaal_kokosnoten // aantal_piraten
    aap_kokosnoten = totaal_kokosnoten % aantal_piraten

    print(f"elke piraat krijgt {nootvorm(per_piraat)} en {nootvorm(aap_kokosnoten)} voor de aap")

def nootvorm(aantal):
    if aantal == 0:
        return "geen noten"
    if aantal == 1:
        return "1 noot"
    return f"{aantal} noten"

piratenkokosnotenverdeling(aantal_piraten, totaal_kokosnoten)
