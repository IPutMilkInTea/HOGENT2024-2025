def ggd(a, b):
    if b == 0:
        return a
    else:
        return ggd(b, a % b)
