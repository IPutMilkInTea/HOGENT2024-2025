import math

a = float(input().strip())
b = float(input().strip())
c = float(input().strip())

D = b**2 - 4*a*c

if D < 0:
    print("geen wortels")
elif D == 0:
    x = -b / (2*a)
    print("een wortel")
    print(f"{x:.6f}")
else:
    x1 = (-b - math.sqrt(D)) / (2*a)
    x2 = (-b + math.sqrt(D)) / (2*a)
    print("twee wortels")
    print(f"{min(x1, x2):.6f}")
    print(f"{max(x1, x2):.6f}")
