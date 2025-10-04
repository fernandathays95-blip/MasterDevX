# Necessário definir as cores no início do seu script se ainda não o fez:
# VERDE='\033[0;32m'
# AZUL='\033[0;34m'
# AMARELO='\033[1;33m'
# VERMELHO='\033[0;31m'
# FIM='\033[0m'

# Função para Flashing de Imagem (masterDev-Boot.img) - Opção 10 no menu
flashear_imagem() {
    
    while true; do # Inicia o loop para múltiplas tentativas
        clear
        echo -e "${AZUL}========================================${FIM}"
        echo -e "${AZUL}      MASTERDEV - FLASH DE IMAGEM       ${FIM}"
        echo -e "${AZUL}========================================${FIM}"
        
        # Chama a função para checar se o dispositivo está em Fastboot
        # Se não estiver, esta função avisa e a 'return' do IF abaixo volta ao menu principal
        checar_fastboot
        
        if [ $? -ne 0 ]; then
            read -p "Pressione Enter para retornar ao menu..."
            return
        fi

        echo -e "\n${AMARELO}Passo 1: Qual arquivo de imagem (ex: boot.img) você quer enviar? (ou digite 0 para Sair)${FIM}"
        read -p "Nome do arquivo (deve estar nesta pasta): " ARQUIVO_IMAGEM

        if [[ "$ARQUIVO_IMAGEM" == "0" ]]; then
            return # Sai do loop e da função
        fi

        # LÓGICA DE VERIFICAÇÃO DE ARQUIVO
        if [ ! -f "$ARQUIVO_IMAGEM" ]; then
            echo -e "\n${VERMELHO}ERRO: Arquivo '$ARQUIVO_IMAGEM' não encontrado na pasta atual.${FIM}"
            sleep 2
            continue # Volta para o início do loop
        fi

        echo -e "\n${AMARELO}Passo 2: Para qual partição de destino você quer flashear?${FIM}"
        read -p "Nome da partição (ex: boot, recovery): " PARTICAO_DESTINO

        echo -e "\n${AMARELO}AVISO:${FIM} Flash: '${VERDE}$ARQUIVO_IMAGEM${FIM}' -> '${VERMELHO}$PARTICAO_DESTINO${FIM}'"
        read -p "Confirma a operação? (s/n): " CONFIRM

        if [[ "$CONFIRM" != "s" && "$CONFIRM" != "S" ]]; then
            echo -e "${AZUL}Operação cancelada. Tentando novamente...${FIM}"
            sleep 2
            continue # Volta para o início do loop
        fi

        echo -e "\n${AZUL}Iniciando Flash...${FIM}"
        # COMANDO PRINCIPAL: FLASHEA O ARQUIVO
        fastboot flash "$PARTICAO_DESTINO" "$ARQUIVO_IMAGEM"
        SAIDA_FASTBOOT=$? # Captura o código de saída (0 é sucesso)
        
        # LÓGICA DE VERIFICAÇÃO DE SUCESSO
        if [ $SAIDA_FASTBOOT -eq 0 ]; then
            echo -e "\n${VERDE}FLASH CONCLUÍDO COM SUCESSO!${FIM}"
            read -p "Pressione Enter para retornar ao menu principal..."
            return # Sai da função após o sucesso
        else
            echo -e "\n${VERMELHO}FALHA NO FLASH! Tente novamente ou verifique a conexão.${FIM}"
            read -p "Pressione Enter para tentar com outra imagem/partição..."
            # O loop continua automaticamente (próxima iteração)
        fi
    done
}
