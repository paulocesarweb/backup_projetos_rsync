#!/bin/bash

# Diretório de origem
ORIGEM="/home/paulo/Projetos/"

# Encontrar o ponto de montagem do disco externo
DISCO=$(findmnt -n -o TARGET /dev/sda1)

# Verificar se o disco foi encontrado
if [ -z "$DISCO" ]; then
    echo "Disco externo não encontrado."
    exit 1
fi

# Exibir o ponto de montagem encontrado
echo "Ponto de montagem do disco externo: $DISCO"

# Solicitar confirmação do usuário
read -p "Deseja prosseguir com o backup? (s/n) " CONFIRMAR

if [ "$CONFIRMAR" != "s" ]; then
    echo "Backup cancelado."
    exit 0
fi

# Diretório de destino no disco externo
DESTINO="${DISCO}/Projetos_Backup/"

# Data e hora para nomear o backup
DATA=$(date +%Y%m%d%H%M%S)

# Diretório de destino com data e hora
DESTINO_COM_DATA="${DESTINO}${DATA}"

# Criar o diretório de destino se não existir
mkdir -p "$DESTINO_COM_DATA"

# Executar o rsync
rsync -avz --delete "$ORIGEM" "$DESTINO_COM_DATA"

echo "Backup concluído em $DESTINO_COM_DATA"
