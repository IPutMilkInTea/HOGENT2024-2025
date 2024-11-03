def som_echte_delers(n):
    som = 0
    for i in range(1, int(n**0.5) + 1):
        if n % i == 0:
            som += i
            if i != 1 and i != n // i:
                som += n // i
    return som

a = int(input("Voer het eerste natuurlijke getal in: "))
b = int(input("Voer het tweede natuurlijke getal in: "))

som_delers_a = som_echte_delers(a)
som_delers_b = som_echte_delers(b)

if som_delers_a == b and som_delers_b == a:
    print(f"{a} en {b} zijn bevriende getallen")
else:
    print(f"{a} en {b} zijn geen bevriende getallen")
