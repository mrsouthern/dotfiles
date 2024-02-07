#!/usr/bin/env bash

if [ -d "$CODESPACE_VSCODE_FOLDER" ]; then
    cd "$CODESPACE_VSCODE_FOLDER" || exit
    echo "Changed folder to $CODESPACE_VSCODE_FOLDER"
fi
if [ -d ".venv" ]; then
    echo "Existing virtual environment"
else
    python3 -m venv .venv
    . .venv/bin/activate
    [ -e requirements-compile.txt ] && pip install -r requirements-compile.txt --upgrade
    pip-sync $(find . -name "requirements*.txt" |
        grep -v requirements-compile.txt |
        grep -v requirements-docker.txt |
        xargs echo)
    pre-commit install
fi
