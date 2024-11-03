def blackjack():
    total = 0

    while True:
        card = int(input("Voer een kaart in (1-11 of 0 om te stoppen): "))

        if card < 0 or card > 11:
            print("Ongeldige invoer. Voer een waarde in van 1 tot 11, of 0 om te stoppen.")
            continue

        total += card

        if total == 21:
            print("Gewonnen!")
            break
        elif total > 21:
            print(f"Verbrand ({total})")
            break
        elif total < 21 and card == 0:
            print(f"Voorzichtig gespeeld ({total})")
            break

blackjack()
