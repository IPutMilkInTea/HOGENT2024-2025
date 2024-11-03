def vertalingToevoegen(woord, vertaling, woordenboek):
    woordenboek[woord] = vertaling

def vertaling(woord, woordenboek):
    return woordenboek.get(woord, "???")
