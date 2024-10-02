#!/bin/bash

# Nome do repositório remoto
REMOTE="origin"
# Nome da branch principal
BRANCH="master"

echo "Iniciando o processo para deletar todos os commits anteriores e redefinir o histórico..."

# Criar uma nova branch sem histórico
echo "Criando uma nova branch sem histórico..."
git checkout --orphan temp_branch

# Adicionar todos os arquivos ao novo commit
echo "Adicionando todos os arquivos ao novo commit..."
git add -A

# Criar um novo commit
echo "Criando um novo commit..."
git commit -m ":fire:"

# Deletar a branch antiga
echo "Deletando a branch $BRANCH antiga..."
git branch -D $BRANCH

# Renomear a nova branch como master
echo "Renomeando a branch atual para $BRANCH..."
git branch -m $BRANCH

# Forçar o push da nova branch para o remoto
echo "Forçando o push da nova branch $BRANCH para o remoto..."
git push -f $REMOTE $BRANCH

# Limpar objetos não referenciados
echo "Executando 'git gc' para limpar objetos não referenciados..."
git gc --aggressive --prune=now

echo "Processo concluído com sucesso! O histórico de commits foi redefinido."
