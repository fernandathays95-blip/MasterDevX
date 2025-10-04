#!/bin/bash
# ==========================================================
# 🧰 MasterDevX - Ferramenta para Técnicos (Simulação)
# Criado por Enzo Gabryel
# ==========================================================

# Cores para o terminal
VERDE='\033[0;32m'
AZUL='\033[0;34m'
AMARELO='\033[1;33m'
VERMELHO='\033[0;31m'
RESET='\033[0m'

# Banner inicial
clear
echo -e "${AZUL}"
echo "=========================================="
echo "        🧰 MASTERDEVX INSTALLER"
echo "=========================================="
echo -e "${RESET}"

sleep 1
echo -e "${VERDE}[+] Verificando dependências...${RESET}"
sleep 1

# Dependências básicas
for pkg in git curl wget jq; do
    if ! command -v $pkg &> /dev/null; then
        echo -e "${AMARELO}[-] Instalando pacote: ${pkg}${RESET}"
        pkg install $pkg -y >/dev/null 2>&1
    else
        echo -e "${VERDE}[✓] ${pkg} já está instalado.${RESET}"
    fi
done

sleep 1
echo -e "${VERDE}[+] Preparando ambiente...${RESET}"
mkdir -p $HOME/.masterdevx
touch $HOME/.masterdevx/config.cfg
sleep 1

clear
echo -e "${AZUL}"
echo "=========================================="
echo "      ✅ MASTERDEVX INSTALADO COM SUCESSO"
echo "=========================================="
echo -e "${RESET}"
sleep 1

# Menu principal (simulação)
while true; do
    clear
    echo -e "${AZUL}=========== MENU MASTERDEVX ===========${RESET}"
    echo -e "${VERDE}1${RESET} - Diagnóstico rápido do sistema"
    echo -e "${VERDE}2${RESET} - Limpeza de cache"
    echo -e "${VERDE}3${RESET} - Testar conexão com a internet"
    echo -e "${VERDE}4${RESET} - Mostrar informações do dispositivo"
    echo -e "${VERDE}5${RESET} - Sair"
    echo -e "${AZUL}=======================================${RESET}"
    read -p "Escolha uma opção: " op

    case $op in
        1)
            echo -e "${AMARELO}Executando diagnóstico...${RESET}"
            sleep 1
            echo "CPU: OK"
            echo "Memória: OK"
            echo "Armazenamento: OK"
            echo "Rede: OK"
            ;;
        2)
            echo -e "${AMARELO}Limpando cache...${RESET}"
            sleep 1
            echo "Cache limpo com sucesso!"
            ;;
        3)
            echo -e "${AMARELO}Testando conexão...${RESET}"
            sleep 1
            ping -c 1 google.com &> /dev/null && echo "Conexão OK!" || echo "Sem conexão!"
            ;;
        4)
            echo -e "${AMARELO}Informações do sistema:${RESET}"
            echo "Usuário: $USER"
            echo "Sistema: $(uname -o)"
            echo "Kernel: $(uname -r)"
            echo "Arquitetura: $(uname -m)"
            ;;
        5)
            echo -e "${VERDE}Saindo da ferramenta... Até logo!${RESET}"
            sleep 1
            exit 0
            ;;
        *)
            echo -e "${VERMELHO}Opção inválida!${RESET}"
            ;;
    esac

    echo ""
    read -p "Pressione ENTER para voltar ao menu..."
done
