from collections import Counter

def dubbel(lijst):
    teller = Counter(lijst)  # Tel hoe vaak elk getal voorkomt
    for getal, aantal in teller.items():
        if aantal == 2:
            return getal
    return None

def dubbels(lijst):
    teller = Counter(lijst)
    een_keer = {getal for getal, aantal in teller.items() if aantal == 1}
    meer_dan_een_keer = {getal for getal, aantal in teller.items() if aantal > 1}
    return een_keer, meer_dan_een_keer
