# Modélisation de la Glycémie chez des Souris

## Introduction

L'étude des mécanismes régulateurs de la glycémie est essentielle dans le contexte de santé publique, notamment pour la compréhension et la détection des troubles métaboliques comme le diabète. Ce projet se concentre sur le développement d'un modèle prédictif basé sur le test oral de tolérance au glucose chez des souris, visant à étudier l'impact d'une pathologie absorptive sur la glycémie.

## Objectifs du Projet

- **Développement d'un Modèle Prédictif :** Créer un modèle fiable pour simuler la glycémie post ingestion de glucose chez des souris.
- **Compréhension des Maladies Métaboliques :** Étudier l'impact d'une pathologie absorptive sur la régulation de la glycémie.

## Méthodologie

### Analyse des Données

- **Description du Jeu de Données :** Utilisation d'une matrice `calibration.mat` qui inclut le temps de l'expérience et le taux de glycémie de chaque souris. Cette analyse aide à comprendre la dynamique d'absorption et de dégradation du glucose. La glycémie obtenue est exprimée en mg/dL, une unité importante pour la modélisation&#8203;``【oaicite:5】``&#8203;.

- **Dynamique de la Glycémie :** Observation d'une augmentation rapide suivie d'une diminution lente du taux de glucose. Ce comportement reflète l'interaction entre la consommation de glucose par les organes, l'action de l'insuline, et le rôle du foie&#8203;``【oaicite:4】``&#8203;.

- **Boite à Moustaches du Jeu de Données :** Cette représentation graphique permet de détecter les valeurs aberrantes et d'examiner la normalité des données. Il est constaté que les souris présentent une grande hétérogénéité en termes de répartition glycémique&#8203;``【oaicite:3】``&#8203;.

### Tests Statistiques sur le Jeu de Données

- **Tests de Normalité et d'Égalité des Médianes :** Utilisation du test de Wilk-Shapiro et du test de Kruskal-Wallis pour analyser la normalité des données et l'égalité des médianes. Les résultats indiquent des différences significatives entre les souris, suggérant l'existence de dynamiques glycémiques distinctes&#8203;``【oaicite:2】``&#8203;.

- **Analyse Comparative Deux à Deux :** Mise en œuvre de tests de Wilcoxon-Mann-Whitney pour comparer les distributions de données entre les souris. Cette analyse permet d'identifier les sous-groupes de souris avec des distributions similaires&#8203;``【oaicite:1】``&#8203;.

- **Stratégie de Calibration :** Calibration basée sur la moyenne de l'ensemble des souris, suivie d'une analyse individuelle pour chaque souris. Les souris présentant des dynamiques distinctes seront examinées séparément pour affiner le modèle&#8203;``【oaicite:0】``&#8203;.



### Hypothèses et Modélisation

- **Formulation d'Hypothèses :** Développement d'hypothèses basées sur la biologie du glucose et son interaction avec l'insuline&#8203;``【oaicite:3】``&#8203;.
- **Conception du Modèle :** Schématisation des interactions entre les différents compartiments biologiques impliqués dans la régulation du glucose&#8203;``【oaicite:2】``&#8203;.

### Développement des Modèles

- **Modèles à Différents Paramètres :** Création de modèles à 5 et 3 paramètres, en tenant compte des spécificités de chaque approche&#8203;``【oaicite:1】``&#8203;.

## Résultats et Discussion

### Résultats de Calibration

- **Ajustement des Modèles :** Présentation des courbes d'ajustement et analyse de leur adéquation avec les données moyennes&#8203;``【oaicite:0】``&#8203;.
- **Illustrations des Résultats :** _[Ajoutez ici le lien vers vos graphiques de calibration]_

### Analyse et Interprétation

- **Comparaison des Modèles :** Discussion sur la performance et la pertinence de chaque modèle dans la représentation de la dynamique glycémique.
- **Implications Biologiques :** Interprétation des résultats à la lumière des connaissances actuelles sur la régulation du glucose et le diabète.

## Conclusion et Perspectives Futures

Ce projet met en lumière l'importance et la complexité de modéliser la régulation de la glycémie. Les modèles développés offrent une base solide pour de futures recherches et applications cliniques.

### Perspectives Futures

- **Amélioration du Modèle :** Exploration de méthodes supplémentaires pour affiner la précision et la généralisabilité du modèle.
- **Applications Cliniques :** Adaptation du modèle pour des études sur les patients diabétiques et pré-diabétiques.
- **Recherche Continue :** Poursuite des recherches pour inclure d'autres facteurs biologiques et environnementaux affectant la glycémie.
