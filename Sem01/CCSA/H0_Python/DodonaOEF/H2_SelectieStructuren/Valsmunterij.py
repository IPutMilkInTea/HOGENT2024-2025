weging1 = input().strip()
weging2 = input().strip()

if weging1 == 'evenwicht':
    if weging2 == 'rechts':
        print("muntstuk #7 is vervalst")
    elif weging2 == 'links':
        print("muntstuk #8 is vervalst")
    else:
        print("muntstuk #9 is vervalst")
else:
    if weging1 == 'rechts':
        if weging2 == 'rechts':
            print("muntstuk #1 is vervalst")
        elif weging2 == 'links':
            print("muntstuk #2 is vervalst")
        else:
            print("muntstuk #3 is vervalst")
    elif weging1 == 'links':
        if weging2 == 'rechts':
            print("muntstuk #4 is vervalst")
        elif weging2 == 'links':
            print("muntstuk #5 is vervalst")
        else:
            print("muntstuk #6 is vervalst")
