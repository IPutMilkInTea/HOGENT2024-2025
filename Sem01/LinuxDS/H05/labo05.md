Hier is een gedetailleerde aanpak voor de oefeningen.

---

### **5.4.1 Globbing**

#### **1. Alle bestanden die beginnen met `file`**
```bash
ls file*
```

#### **2. Alle bestanden die beginnen met `file`, gevolgd door één letterteken**
```bash
ls file?
```

#### **3. Alle bestanden die beginnen met `file`, gevolgd door één letter, maar geen cijfer**
```bash
ls file[a-zA-Z]
```

#### **4. Alle bestanden die beginnen met `file`, gevolgd door één cijfer, maar geen letter**
```bash
ls file[0-9]
```

#### **5. De bestanden `file12` t/m `file16`**
```bash
ls file1[2-6]
```

#### **6. Bestanden die beginnen met `file`, niet gevolgd door een `1`**
```bash
ls file[^1]*
```

---

### **5.4.2 AWK**

#### **1. Herschrijf opdrachtregel met alleen `awk`**
```bash
awk -F: '/bash/ {print $1}' /etc/passwd
```

#### **2. Data uit CSV downloaden en eerste regel weglaten**
```bash
curl -o rlanders.csv https://raw.githubusercontent.com/HoGentTIN/dsai-en-labs/main/data/rlanders.csv
awk 'NR > 1' rlanders.csv
```

#### **3. Minimum en maximum van `Months`**
```bash
awk -F, 'NR > 1 {if ($5 < min || NR == 2) min = $5; if ($5 > max) max = $5} END {print "Min:", min, "Max:", max}' rlanders.csv
```

#### **4. Som van kolom `Count`**
```bash
awk -F, 'NR > 1 {sum += $6} END {print sum}' rlanders.csv
```
Enkel voor "Female":
```bash
awk -F, 'NR > 1 && $2 == "Female" {sum += $6} END {print sum}' rlanders.csv
```

#### **5. Frequenties van `Survey`**
```bash
awk -F, 'NR > 1 {freq[$7]++} END {for (val in freq) print val, freq[val]}' rlanders.csv
```

#### **6. Gemiddelde van `Money`**
```bash
awk -F, 'NR > 1 {sum += $3; count++} END {print sum / count}' rlanders.csv
```

#### **7. Gemiddelde van `Money` per `Gender`**
```bash
awk -F, 'NR > 1 {sum[$2] += $3; count[$2]++} END {for (gender in sum) print gender ":", sum[gender] / count[gender]}' rlanders.csv
```

#### **8. Gemiddelden van kolommen 3 t/m 7**
```bash
awk -F, '
NR > 1 {
  for (i = 3; i <= 7; i++) {
    sum[i] += $i;
    count[i]++;
  }
}
END {
  for (i = 3; i <= 7; i++) {
    print "Column", i, "Average:", sum[i] / count[i];
  }
}' rlanders.csv
```

---

### **5.4.3 JQ**

#### **1. Download JSON-data en pretty print**
```bash
curl -o parkings.json "https://data.stad.gent/parking.json"
jq '.' parkings.json
```

#### **2. Namen van parkeergarages ophalen**
```bash
jq -r '.parkings[].name' parkings.json
```

#### **3. Resultaat als geldige JSON-array**
```bash
jq '[.parkings[].name]' parkings.json
```

#### **4. Gegevens als JSON-array van dictionaries**
```bash
jq '[.parkings[] | {name: .name, lastUpdate: .lastModifiedDate, available: .availableCapacity, total: .totalCapacity}]' parkings.json
```

#### **5. Gegevens als CSV**
```bash
jq -r '[["name","lastUpdate","available","total"], (.parkings[] | [.name, .lastModifiedDate, .availableCapacity, .totalCapacity])] | @csv' parkings.json
```

---

Deze oplossingen zijn volledig functioneel en toepasbaar. Als er vragen of aanpassingen nodig zijn, laat het me weten!