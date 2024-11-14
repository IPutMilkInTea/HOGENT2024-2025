isbn = [int(input()) for _ in range(10)]

som = 0
for i in range(9):
    som += isbn[i] * (10 - i)

controlecijfer = (11 - (som % 11)) % 11

if controlecijfer == isbn[9]:
    print("OK")
else:
    print("FOUT")
