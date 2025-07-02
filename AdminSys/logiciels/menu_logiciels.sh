#!/bin/bash

# Script écrit par Babak

# Couleurs terminal (facultatif si utilisé sans GUI)
rouge='\e[31m'
vert='\e[32m'
bleu='\e[34m'
jaune='\e[33m'
reset='\e[0m'

# Fonction pour installer les logiciels (fictifs ici)
installer() {
    echo -e "${bleu}🔧 Installation de : $1${reset}"
    echo $logiciel
    sleep 1
}
installer1() {
    echo -e "${vert}✔️  $1 installé avec succès !${reset}"
    sleep 1.5
}

# Sous-menu Docker stylé
sous_menu_docker() {
    CHOIX=$(whiptail --title "🚀 Déploiement Docker Centralisé" --menu "Sélectionnez un logiciel à installer :" 20 90 10 \
        "1" "📊  Portainer     - Interface web Docker" \
        "2" "🖥️  GLPI          - Gestion de parc informatique"   \
        "3" "📈  Zabbix        - Supervision réseau avancée" \
        "4" "📡  Nagios        - Monitoring et alertes système" \
        "5" "📞  XiVO          - Téléphonie IP (VOIP)" \
        "6" "↩️  Retour" 3>&1 1>&2 2>&3)

    case $CHOIX in
        1) 
        logiciel="docker" 
        chmod +x $HOME/TSSR0325/AdminSys/logiciels/scripts/install_$logiciel.sh
        installer $logiciel && bash $HOME/TSSR0325/AdminSys/logiciels/scripts/install_$logiciel.sh && installer1 $logiciel
        ;;
        2) 
        logiciel="glpi"
        chmod +x $HOME/TSSR0325/AdminSys/logiciels/scripts/install_$logiciel.sh
        installer "GLPI (Gestion de parc )" && bash $HOME/TSSR0325/AdminSys/logiciels/scripts/install_$logiciel.sh && installer1 $logiciel
        ;;
        3) 
        logiciel="zabix"
        chmod +x $HOME/TSSR0325/AdminSys/logiciels/scripts/install_$logiciel.sh
        nstaller "Zabbix (Supervision)" && bash $HOME/TSSR0325/AdminSys/logiciels/scripts/install_$logiciel.sh && installer1 $logiciel
        ;;
        4) 
        logiciel="nagios"
        chmod +x $HOME/TSSR0325/AdminSys/logiciels/scripts/install_$logiciel.sh
        installer "Nagios (Supervision)" && bash $HOME/TSSR0325/AdminSys/logiciels/scripts/install_$logiciel.sh && installer1 $logiciel
        ;;
        5) 
        logiciel="xivo"
        chmod +x $HOME/TSSR0325/AdminSys/logiciels/scripts/install_$logiciel.sh
        installer "XiVO (VOIP)" && bash $HOME/TSSR0325/AdminSys/logiciels/scripts/install_$logiciel.sh && installer1 $logiciel
        ;;
        6)
        return
        ;;
        *)
        echo -e "${rouge}❌ Option invalide${reset}"
        ;;
    esac
}

# Menu principal

# Menu principal
menu_principal(){
while true; do
    CHOIX_PRINCIPAL=$(whiptail --title "🧭 Menu Principal Administration" --menu "Que souhaitez-vous faire ?" 15 90 5 \
        "1" "🛠️  Installation de logiciels via Docker"   \
        "2" "🚪 Quitter" 3>&1 1>&2 2>&3)

    case $CHOIX_PRINCIPAL in
        1) sous_menu_docker ;;
        2) #clear
           echo -e "${jaune}👋 Merci d'avoir utilisé ce menu, à bientôt.${reset}"
           exit 0 ;;
        *) echo -e "${rouge}❌ Option invalide${reset}" ;;
    esac
done
}

main(){
    menu_principal
}

main