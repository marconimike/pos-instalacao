#!/usr/bin/bash
## Removendo travas eventuais do apt ##
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/cache/apt/archives/lock 
#Remove o  arquivo, permitindo que o snap seja instalado
sudo rm /etc/apt/preferences.d/nosnap.pref
#--------------> Lista de programas <--------------#
LISTA_DE_PROGRAMAS=(
	tilix
	vlc
	vim
	aptitude
	kazam
	snapd
	flameshot
	tree
	brave-browser
	apt-transport-https
	curl
	snapd
	)

D_SOFT="/home/$USER/Downloads/programas"

#------------------> Variáveis <------------------#

#brave
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

#

VSCODE="https://az764295.vo.msecnd.net/stable/dfd34e8260c270da74b5c2d86d61aee4b6d56977/code_1.66.2-1649664567_amd64.deb"
DISCORD="https://dl.discordapp.net/apps/linux/0.0.17/discord-0.0.17.deb"
CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"

#---------------------------------------------------#

mkdir "$D_SOFT"

#Atualizar repositorios
sudo apt-get update -y

# Programas .deb


wget -c "$VSCODE"    -P "$D_SOFT"
wget -c "$DISCORD"   -P "$D_SOFT"
wget -c "$CHROME"    -P "$D_SOFT"

# instalando os .DEB

sudo dpkg -i $D_SOFT/*.deb
sudo apt-get install -f -y

# instalar programas via APT

for nome_do_programa in ${LISTA_DE_PROGRAMAS[@]}; do
  if ! dpkg -l | grep -q $nome_do_programa; then # Só instala se já não estiver instalado
    apt-get install "$nome_do_programa" -y
  else
    echo "[INSTALADO C/ SUCESSO] - $nome_do_programa"
  fi
done


## Finalização, atualização e limpeza##
sudo aptitude update && sudo aptitude dist-upgrade -y
flatpak update
sudo apt-get autoclean
sudo apt-get autoremove -y

