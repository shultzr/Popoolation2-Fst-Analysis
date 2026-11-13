#!/bin/bash

# ==============================================================================
# Script Name: run_popool2_fst.sh
# Description: A wrapper script for Popoolation2 to perform sliding-window Fst 
#              analysis between two populations.
# Usage:       ./run_popool2_fst.sh <ref_genome> <bam1> <bam2> <output_prefix>
# ==============================================================================

# --- 1. Check for required arguments ---
if [ "$#" -ne 4 ]; then
    echo "Error: Missing arguments."
    echo "Usage: $0 <ref_genome> <bam1> <bam2> <output_prefix>"
    exit 1
fi

# --- 2. Assign Arguments to Variables ---
REF_GENOME=$1
BAM1=$2
BAM2=$3
OUT_PREFIX=$4

# --- 3. Environment Setup ---
# Note: Users should have popoolation2 and samtools in their PATH
# or load them via their local module system.
# Example: module load popoolation2 samtools

# --- 4. Execution ---

echo "Starting Step 1: Samtools mpileup..."
# We use a temporary file for the mpileup output
TEMP_MPILE="${OUT_PREFIX}_temp.mpile"

samtools mpileup --max-depth 500 -f "$REF_GENOME" "$BAM1" "$BAM2" > "$TEMP_MPILE"

echo "Starting Step 2: mpileup2sync..."
# Using the variables for the output prefix
java -ea -Xmx7g -jar "$POPOOLATION2_DIR/mpileup2sync.jar" \
    --input "$TEMP_MPILE" \
    --output "${OUT_PREFIX}_all.sync" \
    --fastq-type sanger \
    --min-qual 25 \
    --threads 12

echo "Starting Step 3: Fst-sliding window calculation..."
perl "$POPOOLATION2_DIR/fst-sliding.pl" \
    --input "${OUT_PREFIX}_all.sync" \