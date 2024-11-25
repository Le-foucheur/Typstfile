#import "../../../template.typ": *
#import "../../../transposition.typ": *
#import "@preview/drafting:0.2.0": *
#import "@preview/cetz:0.1.0": *

#show: template

Gaspar Daguet
#align(center, text(20pt)[Physique : DM6])

#set-page-properties()

= I Refroidir les centres de données, quelques solutions techniques contemporaines

=== 

La loi de Fourier : $arrow(dotless.j) = - lambda arrow(nabla) T(x)$

=== 

#canvas({
  import draw: *
  
  line((0,0), (7,0))
  line((0,2), (7,2))
  line((2,0), (2,2), stroke: blue, name: "x")
  line((5,0), (5,2), stroke: blue, name: "x+dx")
  content("x.start", v(4mm) + $x$)
  content("x+dx.start", v(4mm) + $x + dif x$)

  line((1.5,1), (2.5,1), stroke: red, name: "je", mark: (end: ">", stroke: red))
  line((4.5,1), (5.5,1), stroke: red, name: "js", mark: (end: ">", stroke: red))
  content("je.start",h(-3mm)+ v(-12mm) + $text(fill: #red, arrow(dotless.j)_Q)$)
  content("js.start",h(-3mm)+ v(-12mm) + $text(fill: #red, arrow(dotless.j)_Q)$)
  content("x+dx.start", v(-7mm) + h(4mm) +$text(fill: #blue, cal(S))$)
  
  line((3.5,0.5), (3.5,-0.5), stroke: red, name: "jch", mark: (end: ">", stroke: red))
  line((3.5,1.5), (3.5,2.5), stroke: red, name: "jcb", mark: (end: ">", stroke: red))
  content("jch.start",h(1.5cm)+ v(-3mm) + $text(fill: #red, arrow(dotless.j)_(C C))$)
  content("jcb.start",h(0mm)+ v(-3mm) + $text(fill: #red, arrow(dotless.j)_(C C))$)
})


Par le premier principe $dif U = delta Q$, Et comme :
$
  dif U & = 0 "car" T "ne dépend pas du temps"\
  et\
  delta Q &= j_Q (x,t) cal(S) dt - j_Q (x+dx, t) cal(S) dt - j_(C C)(x,t) times 2 pi a^2 dx dt\
     &= j_Q (x,t) cal(S) dt - j_Q (x+dx, t) cal(S) dt - h cal(S) (T(x) - T_a) dx dt 
$
D'où :
$
  j_Q (x,t) pi a^2 dt - j_Q (x+dx, t) pi a^2 dt - 2 pi a h (T(x) - T_a) dx dt = 0\
  Donc  -a (diff j_Q)/(ddx) = 2h T(x) - h T_a\
  "Or" j_Q = -lambda (dif T)/dx\
  Donc (dif^2 T)/dx^2 - 2h/(lambda a) T(x) = -2/(lambda a) T_a\
  undermath( (dif^2 T)/dx^2 - 1/delta^2 T(x) = -1/delta^2 T_a)
$
Avec $delta = sqrt((lambda a)/(2h))$

=== \

Par l'équation précédente on a que $[delta] = L$, or :\
$
  [delta] = [(lambda a)/h]^(1/2) = (W T L^(-1) L W^(-1) T^(-1) L^2)^(1/2) = L
$
#underline("AN :")\
$
  delta approx sqrt((148 times 1 . 10^(-3))/(2 times 30)) approx 1,6 "cm"
$
=== 

comme $T$ est continue et que $delta approx 1,6 "cm"$ : $T(0) = T_d et T(b) = T_a$

===

On a $T_h (x) = A e^(x/delta) + B e^(-x/delta)$ et $T_p (x) = T_a$\
D'où $T(x) = A e^(x/delta) + B e^(-x/delta) + T_a$\
Or par la question précédente :
$
  cases(A + B + T_a = T(0) = T_d, A e^(b/delta) + underbrace( e^(-b/delta), = 0 "car" b >> delta) = 0) <=> 
  cases(B = T_d - T_a, A = 0)
$
#undermath()[Donc $T(x) = (T_d - T_a)e^(-x/delta) + T_a$]\
ce qui correspond au graphe précédent

===
À partir d’un certain $b$, il existe un $c in [0; b]$ tel que toute la partie supérieure à $c$ soit à la température $T_a$, et donc ne participe en rien à la diffusion de la chaleur, d’où l’existence d’un $R_th$ limite

On a que, pour $cal(C)$la surface du cylindre :
$
  Phi &= integral.double_cal(C) arrow(dotless.j)_(C C) . arrow(dS)\
  &= h integral_0^b (T(x) - T_a) times 2 pi a dx\
  &= 2 pi a h integral_0^b (T_d - T_a) e^(-x/delta) dx \
  &= 2 pi a h delta (T_d - T_a) ( 1- e^(-b/delta))
$
Donc pour $b << delta$
$
  R_th &= (T_d - T_a)/Phi = 1/(2 pi a h delta (1 - e^(-b/delta)))\
  &approx  delta/(2 pi a h (1 − (1 − b/delta))) approx 1/(2pi a b h)\
  
$

===

D’après les calculs précédents

$
  R_th &= 1/(2 pi a h delta (1 - underbrace(e^(-b/delta), approx 0 ", pour" b >> delta)))\
  &approx  1/(2 pi a h delta)\
  
$

===

Les ailettes sont le plus efficace pour $b/delta approx 1$, donc pour $b approx delta approx 1,6 "cm"$
#AFL

===

$
  "énergie consommée :" 100/3 "kW" dot.c "h"\
  "cout :" 0,17 times 100/3 approx 5,67 "€" dot.c h^(-1) => 24 times 5,67 approx 136 "€/Jour"
$
===
Comme l’aire est un gaz parfait, alors : $P V = R n T$, de plus $n = m/M$\
D’où $V = (R m T)/(P M)$\
Ainsi :
$
  rho = m/V = cancel(m) dot.c (P M)/(R cancel(m) T) = (P M)/(R T)
$
Donc \
$
  D_m = rho D_v
$
#underline(stroke: red)[AN :] 
$
  rho approx (1.10^(5) times 2(0,3 times 16 + 0,7 times 14))/(8,3 times (35 + 273,15)) approx 1,2 "kg"dot.c "m"^(-1)\
  "Et"\
  D_m approx 1,2 times 830 approx 958,5 "kg" dot.c "h"^(-1) approx 0,266 "kg" dot.c "s"^(-1)
$

=== 
#AFL