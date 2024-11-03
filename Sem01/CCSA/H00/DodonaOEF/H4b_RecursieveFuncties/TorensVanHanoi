def hanoi(n, start='A', target='C', auxiliary='B'):
    stappen = []

    def verplaats_schijven(n, start, target, auxiliary):
        if n == 1:
            stappen.append(f"Schijf 1 van {start} naar {target}")
        else:
            verplaats_schijven(n - 1, start, auxiliary, target)
            stappen.append(f"Schijf {n} van {start} naar {target}")
            verplaats_schijven(n - 1, auxiliary, target, start)

    verplaats_schijven(n, start, target, auxiliary)

    for stap in stappen:
        print(stap)

    print(f"{len(stappen)} stappen gedaan")
