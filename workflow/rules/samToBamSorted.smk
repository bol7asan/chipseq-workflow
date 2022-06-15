rule samToBamSorted:
    input:
        samFile="{sample}/bowtie2/unfiltered_aligned.sam"         
    output:
        bamFile= "{sample}/bowtie2/UnfilAlignedSortByCoord.bam"
    params:
        samtools="sort --write-index -O BAM"
    threads: 8

    conda:
        "ngsmo"

    shell:
        "samtools {params.samtools} -@ {threads}  -o {output.bamFile}  {input.samFile} "
