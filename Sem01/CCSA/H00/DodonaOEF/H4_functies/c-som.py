def csom(n):
    if n == 0:
        return 0
    else:
        return n % 9 if n % 9 != 0 else 9
