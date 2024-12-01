#import "../../template.typ": *

#show: template
#set page(numbering: none)

#align(center, text(20pt)[*Projection (cartographique/de Mercator) (d’une surface hyperbolique/d’un tractricoïde) sur un plan*])

Étant toujours curieux de comment nos cartes on était faites, je me suis mis le défis de réaliser une telle projection, non pas d’une surface sphérique mais d’une surface hyperbolique.\
Par ses considérations géométriques, le sujet s’inscrit parfaitement dans le thème de cette année. En effet une projection cartographique est une transformation d’une surface non plane en une plane.

= Positionnement thématique (phase 2) :

MATHÉMATIQUE (géométrie), MATHÉMATIQUE ()

= Mot clef (phase 2) :

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

= Bibliographie documentée :

Les projections cartographiques sont un type de projection spatial très connue des mathématiciens @wikiliste, mais l’étude de ce type de projection en reste néanmoins intéressant, dans un but artistique comme avec l’artiste M.C. Escher, ou dans un but dans un but de compréhension et d’étude de certaine surface comme le disque de Poincaré qui n’est qu’une projection de l’Hyperboloïde.\
Pour cela différent type de projection existe, des azimutales au conique en passant par les cylindriques qui auront retenu mon attention avec la plus connue : La Projection de Mercator.\
Pour réaliser la projection il faut déjà avoir une surface à projeter : c’est la pseudosphère @mathcurve qui auras retenu mon attention, étant donné quelle eu été l’une des premières surface qui présentait un caractère hyperbolique, et qui a donc une courbure négative et même constante @ens @courbure.\
Pour réaliser la projection type Mercator il faut s’intéresser à la géométrie de la surface, est plus particulièrement aux éléments de surface, car elle a pour but de préserver les rectangles infinitésimaux @mercat.\
De plus une projection est intéressante dans ce quelle conserve, par exemple la projection de Mercator est utilisée des marins, car elle conserve les angles, ou encore le projet build the earth a utilisé une projection qui ne conserve rien mais dont la distorsion des angles est des longueurs est la plus minime possible, d’où l’étude des longueurs et des angles des projections @surface @ens

= Problématique retenu :

Comment projeter une surface hyperbolique sur le plan ?\
Et quelles seraient les grandeurs conservées ?

= Objectif du TIPE :

+ étudier la géométrie de la pseudosphère

+ réaliser une projection de la pseudosphère sur le plan

+ étudier les grandeurs conservées
    - les longueurs
    - les angles

#bibliography("biblio.yml", title: [#h(4pt)Bibliographie])

= DOT :

- [Mars — Juin 2024] : choix de faire le TIPE dans le domaine de la géométrie, étude du théorème de Bézout

- [Septembre 2024] : choix final le faire le TIPE sur les projections cartographique et plus particulièrement d'une surface hyperbolique

- [Octobre — Novembre 2024] : découverte et étude de la pseudosphère, réalisation de la projection et visualisation de la projection via desmos puis géogébra

- [Novembre — Décembre 2024] : apprentissage des outils mathématique telle que la courbure de Gauss, des droites sur une surface paramétrée. Et début de la réalisation de la diapo

- [futur] : calcule sur la préservation des longueurs et la non préservation des longueurs
