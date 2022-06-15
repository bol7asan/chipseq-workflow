rule filterBam:
    input:
        "{sample}/bowtie2/aligned_rmdup.bam"        
    output:
        filteredBam="{sample}/bowtie2/aligned_rmdupPrimary.bam",
        index="{sample}/bowtie2/aligned_rmdupPrimary.bam.bai"
    params:
        filter="view -h -f bam -F '[XS] == null and not unmapped and not duplicate' ",
        index="index --show-progress "
    threads: 8

    conda:
        "sambamba"

    shell:
        """
        sambamba {params.filter} -t {threads} {input} > {output.filteredBam}
        sambamba {params.index} -t {threads} {output.filteredBam} {output.index}
        
        """
