#!/bin/bash
#USAGE
# ./scan_vuln.sh 192.168.1.0/24
# sh scn_vuln.sh 192.168.1.0/24
# $1 est égal au pramarètre reçu, dans l'exemple "192.168.1.0/24"
#Sur la ligne ci-dessous, nous séparons l'IP du masque, stockées dans une liste appelée ipAndMask.
ipAndMask=(`echo $1 | tr '/', ' '`)
# Sur les deux lignes ci-dessous, nous récupérons dans deux variables distinctes l'adresse IP
# et le masque, en jouant sur les index de la liste (0 et 1)
# Pour rappeler une variable, on utilise ${maVariable}
# Pour taper dans les index d'une liste, on utilise sur la variable [index]
ip=${ipAndMask[0]}
mask=${ipAndMask[1]}

# On reproduit la même opération consistant cette fois à séparer les éléments par le caractère ".".
# Nous obtenons ainsi dans la variable ipArray la liste des octets de l'adresse IP
ipArray=(`echo $ip | tr '.', ' '`)

# Si le masque est supérieur ou égal à 24
if [ $mask -ge 24 ]
then
        # Alors, je garde les 3 premiers octets dans la variable ipGrep
        ipGrep="${ipArray[0]}.${ipArray[1]}.${ipArray[2]}."
fi

# Si le masque est inférieur à 
if [ $mask -lt 24 ]
then
        # Alors, je garde les deux premiers octets dans la variable ipGrep
        ipGrep="${ipArray[0]}.${ipArray[1]}."
fi

# Scan sur le protocole ARP sur le paramètre $1 reçu, ici 192.168.1.0/24
# On transmet le résultat avec le caractère "|", qu'on appelle "pipe", à la commande
# grep -v "Interface" signifie qu'on filtre les liggnes contenant "Interface" pour ne garder
# que les autres.
# On transmet avec "|" le résultat de ce grep pour une nouvelle fois filtrer sur les lignes
# contenant les octets qui nous intéressent.
# On stocke le résultat dans le fichier hosts.txt
arp-scan $1 | grep -v "Interface" | grep $ipGrep > hosts.txt

# -vv : rendre le scan verbeux (-v, -vv, -vvv)
# -sS : scan sur les ports en TPC en faisant du Syn/Ack. Le principe consiste à couper
# la connexion avant que le pare-feu nous réponde, ce qui peut potentiellement éviter que
# la requête soit logguée
# -T3 : Temporiser le scan pour ne pas se faire détecter (de 1 (sneaky) à 5)
# -A et -O : OS guessing, de technos, de versions
# -sC : embarque 3 scripts NSE (ceux par défaut)
# --script vuln : embarque le script pour réaliser le scan de vulnérabilités
# -oX : générer en Output (les résultats) dans un fichier XML
# --stylesheet : Pour définir une feuille de style au format .xsl, c'est dans ce fichier
# que nous pouvons définir le rend HTML du rapport final
# -iL hosts.txt : prend en entrée les lignes du fichier hosts.txt (une adresse IP par ligne)
# --exclude-ports 631,515,9100 : Exclus ces ports (imprimantes, en effet, le scan va déclencher
# plusieurs impressions, ce qui peut poser problèmes dans une infra si toutes les imprimantes
# se mettent à imprimer.
nmap -vv -sS -T3 -A -O -sC --script vuln -oX report --stylesheet custom-nmap-template.xsl -iL hosts.txt --exclude-ports 631,515,9100

# Pour générer le rendu HTML, on utilise l'utilitaire xsltproc pour transformer le fichier
# report (XML) en fichier report.html (HTML)
xsltproc report -o report.html

# On supprime les fichiers report et hosts.txt
rm ./report
rm ./hosts.txt

# On déplace le rapport HTML généré dans /var/www/html pour l'exposer via le serveur web Apache
mv ./report.html /var/www/html/index.html

