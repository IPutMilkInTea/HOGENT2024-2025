total = round(float(input()) * 100)

for a in range(1, total // 3 + 1):
    for b in range(a, (total - a) // 2 + 1):
        c = total - a - b
        if a * b * c == total * (10 ** 4):
            a, b, c, total = a/100, b/100, c/100, total/100
            print(f"€{a:.2f} + €{b:.2f} + €{c:.2f} = €{a:.2f} x €{b:.2f} x €{c:.2f} = €{total:.2f}")
            break
    else:
        continue
    break
