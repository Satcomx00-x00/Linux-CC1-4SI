#! /bin/bash
# Auteur: EG
# Date: 2024-04-03
# Description: Exo 1 du CC1
# Binaires autorisées :

classe=""                                                      # variable pour stocker le nom de la classe
foldersToCreate=("Francais" "Histoire" "Mathematiques" "Docs") # tableau pour stocker les noms des dossiers à créer
csvFile="listeEtudiants.csv"                                   # variable pour stocker le nom du fichier

# tester si le fichier listeEtudiants.csv existe si oui tester si le fichier est vide
if [ ! -f "$csvFile" ]; then # tester si le fichier listeEtudiants.csv existe
    echo "Le fichier $csvFile n'existe pas"
    exit 1
fi
if [ ! -s "$csvFile" ]; then # tester si le fichier listeEtudiants.csv est vide
    echo "Le fichier $csvFile est vide"
    exit 2
fi

# fonction pour créer les dossiers
createFolders() {
    for folder in "${foldersToCreate[@]}"; do # pour chaque nom et prénom, créer un dossier avec le nom et le prénom (col2 _ col3)
        mkdir -p "$classe/$1 $2/$folder"      # créer les dossiers avec le nom et le prénom (col2 _ col3) et créer des sous-dossiers 'Français', 'Histoire', 'Mathematiques', 'Docs'.
    done                                      # mkdir -p permet de créer les dossiers parents si ils n'existent pas
}

# méthode de lecture du fichier listeEtudiants.csv,
# IFS est utilisé pour définir le séparateur de colonnes et on défini les variables col1, col2 et col3 pour stocker les valeurs de chaque colonne respectivement
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
        createFolders "$col2" "$col3" # appeler la fonction createFolders avec les valeurs de col2 et col3
    fi
done <listeEtudiants.csv
