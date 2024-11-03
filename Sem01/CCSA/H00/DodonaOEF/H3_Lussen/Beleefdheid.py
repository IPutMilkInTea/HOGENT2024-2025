def beleefdheid(n):
    count = 0
    for k in range(2, n + 1):
        sum_k_minus_1 = (k * (k - 1)) // 2

        if n > sum_k_minus_1 and (n - sum_k_minus_1) % k == 0:
            count += 1
    
    return count

n = int(input("Voer een strikt positief natuurlijk getal in: "))

if n > 0:
    result = beleefdheid(n)
    print(result)
else:
    print("Ongeldige invoer. Voer een strikt positief natuurlijk getal in.")
