def ontleding(akkoord):
    i = 1
    if len(akkoord) > 1 and akkoord[1] == '#':  # Controleer op hekje
        i = 2
    grondnoot = akkoord[:i]
    symbool = akkoord[i:]
    return grondnoot, symbool

def noten(grondnoot, intervallen):
    # Chromatische toonladder
    toonladder = ['C', 'C#', 'D', 'D#', 'E', 'F', 'F#', 'G', 'G#', 'A', 'A#', 'B']
    startindex = toonladder.index(grondnoot)
    
    akkoordnoten = []
    for interval in intervallen:
        nootindex = (startindex + interval) % 12
        akkoordnoten.append(toonladder[nootindex])
    return akkoordnoten

def akkoord(akkoordnotatie, akkoordtypes, akkoordsymbolen):
    grondnoot, symbool = ontleding(akkoordnotatie)
    akkoordtype = akkoordsymbolen[symbool]
    intervallen = akkoordtypes[akkoordtype]
    akkoordnoten = noten(grondnoot, intervallen)
    return tuple(akkoordnoten)
