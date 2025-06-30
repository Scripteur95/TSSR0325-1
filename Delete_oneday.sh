#!/bin/bash

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

#=============================================================================
# Couleurs pour l'affichage dans le terminal
#=============================================================================
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[1;33m'
readonly CYAN='\033[0;36m'
readonly RED='\033[0;31m'
readonly BOLD='\033[1m'
readonly RESET='\033[0m'

#=============================================================================
# Bannière
#=============================================================================
display_header() {
    # ASCII Art GLPI - version alignée
    local header_lines=(
        ""
        ""
        ""
        ""
        "    .............................."
        "    .░██████╗░██╗░░░░░██████╗░██╗."
        "    .██╔════╝░██║░░░░░██╔══██╗██║."
        "    .██║░░██╗░██║░░░░░██████╔╝██║."
        "    .██║░░╚██╗██║░░░░░██╔═══╝░██║."
        "    .╚██████╔╝███████╗██║░░░░░██║."
        "    .░╚═════╝░╚══════╝╚═╝░░░░░╚═╝."
        "    ''''''''''''''''''''''''''''''"
        ""
        "========================================="
        "     Menu d'installation de GLPI"
        "========================================="
        ""
        "  Bienvenue dans l'installateur GLPI"
        ""
        ""
        ""
        ""
        ""
    )

    # Effacer l'écran du terminal
    clear

    # Calculer la largeur du terminal pour centrer l'affichage
    local term_width=$(tput cols)
    
    # Afficher chaque ligne centrée avec les couleurs définies
    for line in "${header_lines[@]}"; do
        # Appliquer le padding (espacement) seulement si la ligne n'est pas vide
        if [[ -n "$line" ]]; then
            # Calculer la longueur de la ligne en ignorant les codes de couleur ANSI
            local line_length=$(echo "$line" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g" | wc -c)
            line_length=$((line_length - 1)) # wc -c compte le caractère de nouvelle ligne
            local padding=$(( (term_width - line_length) / 2 ))
            if [[ $padding -lt 0 ]]; then padding=0; fi # Éviter un padding négatif
            printf "%${padding}s" ""
        fi

        # Appliquer les couleurs spécifiques au texte
        if [[ "$line" == *"GLPI"* ]]; then
            echo -e "${CYAN}${BOLD}$line${RESET}"
        elif [[ "$line" == *"===="* ]]; then
            echo -e "${YELLOW}$line${RESET}"
        else
            echo -e "${GREEN}$line${RESET}"
        fi
        sleep 0.1 # Petite pause pour un effet d'animation
    done

    # Pause finale après l'affichage de l'entête
    sleep 1
}
display_header
