#import "../../../template.typ": *
#import "../../../transposition.typ": *
#import "@preview/drafting:0.2.0": *
#import "@preview/cetz:0.2.2": *

#show: template

Gaspar Daguet
#align(center, text(20pt)[Physique : DM6])

#set-page-properties()

= Installer un écran solaire dans l'espace

== A — Préliminaires

===

#canvas({
  import draw: *

  line((0,0), (15.5,0))

  circle((14, 0), radius: 1, name: "terre")

  line((9, 0.25), (9, -0.25))
  content((9, -0.5), $f’$)

  line((0, 0.75), (7, 0.75), mark: (end: ">"), fill: red, stroke: red)
  line((6, 0.75), (11, 0.75), fill: red, stroke: red)
  line((9, 0), (11, 0.75), fill: red, stroke: (dash: "dashed", paint: red))
  line((11, 0.75), (14, 1.875), fill: red, stroke: red, mark: (end: ">"))
  line((0, -0.75), (7, -0.75), mark: (end: ">"), fill: red, stroke: red)
  line((6, -0.75), (11, -0.75), fill: red, stroke: red)
  line((9, 0), (11, -0.75), fill: red, stroke: (dash: "dashed", paint: red))
  line((11, -0.75), (14, -1.875), fill: red, stroke: red, mark: (end: ">"))
  content((5, 1.1), text(red)[rayon lumineux])

  line((9, 2), (11, 2), mark: (start: "straight", end: "straight"))
  content((10, 2.25), $delta$)

  line((11, 2), (14, 2), mark: (start: "straight", end: "straight"))
  content((12.5, 2.25), $l$)

  line((14, -1), (14, 0), mark: (start: "straight", end: "straight"))
  content((14.35, -0.5), $scr(R)_T$)

  line((15.5, 1.875), (15.5, -1.875), mark: (start: "straight", end: "straight"))
  content((15.85, 0), $Delta$)

  line((11, 1), (11, -1), mark: (start: "straight", end: "straight", scale: -1), name: "écran")

})

Ici on cherche $delta$ pour le quel $scr(R)_T = mu Delta$, de plus par le théorme de Thalès on a $delta / l =  2scr(R)_T / Delta$ avec ici $2 scr(R)_T$ la longueur de la lentille.\
Ainsi la distance focale de la lentille est : $delta = 2l mu = 2 times 0,018 times 1,5 dot.c 10^9 = 54 dot.c 10^3 k m$

=== 
Tout d'abord les symétries  et les invariances du champ $arrow(scr(G))$, nous permettent de déduire que le champ $arrow(scr(G))$ est radial.\
Pour $r > scr(R)_T$, le théorème de Gauss sur une sphère de rayon $r$, nous donne :
$
  - 4 pi G M = integral.surf_scr(S) arrow(scr(G))(r) dot.c arrow(dS) = scr(G)(r) 4 pi r^2
$
Ainsi on a :
$
  arrow(scr(G))(r) = - G M / r^2 arrow(Ur)
$
\
De plus comme $arrow(scr(G)) =- (diff V)/ddt arrow(Ur) $, donc $V = G M/r$

=== 
Par la 3#super[ième] loi de Kepler : 
$
  T^2 / r^3 =( 4 pi^2) / (G M)
$
Or $T = (2pi)/omega$, d'où :
$
  omega = sqrt( (G M) / r^3)
$

#pagebreak()

#text(14pt)[*Partie I.B — Les points de Lagrange*]

===
Si l'on ne considère que les champs de gravité de la terre et du soleil, alors 
$
  arrow(scr(G)) = arrow(scr(G))_T (r_t) + arrow(scr(G))_S (r_s) = 0
$
avec $r_t$ et $r_s$ les rayons des orbites depuis la terre et le soleil.\
Or :
$
  r_s = sqrt(x^2 + y^2)\
  r_t = sqrt((D-x)^2 + y^2)
$
Ainsi :
$
  arrow(scr(G))_T (r_t) = - G( a M) / r_t^2 arrow(Ur) = - G (a M) / ((D-x)^2 + y^2) arrow(Ur)\
  arrow(scr(G))_S (r_s) = - G ((1-a)M) / r_s^2 arrow(Ur) = - G ((1-a)M) / (x^2 + y^2) arrow(Ur)
$
Donc :
$
  arrow(scr(G)) = -G M ((a)/((D - x)^2 + y^2) + ((1 - a))/(x^2 + y^2)) arrow(Ur) = 0
$
