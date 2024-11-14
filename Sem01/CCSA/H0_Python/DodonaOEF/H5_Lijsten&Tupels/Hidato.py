def eerste(rooster):
    for r, rij in enumerate(rooster):
        for k, waarde in enumerate(rij):
            if waarde == 1:
                return (r, k)
    return (None, None)

def opvolger(rooster, r, k):
    m, n = len(rooster), len(rooster[0])
    waarde = rooster[r][k]
    doelwaarde = waarde + 1
    for dr, dk in [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 1), (1, -1), (1, 0), (1, 1)]:
        nr, nk = r + dr, k + dk
        if 0 <= nr < m and 0 <= nk < n and rooster[nr][nk] == doelwaarde:
            return (nr, nk)
    return (None, None)

def laatste(rooster):
    huidige = eerste(rooster)
    while True:
        volgende = opvolger(rooster, *huidige)
        if volgende == (None, None):
            return huidige
        huidige = volgende

def hidato(rooster):
    eind_cel = laatste(rooster)
    eind_waarde = rooster[eind_cel[0]][eind_cel[1]]
    return eind_waarde == len(rooster) * len(rooster[0])
