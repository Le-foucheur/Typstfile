#import "../../../template.typ": *
#import "../../../transposition.typ": *
#import "@preview/drafting:0.2.2": *
#import "@preview/cetz:0.3.2": *

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

#text(14pt)[*Partie I.B — Les points de Lagrange*]

===
#AFL

===

Pour vérifier que l'équation (I.1) est symétrique par rapport à l'axe $(A x)$, on remplace $y$ par $-y$, ainsi :
$
  cases(
    -(a(x-(1-a)D))/((x-(1-a)D)^2 + (-y)^2)^(3\/2) - ((1-a)(x+a D))/(((x+a D)^2 + (-y)^2)^(3\/2)) + x/D^3 = 0,
    -(a (-y))/((x-(1-a)D)^2 + (-y)^2)^(3\/2) - ((1-a)(-y))/(((x+a D)^2 + (-y)^2)^(3\/2)) + (-y)/D^3 = 0,
  )\
  <==>\
  cases(
    -(a(x-(1-a)D))/((x-(1-a)D)^2 + y^2)^(3\/2) - ((1-a)(x+a D))/(((x+a D)^2 + y^2)^(3\/2)) + x/D^3 = 0,
    -(a y)/((x-(1-a)D)^2 + y^2)^(3\/2) - ((1-a)y)/(((x+a D)^2 + y^2)^(3\/2)) + y/D^3 = 0,
  )
$

#question.step()

#text(14pt)[*Partie I.C — Dynamique des flyers au voisinage de $upright(L)_1$*]

#text(13pt)[*Partie I.C 1) — Position de $upright(L)_1$*]

===
AN :
$
  a = M_T/M = (6 dot.c 10^24) / (2 dot.c 10^30 + 6 dot.c 10^24) ) approx 3 dot.c 10^-6
$
De plus pour $a = 0$ :
$
  0 =1/(D - epsilon)^2 - 1/D^2 + epsilon/D^3 = (D^3 - (D - epsilon)^3 ) / (D^3 (D - epsilon)^2)\
  Donc cancel(D^3) - cancel(D^3) + 3 D^2 epsilon - 3epsilon^2 D + epsilon^3 = epsilon underbrace((epsilon^2 - 3D epsilon + 3D^2), Delta = -3 D^2 < 0) = 0\
$
Donc $epsilon = 0$, ainsi la terre et $upright(L)_1$ sont confondus, donc on ne peut pas prendre $a = 0$

===
Pour $epsilon << D$, alors
$
  (1-a)/(D^2(1 - epsilon/D)^2) - a/epsilon^2 - (1-a)/D^2 + underbrace((epsilon/D^3), = 0", car " epsilon << D) = 0\
  (1-a)/D^2 (cancel(1)+(2 epsilon)/D) - cancel((1 - a)/D^2) = a/epsilon^2\
  2 epsilon (1-a)/D^3 = a/epsilon^2\
  epsilon^3/D^3 = a/(2(1-a))\
  epsilon/D = root(3 , a/(2(1-a))) approx root(3, a/2)\
  "car " a << 1\
$

AN :
$epsilon/D approx root(3, (3 dot.c 10^(-6))/2) approx 1.1 dot.c 10^(-2)$

===

On peut lire sur la figure 2 que $epsilon/D approx 1 dot.c 10^(-2)$\
Ce qui est très proche de la valeur calculée précédemment

#text(13pt)[*Partie I.C 2) — Dynamique des flyers au voisinage de $upright(L)_1$*]

===

$
  underbrace((dif^2 u)/(dif tau^2), "viens de "\ l2LN) = underbrace(4pi (dif v)/(dif tau), "dû à" \ "la force centrifuge") + underbrace( pi^2 (1 + (2a)/epsilon.alt^2 + (2(1-a))/(1-epsilon.alt)^3)u, "dû à" \ "l'influance gravitationelle" \ "dus autres astres")\
$

=== 


Posons $ateb = 4 pi^2 (a/epsilon.alt^3 + (1-a)/(1-epsilon.alt)^3)$, ainsi
$
  (dif^2 w)/(dif tau^2) + ateb w = 0
$
On reconais une équation différentielle du second ordre homogène, dont le polynome caractéristique $X^2 + ateb = 0$, a pour racine : $plus.minus i sqrt(ateb)$.\
Ainsi le mouvement du flayer suivant $z$ est périodique, de pulsation $omega_0 = sqrt(ateb)$

===
Le système (I.3) devient :
$
  cases(
    (dif u_p)/(dif tau) = 4pi v_p + 4pi^2 A u,
    (dif v_p)/(dif tau) = -4pi u_p + 4pi^2 B v,
    (dif w_p)/(dif tau) = - 4pi^2 C w,
  )
$

===
#AFL