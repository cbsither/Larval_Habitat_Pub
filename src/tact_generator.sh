#!/bin/bash

### To run: ./script_name.sh Carangaria.csv Carangaria.taxonomy.tre 1000
# tree path: data/cleaned_data/culicidae_tree_soghigian_2023.treefile
# tax path: data/cleaned_data/culicidae.taxonomy.csv
# outgroup path: data/cleaned_data/outgroups.taxonomy.csv
# Take inputs from command line arguments


#### THIS NEEDS EDITING TO WORK FOR YOUR PURPOSES #####

tax_csv=$1
tax_tre=$2
outgroups=$3
loops=$4

mkdir -p runs
mkdir -p trees

for ((i=1; i<=loops; i++))
do
  mkdir -p runs/run_$i
  cd runs/run_$i

  tact_build_taxonomic_tree $tax_csv --output taxonomic_tree.taxonomy.tre
  tact_add_taxa --backbone $tax_tre --taxonomy taxonomic_tree.taxonomy.tre --outgroups $outgroups --output taxa.tacted --verbose --verbose
  tact_check_results taxa.tacted.newick.tre --backbone $tax_tre --taxonomy taxonomic_tree.taxonomy.tre > checkresults.csv

  cp taxa.tacted.newick.tre ../../trees/taxa_$i.tacted.newick.tre
  cd ../..
done
