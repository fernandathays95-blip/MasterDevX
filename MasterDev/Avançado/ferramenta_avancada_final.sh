#!/bin/bash

# =======================================================
# FERRAMENTA DE DESENVOLVEDOR: ADB E FASTBOOT
# Uso: Guia de referência para comandos executados no PC.
# =======================================================

echo "--- FUNÇÕES AVANÇADAS: ADB E FASTBOOT ---"
echo "AVISO CRÍTICO: Estas operações são realizadas por um COMPUTADOR (PC) com drivers ADB/Fastboot instalados, enquanto o celular está conectado via USB."
echo "--------------------------------------------------------"

# Comandos de Referência Específicos da sua Ferramenta
FASTBOOT_COMMAND="masterDev-fastbootCell"
ADB_COMMAND="masterDev-adbCell"
BOOTLOADER_UNLOCK_COMMAND="masterDev-keybootlooaderCell"


# Função para Comandos no Modo Fastboot (Bootloader)
masterDev_fastbootCell() {
    echo -e "\n[1] Executar $FASTBOOT_COMMAND (Modo Fastboot)"
    echo "--------------------------------------------------------"
    echo "PRÉ-REQUISITO: Celular deve estar no modo Fastboot/Bootloader (geralmente desligado e ligado segurando Power + Volume Baixo)."
    echo "AÇÃO: Usada para flash, desbloqueio e operações de baixo nível."
    echo "--------------------------------------------------------"
    echo "COMANDOS CHAVE (Executar no PC):"
    echo "  1. Verificar Conexão: fastboot devices"
    echo "  2. Reiniciar o Sistema: fastboot reboot"
    echo "  3. $BOOTLOADER_UNLOCK_COMMAND: fastboot flashing unlock"
    echo "--------------------------------------------------------"
}

# Função para Comandos no Modo ADB (Depuração)
masterDev_adbCell() {
    echo -e "\n[2] Executar $ADB_COMMAND (Modo ADB)"
    echo "--------------------------------------------------------"
    echo "PRÉ-REQUISITO: Depuração USB ativada nas Opções do Desenvolvedor. O celular deve estar ligado e no sistema Android."
    echo "AÇÃO: Usada para debugging, logs, e controle do sistema operacional."
    echo "--------------------------------------------------------"
    echo "COMANDOS CHAVE (Executar no PC):"
    echo "  1. Verificar Conexão: adb devices"
    echo "  2. Acessar Shell do Sistema: adb shell"
    echo "  3. Instalar um APK: adb install <caminho/arquivo.apk>"
    echo "  4. Capturar Logs (Debugging): adb logcat"
    echo "  5. Reiniciar em Fastboot: adb reboot bootloader"
    echo "--------------------------------------------------------"
}


# --- Execução Principal (Menu Interativo) ---
echo "Comandos disponíveis para o Técnico:"
echo "1. $FASTBOOT_COMMAND (Fastboot/Bootloader)"
echo "2. $ADB_COMMAND (Depuração ADB)"
echo "3. Sair"
echo -n "Escolha uma opção (1, 2 ou 3): "
read OPTION

case $OPTION in
    1) masterDev_fastbootCell ;;
    2) masterDev_adbCell ;;
    3) echo "Saindo da ferramenta avançada.";;
    *) echo "Opção inválida. Saindo.";;
esac

echo -e "\n--- FIM DA FERRAMENTA DE REFERÊNCIA AVANÇADA ---"
