#!/bin/bash

# Cores
VERDE='\033[0;32m'
AZUL='\033[0;34m'
AMARELO='\033[1;33m'
VERMELHO='\033[0;31m'
FIM='\033[0m'

# Função para monitorar recursos
monitorar_recursos() {
    clear
    echo -e "${AZUL}========================================${FIM}"
    echo -e "${AZUL}    MONITOR DE RECURSOS DO APARELHO     ${FIM}"
    echo -e "${AZUL}========================================${FIM}"
    
    echo -e "\n${AMARELO}--- INFORMAÇÕES GERAIS ---${FIM}"
    
    # 1. Bateria (Requer termux-api)
    echo -e "${VERDE}BATERIA:${FIM}"
    termux-battery-status | grep -E 'percentage|status|health' | sed 's/"//g; s/,//g'
    
    # 2. Status de Rede/WiFi (Requer termux-api)
    echo -e "\n${VERDE}REDE (Wi-Fi/Dados):${FIM}"
    termux-telephony-deviceinfo | grep -E 'network_type|is_network_roaming' | sed 's/"//g; s/,//g'

    echo -e "\n${AMARELO}--- LOGS DE SISTEMA EM TEMPO REAL (Logcat) ---${FIM}"
    echo -e "Use ${VERDE}Ctrl+C${FIM} para parar o log."
    
    # 3. Logcat (Logs de Erro)
    # Exibe os logs de erros (E) e alertas (W) para identificar falhas.
    adb devices | grep -q "device" 
    if [ $? -eq 0 ]; then
        echo -e "${VERDE}[ADB]${FIM} Capturando logs do dispositivo via ADB..."
        adb logcat -d -s *:E *:W # Captura o buffer de logs de erros e warnings
    else
        echo -e "${VERMELHO}[ATENÇÃO]${FIM} ADB não conectado. Exibindo logs locais do Termux."
        # Se ADB não está conectado, mostramos logs internos (menos úteis para o celular conectado)
        logcat -d -s *:E *:W 
    fi

    echo -e "\n${AZUL}----------------------------------------${FIM}"
    read -p "Pressione Enter para retornar ao menu..."
}

# CHAME A FUNÇÃO AQUI PARA TESTAR
# monitorar_recursos
