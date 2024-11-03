def letterfrequenties(zin):
    zin = zin.lower()
    frequentie_dict = {}
    
    for char in zin:
        if char.isalpha():
            if char in frequentie_dict:
                frequentie_dict[char] += 1
            else:
                frequentie_dict[char] = 1
                
    return frequentie_dict

def letterposities(zin):
    zin = zin.lower()
    posities_dict = {}
    
    for index, char in enumerate(zin):
        if char.isalpha():
            if char in posities_dict:
                posities_dict[char].add(index)
            else:
                posities_dict[char] = {index}
                
    return posities_dict
