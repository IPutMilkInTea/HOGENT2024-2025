def bereken_temperaturen(tjirps_per_minuut):
    TF = 50 + (tjirps_per_minuut - 40) / 4

    TC = 10 + (tjirps_per_minuut - 40)  / 7

    print(f"temperatuur (Fahrenheit): {TF}")
    print(f"temperatuur (Celsius): {TC}")

tjirps_per_minuut = int(input("Voer het aantal tjirps per minuut in: "))

bereken_temperaturen(tjirps_per_minuut)
