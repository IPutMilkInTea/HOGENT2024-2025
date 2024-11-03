def waardering(prijs_big_mac, reeële_wisselkoers):
    prijs_big_mac_vs = 4.07

    big_mac_wisselkoers = prijs_big_mac / prijs_big_mac_vs

    verhouding = ((big_mac_wisselkoers - reeële_wisselkoers) / reeële_wisselkoers) * 100

    if verhouding <= -25:
        return "sterk ondergewaardeerd"
    elif -25 < verhouding <= -5:
        return "ondergewaardeerd"
    elif -5 < verhouding <= 5:
        return "ongeveer gelijk"
    elif 5 < verhouding <= 25:
        return "overgewaardeerd"
    else:
        return "sterk overgewaardeerd"
        
def wisselkoersanalyse(kostprijs_munt, reeële_wisselkoers):
    prijs, munt = kostprijs_munt.split(' ', 1)

    prijs = float(prijs.strip())

    valutawaardering = waardering(prijs, reeële_wisselkoers)

    return f"De {munt.strip()} is {valutawaardering} ten opzichte van de dollar."
