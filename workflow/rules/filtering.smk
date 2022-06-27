rule markDup:
    input:
        bamFile= "{sample}/bowtie2/Aligned.sortedByCoord.out.bam"     
    output:
        bamMarked= "{sample}/bowtie2/aligned_markDup.bam",
        dupStats="{sample}/bowtie2/dupMetrics.tsv" 
    params:
        samtools="-ASO=coordinate --TAGGING_POLICY All"
    threads: 4

    conda:
        "ngsmo"
    log:
        "{sample}/logs/MarkDuplicates.log"

    shell:
        "gatk MarkDuplicates -I {input.bamFile} -O  {output.bamMarked} -M {output.dupStats} 2> {log}"

rule samtools:
    input:
        "{sample}/bowtie2/unfiltered_aligned.sam"
        
    output:
        "{sample}/bowtie2/unfiltered_aligned_stats.tsv"
    threads: 4
    params:
        bwa = "-M",
        index = lambda w: config["ref"]["{}".format(w.aligner)]
    conda:
        "ngsmo"

    shell:
        """
        samtools flagstat -O tsv -@ {threads} {input} > {output}
        
        """

rule samToBamSorted:
    input:
        samFile="{sample}/bowtie2/unfiltered_aligned.sam"         
    output:
        bamFile= "{sample}/bowtie2/Aligned.sortedByCoord.out.bam"
    params:
        samtools="sort --write-index -O BAM"
    threads: 4

    conda:
        "ngsmo"

    shell:
        "samtools {params.samtools} -@ {threads}  -o {output.bamFile}  {input.samFile} "

rule filterBam:
    input:
        "{sample}/bowtie2/aligned_markDup.bam"      
    output:
        filteredBam="{sample}/bowtie2/aligned.primary.rmdup.bam",
        index="{sample}/bowtie2/aligned.primary.rmdup.bam.bai"
    params:
        filter="view -h -f bam --num-filter /3340",
        index="index --show-progress "
    threads: 4

    conda:
        "sambamba"

    shell:
        """
        sambamba {params.filter} -t {threads} {input} > {output.filteredBam}
        sambamba {params.index} -t {threads} {output.filteredBam} {output.index}
        
        """
