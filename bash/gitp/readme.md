# Script de Commit e Push Automatizado para Git

## [🏠 Home](/readme.md)

Este é um script Bash que simplifica o processo de fazer commit e push de alterações em um repositório Git.

## Funcionalidades Principais:

1. Define algumas variáveis para facilitar a formatação de mensagens de saída com cores.
2. Verifica se um argumento (mensagem de commit) foi fornecido ao script. Se não, exibe uma mensagem de erro e instruções de uso.
3. Obtém o nome do usuário Git usando `git config --get user.name`.
4. Constrói a mensagem de commit formatada com um emoji (no exemplo, um emoji de fogo) seguido pelo nome de usuário Git e a mensagem de commit fornecida como argumento.
5. Adiciona todas as alterações ao staging area usando `git add --all`.
6. Faz o commit das alterações usando a mensagem construída.
7. Verifica se o commit foi bem-sucedido e exibe uma mensagem de sucesso ou erro, se aplicável.
8. Faz push das alterações para o repositório remoto usando `git push`.
9. Verifica se o push foi bem-sucedido e exibe uma mensagem de sucesso ou erro, se aplicável.

## Utilização:

Para usar o script, siga estas etapas:

1. Salve o script em um arquivo com extensão `.sh`.
2. Dê permissões de execução ao arquivo usando o comando `chmod +x seu_script.sh`.
3. Execute o script fornecendo uma mensagem de commit como argumento, por exemplo: `./seu_script.sh 'Mensagem de commit aqui'`.

O script automatiza o processo de commit e push de alterações para um repositório Git, fornecendo feedback visual sobre o sucesso ou falha das operações.

## Baixar

```sh
curl -o gitp.sh https://raw.githubusercontent.com/saulotarsobc/scripts/master/gitp/gitp.sh
```

## Script

```sh
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
```