nextflow.enable.dsl=2

params.input = ''
params.output_dir = ''

process analyzeFastq {   
    publishDir path: "${params.output_dir}", mode: 'copy'

    input:
    path merged_file

    output:
    path "fastqc_output"

    script:
    """
    fastqc ${merged_file} -o fastqc_output
    """
}

workflow {
    analyzeFastq(Channel.fromPath(params.input))
}
