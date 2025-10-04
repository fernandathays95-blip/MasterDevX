# Função para Backup (masterDev-backup) - Opção 8
fazer_backup_adb() {
    clear
    echo -e "${AZUL}========================================${FIM}"
    echo -e "${AZUL}         MASTERDEV - BACKUP ADB         ${FIM}"
    echo -e "${AZUL}========================================${FIM}"
    checar_adb # Checa se o ADB está conectado (função definida anteriormente)
    
    if [ $? -ne 0 ]; then
        read -p "Pressione Enter para retornar ao menu..."
        return
    fi
    
    NOME_BACKUP="backup_$(date +%Y%m%d_%H%M%S).ab"
    
    echo -e "\n${AMARELO}ATENÇÃO:${FIM} Este método de backup SÓ funciona se o dispositivo estiver ${VERDE}DESBLOQUEADO${FIM}."
    echo -e "O backup será salvo em: ${VERDE}./$NOME_BACKUP${FIM}"
    
    echo -e "\n${AZUL}Iniciando backup... Olhe a tela do celular e confirme a operação!${FIM}"
    echo -e "Comando: adb backup -all -f ./$NOME_BACKUP"
    
    # Executa o comando de backup ADB (requer interação no celular!)
    adb backup -all -f ./$NOME_BACKUP
    
    if [ $? -eq 0 ]; then
        echo -e "\n${VERDE}BACKUP CONCLUÍDO! Verifique o arquivo $NOME_BACKUP.${FIM}"
    else
        echo -e "\n${VERMELHO}FALHA NO BACKUP! Verifique se o celular está desbloqueado e conectado.${FIM}"
    fi

    read -p "Pressione Enter para retornar ao menu..."
}
