# Script para Redefinir o Histórico do Git

## [🏠 Home](../../readme.md)

Este é um script Bash que simplifica o processo de redefinir o histórico de commits de um repositório Git, criando um novo commit em uma nova branch sem histórico anterior.

> [!CAUTION]
> Este script irá excluir permanentemente o espaço de commits anteriores. Certifique-se de ter um backup do repositório antes de executá-lo.

## Funcionalidades Principais:

- Criação de uma nova branch sem histórico de commits.
- Adição de todos os arquivos do repositório ao novo commit.
- Exclusão da branch antiga e renomeação da nova branch para o nome original.
- Fornecimento de um push forçado para o repositório remoto, substituindo o histórico anterior.
- Limpeza de objetos não referenciados no repositório.

## Utilização:

Para usar o script, siga estas etapas:

1. Salve o script em um arquivo com extensão `.sh`. Por exemplo, `reset_git_history.sh`.
2. Dê permissões de execução ao arquivo usando o comando:
   ```sh
   chmod +x reset_git_history.sh
   ```
3. Execute o script com o seguinte comando:
   ```sh
   ./reset_git_history.sh
   ```

### Atenção:

- **Backup**: Antes de executar esse script, certifique-se de ter um backup de qualquer informação importante, pois ele irá excluir permanentemente o histórico de commits.
- **Colaboradores**: Informe seus colaboradores sobre a mudança, pois eles precisarão clonar o repositório novamente após a execução deste script.

## Baixar

```sh
curl -o reset_branch.sh https://raw.githubusercontent.com/saulotarsobc/scripts/master/bash/reset_branch/reset_branch.sh
```

## Script

```sh
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
git commit -m "Iniciando o histórico do zero"

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
```

## Conclusão

- Sinta-se à vontade para ajustar o texto conforme necessário para se alinhar ao seu estilo de documentação.
- Certifique-se de que o link para baixar o script esteja correto, caso você esteja hospedando-o em um repositório específico.
