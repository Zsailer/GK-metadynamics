set -e
# Equilibrate the system
INPUT="../input/"
OUTPUT="../output/"

# Once again, reprocess the topology file
# -f indicates the MD parameters input file for the processing
# -c indicates the input structure file to process
# -o output file thats used for an MD run command (mdrun)
# -p input file that describes the topology

grompp_mpi_d -v -f ${INPUT}eq.mdp -c ${OUTPUT}afterem.gro -o ${OUTPUT}eq.tpr -p ${OUTPUT}${PROTEIN}.top

# We are going to do a 50ps run to equilibrate the system. This is a position restraint MD simulation, which constrains all bonds.

### This is going to require a .pbs input file for aciss to get off the main node

qsub ${INPUT}equilibration.pbs

cat <<EOF >> ../${PROTEIN}_log.pbs
-----------------------------------------------------------------
Ran MD4.sh

md_run was used to equilibrate the system.

This is the first iteration of equilibration for the system

EOF