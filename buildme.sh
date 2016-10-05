#!/bin/bash

echo "update submodules"
git submodule update --init --recursive

echo "Find python site config"
#python -m site --user-site
#python -m site --user-base
#python -m site --user-site --user-base
python -c "import site
print site.USER_SITE + '\n'
print site.USER_BASE + '\n'
"

echo "
Put this in ~/.pydistutils.cfg
[install]
install_lib = ~/Library/Python/$py_version_short/site-packages
install_scripts = ~/Library/Python/$py_version_short/bin

Also, make this change to the Makefile:
--- a/Makefile
+++ b/Makefile
@@ -162,7 +162,7 @@ python:
        \$(PYTHON) setup.py build

 install:
-       \$(PYTHON) setup.py install
+       \$(PYTHON) setup.py install --prefix ~/Library/Python/2.7
"

echo -n "Do you want to continue? (y/n)"

read ANS
if [ "$ANS" != "y" ];then
  echo "Ok. Quitting."
  exit 0
fi

# Load environment
source ./hacking/env-setup

# install pip
easy_install pip

# install dependencies
pip install --user pip install --user paramiko PyYAML Jinja2 httplib2 six

# What do we have?
which ansible
ansible --version
