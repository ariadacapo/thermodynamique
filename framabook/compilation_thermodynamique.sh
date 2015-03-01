#!/bin/bash

# Script pour automatiser la compilation du Framabook de thermodynamique
# Attention — écrit selon la méthode de la Rhâche par un complet amateur
# Doit être configuré pour fonctionner
# Mise à jour du 2014-10-17


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

# Rapatriement des fichiers temporaires utiles produits lors de la dernière compilation
# (éviter si la compilation est reprise depuis zéro)
	mv -v tmp/thermodynamique.aux tmp/thermodynamique.bbl tmp/thermodynamique.bcf tmp/thermodynamique.blg thermodynamique.idx thermodynamique.ilg thermodynamique.ind tmp/thermodynamique.maf tmp/thermodynamique.mtc* tmp/thermodynamique.toc ./
	mv -v tmp/chapitre_1.aux 1/
	mv -v tmp/chapitre_2.aux 2/
	mv -v tmp/chapitre_3.aux 3/
	mv -v tmp/chapitre_4.aux 4/
	mv -v tmp/chapitre_5.aux 5/
	mv -v tmp/chapitre_6.aux 6/
	mv -v tmp/chapitre_7.aux 7/
	mv -v tmp/chapitre_8.aux 8/
	mv -v tmp/chapitre_9.aux 9/
	mv -v tmp/chapitre_10.aux 10/
	mv -v tmp/trucsdelafin.aux tmp/trucsdudebut.aux tmp/
# Suppression du reste
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

# makeindex potasse l’index à partir des références \index{} du contenu
makeindex thermodynamique

# Deuxième compilation, permet de finaliser :
# 	grande table des matières,
# 	références internes,
#	abaques en annexe,
# 	bibliographie,
#	index.
echo "##############################################"
echo "##############################################"
echo "############# Compilation n°2 ################"
echo "##############################################"
echo "##############################################"
sleep 2s
mv thermodynamique.pdf tmp/thermodynamique_compil1.pdf 	# pour les curieux
mv thermodynamique.log tmp/thermodynamique_compil1.log	# pour les curieux

pdflatex -file-line-error thermodynamique.tex | colout -t latex
bibtex thermodynamique.aux
biber thermodynamique
makeindex thermodynamique


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
mv -v thermodynamique.aux thermodynamique.bbl thermodynamique.bcf thermodynamique.blg thermodynamique.idx thermodynamique.ilg thermodynamique.ind thermodynamique.log thermodynamique.maf thermodynamique.toc thermodynamique.run.xml thermodynamique.mtc* tmp/
mv -v */*.aux tmp/

echo "#"
echo "#"
echo "...fini."

# dans Gnome (et Unity), afficher une petite notification pour dire que c’est fini
notify-send -i gnome-terminal --hint int:transient:1 "ouf" "Script de compilation terminé."

exit
