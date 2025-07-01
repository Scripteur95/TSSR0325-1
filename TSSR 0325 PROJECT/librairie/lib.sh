#!/bin/bash

# =============================================================================
# Bibliothèque de fonctions et variables partagées
# Ce fichier centralise les éléments communs pour les scripts du projet.
# À inclure avec : source ./lib.sh
# =============================================================================

# --- Variables de couleur ---
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly CYAN='\033[0;36m'
readonly RED='\033[0;31m'
readonly BOLD='\033[1m'
readonly RESET='\033[0m'

# --- Fonctions d'affichage ---
print_step() { echo -e "${CYAN}${BOLD}➤ $1${RESET}"; }
print_success() { echo -e "${GREEN}✓ $1${RESET}"; }
print_error() { echo -e "${RED}✗ Erreur: $1${RESET}" >&2; }

# --- Fonctions d'interface utilisateur (whiptail) ---

# Affiche une barre de progression
progress_bar() {
    local message=$1
    local duration=${2:-3}
    {
        for ((i = 0 ; i <= 100 ; i+=10)); do
            echo "$i"
            sleep "$(bc <<< "scale=2; $duration / 10")"
        done
        echo "100"
    } | whiptail --gauge "$message" 6 70 0
}


# Fonction d'affichage d'erreurs avec une boîte de dialogue whiptail.
# Affiche un message d'erreur et met en pause l'exécution jusqu'à ce que l'utilisateur appuie sur OK.
show_error() {
    local error_message="$1" # Récupère le message d'erreur passé en argument.
    echo -e "${RED}✗ Erreur: $error_message${RESET}" >&2 # Affiche l'erreur dans le terminal.
    # Affiche une boîte de message whiptail avec le message d'erreur.
    whiptail --title "Erreur" --msgbox "Une erreur est survenue : $error_message\n\nAppuyez sur OK pour revenir au menu." 12 70
}

# Fonction pour afficher une erreur et demander à l'utilisateur de continuer (avant de retourner au menu).
# Utilisée lorsque l'erreur n'est pas bloquante pour l'ensemble du script mais empêche l'opération courante.
show_error_and_return_to_menu() {
    local error_message="$1" # Récupère le message d'erreur.
    print_error "$error_message" # Affiche l'erreur dans le terminal.
    # Affiche une boîte de message whiptail.
    whiptail --title "Erreur" --msgbox "Une erreur est survenue : $error_message\n\nAppuyez sur OK pour continuer." 12 70
    return 1 # Indique une erreur pour que le script appelant puisse réagir.
}

# Fonction pour vérifier et installer whiptail.
# Whiptail est un outil qui permet de créer des boîtes de dialogue interactives dans le terminal.
check_whiptail() {
    # Vérifie si la commande whiptail existe.
    if ! command -v whiptail &> /dev/null; then
        echo -e "${YELLOW}Whiptail n'est pas installé. Tentative d'installation...${RESET}"
        # Tente de mettre à jour les dépôts APT (gestionnaire de paquets de Debian/Ubuntu).
        if ! sudo apt update -qq > /dev/null 2>&1; then
             show_error "Échec de la mise à jour des dépôts APT avant l'installation de whiptail."
             return 1 # Retourne 1 pour indiquer un échec.
        fi
        # Tente d'installer whiptail.
        if ! sudo apt install -y whiptail -qq > /dev/null 2>&1; then
            show_error "Échec de l'installation de whiptail. Le menu ne peut pas fonctionner sans lui."
            return 1 # Retourne 1 pour indiquer un échec.
        else
            echo -e "${GREEN}Whiptail installé avec succès.${RESET}"
        fi
    fi
    return 0 # Retourne 0 pour indiquer un succès.
}
