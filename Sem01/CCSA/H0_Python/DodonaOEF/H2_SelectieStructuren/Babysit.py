def tijd_in_minuten(uur, minuut):
    return (uur - 18) * 60 + minuut

begin_uur = int(input())
begin_minuut = int(input())
eind_uur = int(input())
eind_minuut = int(input())

if begin_uur < 18 or (eind_uur == 0 and eind_minuut > 0) or eind_uur > 23 or eind_uur == 0 or begin_uur >= 24:
    print("ongeldige invoer")
else:
    begintijd = tijd_in_minuten(begin_uur, begin_minuut)
    eindtijd = tijd_in_minuten(eind_uur, eind_minuut) if eind_uur != 0 else 360
    
    if begintijd > eindtijd:
        print("ongeldige invoer")
    else:
        grens_tarief1 = 210

        totaal_bedrag = 0

        if begintijd < grens_tarief1:
            tijd_in_tarief1 = min(eindtijd, grens_tarief1) - begintijd
            totaal_bedrag += tijd_in_tarief1 * (2 / 60)

        if eindtijd > grens_tarief1:
            tijd_in_tarief2 = eindtijd - max(begintijd, grens_tarief1)
            totaal_bedrag += tijd_in_tarief2 * (4 / 60)
        
        print(f"{totaal_bedrag:f}")
