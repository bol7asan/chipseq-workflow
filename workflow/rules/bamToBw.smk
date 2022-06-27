rule bamToBw:
    input:
        "{sample}/bowtie2/aligned.primary.rmdup.bam"      
    output:
        "{sample}/bigWig/{sample}.bw"
    params:
        main="--binSize 1 --normalizeUsing CPM --centerReads",
        blacklist= config["ref"]["blacklist"]
    threads: 4

    log:
        "{sample}/logs/BigWig.log"

    conda:
        "ngsmo"

    shell:
        "bamCoverage {params.main} -bl {params.blacklist} -b {input} -o {output}  -p {threads} 2> {log} "
