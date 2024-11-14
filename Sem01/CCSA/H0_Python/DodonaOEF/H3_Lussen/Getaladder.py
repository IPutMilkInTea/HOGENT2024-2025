def print_ladder(n):
    for k in range(1, n + 1):
        for i in range(1, k + 1):
            print(i, end="")
        print()

n = int(input("Voer een natuurlijk getal in (0 < n <= 9): "))

if 0 < n <= 9:
    print_ladder(n)
else:
    print("Ongeldige invoer. Voer een getal in tussen 1 en 9.")
