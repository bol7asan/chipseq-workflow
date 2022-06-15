rule bowtie2:
    input:
        r1 = "data/{sample}_R1.fastq.gz",
        r2 = "data/{sample}_R2.fastq.gz",
        
        
    output:
        aligned_sam="{sample}/bowtie2/unfiltered_aligned.sam"
    log:
        "{sample}/bowtie2/unfiltered_aligned.txt"
    threads: 8
    params:
        bowtie2 = "bowtie2 --local --no-mixed --no-discordant -p",
        index = config["ref"]["index"]
    conda:
        "ngsmo"

    shell:
        """
        {params.bowtie2} {threads} -x {params.index} -1 {input.r1} -2 {input.r2} -S {output.aligned_sam}  &> {log}
        
        """
