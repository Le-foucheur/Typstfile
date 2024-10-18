#import "../../../template.typ": *
#import "../../../transposition.typ": *
#import "@preview/drafting:0.2.0": *
#import "@preview/cetz:0.2.2": *

#show math.equation : mat => math.display(mat)

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

#pagebreak()

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

===

Si $e = 0$, alors la trajectoire est circulaire, et 
$
  cal(I) &= integral_0^(2 pi)dif theta = 2pi\
  &Donc T = 2 pi p^(3/2)/sqrt(#G m_a)\
  &Donc T^2/p^3 = 4 pi^2/(#G m_a) ""
$
On retrouve ainsi la troisième lois de Kepler, #text(style: "italic")[i.e.] : \
le rapport du carré la période par le cube du demi grand axe est égale au rapport du le carré du périmètre du cercle unité par le produit de la constante de gravitation universel avec la masse de l'astre $A$ attracteur

#pagebreak()

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
#pagebreak()
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

#text(size: 18pt)[*II Structure et énergie des étoiles*]\
\
#text(size: 16pt)[*II.A L'énergie gravitationnelle*]

===

On a $W_g = -W(ar(F)) < 0$ car la force est opposée au déplacement

===
On a $rho = M/(4/3 pi R^3) = (3M)/(4 pi R^3)$\
Et donc $m = rho . 4/3 pi r^3 = M (r/R)^3$\
Et $dif m$ correspond à la masse de la sphère d'épaisseur $dif r$\
Donc 
$
dif m &= rho . 4/3 pi (r + dif r)^3  - m = M(r/R)^3(1+ (dif r)/r)^3 - m\
dif m & = m(cancel(1)+3 (dif r)/r) - cancel(m) = 3m (dif r)/r
$

===
Comme $W = -W_g = - Delta E_p donc dif W_g = dif E_p$\
\
Or $ar(F) = - ar(nabla) . E_p = ve((diff E_p) / (diff r), 1/r (diff E_p)/ (diff theta), 1 / (r sin theta) (diff E_p)/(diff phi)) = ve( - #G (m dif m) / r^2, 0, 0) $\
\
Donc $E_p = #G (m dif m)/r$
Ainsi la variation de $E_p$ entre $r et +oo$ vaut : $dif E_p = -#G (m dif m)/r$\
\
Donc $W_g =  - #G (m dif m)/r$\
Et donc
$
  dif W_g = -3#G m^2 (dif r)/r = -3 M^2 (r/R)^6 (dif r)/r^2 = -3 M^2 r^4/R^6 dif r 
$
Et donc en intégrant :
$
  W_g = - 3/5 #G M^2 R^5/R^6 = -3/5 #G M^2/R
$

#text(size: 16pt)[*II.B Pression cinétique*]

===
Sur ce volume il y a le poid et les forces de préssion qui s'exerce\
Ainsi en prenand $z_1 = z et z_2 = z + dif z$\
Donc comme le système est à l'équilibre :
$
  P(z)S - P(z + dif z) S - rho(z) S dif z G(z) = 0\
  Donc (diff P)/(diff z) - rho G = 0
  Donc (diff P)/(diff z) = rho G
$

===
Dans le modèle des gaz parfaits

===
Par le théorème de Gauss, on obtient : $ar(G) = - #G rho 4/3 pi r^3 hat(Ur) = - #G M r/R^3$\
par la question 16 :
$
  (diff P)/(diff r) = -rho #G M r/R^3 = - 3/(4pi) (#G M)/R^3 M r/R^3 =  - 3/(4pi)  (#G M^2)/R^6 r\
  Donc P(r) =  - 3/(8pi)  (#G M^2)/R^6 r^2 + K "avec K une constante"
$
On sait que $P(R) = 0$ donc $K =  3/(8pi)  (#G M^2)/R^6 R^2 $,\
D'où 
$
  P(r) = 3/(8pi)  M^2/R^6 (R^2 - r^2)
$ 

===
Par la question précédente $P(r) = 3/(8pi)  (#G M^2)/R^6 (R^2 - r^2)$ et on a $dif V = 4 pi r^2 dif r$\
Donc 
$
  dif E_c = P dif V = 9/(4)  (#G M^2)/R^6 (R^2 - r^2) r^2\
  donc E_c = 9/(4)  (#G M^2)/R^6 underbrace(integral_0^R (R^2 - r^2)r^2 dif r, = 2/5 R^2) = 3/10 (#G M^2)/R
$
On retrouve $W_g$ : $E_c = - W_g/2$ et donc que $E_c et |W_g|$ sont de même ordre de grandeur