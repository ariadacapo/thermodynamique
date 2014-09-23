#!/bin/bash

# Script pour automatiser la compilation du Framabook de thermodynamique
# Doit être configuré pour fonctionner
# Mise à jour du 2014-09-20


# CONFIGURATION
# 1) 	Dé-commentez ces deux lignes et remplacez $STYFOLDER 
# 		par l’adresse des fichiers .sty et .cls de votre 
#		système (avec un / final) :
#export STYFOLDER='/chemin/absolu/vers/les/sty/'
#export TEXINPUTS='.//:$STYFOLDER/:'

# 2) 	Liez ou insérez dans votre $STYFOLDER le contenu du 
#		dossier "styles thermo".
#		Celui-ci contient notamment la classe "framabook" 
# 		du dépôt framaquette-thermo accessible à l’adresse
#		https://github.com/ariadacapo/framaquette-thermo.git

#		Ainsi votre compilateur LaTeX disposera des styles et 
#		appels de paquets nécessaires pour construire le livre.


###############################################################

# Ménage -- effacement des fichiers temporaires
rm -rfv tmp/*	

# on dit ce qu’on va faire
echo "##############################################"
echo "##############################################"
echo "############# Compilation n°1 ################"
echo "##############################################"
echo "##############################################"
sleep 2s

# on compile. Colout (https://github.com/nojhan/colout, par le génial nojhan) colore la sortie
pdflatex -file-line-error thermodynamique.tex | colout -t latex

# bibtex & biber potassent la bibliographie à partir des citations utilisées
bibtex thermodynamique.aux
biber thermodynamique

# Deuxième compilation, permet de finaliser :
# 	grande table des matières,
# 	minitoc en début de chapitre,
# 	références internes,
#	abaques en annexe,
# 	bibliographie.
echo "##############################################"
echo "##############################################"
echo "############# Compilation n°2 ################"
echo "##############################################"
echo "##############################################"
sleep 2s
mv thermodynamique.pdf tmp/thermodynamique_compil1.pdf  # pour les curieux
mv thermodynamique.log tmp/thermodynamique_compil1.log # pour les curieux

pdflatex -file-line-error thermodynamique.tex | colout -t latex
bibtex thermodynamique.aux
biber thermodynamique


# Si le nombre de pages supplémentaires dans la compilation n°2 n’est pas pair,
# alors certaines figures seront décalées dans la mauvaise marge. 
# Donc, on compile trois fois. Third time’s a charm.
echo "##############################################"
echo "##############################################"
echo "############# Compilation n°3 ################"
echo "##############################################"
echo "##############################################"
sleep 2s
mv thermodynamique.pdf tmp/thermodynamique_compil2.pdf 	# pour les curieux
mv thermodynamique.log tmp/thermodynamique_compil2.log	# pour les curieux
pdflatex -file-line-error thermodynamique.tex | colout -t latex


# on déplace les fichiers temporaires pour faire de la place.
mv -v thermodynamique.aux thermodynamique.bbl thermodynamique.bcf thermodynamique.blg thermodynamique.log thermodynamique.maf thermodynamique.mtc thermodynamique.mtc0 thermodynamique.mtc1 thermodynamique.mtc2 thermodynamique.mtc3 thermodynamique.mtc4 thermodynamique.mtc5 thermodynamique.mtc6 thermodynamique.mtc7 thermodynamique.mtc8 thermodynamique.mtc9 thermodynamique.mtc10 thermodynamique.mtc11 thermodynamique.mtc12 thermodynamique.mtc13 thermodynamique.run.xml thermodynamique.toc tmp/

echo "#"
echo "#"
echo "...fini."

# dans Gnome (et Unity), afficher une petite notification pour dire que c’est fini
notify-send -i gnome-terminal "ouf" "Script de compilation terminé."

exit
