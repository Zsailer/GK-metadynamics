set -e
echo "Enter the name of your protein and hit [ENTER]: "

read PROTEIN
export PROTEIN=$PROTEIN

# Define Variables
INPUT="../input/"
OUTPUT="../output/"

# Generate a topology file necessary to run a simulation
# _d means double precision
# flag -f for input .pdb file
# flag -p for the topology file
# flag -o for the output gro file
module load gromacs/4.6.1p

pdb2gmx_mpi_d -f ${INPUT}${PROTEIN}.pdb -p ${OUTPUT}${PROTEIN}.top -o ${OUTPUT}${PROTEIN}.gro

# Define the Dimensions of the box around the protein
# flag -f for input file
# flag -o for output file
# flag -c centers molecule
# flag -d with number is for empty space around protein (in nm)
# flag -bt signals box-type 

editconf_mpi_d -f ${OUTPUT}${PROTEIN}.gro -o ${OUTPUT}${PROTEIN}_newbox.gro -c -d 0.9 -bt cubic

# Fill the box with solvent molecules
# flag -cp configuration of protein for input (from last command)
# flag -cs configuration of solvent from standand Gromacs install
# flag -p for output topology file to be modified
# flag -o output file

genbox_mpi_d -cp ${OUTPUT}${PROTEIN}_newbox.gro -cs -p ${OUTPUT}${PROTEIN}.top -o ${OUTPUT}b4em.gro

cat <<EOF >> ../${PROTEIN}_log.pbs
-----------------------------------------------------------------
Ran MD1.sh

Box created and solvent added.

EOF