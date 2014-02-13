set -e
# This is the Energy Minimization step
INPUT="../input/"
OUTPUT="../output/"

# Reprocess for energy minimization
# -f indicates the MD parameters input file for the processing
# -c indicates the input structure file to process
# -o output file thats used for an MD run file
# -p input file that describes the topology

grompp_mpi_d -v -f ${INPUT}em.mdp -c ${OUTPUT}afterions.gro -o ${OUTPUT}em.tpr -p ${OUTPUT}${PROTEIN}.top

## Now run the actual energy minimization

### This is going to require a .pbs input file for aciss to get off the main node

qsub ${INPUT}minimization.pbs

cat <<EOF >> ../${PROTEIN}_log.pbs
-----------------------------------------------------------------
Ran MD3.sh

md_run was used for 1000 steps to minimize the energy of the system.

EOF