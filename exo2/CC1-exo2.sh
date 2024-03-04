#! /bin/bash
# Auteur: Gouraud Elie
# Date: 2024-04-03
# Description: Exo 2 du CC1, ce script permet de parse un fichier log spécifique

logFile=$1

if [ ! -f "$logFile" ]; then # tester si le fichier listeEtudiants.csv existe
    echo "Le fichier $logFile n'existe pas"
    exit 1
fi

if [ ! -s "$logFile" ]; then # tester si le fichier listeEtudiants.csv est vide
    echo "Le fichier $logFile est vide"
    exit 2
fi

while IFS= read -r line; do
    datetime=$(echo $line | awk '{print $1 " " $2 " " $3 " " $4 " " $5}') # extrait la date et l'heure
    datetime=$(echo $datetime | cut -c 2- | rev | cut -c 2- | rev)        # supprime les crochets
    type=$(echo $line | cut -d' ' -f6- | cut -d' ' -f1)                   # extrait le type à partir du 6ème caractère/position de la ligne et et retire le dernier mot présent en trop, ici "["
    message=$(echo $line | cut -d' ' -f8-)                                # extrait le message à partir du 8ème caractère/position de la ligne et récupère tout le reste jusqu'à la fin de la ligne
    # echo "[$type] - $datetime - $message"                                 # affiche le message avec le type et la date

    if [ "$type" = "[error]" ]; then # si le type est [error] alors l'icône est ✗
        icon="✗"
    elif [ "$type" = "[notice]" ]; then # si le type est [notice] alors l'icône est i
        icon="i"
    else # sinon l'icône est ✓
        icon="✓"
    fi
    timestamp=$(date -d "$datetime" +%s) # convertit la date en timestamp

    echo "[$icon] - $timestamp - $message" # affiche le message avec l'icône et le timestamp
    # generate the output file 
    echo "[$icon] - $timestamp - $message" >> "output.log"

done <"$logFile"
