ruleorder: macs_broad > macs_narrow
rule macs_narrow:
    input:
        "{sample}/bowtie2/aligned.primary.rmdup.bam"
    
    output:
        multiext("{sample}/macs/NA_","peaks.narrowPeak","summits.bed","peaks.xls")
    
    params:
        macs="callpeak -q 0.01 -f BAMPE -g hs -c igG/bowtie2/aligned.primary.rmdup.bam",
        outdir="{sample}/macs"        

    threads: 6

    log:
        "{sample}/logs/macs3.log"


    conda:
        "macs3"

    shell:
        "macs3 {params.macs}  -t {input} --outdir {params.outdir}  2> {log}"



rule macs_broad:
    input:
        "{sample}/bowtie2/aligned.primary.rmdup.bam"

    output:
        multiext("{sample}/macs/NA_","peaks.broadPeak","peaks.gappedPeak","peaks.xls")

    params:
        macs="callpeak --broad -g hs --broad-cutoff 0.1 -f BAMPE -c igG/bowtie2/aligned.primary.rmdup.bam",
        outdir="{sample}/macs",
        blacklist= config["ref"]["blacklist"]

    threads: 6

    log:
        "{sample}/logs/macs3.log"

    conda:
        "macs3"

    shell:
        """
        
        macs3 {params.macs}  -t {input} --outdir {params.outdir}  2> {log}
        sed -i -r '/(chrX|chrM|chrUn)/d' {params.outdir}/NA_peaks.broadPeak
        bedtools intersect -a {params.outdir}/NA_peaks.broadPeak -b {params.blacklist} -v > {params.outdir}/NA_peaks.broadPeakFiltered

        """




