set -e
# This runs the actual simulation
INPUT="../input/"
OUTPUT="../output/"

# Run the simulation
# NOTICE: The names of the files are changing over interations
# -f indicates the MD parameters input file for the processing
# -c indicates the input structure file to process
# -o output file thats used for an MD run command (mdrun)
# -p input file that describes the topology

grompp_mpi_d -v -f ${INPUT}md.mdp -c ${OUTPUT}${PROTEIN}_eq2.gro -o ${OUTPUT}${PROTEIN}_1.tpr -p ${OUTPUT}${PROTEIN}.top

### This is going to require a .pbs input file for aciss to get off the main node

qsub ${INPUT}metadynamics.pbs 

cat <<EOF >> ../${PROTEIN}_log.pbs
-----------------------------------------------------------------
Ran Metadynamics.sh

First iteration of a metadynamics trajectory.

EOF