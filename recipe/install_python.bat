:: %PYTHON% setup.py install --build-type Release %CMAKE_ARGS%
:: with scikit-build incompatible arguments stripped from it

git clone https://github.com/scikit-build/scikit-build.git
cd scikit-build
git checkout henryiii-patch-1
$PYTHON -m pip install .
cd ..

echo import os > my_cmake_args.py
echo args = [] >> my_cmake_args.py
echo if 'CMAKE_ARGS' in os.environ: >> my_cmake_args.py
echo     args = list(filter(None, os.environ['CMAKE_ARGS'].split(' '))) >> my_cmake_args.py
echo args = [arg for arg in args if len(arg.split('DCMAKE_INSTALL_PREFIX')) == 1] >> my_cmake_args.py
echo print(' '.join(args)) >> my_cmake_args.py


python my_cmake_args.py > mytemp.txt
%PYTHON% setup.py install --build-type Release < mytemp.txt
