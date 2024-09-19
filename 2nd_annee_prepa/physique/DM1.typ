#import "/template.typ": *
#import "/transposition.typ": *
#import "@preview/drafting:0.2.0": *
#import "@preview/vartable:0.1.0": *
#import "@preview/cetz:0.2.2": *

Gaspar Daguet
#align(center, text(20pt)[Physique : DM1])
#set-page-properties()

= Un modèle simplifié de génératrice linéaire : le rail de Laplace \
\
== Présentation du système
=== \

Par la règle de la main droite, on a que le champs magnétique va renfoncer la force déjà présente mais celle-ci va être de plus en plus petite, donc notre tige métalique devrais accélérer de plus en plus jusqu’à atteindre une vitesse maximal.

=== \

On a : 
$
  ar(F_l) &= i arrow(M N) and arrow(B) = i #ve($0$,$l$,$0$) and #ve($0$,$0$,$B_e$) = i l B_e ar(ux)
$

=== \

#v(6cm)

== Étude temporelle \

=== \

Calculons d'abord le flux magnétique :
$
  Phi &= integral.double ar(B) ar(d S) "Or comme " ar(d S) = d S ar(uz) "et" ar(B) = B ar(uz)\
  &= integral.double B d S = B integral.double d S = B L x
$
Ainsi : 
$
  #undermath( $e = - (dif Phi)/(dif t) =  -B L dot(x)$)
$

=== \

Par la loi des mailles :
$e = R i$ ($i$)
 
=== \

Par #l2LN, ici projeté sur $ux$ car $ux$ est la seul com»osante, donc :\
$dot.double(x) = sum F_"ext"/m = F_l /m + F/m = i (L B)/m + F/m$ ($i i$)

=== \

Par ($i$), $i = - (B L)/R dot(x)$\
en réinjectant dans ($i i$)
$
  #undermath[$dot.double(x) + (B^2 L^2)/(m R) dot(x) = F/m #h(10pt) (i i i)$]
$

=== \

Par ($i i i$), on sait que $[dot.double(x)] = [(B^2 L^2)/(m R) dot(x)]$\
D’où 
$
  [(m R)/(B^2 L^2)] = [dot(x)/dot.double(x)] = m dot.c s^(-2) dot.c m^(-1) dot.c s = s^(-1)
$
#undermath[Donc $[(m R)/(B^2 L^2)] = s^(-1)$]

\
=== \

En résolvant ($i i i$), on trouve : On poseras $tau = (m R)/(B^2 L^2)$
$
  dot(x) = K e^(-t/tau) + (F R)/(B^2 L^2)
$
Or on sait que pour $t = 0, dot(x) = 0$, d’où $K = - (F R)/(B^2 L^2)$
D’où :
$
  #undermath[$dot(x)(t) = (F R)/(B^2 L^2) (1 - e^(-t/tau))$]
$
\
#canvas(
  {
    plot.plot(size:(15,7),
      name: "vit",
      axis-style:"left",
      y-tick-step:none,
      x-min:0,
      x-max:5,
      y-max:1.2,
      x-label:$ t $,
      y-label:$ dot(x)(t) $,
      x-format:x => $#{x} tau$,
      {
        plot.add(domain: (0, 10), x => 1 - calc.exp(-x))
        plot.add-anchor("tau",(1,0))
        plot.add-hline(1,style: (stroke:red + 0.7pt))
        plot.add-hline(0.63,style: (stroke:green + 0.7pt),max: 1)
      }
    )
    draw.line("vit.tau",((), "|-", (1,(1 - calc.exp(-1))*6-0.1)),name:"lt", stroke: green + 0.7pt)
    draw.content("lt.end","", anchor: "north",)
    draw.content((-0.5,6),$(F R)/(B^2 L^2)$)
    draw.content((-1,(1 - calc.exp(-1))*6-0.1),$0.63 (F R)/(B^2 L^2)$)
  }
)

#pagebreak()
== Bilan de puissance \

=== \

On a :
$
  cal(P)_l (ar(F_l)) = ar(F_l) dot.c ar(v) = i L B dot(x)
$

#undermath[Ainsi $cal(P)_l (ar(F_l)) = i L B dot(x)$]\


=== \

Par effet joule on a : $cal(P)_J = R i^2$, or par la question 7 : $i = -(B L)/R dot(x) <=> R = - (B L) / i dot(x)$, d’où :
$
  undermath(cal(P)_J = R i^2 = - B L i dot(x) = - cal(P)_l)
$
On a donc que la puissance gagnée par la force de Laplace est dissipée par effet joule

=== \

On a : $cal(P)_op = cal(P)(ar(F)) = ar(F) dot.c ar(v) = F dot(x)$

=== \

En multipliant $(i i i)$ par $dot(x)$, on trouve :
$
  dif/(dif t)(1/2 m dot(x)^2) + (B^2 L^2)/R dot(x)^2 &= F dot(x) "Or" R = -(B L)/i dot(x)\
  underbrace(dif/(dif t)(1/2 m dot(x)^2),"puissance gagnée par\n l'énergie cinétique") - underbrace(B L i dot(x), "puissance dissipée \n par effet joule") &= underbrace(F dot(x), "puissance fournie par\n l'opérateur")\
$