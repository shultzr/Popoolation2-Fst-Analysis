# Popoolation2 Fst Analysis Pipeline

This repository contains a wrapper script to automate the `popoolation2` pipeline for calculating sliding-window $F_{ST}$ values between two populations.

## Dependencies

To run this script, you must have the following installed and available in your environment:
* [Popoolation2](https://github.com/p-filippo/popoolation2)
* [Samtools](https://http://www.htslib.org/)
* Java (for `mpileup2sync.jar`)

## Usage

The script requires four positional arguments:
1. `ref_genome`: Path to the reference genome FASTA file.
2. `bam1`: Path to the first BAM file (Population 1).
3. `bam2`: Path to the second BAM file (Population 2).
4. `output_prefix`: A prefix for all output files.

### Example Command

```bash
chmod +x run_popool2_fst.sh
./run_popool2_fst.sh ./ref/genome.fa ./data/pop1.bam ./data/pop2.bam my_analysis

