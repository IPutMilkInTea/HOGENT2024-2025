def nieuw_kaartspel(kleuren, waarden):
    return [kleur + waarde for kleur in kleuren for waarde in waarden]

def splits_kaartspel(kaarten):
    mid = len(kaarten) // 2
    if len(kaarten) % 2 == 0:
        return (kaarten[:mid], kaarten[mid:])
    else:
        return (kaarten[:mid], kaarten[mid:])

def faro_shuffle(deel1, deel2):
    kaarten = []
    for kaart1, kaart2 in zip(deel1, deel2):
        kaarten.append(kaart1)
        kaarten.append(kaart2)
    if len(deel2) > len(deel1):
        kaarten += deel2[len(deel1):]
    return kaarten
