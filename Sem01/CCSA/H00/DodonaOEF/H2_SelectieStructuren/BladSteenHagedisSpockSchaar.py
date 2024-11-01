regels = {
    'schaar': ['blad', 'hagedis'],
    'blad': ['steen', 'Spock'],
    'steen': ['schaar', 'hagedis'],
    'hagedis': ['Spock', 'blad'],
    'Spock': ['schaar', 'steen']
}

speler1 = input().strip()
speler2 = input().strip()

if speler1 == speler2:
    print("gelijkspel")
elif speler2 in regels[speler1]:
    print("speler1 wint")
else:
    print("speler2 wint")
