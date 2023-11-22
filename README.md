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

#### Formulation d'Hypothèses

Pour guider la construction du modèle, plusieurs hypothèses ont été formulées, répondant à des questions clés sur la régulation de la glycémie :

- **Quantité Initiale de Glucose :** Détermination de la quantité de glucose présente initialement suite à l'ingestion.
- **Diffusion du Glucose :** Hypothèse selon laquelle la diffusion du glucose à travers l'intestin est constante dans le temps.
- **Impact de l'Insuline sur le Glucose :** Étude de l'interaction entre l'insuline et le glucose, malgré l'absence de données directes sur l'insuline.
- **Dynamique de l'Insuline :** Variation de la quantité d'insuline, initialement faible, qui augmente avec le temps en réponse au glucose et diminue ensuite.
- **Rôle du Glucagon :** Supposition que le glucagon n'a pas d'effet significatif sur la glycémie.
- **Niveau Basal de Glucose :** Existence d'un niveau basal de glucose dans le sang, attribué à l'activité du foie, estimé autour de 150 mg/dL.

Ces hypothèses sont susceptibles d'évoluer en fonction des résultats obtenus et pourraient mener à la création de modèles plus réalistes&#8203;``【oaicite:1】``&#8203;.

#### Schématisation du Modèle

Le modèle considère trois principaux compartiments biologiques :

- **Œsophage :** Point de départ du glucose, qui est ensuite transmis à l'intestin.
- **Intestin :** Lieu de diffusion du glucose.
- **Sang et Foie :** Variations de la glycémie et régulation par le foie permettant de revenir à un niveau basal de glucose après un pic.

La dynamique du glucose est illustrée à travers ces compartiments, avec l'intégration de l'insuline dans la dynamique. Le premier modèle ajoutera deux paramètres liés à la production de l'insuline par le pancréas et à sa dégradation naturelle&#8203;``【oaicite:0】``&#8203;.

- **Conception du Modèle :** Schématisation des interactions entre les différents compartiments biologiques impliqués dans la régulation du glucose&#8203;``【oaicite:2】``&#8203;.

### Développement des Modèles

### Modèle Basique à 5 Paramètres

#### Paramètres du Modèle

Les cinq paramètres utilisés pour ce modèle incluent :

- **k_abs :** Efficacité de la membrane intestinale pour l'absorption du glucose.
- **k_meet :** Taux de rencontre entre le glucose et l'insuline.
- **k_foie :** Efficacité du foie pour le retour au niveau basal de glucose.
- **k_prod :** Production de l'insuline dépendante du glucose.
- **k_degr :** Dégradation naturelle de l'insuline.

#### Équations Différentielles

Le modèle repose sur trois équations différentielles principales, qui modélisent la diffusion du glucose à travers l'intestin, l'évolution du glucose sanguin, et l'évolution de l'insuline.

#### Données Initiales

- La quantité initiale de glucose dans l'intestin est calculée à partir de la dose administrée aux souris.
- La quantité initiale de glucose et d'insuline dans le sang est basée sur des valeurs moyennes et des estimations.

#### Simulation et Calibration

La calibration est réalisée en ajustant les paramètres pour correspondre au mieux à la courbe moyenne de la glycémie des souris, en utilisant des méthodes comme les moindres carrés et l'optimisation des paramètres.

### Modèle à 3 Paramètres avec Absorption Intestinale Constante

#### Réduction des Paramètres

En l'absence de données sur l'insuline, le modèle est simplifié à trois paramètres, en se focalisant sur l'absorption du glucose, la rencontre entre le glucose et l'insuline, et un seuil d'activation du foie.

#### Équations Différentielles et Données Initiales

Les mêmes équations différentielles sont utilisées, avec des ajustements sur les paramètres et les conditions initiales pour refléter la réduction du nombre de paramètres.

#### Calibration et Résultats

La calibration sur la moyenne et sur chaque souris individuelle est réalisée, permettant de comparer les modèles et d'optimiser les paramètres.

### Modèle à 3 Paramètres avec Absorption Intestinale Exponentielle

#### Introduction d'une Nouvelle Dynamique

Ce modèle intègre une décroissance exponentielle pour la diffusion du glucose à travers l'intestin, apportant une amélioration biologique réaliste au modèle.

#### Paramètres et Équations Différentielles

Les paramètres et équations différentielles sont ajustés pour inclure cette nouvelle dynamique, avec une attention particulière portée à la modélisation de l'insuline.

#### Résultats de la Calibration

Les calibrations sur la moyenne et sur chaque souris sont effectuées, montrant une amélioration significative de l'ajustement des modèles.

### Choix du Modèle

Le choix final entre les modèles est basé sur le principe de parcimonie, privilégiant le modèle à 3 paramètres avec absorption intestinale exponentielle, qui offre un équilibre entre réalisme biologique et ajustement des données.

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
