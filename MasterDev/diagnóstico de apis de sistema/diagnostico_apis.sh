#!/bin/bash

# =======================================================
# SCRIPT DE DIAGNÓSTICO DE API E SISTEMA PARA TERMUX
# Verifica APIs/Recursos essenciais do Android via Shell
# =======================================================

echo "--- RELATÓRIO DE DIAGNÓSTICO DE API/SISTEMA (TERMUX) ---"
echo "Data/Hora: $(date)"
echo "--------------------------------------------------------"

# --- 1. VERIFICAÇÃO DO NÍVEL DA API (Compatibilidade de Versão) ---
echo -e "\n[1] Nível da API do Sistema (SDK)"
API_LEVEL=$(getprop ro.build.version.sdk)
ANDROID_VERSION=$(getprop ro.build.version.release)

if [ -z "$API_LEVEL" ]; then
    echo "  Status: ❌ FALHA (Não foi possível ler o nível da API)"
else
    echo "  Nível SDK: $API_LEVEL"
    echo "  Versão Android: $ANDROID_VERSION"
    if [ "$API_LEVEL" -ge 33 ]; then
        echo "  Status: ✅ Atualizado (Android 13+)"
    elif [ "$API_LEVEL" -ge 28 ]; then
        echo "  Status: ⚠️ Funcional (Android 9+)"
    else
        echo "  Status: 🚨 Desatualizado (Pode ter problemas de compatibilidade)"
    fi
fi
echo "--------------------------------------------------------"


# --- 2. TESTE DE CONECTIVIDADE DE REDE (A API mais essencial) ---
# Testa se as APIs de rede estão funcionando fazendo uma requisição externa.
echo -e "\n[2] Teste de Conectividade de Rede (Google API)"
URL_TESTE="https://www.google.com/generate_204"

# Tenta fazer uma requisição silenciosa e verifica o código de retorno HTTP
if command -v curl &> /dev/null; then
    STATUS=$(curl -s -o /dev/null -w "%{http_code}" --connect-timeout 5 $URL_TESTE)
    LATENCY=$(curl -s -o /dev/null -w "%{time_total}" --connect-timeout 5 $URL_TESTE)
    
    echo "  Endpoint Testado: $URL_TESTE"

    if [ "$STATUS" == "204" ]; then
        echo "  Status: ✅ SUCESSO"
        echo "  API Web Alcançável (Resposta HTTP $STATUS)"
        echo "  Latência (s): $LATENCY"
    elif [ "$STATUS" == "000" ]; then
        echo "  Status: ❌ FALHA (Sem Conexão ou Timeout)"
        echo "  Problema: API de Rede do Sistema não está respondendo. Verifique Wi-Fi/Dados Móveis."
    else
        echo "  Status: ⚠️ ALERTA (Resposta inesperada HTTP $STATUS)"
    fi
else
    echo "  Status: ❌ FALHA (Ferramenta 'curl' não instalada no Termux)"
fi
echo "--------------------------------------------------------"


# --- 3. VERIFICAÇÃO DO ESTADO DA BATERIA (API de Energia) ---
echo -e "\n[3] Estado da Bateria (API de Energia)"
# Acessa o estado da bateria via /sys/class/power_supply (comum no Android)
POWER_PATH="/sys/class/power_supply/battery"

if [ -d "$POWER_PATH" ]; then
    CAPACITY=$(cat "$POWER_PATH/capacity" 2>/dev/null)
    STATUS_BAT=$(cat "$POWER_PATH/status" 2>/dev/null)
    
    if [ ! -z "$CAPACITY" ] && [ ! -z "$STATUS_BAT" ]; then
        echo "  Nível de Carga: $CAPACITY%"
        echo "  Status da API: $STATUS_BAT"
        if [ "$CAPACITY" -lt 20 ] && [ "$STATUS_BAT" != "Charging" ]; then
            echo "  Status: ⚠️ Bateria Baixa e Descarregando"
        else
            echo "  Status: ✅ OK"
        fi
    else
        echo "  Status: ❌ FALHA (Não foi possível ler os dados da bateria)"
    fi
else
    echo "  Status: ⚠️ Aviso: Caminho da API de Energia não encontrado, usando método alternativo."
    # Poderia usar 'termux-battery-status' se a permissão 'termux-api' estivesse instalada
fi
echo "--------------------------------------------------------"

