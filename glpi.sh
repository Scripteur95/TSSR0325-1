#!/bin/bash

# Couleurs terminal (facultatif si utilisé sans GUI)
rouge='\e[31m'
vert='\e[32m'
bleu='\e[34m'
jaune='\e[33m'
reset='\e[0m'
VERT='\033[0;32m' # vert mince
BLANC='\[\033[1;37m\]' # blanc gras
DEFAUT='\[\033[0;m\]' # couleur console par defaut
NOIR='\[\033[0;30m\]' # noir mince
ROUGE='\[\033[0;31m\]' # rouge mince
MARRON='\[\033[0;33m\]' # marron mince
BLEU='\[\033[0;34m\]' # bleu fonce mince
violet='\033[0;35m' # violet mince
VIOLET='\033[1;35m' # violet épais
CYAN='\[\033[0;36m\]' # cyan mince
GRIS='\[\033[0;37m\]' # gris clair mince
BLANCLEGER='\[\033[0;38m\]' # blanc mince
ROUGECLAIR='\[\033[1;31m\]' # rouge clair gras
VERTCLAIR='\[\033[1;32m\]' # vert clair gras
JAUNE='\[\033[1;33m\]' # jaune gras
BLEUCLAIR='\[\033[1;34m\]' # bleu clair gras
ROSE='\[\033[1;35m\]' # rose clair gras
CYANCLAIR='\[\033[1;36m\]' # cyan clair gras

# variables
read -p "donnez le mot de passe root de MariaDB : " root_pass
read -p "donnez le nom de la Bande De Donnée : " bdd_name
read -p "donnez le l'utilisateur de la Bande De Donnée : " bdd_user
read -p "donnez le mot de passe de l'utilisateur de la Bande De Donnée : " bdd_pass
read -p "donnez le numero de port : " port
ip=$(ip -o -4 addr show | awk '!/ lo |docker|br-|veth/ {print $2, $4}' | head -n1 | cut -d' ' -f2 | cut -d/ -f1)


# coeur de script
apt install -y docker.io docker-compose


mkdir /glpi
cd glpi

cat > docker-compose.yml << EOF
version: "3.8"

services:
#MariaDB Container
  mariadb:
    image: mariadb:10.7
    container_name: mariadb
    hostname: mariadb
    environment:
      - MARIADB_ROOT_PASSWORD=$root_pass
      - MARIADB_DATABASE=$bdd_name
      - MARIADB_USER=$bdd_user
      - MARIADB_PASSWORD=$bdd_pass

#GLPI Container
  glpi:
    image: diouxx/glpi
    container_name : glpi
    hostname: glpi
    ports:
      - "$port:80"
EOF


docker-compose up -d

# message de fin
echo -e "${vert}✔️  $1 bravo glpi est bien installé !${reset}"
echo -e "${vert}    $1 connectez-vous sur l'url suivante : ${jaune}http://$ip:$port${reset}"
echo -e "${vert}    $1 utiliser l'identifiant ${cyan}$bdd_user${vert} avec le mdp ${cyan}$bdd_pass${vert} pour vous connecter a la bdd ${VIOLET}$bdd_name${reset}"
echo -e "${vert}    $1 merci bonsoir${reset}"
