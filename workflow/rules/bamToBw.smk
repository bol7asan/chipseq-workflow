rule bamToBw:
    input:
        "{sample}/bowtie2/aligned_rmdupPrimary.bam"      
    output:
        "{sample}/bw/{sample}.bw"
    params:
        main="--binSize 20 --normalizeUsing BPM --smoothLength 60 --extendReads 150 --centerReads",
        blacklist= config["ref"]["blacklist"]
    threads: 8

    log:
        "{sample}/logs/BigWig.log"

    conda:
        "ngsmo"

    shell:
        "bamCoverage {params.main} -bl {params.blacklist} -b {input} -o {output}  -p {threads} 2> {log} "
