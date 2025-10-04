# 🧰 MasterDevX

Ferramenta criada para técnicos que usam **Termux**, feita para automatizar tarefas, testar comandos e otimizar manutenção em dispositivos Android/Linux.

---

## ⚙️ Instalação

No Termux, copie e execute os comandos:

bash
pkg install git -y
git clone https://github.com/fernandathays95-blip/MasterDevX.git
cd MasterDevX
chmod +x install.sh
./install.sh 
Se não existir o arquivo install.sh, basta entrar no diretório da ferramenta e rodar manualmente:
bash
bash toolkit.sh 

##🚀 Uso

Após a instalação, inicie com:
bash
bash masterdevx.sh 

ou, se estiver configurado como comando global:
bash
masterdev

A ferramenta exibirá o menu principal com as opções técnicas disponíveis, como:
	•	Diagnóstico do sistema
	•	Limpeza de cache e dados temporários
	•	Ferramentas de rede
	•	Testes de conectividade
	•	Informações do dispositivo

⸻

## 🧱 Estrutura
Pasta / Arquivo
Função
MasterDev/
Scripts principais
Toolkit/
Ferramentas auxiliares
.gitignore
Ignora arquivos desnecessários no repositório
README.md
Documentação básica da ferramenta


📦 Requisitos
	•	Termux atualizado
	•	Pacotes: bash, curl, wget, git, jq
	•	Permissão de armazenamento ativada (termux-setup-storage)

⸻

👨‍💻 Autor

Criado por fernanda
Feito para estudos, testes e aprendizado em automação com Termux.
