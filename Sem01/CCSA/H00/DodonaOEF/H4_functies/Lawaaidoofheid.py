def maximale_blootstelling(decibel):
    if decibel < 80:
        return -1.0

    blootstelling = 28800.0

    stappen = (decibel - 80) // 3
    blootstelling /= 2 ** stappen
    
    return blootstelling
