nextflow.enable.dsl=2

params.input_dir = ''
params.output_file = ''

process mergeFastq {
    publishDir "${params.input_dir}", mode: 'copy'

    input:
    path fastq_files

    output:
    path merged_fastq

    script:
    """
    cat ${fastq_files} > merged.fastq.gz
    """
}

workflow {
    fastq_files = Channel.fromPath("${params.input_dir}/*.fastq.gz")
    merged_fastq = file("${params.output_file}")
    mergeFastq(fastq_files)
}
