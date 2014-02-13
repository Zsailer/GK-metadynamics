# If something breaks, clean the output directory

find . -mindepth 1 -maxdepth 1 ! -name '*.sh' -delete

cd ../output

rm -rf *
