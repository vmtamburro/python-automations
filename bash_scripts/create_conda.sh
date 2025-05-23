source ~/.bash_profile
conda init

mamba create -n $1 python=3.8

conda activate $1

# https://github.com/scikit-learn/sklearn-pypi-package
conda env config vars set SKLEARN_ALLOW_DEPRECATED_SKLEARN_PACKAGE_INSTALL=True

pip install -r requirements/dev.txt

pip install pyfarmhash==0.3.2;

# https://stackoverflow.com/questions/54499749/how-to-fix-the-tensorflow-library-was-compiled-to-use-avx512f-instructions-but
pip uninstall -y numpy tensorflow tensorflow-macos tensorflow-decision-forests && pip install tensorflow-macos 

