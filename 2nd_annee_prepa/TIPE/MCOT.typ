#import "../../template.typ": *

#show: template
#set page(numbering: none)

#align(center, text(20pt)[*Projection (cartographique/de Mercator) (d’une surface hyperbolique/d’un tractricoïde) sur un plan*])

Étant toujours curieux de comment nos cartes ont été faites, je me suis mis le défi de réaliser une projection, non pas d’une surface sphérique mais d’une surface hyperbolique.\
Par ses considérations géométriques, le sujet s’inscrit parfaitement dans le thème de cette année. En effet une projection cartographique est une transformation d’une surface non plane en une plane.

= Positionnement thématique :

MATHÉMATIQUE (géométrie), MATHÉMATIQUE (géométrie différentielle)

= Mot clef :

#grid(
    columns: 2,
    column-gutter: 30pt,
    [
        *mots clefs* (en français) :\
        - projection cartographique
        - géométrie hyperbolique
        - projection de Mercator
        - conservation des angles et des aires
    ],
    [
        *mots clefs* (en anglais) :
        - Map projection
        - Hyperbolic geometry
        - Mercator projection
        - angle and area conservation
    ]
)

= Bibliographie commentée:

Les projections cartographiques sont un type de projection spatial très connu des mathématiciens @wikiliste, 
mais l’étude de ce type de projections en reste néanmoins intéressante,
dans un but artistique comme avec l’artiste M.C. Escher, ou dans un but de compréhension et
d’étude de certaines surfaces comme le disque de Poincaré qui n’est qu’une projection
azimutale de l’Hyperboloïde.\
Pour cela différents types de projections existent, des azimutales aux coniques en passant
par les cylindriques. Ces dernières ont retenu mon attention avec la plus connue : La Projection de Mercator.\
Pour réaliser une projection il faut déjà avoir une surface à projeter. J’ai choisi
la pseudosphère @mathcurve étudiée en premier par Ferdinand Minding (1806 — 1885) puis Eugène Beltrami
en 1868 qui a montré son caractère hyperbolique et l’a baptisée : « pseudosphère »,
dont la courbure est constante négative @ens @courbure.\
Pour réaliser la projection de type Mercator il faut s’intéresser à la géométrie de la surface,
et plus particulièrement aux éléments de surface. En effet, le principe de la projection de Mercator
est de préserver le rapport des cotés d’un élément de surface@mercat, pour ainsi préserver les angles
de la surface sur la carte ainsi faite\
Une projection est intéressante dans ce quelle conserve,
par exemple la projection de Mercator est utilisée par des marins,
car elle conserve les angles. Le projet build the earth, projet qui a pour but de reproduire
la terre dans le jeu Minecraft dont le monde est plat, a utilisé une projection qui
ne conserve rien mais dont la distorsion des angles et des longueurs est la plus minime possible,
d’où l’étude des longueurs et des angles des projections @surface @ens

= Problématique retenu :

Comment projeter une surface hyperbolique sur le plan ?\
Et quelles en seraient les grandeurs conservées ?

= Objectif du TIPE :

+ étudier la géométrie de la pseudosphère

+ réaliser une projection de la pseudosphère sur le plan

+ étudier les grandeurs conservées
    - les longueurs
    - les angles

#bibliography("biblio.yml")

= DOT :

- [Mars — Juin 2024] : choix de faire le TIPE dans le domaine de la géométrie, étude du théorème de Bézout

- [Septembre 2024] : choix final le faire le TIPE sur les projections cartographique et plus particulièrement d’une surface hyperbolique

- [Octobre — Novembre 2024] : découverte et étude de la pseudosphère, réalisation de la projection et visualisation de la projection via desmos puis géogébra

- [Novembre — Décembre 2024] : apprentissage des outils mathématique telle que la courbure de Gauss, des droites sur une surface paramétrée. Et début de la réalisation de la diapo

- [futur] : calcule sur la préservation des angles et la non préservation des longueurs
