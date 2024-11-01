bovenkant, eigenschap, gegeven = input(), input(), bool(input() == 'ja')
verwachting = float(eigenschap) % 2 == 0 if eigenschap.isdigit() else eigenschap != 'rood'
print(('Juist' if gegeven == verwachting else 'Fout') + ': kaarten met ' + bovenkant + ' ' + eigenschap + ' moeten ' + ('' if verwachting else 'niet ') + 'gedraaid worden.')
