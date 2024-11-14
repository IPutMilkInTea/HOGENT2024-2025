def verdeel_appels(aantal_appels):
    appels_per_kist = 20
    kisten_per_pallet = 35
    appels_per_pallet = appels_per_kist * kisten_per_pallet
    
    palletten = aantal_appels // appels_per_pallet
    overgebleven_appels_na_palletten = aantal_appels % appels_per_pallet
    
    kisten = overgebleven_appels_na_palletten // appels_per_kist
    overgebleven_appels = overgebleven_appels_na_palletten % appels_per_kist
    
    print(palletten)
    print(kisten)
    print(overgebleven_appels)
