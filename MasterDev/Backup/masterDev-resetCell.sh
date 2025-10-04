# Função para Reset de Fábrica (masterDev-resetCell) - Opção 9
resetar_celular() {
    clear
    echo -e "${AZUL}========================================${FIM}"
    echo -e "${AZUL}       MASTERDEV - RESET DE FÁBRICA     ${FIM}"
    echo -e "${AZUL}========================================${FIM}"
    
    echo -e "${VERMELHO}AVISO CRÍTICO: ISSO APAGARÁ TODOS OS DADOS DO USUÁRIO, INCLUINDO SENHAS!${FIM}"
    echo -e "${VERMELHO}Certifique-se de ter autorização por escrito do cliente.${FIM}"
    
    read -p "Deseja continuar com o Reset de Fábrica? (s/n): " CONFIRM

    if [[ "$CONFIRM" != "s" && "$CONFIRM" != "S" ]]; then
        echo -e "${AZUL}Operação cancelada.${FIM}"
        read -p "Pressione Enter para retornar ao menu..."
        return
    fi

    # 1. Tenta reset via Fastboot (se o aparelho estiver neste modo)
    if checar_fastboot; then
        echo -e "\n${AMARELO}Dispositivo em Fastboot. Apagando dados (userdata)...${FIM}"
        fastboot erase userdata
        echo -e "${VERDE}Reset via Fastboot concluído! Reiniciando...${FIM}"
        fastboot reboot
    
    # 2. Tenta reset via ADB (se o aparelho estiver ligado e desbloqueado)
    elif checar_adb; then
        echo -e "\n${AMARELO}Dispositivo em ADB. Enviando comando de Reset...${FIM}"
        echo -e "${VERMELHO}Aparelho pode pedir confirmação na tela.${FIM}"
        adb shell recovery --wipe_data
        
    else
        echo -e "\n${VERMELHO}Nenhum dispositivo conectado em ADB ou Fastboot. Não é possível resetar.${FIM}"
    fi
    
    read -p "Pressione Enter para continuar..."
}
