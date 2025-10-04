# Função para exibir informações detalhadas do dispositivo (Opção 1)
info_detalhada() {
    clear
    echo -e "${AZUL}========================================${FIM}"
    echo -e "${AZUL}    INFORMAÇÕES DETALHADAS DO CELULAR   ${FIM}"
    echo -e "${AZUL}========================================${FIM}"
    checar_adb # Garante que a conexão ADB está ativa
    
    if [ $? -ne 0 ]; then
        read -p "Pressione Enter para retornar ao menu..."
        return
    fi
    
    echo -e "\n${AMARELO}--- DADOS GERAIS DO SISTEMA ---${FIM}"
    
    # Extrai e exibe o modelo e a marca
    MODELO=$(adb shell getprop ro.product.model 2>/dev/null)
    MARCA=$(adb shell getprop ro.product.manufacturer 2>/dev/null)
    ANDROID_VERSAO=$(adb shell getprop ro.build.version.release 2>/dev/null)
    
    echo -e "  ${VERDE}Marca:${FIM} ${MARCA}"
    echo -e "  ${VERDE}Modelo:${FIM} ${MODELO}"
    echo -e "  ${VERDE}Android Versão:${FIM} ${ANDROID_VERSAO}"
    
    echo -e "\n${AMARELO}--- DETALHES TÉCNICOS ---${FIM}"
    
    # Extrai e exibe o serial, IMEI e Kernel
    SERIAL=$(adb shell getprop ro.serialno 2>/dev/null)
    KERNEL=$(adb shell cat /proc/version | head -n 1 2>/dev/null)
    
    # Para obter o IMEI, muitas vezes é necessário ROOT ou permissões mais elevadas.
    # Usaremos um comando que funciona em muitos casos, mas pode falhar sem ROOT:
    IMEI=$(adb shell service call iphonesubinfo 1 | awk -F '[\\x00]' '{for(i=1;i<=NF;i++){if(length($i)>15){print $i}}}' 2>/dev/null)
    
    echo -e "  ${VERDE}Número de Série:${FIM} ${SERIAL}"
    echo -e "  ${VERDE}Kernel:${FIM} ${KERNEL}"
    
    # Exibe o IMEI se encontrado, ou uma mensagem alternativa
    if [[ -z "$IMEI" ]]; then
        echo -e "  ${VERDE}IMEI:${FIM} ${AMARELO}Não disponível (pode exigir ROOT).${FIM}"
    else
        echo -e "  ${VERDE}IMEI:${FIM} ${IMEI}"
    fi
    
    echo -e "${AZUL}----------------------------------------${FIM}"
    read -p "Pressione Enter para retornar ao menu..."
}
