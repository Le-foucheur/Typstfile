#import "/template.typ": *
#import "/transposition.typ": *
#import "@preview/drafting:0.2.0": *
#import "@preview/vartable:0.1.0": *
#import "@preview/cetz:0.2.2": *

#show: template

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
F_l &= i arrow(M N) and arrow(B) = i #ve($0$,$l$,$0$) and #ve($0$,$0$,$B_e$) = i l B_e
$

=== \

#LAF

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

Par #l2LN : $dot.double(x) = sum F_"ext"/m = F_l /m + F/m = i (L B)/m + F/m$ ($i i$)

=== \

Par ($i$), $i = - (B L)/R dot(x)$\
en réinjectant dans ($i i$)
$
  #undermath[$dot.double(x) + (B^2 L^2)/(m R) dot(x) = F/m #h(10pt) (i i i)$]
$

#pagebreak()
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
        plot.add-hline(1,style: (stroke:red + 0.7pt))
      }
    )
  }
)