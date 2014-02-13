set -e
#!/bin/sh
echo "Enter the name of your protein and hit [ENTER]: "

read PROTEIN
VARIABLE="PROTEIN=$PROTEIN"
SCRIPTS_LOCATION="md_scripts/"
INPUT_LOCATION="md_input/"

mkdir ${PROTEIN}

cd ${PROTEIN}

mkdir output
mkdir input
mkdir scripts

cp ~/${INPUT_LOCATION}em.mdp input
cp ~/${INPUT_LOCATION}eq.mdp input
cp ~/${INPUT_LOCATION}eq2.mdp input
cp ~/${INPUT_LOCATION}md.mdp input
cp ~/${INPUT_LOCATION}minimization.pbs input
cp ~/${INPUT_LOCATION}equilibration.pbs input
cp ~/${INPUT_LOCATION}equilibration2.pbs input
cp ~/${INPUT_LOCATION}metadynamics.pbs input
cp ~/${INPUT_LOCATION}restart.pbs input
cp ~/${INPUT_LOCATION}meta.dat input
cp ~/${INPUT_LOCATION}restart.dat input

mv ~/${PROTEIN}.pdb input

cp ~/${SCRIPTS_LOCATION}MD1.sh scripts
cp ~/${SCRIPTS_LOCATION}MD2.sh scripts
cp ~/${SCRIPTS_LOCATION}MD3.sh scripts
cp ~/${SCRIPTS_LOCATION}MD4.sh scripts
cp ~/${SCRIPTS_LOCATION}MD5.sh scripts
cp ~/${SCRIPTS_LOCATION}clean.sh scripts
cp ~/${SCRIPTS_LOCATION}Metadynamics.sh scripts
cp ~/${SCRIPTS_LOCATION}restart.sh scripts

cd scripts
echo ${VARIABLE} | cat - MD1.sh > temp && mv temp MD1.sh
echo ${VARIABLE} | cat - MD2.sh > temp && mv temp MD2.sh
echo ${VARIABLE} | cat - MD3.sh > temp && mv temp MD3.sh
echo ${VARIABLE} | cat - MD4.sh > temp && mv temp MD4.sh
echo ${VARIABLE} | cat - MD5.sh > temp && mv temp MD5.sh
echo ${VARIABLE} | cat - Metadynamics.sh > temp && mv temp Metadynamics.sh
echo ${VARIABLE} | cat - restart.sh > temp && mv temp restart.sh

chmod u+x MD1.sh
chmod u+x MD2.sh
chmod u+x MD3.sh
chmod u+x MD4.sh
chmod u+x MD5.sh
chmod u+x Metadynamics.sh
chmod u+x restart.sh

cd ../input

for f in *.pbs
do
cat <<EOF >> test.pbs
#!/bin/bash -l
#PBS -N ${PROTEIN}_min
#PBS -q generic
#PBS -l nodes=1:ppn=12
#PBS -d /home6/zsailer/${PROTEIN}/input
#PBS -o /home6/zsailer/${PROTEIN}/output/MESSAGE.log
#PBS -e /home6/zsailer/${PROTEIN}/output/MESSAGE.log
#PBS -j oe

### this will submit to the "long-generic" queue on ACISS
### requesting 1 node and 12 processor per node
### change ppn to 1 if you want to run 12 processes with this script

# Load any modules needed to run your software
module load gromacs/4.6.1p
# the examples below load modules for running OpenMPI jobs

PROTEIN="${PROTEIN}"

cd ${PROTEIN}/input
EOF

cat $f >> test.pbs
mv test.pbs $f
done

cat > ${PROTEIN}_log.txt

echo "###############  NOTICE  ##################"
echo "Make sure you edit all .pbs files to include the path of the created input directory!!"
