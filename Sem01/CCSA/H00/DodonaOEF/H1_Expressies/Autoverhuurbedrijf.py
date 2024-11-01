def bereken_verbruik(a, b, l):

    afgelegde_kilometers = b - a

    verbruik_per_100_km = (l / afgelegde_kilometers) * 100

    print(f"{verbruik_per_100_km: }")

a = float(input("Kilometerstand bij afhalen: "))
b = float(input("Kilometerstand bij terugbrengen: "))
l = float(input("Aantal liter getankt: "))

bereken_verbruik(a, b, l)
