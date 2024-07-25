# Backup de Projetos com Rsync

Este script realiza o backup dos seus projetos localizados em `/seu/path/Projetos/` para um disco externo montado em `/dev/sda1` ou outro que desejar.

## Instalação

1. **Clone o repositório**:
    ```bash
    git clone https://github.com/paulocesarweb/backup_projetos_rsync.git
    cd backup_projetos_rsync
    ```

2. **Dê permissão de execução ao script**:
    ```bash
    chmod +x backup_projetos.sh
    ```

3. **Mova o script para um diretório acessível no seu PATH**:
    ```bash
    sudo mv backup_projetos.sh /usr/local/bin/backup_projetos
    ```

## Uso

1. **Execute o script**:
    ```bash
    backup_projetos
    ```

2. **Confirmação**:
    - O script irá exibir o ponto de montagem do disco externo e solicitar sua confirmação para prosseguir com o backup.
    - Responda `s` para iniciar o backup ou `n` para cancelar.
