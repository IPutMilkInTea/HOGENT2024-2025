aantal_stuks = int(input())
kostprijs_per_stuk = float(input())
barcodes_per_coupon = int(input())
mijlen_per_coupon = int(input())

totale_kostprijs = aantal_stuks * kostprijs_per_stuk

aantal_coupons = aantal_stuks // barcodes_per_coupon

totale_mijlen = aantal_coupons * mijlen_per_coupon

print(f"Phillips spendeerde ${totale_kostprijs} voor {totale_mijlen} frequent flyer mijlen.")
