def zeef(n):
    priem = [True] * (n + 1)
    p = 2
    while p * p <= n:
        if priem[p]:
            for i in range(p * p, n + 1, p):
                priem[i] = False
        p += 1
    return [p for p in range(2, n + 1) if priem[p]]
