rule markDup:
    input:
        bamFile= "{sample}/bowtie2/UnfilAlignedSortByCoord.bam"     
    output:
        bamMarked= "{sample}/bowtie2/aligned_rmdup.bam",
        dupStats="{sample}/bowtie2/marked_dup_metrics.txt" 
    params:
        samtools="--REMOVE_DUPLICATES true --REMOVE_SEQUENCING_DUPLICATES true --ASSUME_SORT_ORDER=coordinate"
    threads: 4

    conda:
        "ngsmo"

    shell:
        "gatk MarkDuplicates -I {input.bamFile} -O  {output.bamMarked} -M {output.dupStats}"