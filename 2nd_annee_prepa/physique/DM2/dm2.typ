#import "../../../template.typ": *
#import "../../../transposition.typ": *
#import "@preview/drafting:0.2.0": *
#import "@preview/cetz:0.2.2": *

#show: template

Gaspar Daguet
#align(center, text(20pt)[Physique : DM4])

#set-page-properties()

= I.A Mouvements d'une planète sous l'action d'un astre attracteur

===

Pour que $A$ soit considéré comme fixe, if faut $m_a > m_p$ \
Et
$
  arrow(F) = - #G (m_a m_p)/r^2 hat(Ur)
$ 

===

Le système admet comme plan symetrie : tous les plans passant par $O$ et $M$\
De plus comme on est a symetrie sphérique, il y a invariance par rotation suivant $theta et phi$\
Ainsi le champ de gravitation induit par $A$ s'écrit :
$
  arrow(E) = E(r) hat(Ur)
$
Donc en appliquant l'analogie du théorème d'Gauss pour la garvitation :
$
integral.surf ar(G).ar(dS) = -4pi #G M_"int"
$
Or ici $M_"int" = m_a et integral.surf ar(E).ar(dS) = 4 pi r^2 E(r)$\
D'où : $ar(E) = - #G m_a/r^2 hat(Ur)$
Ainsi :
$
 ar(F) = m_p ar(E) = -#G (m_a m_p)/r^2 hat(Ur)
$

=== \

Non car la force exercé sur le point le plus proche et le point le plus éloigné de l'astre $A$, n'est pas la même, if faudrait donc faire l'intégrale du champ sur tout $P$ pour avoir la valeur moyenne de la force.

===

On a par le théorème cinétique :
$
  (diff cal(ar(L))) / (diff t) = ar(r) and ar(F) \
  "Or" cal(ar(L)) = ar(r) and ar(p) = ve(r, 0, 0) and m ve(0, r dot(theta), 0) = ve(0,0,r dot(theta)^2)\
  et \
  ar(r) and ar(F) = ve(r, 0, 0) and ve(-#G (m_a m_p) /r^2, 0, 0) = ar(0)
$
Donc $ar(cal(L)) = m_p C$ avec $C$ un constante, qui est la constante des aire, et le mouvement est plan\
Et on a particulièrement $r dot(theta)^2 = C$

#pagebreak()

===

Par #l2LN on a : $(dif ar(v))/dt = - #G m_a/r^2 hat(Ur)$

$
(dif ar(v))/(dif theta) = (dif ar(v))/(dt) dot dt/(dif theta) = 1/dot(theta) ve(- #G m_a/r^2, 0, 0)
$
Donc $(dif ar(v))/ (dif theta) = -#G m_a/(r^2 dot(theta)) hat(Ur)$\
Donc 
$
(dif ar(v))/ (dif theta) = #G m_a/C hat(ut) + #G m_a ar(e)/C = #G m_a (hat(ut) + ar(e))/C = C (hat(ut) + ar(e))/p\
"avec" p = C^2/(#G m_a)
$

Comme $[hat(ut)]$ est sans dimention et que l'on a $hat(ut) + ar(e)$, donc $ar(e)$ est sans dimention\
De plus comme $ar(v) in (A x y)$, alors $0 = ar(v) dot hat(uz) = ar(e) dot hat(uz)$, donc $ar(e) in (A x y)$

===

On a $ar(v) = #ve($dot(r)$, $r dot(theta)$, $0$) = C/p (hat(ut) + ar(e))$ par la question précédente\
\
or $ar(e) = #ve($e sin(theta)$, $e cos(theta)$, $0$)$, d'où $ar(v) = (C)/p #ve($e sin(theta)$, $1 + e cos(theta)$, $0$)$,\
Ainsi :
$
  dot(r) = C/p e sin(theta) et r dot(theta) = C/r = C/p (1+ e cos theta)
$

D'où $r = p/(1 + e cos theta)$

Et de plus comme $-e <= e cos theta <= e$, alors $underbrace(1 - e, != 0 "car" e < 1) <= 1 - e cos theta <= 1 + e$\
Donc $p/(1+e) <= p/(1 + e cos theta) = r <= p/(1 - e)$\
Donc le mouvement est bornée
et la trajectoire est elipsoïdal

#text(size: 16pt)[*I.B Période du mouvement*]

===

On sait par la question précédente que
$ dot(theta) = C/r^2 = C(1+ e cos theta)^2/p^2 = sqrt(#G m_a)/p^(3/2) (1+e cos theta)^2 $
Or $dot(theta) = (dif theta) / dt$, d'où :
$
dt = p^(3/2)/sqrt(#G m_a) (dif theta)/(1+e cos theta)^2\
Donc T = p^(3/2)/sqrt(#G m_a) integral_0^(2 pi)(dif theta)/(1+e cos theta)^2 = p^(3/2)/sqrt(#G m_a) cal(I)\
"avec" cal(I) = integral_0^(2 pi)(dif theta)/(1+e cos theta)^2 
$

#pagebreak()

===

Si $e = 0$, alors la trajectoire est circulaire, et 
$
  cal(I) &= integral_0^(2 pi)dif theta = 2pi\
  &Donc T = 2 pi p^(3/2)/sqrt(#G m_a)\
  &Donc T^2/p^3 = 4 pi^2/(#G m_a) ""
$
On retrouve ainsi la troisième lois de Kepler, #text(style: "italic")[i.e.] : \
le rapport du carré la période par le cube du demi grand axe est égale au rapport du le carré du périmètre du cercle unité par le produit de la constante de gravitation universel avec la masse de l'astre $A$ attracteur

===

```python
from math import cos, pi
from matplotlib.pyplot import show, plot

def I(x,N):
    res = 0
    for i in range(N):
        res += (1 / (1 + x  * cos(2 * pi * i / N))**2)
    return 2 * pi/N * res

precision = 10000
N = 10000

Y = [I(i/(2*N), precision) for i in range(N +1)]
X = [i/(2*N) for i in range(N+1)]

plot(X,Y)
show()
```
Avec N le nombre de points et precision la précisision de l'intégrale (ici calculé par la méthode de riemann)

#pagebreak()


#text(size: 16pt)[*I.C Mesure de l'unité astronomique*]

=== 
#canvas({
  import draw: *
  let r = 40mm
  //les planètes
  circle((), radius: r, name: "MS")
  circle("MS.center", radius: r/2.5, name: "MT")
  mark("MS.center", (0,0.1), symbol:"x")
  content("MS",(), $S$, anchor: "north")
  set-style(mark: (symbol: "barbed"))
  line("MS.-500deg", "MS.center", name: "a1")
  content("a1.mid", $a_0$, anchor: "north-west")
  line("MT.140deg", "MS.center", name: "a1")
  content("a1.mid", $a_1$, anchor: "north-east")

  set-style(mark:(symbol:none))
  circle("MT.east", radius: 5mm, fill:blue, name:"terre")
  content("terre.-90deg", "Terre", anchor: "north-west")
  line("terre.north", "MS.east", name: "l1")
  line("terre.south", "MS.east", name: "l2")
  set-style(mark: (symbol: "barbed"))
  line("terre.south", "terre.north", name: "l0", stroke: white)
  content("l0.mid", box(text($l$, fill: white), fill: blue, outset: 1pt))
  content("MS.east", "Mars", anchor: "west")

  set-style(mark:(symbol:none))
  line("MS.center", "MS.east", stroke: 0pt, name: "aide")
  arc-through("l2.70%", "aide.80%", "l1.70%", name: "alpha")
  content("aide.75%", text(size: 10pt,$alpha$))
})

===
On a par des considératin géométrique : $tan(alpha/2) = l/(2(a_1 - a_0)) $, or $tan(alpha/2) approx alpha/2$\
Donc $alpha approx l/(a_1 - a_0)$ donc $ a_1 = a_0 + l/alpha$\
\
Et par la 3ième loi de Kepler : $T_0^2/a_0^3 = T_1^2/a_1^3$\
Donc
$
  a_0 /T_0^(2/3) &= a_1 /T_1^(2/3) = 1/T_1^(2/3) (a_0 + l/alpha)\
  &Donc a_0(1/T_0^(2/3) -1 /T_1^(2/3)) = l/(alpha T_1^(2/3)) \
  &Donc a_0 = l/(alpha T_1^(2/3)) (T_1^(2/3)T_0^(2/3)) / (T_1^(2/3) -T_0^(2/3)) = (l)/(alpha) 1/((T_1/T_0)^(2/3) - 1)
$
On trouve également pour que $a_0 = 1 "a.u."$ : $(l)/(a_0 alpha) 1/((T_1/T_0)^(2/3) - 1) = 1$\

===
#undermath("AN :") $display(7.10^3/(1,5.10^11 times 6,8.10^(-5)) 1/((687/365)^(3/2) -1)) approx 1.33 > 1$

Donc la valeur est compatible a 33% près

#pagebreak()

#text(size: 18pt)[*II Structure et énergie des étoiles*]\
\
#text(size: 16pt)[*II.A L'énergie gravitationnelle*]

===