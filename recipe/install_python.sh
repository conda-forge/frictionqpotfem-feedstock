# ${PYTHON} setup.py install --build-type Release ${CMAKE_ARGS}
# with scikit-build incompatible arguments stripped from it


echo "import os
args = []
if 'CMAKE_ARGS' in os.environ:
    args = list(filter(None, os.environ['CMAKE_ARGS'].split(' ')))
args = [arg for arg in args if len(arg.split('DCMAKE_INSTALL_PREFIX')) == 1]
print(' '.join(args))
" > my_cmake_args.py


$PYTHON setup.py install --build-type Release `python my_cmake_args.py`
