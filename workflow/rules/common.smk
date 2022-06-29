def macs_output(Sample):
    modes = []
    for index,i in enumerate(set(Sample)):
        if i == "igG":
            pass
        else:
            for mark in config["macs"]["broad"]:
                
                if mark in i.upper():
                    output = multiext(f"{i}/macs/broad/NA_","peaks.broadPeak","peaks.gappedPeak","peaks.xls")
                    mode = "broad"
                    
                    break
                else:
                    output =  multiext(f"{i}/macs/narrow/NA_","peaks.narrowPeak","summits.bed","peaks.xls")
                    mode = "narrow"
            modes.append(output)
            print(f"{i} is {mode}")
    print(modes)
    return(modes)