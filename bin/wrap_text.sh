#!/bin/bash
# wrap_text : 
text="A2WDB-male-PCA-eigenvectors.csv.bin
A2WDB-male-PCA-hand-FIX.pcf
A2WDB-male-pose-normalized.xyz.pca-eigenvalues.csv
features_May2017.txt
final_male_2.ply
Joint_Segments_Properties.txt
male_database_10_PCA_Features.bin
male_database_10_PCA_Values.bin
male_database_1000_PCA_Features.bin
male_database_1000_PCA_Values.bin
MaleLandmarks_full_Sept2016.txt
MaleLandmarks_full_Sept2016_new.txt
new_lands.txt
PCA_Features.txt
PCA_Features_PID.bin
PCA_Values_PID.bin
pcf.diff
Voxel_Based_Mass_Inertia_Properties.txt"

for line in $text; do
    echo "<file alias=\"$line\">../data/MaleFemale_burn/poses/MaleNormal/$line</file>"
    done
