#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd ${SCRIPT_DIR}/../
BASE_DIR=$(pwd)

LATEX="pdflatex -src -interaction=nonstopmode"
BIBTEX="bibtex"
PYTHON="python"

if [ "$(command -v pdflatex)" == "" ]; then
    IMAGE="blang/latex:ubuntu"
    echo "pdflatex not found, using docker image ${IMAGE}"
    LATEX="docker run --rm -v ${BASE_DIR}:/data ${IMAGE} ${LATEX}"
    BIBTEX="docker run --rm -v ${BASE_DIR}:/data ${IMAGE} ${BIBTEX}"
fi

echo "writing file tmp/index.tex"
python scripts/make_index.py ${BASE_DIR} > tmp/index.tex 

echo "writing file tmp/book.tex"
python scripts/make_book.py ${BASE_DIR} > tmp/book.tex

echo "compiling tmp/index.tex"
${LATEX} tmp/index.tex > /dev/null

echo "compiling tmp/book.tex"
${LATEX} tmp/book.tex > /dev/null

echo "bibtex book"
${BIBTEX} book > /dev/null

echo "compiling again tmp/book.tex"
${LATEX} tmp/book.tex > /dev/null
${LATEX} tmp/book.tex | grep "Output written"