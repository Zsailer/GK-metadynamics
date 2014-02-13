set -e
# This runs the actual simulation
IT=2
INPUT="../input/"
OUTPUT="../output/"
I=$(expr ${IT} - 1 )
VARIABLE="IT=${IT}"

# Run the simulation
# NOTICE: The names of the files are changing over interations
# -f indicates the MD parameters input file for the processing
# -c indicates the input structure file to process
# -o output file thats used for an MD run command (mdrun)
# -p input file that describes the topology

grompp_mpi_d -v -f ${INPUT}md.mdp -c ${OUTPUT}${PROTEIN}_${I}.gro -o ${OUTPUT}${PROTEIN}_${IT}.tpr -p ${OUTPUT}${PROTEIN}.top

### This is going to require a .pbs input file for aciss to get off the main node
echo ${VARIABLE} | cat - ${INPUT}restart.pbs > temp && mv temp ${INPUT}restart.pbs

qsub ${INPUT}restart.pbs 

cat <<EOF >> ../${PROTEIN}_log.pbs
-----------------------------------------------------------------
Ran restart.sh


EOF