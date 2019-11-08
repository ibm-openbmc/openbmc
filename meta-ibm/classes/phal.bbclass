def getlibekb_depend(d) :
    target_chip = d.getVar('TARGET_PROC')
    if target_chip == "p9" :
        target = "libekb"
    elif target_chip == "p10" :
        target = "libekb-p10"
    else:
        target = ""
        bb.error("Unsupported target =%s to get libekb dependency" % taregt_chip)
    return target
