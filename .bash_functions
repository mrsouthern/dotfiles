dotenv () 
{
  set -a; [ -f ${1-.}/.env ] && echo source ${1-.}/.env && source ${1-.}/.env; set +a;
}

dotenv $CODESPACE_VSCODE_FOLDER
