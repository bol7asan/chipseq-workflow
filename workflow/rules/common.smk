def macs_output(Sample):
    modes = []
    for index,i in enumerate(Sample):
        if i == "igG":
            pass
        else:
            for mark in config["macs"]["broad"]:
                
                if mark in i.upper():
                    output = multiext(f"{i}/macs/NA_","peaks.broadPeak","peaks.gappedPeak","peaks.xls")
                    
                    break
                else:
                    output =  multiext(f"{i}/macs/NA_","peaks.narrowPeak","summits.bed","peaks.xls")
            modes.append(output)

    return(modes)