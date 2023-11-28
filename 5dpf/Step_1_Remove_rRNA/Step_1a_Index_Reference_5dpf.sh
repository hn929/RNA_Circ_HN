#Step 1a: Build Bowtie2 index for reference genome 
#This step may be skipped if already built for 2dpf (Step 1a) as it is the same index

#!/bin/bash
#$ -l h_rt=12:00:00
#$ -l h_vmem=5G
#$ -o /home/hn2435/external/github/RNA_Circ_HN/5dpf/output_logs/Step_1_Remove_rRNA/Step_1a_BGI_CD_RNA_CD_BATCH1_RNA_ZFR_CGTRLL230605_$JOB_ID.out
#$ -e /home/hn2435/external/github/RNA_Circ_HN/5dpf/output_logs/Step_1_Remove_rRNA/Step_1a_BGI_CD_RNA_CD_BATCH1_RNA_ZFR_CGTRLL230605_$JOB_ID.err
#$ -N Step_1a_Build_Reference_Index
#$ -j y
#$ -q csg.q
#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#export your Miniconda path 
export PATH=$HOME/miniconda3/bin:$PATH

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#Module load or path to BOWTIE2 executable
module load BOWTIE2/2.5.1

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#Path to reference genome FASTA file
Genome_FASTA="/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa"

#Path to output directory in cluster for index
cluster_dir="/mnt/vast/hpc/csg/hn2435/RNA_Circ/index"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo "                                "
echo "                                "
echo "Job started at: $start_timestamp"
echo "                                "


#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#Step 1_a: Build Reference Index with BOWTIE2

#Index the reference genome to index danio rerio
echo "Indexing a reference genome using bowtie2"

bowtie2-build "${Genome_FASTA}" "${cluster_dir}"/danio_rerio_index

echo "Index output directory: ${cluster_dir}/danio_rerio_index"

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



