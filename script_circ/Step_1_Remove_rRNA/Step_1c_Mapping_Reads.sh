#!/bin/bash
#$ -l h_rt=24:00:00
#$ -l h_vmem=50G
#$ -o /home/hn2435/RNA_Circtools/Step_1/Step_1c_BGI_CD_RNA_CD_BATCH1_RNA_ZFR_CGTRLL230605_$JOB_ID.out
#$ -e /home/hn2435/RNA_Circtools/Step_1/Step_1c_BGI_CD_RNA_CD_BATCH1_RNA_ZFR_CGTRLL230605_$JOB_ID.err
#$ -N Step_1c_Mapping_Reads
#$ -j y
#$ -q csg.q
#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#export your Miniconda path 
export PATH=$HOME/miniconda3/bin:$PATH

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
# Path to the STAR executable or module load it
module load STAR/2.7.10b
module load SAMTOOLS/1.17

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
#Path to Trimmed FASTQ file to be used as raw data
Input_Directory="/mnt/vast/hpc/csg/hn2435/RNA_Circ/rrna"

#Path to reference genome FASTA file
Genome_FASTA="/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa"

#Path to output directory in cluster
cluster_dir="/mnt/vast/hpc/csg/hn2435/RNA_Circ"

#Path to rRNA index 
rRNA_index="/mnt/vast/hpc/csg/hn2435/RNA_Circ/index/danio_rerio_index"

#rrna output directory 
output_dir="/mnt/vast/hpc/csg/hn2435/RNA_Circ/mapped_reads"

#Path to annotation GTF File
Annotation_GTF="/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/Danio_rerio.GRCz11.110.chr.gtf"
#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

for forward_file in "${Input_Directory}"/*_R1.fq; do
    # Extract the file name without extension
    file_name=$(basename "${forward_file}" _R1.fq)

    # Path to the corresponding reverse FASTQ file
    reverse_file="${forward_file/_R1/_R2}"

    echo "Forward File: ${forward_file}"
    echo "Reverse File: ${reverse_file}"
    echo "Output Directory: ${output_dir}"

    # Create a unique temporary directory for this sample
    TMPDIR="${output_dir}/${file_name}___STARtmp"

    echo "The temporary directory is: ${TMPDIR}"

    # Change working directory to the output directory
    cd "${output_dir}"

    echo "Made temporary directory: ${TMPDIR}"

    echo "Output Directory + Prefix: ${output_dir}/${file_name}___"

    # Run STAR alignment
    STAR \
        --runThreadN 10 \
        --genomeDir "${Genome_FASTA}" \
        --genomeLoad NoSharedMemory \
        --readFilesIn "${forward_file}" "${reverse_file}" \
        --readFilesCommand zcat \
        --outFileNamePrefix "${output_dir}/${file_name}_Soft_Circtools_Mate_Pairs___" \
        --outReadsUnmapped Fastx \
        --outSAMattributes NH   HI   AS   nM   NM   MD   jM   jI   XS \
        --outSJfilterOverhangMin 15   15   15   15 \
        --outFilterMultimapNmax 20 \
        --outFilterScoreMin 1 \
        --outFilterMatchNminOverLread 0.7 \
        --outFilterMismatchNmax 999 \
        --outFilterMismatchNoverLmax 0.05 \
        --alignIntronMin 20 \
        --alignIntronMax 1000000 \
        --alignMatesGapMax 1000000 \
        --alignSJoverhangMin 15 \
        --alignSJDBoverhangMin 10 \
        --alignSoftClipAtReferenceEnds No \
        --chimSegmentMin 15 \
        --chimScoreMin 15 \
        --chimScoreSeparation 10 \
        --chimJunctionOverhangMin 15 \
        --sjdbGTFfile "${Annotation_GTF}" \
        --quantMode GeneCounts\
        --twopassMode Basic\
        --chimOutType Junctions SeparateSAMold


done

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Memory Used:
echo "                       "
echo "Let's look at the vmem:"
qstat -j $JOB_ID | grep vmem 
echo "                       "

# Get the timestamp when the command completes:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Print the end timestamp to stdout:
echo "                            "
echo "Job ended at: $end_timestamp"
echo "                            "

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________



