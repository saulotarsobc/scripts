#!/bin/bash

# Cores para mensagens
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Verifica se um argumento foi fornecido
if [ $# -eq 0 ]; then
    echo -e "${RED}Erro:${NC} Nenhuma mensagem de commit fornecida."
    echo "Uso: $0 'Mensagem de commit'"
    exit 1
fi

# Obtém o nome do usuário Git
GIT_USER_NAME=$(git config --get user.name)

# Constrói a mensagem de commit
MSG=":fire: @$GIT_USER_NAME $1"

# Adiciona todas as alterações ao staging area
git add --all

# Commit com a mensagem construída
git commit -m "$MSG"

# Verifica se o commit foi bem sucedido
if [ $? -ne 0 ]; then
    echo -e "${RED}Erro:${NC} Falha ao fazer commit. Abortando..."
    exit 1
else
    echo -e "${GREEN}Sucesso:${NC} Alterações foram commitadas."
fi

# Push para o repositório remoto
git push

# Verifica se o push foi bem sucedido
if [ $? -ne 0 ]; then
    echo -e "${RED}Erro:${NC} Falha ao fazer push. Abortando..."
    exit 1
else
    echo -e "${GREEN}Sucesso:${NC} Alterações foram enviadas para o repositório remoto."
fi