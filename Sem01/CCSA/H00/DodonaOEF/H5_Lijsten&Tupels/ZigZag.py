def iszigzag(reeks):
    """
    Controleer of een lijst zigzag-gesorteerd is.
    """
    for i in range(len(reeks) - 1):
        if i % 2 == 0:  # even index
            if reeks[i] < reeks[i + 1]:
                return False
        else:  # oneven index
            if reeks[i] > reeks[i + 1]:
                return False
    return True

def zigzag_traag(reeks):
    """
    Zigzag-sorteer een lijst volgens de trage methode:
    Sorteer de lijst, en wissel om de beurt elk paar om.
    """
    # Stap 1: Sorteer de lijst in oplopende volgorde
    reeks.sort()
    
    # Stap 2: Wissel elk niet-overlappend paar
    for i in range(1, len(reeks), 2):
        # Wissel index i met index i-1
        reeks[i - 1], reeks[i] = reeks[i], reeks[i - 1]

def zigzag_snel(reeks):
    """
    Zigzag-sorteer een lijst volgens de snelle methode: check en wissel alleen voor even indices.
    """
    for i in range(0, len(reeks), 2):
        # Wissel met de vorige oneven index als de huidige kleiner is (indien mogelijk)
        if i > 0 and reeks[i] < reeks[i - 1]:
            reeks[i], reeks[i - 1] = reeks[i - 1], reeks[i]
        # Wissel met de volgende oneven index als de huidige kleiner is (indien mogelijk)
        if i + 1 < len(reeks) and reeks[i] < reeks[i + 1]:
            reeks[i], reeks[i + 1] = reeks[i + 1], reeks[i]
