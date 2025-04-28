source ~/.bash_profile
conda init

mamba create -n $1 python=3.8

conda activate $1
conda env config vars set SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True
pip install -r requirements/dev.txt