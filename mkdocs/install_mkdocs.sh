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
python3 -m pip install mkdocs==1.6.0 $QUIET $USEROPT
#python3 -m pip install mkdocs-material==9.5.25 $QUIET $USEROPT
MKDOCS_COMMIT=12a8e82837fe400dd1f123e41d75b32987a11744
curl -LJO https://github.com/squidfunk/mkdocs-material/archive/MKDOCS_COMMIT.tar.gz
python3 -m pip install mkdocs-material-$MKDOCS_COMMIT.tar.gz $QUIET $USEROPT
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
