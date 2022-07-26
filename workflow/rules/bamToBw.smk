# rule bamToBw:
#     input:
#         "{sample}/bowtie2/aligned.primary.rmdup.bam"      
#     output:
#         "{sample}/bigWig/{sample}.bw"
#     params:
#         main="--binSize 1 --normalizeUsing CPM --centerReads ",
#         blacklist= config["ref"]["blacklist"]
#     threads: 4

#     log:
#         "{sample}/logs/BigWig.log"

#     conda:
#         "ngsmo"

    # shell:
    #     "bamCoverage {params.main} -bl {params.blacklist} -b {input} -o {output}  -p {threads} 2> {log} "

rule bamToBw_forward:
    input:
        "{sample}/bowtie2/aligned.primary.rmdup.bam"      
    output:
        "{sample}/bigWig/{sample}_forward.bw"
    params:
        main="--binSize 1 --normalizeUsing CPM --centerReads --filterRNAstrand forward ",
        blacklist= config["ref"]["blacklist"]
    threads: 4

    log:
        "{sample}/logs/BigWig.log"

    conda:
        "ngsmo"

    shell:
        "bamCoverage {params.main} -bl {params.blacklist} -b {input} -o {output}  -p {threads} 2> {log} "

rule bamToBw_reverse:
    input:
        "{sample}/bowtie2/aligned.primary.rmdup.bam"      
    output:
        "{sample}/bigWig/{sample}_reverse.bw"
    params:
        main="--binSize 1 --normalizeUsing CPM --centerReads --filterRNAstrand reverse ",
        blacklist= config["ref"]["blacklist"]
    threads: 4

    log:
        "{sample}/logs/BigWig.log"

    conda:
        "ngsmo"

    shell:
        "bamCoverage {params.main} -bl {params.blacklist} -b {input} -o {output}  -p {threads} 2> {log} "

rule bamToBw:
    input:
        "pre-analysis/{sample}/bowtie2/aligned.primary.rmdup.bam"      
    output:
        "pre-analysis/ucsc/" + config["ref"]["build"] + "/" + "{sample}.bw"
    params:
        main="--binSize 1 --normalizeUsing CPM --centerReads",
        blacklist= config["ref"]["blacklist"]
    threads: 4

    log:
        "pre-analysis/{sample}/logs/BigWig.log"

    conda:
        "ngsmo"

    shell:
        "bamCoverage {params.main} -bl {params.blacklist} -b {input} -o {output}  -p {threads}  > {log} "

rule make_hub:   
    output:
        trackDb = "pre-analysis/ucsc/" + config["ref"]["build"] + "/" + "trackDb.txt",
        hub = "pre-analysis/ucsc/hub.txt",
        genomes = "pre-analysis/ucsc/genomes.txt"
    params:
        bwDir= "pre-analysis/ucsc/" + config["ref"]["build"],
        build = config["ref"]["build"]

    script:
        "../scripts/make_trackDB.py"