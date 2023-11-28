#!/bin/bash
#$ -l h_rt=24:00:00
#$ -l h_vmem=30G
#$ -o /home/hn2435/RNA_Circtools/Step_1/Step_1b_BGI_CD_RNA_CD_BATCH1_RNA_ZFR_CGTRLL230605_$JOB_ID.out
#$ -e /home/hn2435/RNA_Circtools/Step_1/Step_1b_BGI_CD_RNA_CD_BATCH1_RNA_ZFR_CGTRLL230605_$JOB_ID.err
#$ -N Step_1b_Bowtie_rRNA_Filtering
#$ -j y
#$ -q csg.q
#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#export your Miniconda path 
export PATH=$HOME/miniconda3/bin:$PATH

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#Module load or path to BOWTIE2 executable
module load BOWTIE2/2.5.1

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
#Path to Trimmed FASTQ file to be used as raw data
raw_data_trimmed="/mnt/vast/hpc/csg/hn2435/RNA_Circ/raw_data/reads"

#Path to reference genome FASTA file
Genome_FASTA="/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa"

#Path to output directory in cluster
cluster_dir="/mnt/vast/hpc/csg/hn2435/RNA_Circ"

#Path to rRNA index 
rRNA_index="/mnt/vast/hpc/csg/hn2435/RNA_Circ/index/danio_rerio_index"

#rrna output directory 
output_dir="/mnt/vast/hpc/csg/hn2435/RNA_Circ/rrna"


#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#Align reads to the indexed genome reference using bowtie2

 # Construct paths for input files
    Read1_file="${raw_data_trimmed}"/*_R1.fq.gz
    Read2_file="${raw_data_trimmed}"/*_R2.fq.gz

        # Construct path for output file
        Unaligned_file="${output_dir}/_unaligned.fq.gz"

        # Run Bowtie2 for the current sample
        bowtie2 -x "${rRNA_index}" -1 $Read1_file -2 $Read2_file -S "${Unaligned_file}.sam"

echo "Output Directory output directory: ${output_dir}"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

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



