# Metadynamics of the GK enzyme and domain proteins. 

This repository contains the bash scripts used to run a metadynamics simulation using Gromacs/Plumed on the University of Oregon's ACISS cluster. A simulation was run on three PDB files describing proteins who demonstrate different functionality in the Guanylate kinase family. 

The input files for both Gromacs and Plumed are included in the md_input folder. These define the conditions for the box generated in the simulation and the collective variables for the metadynamics.

The output files include the Gaussians added in the Plumed metadynamics simulation. The data is processed and analyzed using IPython notebooks. These notebooks require that Jake Vanderplas' JSAnimation package be installed in the machine to run any movies in the notebook.