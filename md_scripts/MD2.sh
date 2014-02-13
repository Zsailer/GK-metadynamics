set -e
# Define variables
INPUT="../input/"
OUTPUT="../output/"
CONCENTRATION=".150"

# Gromacs pre-processor to generate an atomic-level input .tpr.
# This requires .mdp (molecular dynamics parameter file)
# This file is em.mdp (energy minimizaton)

# This pre-processor is found in the command grompp_d
# flag -v for verbose comments
# flag -f for input mdp parameter file
# flag -c for output gro file
# flag -o output .tpr file for generating ions
# flad -p for output topology file

grompp_mpi_d -v -f ${INPUT}em.mdp -c ${OUTPUT}b4em.gro -o ${OUTPUT}ions.tpr -p ${OUTPUT}${PROTEIN}.top

# Neutralize the charge type
# -s if the input structure/state file
# -o generated output .gro file 
# -p process the topology file to reflect removal of water molecules and add ions
# -conc specifies the concentration
# -neutral also changes concentration

genion_mpi_d -s ${OUTPUT}ions.tpr -o ${OUTPUT}afterions.gro -g ${OUTPUT}genion.log -conc ${CONCENTRATION} -neutral -p ${OUTPUT}${PROTEIN}.top


cat <<EOF >> ../${PROTEIN}_log.pbs
-----------------------------------------------------------------
Ran MD2.sh

Neutralized the charge of the box

EOF


# After this runs, you need to count how many ions were generate and add them to the end of your topology file

echo "####################  NOTICE!!! #####################"

echo "Don't forget to edit the ${PROTEIN}.top topology file located in the output folder. Reduce the number of
SOL molecules and add NA and CL molecules to fill in those numbers."

