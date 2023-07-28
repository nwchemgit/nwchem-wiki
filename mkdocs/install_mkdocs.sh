#!/bin/bash
#if [[ $(command -v pandoc 2 > /dev/null) ]]; then
#    echo need to install pandoc
#    sudo apt-get install -y pandoc
#    sudo apt-get install -y pandoc-citeproc
#fi
#pandoc --version
#if [[ "$?" != 0 ]]; then
#    echo broken pandoc installation
#    exit 1
#fi
if [[ -z "$VIRTUAL_ENV" ]]; then
    USEROPT=--user
else
    USEROPT=
fi
QUIET=--quiet
#QUIET=
python3 -m pip install --upgrade pip $QUIET  $USEROPT
python3 -m pip install  MarkupSafe --use-pep517 $QUIET $USEROPT
python3 -m pip install mkdocs==1.4.3 $QUIET $USEROPT
python3 -m pip install mkdocs-material==9.1.18 $QUIET $USEROPT
python3 -m pip install git+https://github.com/cmitu/mkdocs-altlink-plugin/ --use-pep517 $QUIET $USEROPT
python3 -m pip install python-markdown-math $QUIET $USEROPT
python3 -m pip install install pymdown-extensions $QUIET $USEROPT
#python3 -m pip install install mkdocs-with-pdf $QUIET $USEROPT
python3 -m pip install  mkdocs-bibtex --use-pep517 $QUIET $USEROPT
python3 -m pip install  pandoc --use-pep517 $QUIET $USEROPT
python3 -m pip install  pypandoc_binary --use-pep517 $QUIET $USEROPT
python3 -m pip install install git+https://github.com/flywire/caption --use-pep517 $QUIET $USEROPT
python3 -m pip install install mkdocs-print-site-plugin $QUIET $USEROPT
pip freeze
