rw = int(input().strip())
wb = int(input().strip())
operator = input().strip()

for blue in range(2, wb):
    white = wb - blue
    red = rw - white
    
    if red >= 2 and white >= 2:
        total_br = blue + red

        if (operator == '>' and total_br > wb) or (operator == '<' and total_br < wb):
            print(blue)
            print(white)
            print(red)
            break
