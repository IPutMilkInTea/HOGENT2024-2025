def bovensteboven(n):
    draai_mapping = {'0': '0', '1': '1', '6': '9', '8': '8', '9': '6'}
    n_str = str(n)
    gedraaide_str = ''
    
    for char in n_str:
        if char not in draai_mapping:
            return False
        gedraaide_str = draai_mapping[char] + gedraaide_str
    return n_str == gedraaide_str

def volgende(n):
    n += 1
    while not bovensteboven(n):
        n += 1
    return n
