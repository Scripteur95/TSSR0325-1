#!/bin/bash



# variables
read -p "donnez le mdproot : " root_pass
read -p "donnez le nom de bdd : " bdd_name
read -p "donnez le l'utilisateur de la bdd : " bdd_user
read -p "donnez le mot de passe utilisateur de la bdd : " bdd_pass
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
echo "bravo glpi est bien installé"
echo "connectez-vous sur l'url suivante : http://$ip:$port "
echo "utiliser l'identifiant $bdd_user avec le mdp $bdd_pass pour vous connecter a la bdd $bdd_name"
echo "merci bonsoir"
