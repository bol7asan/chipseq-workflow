rule fastqc:
    input:
        rawread="data/{sample}_{read}.fastq.gz"
    output:
        zip ="{sample}/fastqc/{sample}_{read}_fastqc.zip",
        html="{sample}/fastqc/{sample}_{read}_fastqc.html"
    threads: 1
    
    conda:
        "ngsmo"

    params:
        path="{sample}/fastqc/"
    shell:
        "fastqc {input.rawread} --threads {threads} -o {params.path}"
    