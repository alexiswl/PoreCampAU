#!/bin/bash

PROGRAMS_DIR=$HOME/programs
mdkir -p ${PROGRAMS_DIR};

SOURCE_DIR=$HOME/src
mkdir -p ${SOURCE_DIR};

# Downloading Anaconda
cd ${SOURCE_DIR}
wget https://repo.continuum.io/archive/Anaconda2-4.2.0-Linux-x86_64.sh

# Install Anaconda
ANACONDA_DIR=${PROGRAMS_DIR}/anaconda2
bash Anaconda2* -b -p ${ANACONDA_DIR}

# Add Anaconda to path
export PATH=${ANACONDA_DIR}/bin:$PATH

# Update pip
pip install --upgrade pip

# Install a gcc compiler
conda install libgcc --yes
export LD_LIBRARY_PATH=${ANACONDA_DIR}/lib:$LD_LIBRARY_PATH

# Install R in Anaconda
conda install -c r r-essentials --yes
export R_HOME=${ANACONDA_DIR}/lib/R/

# Install another python kernel
python -m ipykernel install --user

# Install biopython
conda install -c anaconda biopython=1.68 --yes

# Install Onecodex command line
pip install onecodex all

# Install ete3 for NCBI Taxonomy database
conda install -c etetoolkit ete3=3.0.0b36 --yes

# Install further R dependencies
conda install -c r rpy2=2.8.5 --yes
conda install -c jdreaver libxdmcp=1.0.2 --yes

# For FastQC install java through anaconda
conda install -c cyclus java-jdk=8.45.14 --yes
conda install -c anaconda javabridge=1.0.14 --yes

# Update LD_LIBRARY_PATH for Java
LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/researcher/anaconda2/jre/lib/amd64

# Install FastQC
wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.6.devel.zip
unzip fastqc*
mv FastQC ${PROGRAMS_DIR}

# Add FastQC to PATH
PATH=$PATH:${PROGRAMS_DIR}/FastQC/

# Install Samtools
conda install -c bioconda samtools=1.3.1 --yes

# Install IGV for viewing through Jupyter notebooks
pip install igv

# Install Jupyter IGV Extension 
jupyter nbextension install --py igv --user

# Enable Jupyter IGV Extension
jupyter nbextension enable igv --py --user

# Install poretools
git clone https://github.com/arq5x/poretools
cd poretools
python setup.py install

# Install bwa mem
conda install -c bioconda bwa=0.7.15 --yes

# Install Bedtools
conda install -c bioconda bedtools=2.26.0 --yes

# Install bamtools
conda install -c bioconda bamtools=2.4.0 --yes

### Do not install any programs past this line. ####

# Write accumulated PATH and LD_LIBRARY_PATH to the bash profile
echo "#!/bin/bash" > ~/.bash_profile
echo "export PATH=$PATH" >> ~/.bash_profile
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH" >> ~/.bash_profile
echo "export R_HOME=$R_HOME" >> ~/.bash_profile
