#! /bin/bash
# Auteur: EG
# Date: 2024-04-03
# Description: Exo 1 du CC1
# Binaires autorisées :

classe=""                                                      # variable pour stocker le nom de la classe
foldersToCreate=("Francais" "Histoire" "Mathematiques" "Docs") # tableau pour stocker les noms des dossiers à créer

# méthode de lecture du fichier listeEtudiants.csv, IFS est utilisé pour définir le séparateur de colonnes et on défini les variables col1, col2 et col3 pour stocker les valeurs de chaque colonne selectionnées
while
    IFS=';'
    read -r col1 col2 col3
do
    if [[ $col1 =~ [0-9] ]] || [[ $col2 =~ [0-9] ]] || [[ $col3 =~ [0-9] ]]; then # vérifier s'il y a un numéro dans l'une des colonnes et si c'est le cas
        mkdir -p "$col2"                                                          #  créer un dossier avec le nom de la classe col2
        classe=$col2                                                              # et continuer la boucle avec cette même classe comme dossier principal
        continue
    else
        echo -e "Création des dossiers pour $col2 $col3 dans la classe => $classe"
        for folder in "${foldersToCreate[@]}"; do  # pour chaque nom et prénom, créer un dossier avec le nom et le prénom (col2 _ col3)
            mkdir -p "$classe/$col2 $col3/$folder" # créer les dossiers avec le nom et le prénom (col2 _ col3) et créer des sous-dossiers 'Français', 'Histoire', 'Mathematiques', 'Docs'.
        done                                       # mkdir -p permet de créer les dossiers parents si ils n'existent pas
    fi

done <listeEtudiants.csv
