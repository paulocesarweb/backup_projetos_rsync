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

# Perguntar ao usuário o tipo de backup desejado
echo "Escolha o tipo de backup:"
echo "1) Backup completo"
echo "2) Backup incremental"
read -p "Digite 1 ou 2: " TIPO_BACKUP

# Diretório de destino no disco externo
DESTINO="${DISCO}/Projetos_Backup/"

# Data e hora para nomear o backup
DATA=$(date +%Y%m%d%H%M%S)

# Diretório de destino com data e hora
DESTINO_COM_DATA="${DESTINO}${DATA}"

# Criar o diretório de destino se não existir
mkdir -p "$DESTINO_COM_DATA"

# Definir opções do rsync baseadas no tipo de backup
case $TIPO_BACKUP in
    1)
        # Backup completo
        RSYNC_OPCOES="-avz --delete"
        ;;
    2)
        # Backup incremental
        RSYNC_OPCOES="-avz --delete --link-dest=${DESTINO}ultimo_backup/"
        ;;
    *)
        echo "Opção inválida. Backup cancelado."
        exit 1
        ;;
esac

# Executar o rsync com as opções definidas
rsync $RSYNC_OPCOES "$ORIGEM" "$DESTINO_COM_DATA"

# Atualizar o diretório do último backup para backups incrementais
if [ $TIPO_BACKUP -eq 2 ]; then
    ln -sfn "$DESTINO_COM_DATA" "${DESTINO}ultimo_backup"
fi

echo "Backup concluído em $DESTINO_COM_DATA"

