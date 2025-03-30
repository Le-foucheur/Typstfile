#import "../../../template.typ": *
#import "../../../transposition.typ": *
#import "@preview/drafting:0.2.2": *
#import "@preview/cetz:0.3.2": *

#show: template

Jean Valjean
#align(center, text(20pt)[Physique : DM17])

#set-page-properties()

= Problème 1 : noyaux et images en dimension finie

== Généralités

=== \

Soit $k in NN$ et $x in Ker(f^k)$, alors
$
  f^k ( f (x)) = f^(k+1)(x) = f (f^k (x)) = f(0) = 0
$
Donc $f(x) in Ker(f^k)$, et #undermath[donc $Ker(f^k)$ est stable par $f$]\
\
Soit $x in ImE(f^k)$, alors\
$exists y in E, f^k (y) = x$ donc
$
  f(x) = f(f^k (y)) = f^(k+1)(y) = f^k (f(y)) in ImE(f^k)
$
Donc $f(x) in ImE(f^k)$, et #undermath[donc $ImE(f^k)$ est stable par $f$]\

===
Montrons par récurrence sur $k in NN$ que $ImE(f^(k+1)) subset ImE(f^k)$ et que $Ker(f^k) subset Ker(f^(k+1))$\
- Initialisation :
#align(center,
    grid(
    columns: 2,
    column-gutter: 3cm,
    [
      Pour #scr("K")er\
      Soit $x in Ker(f^0) = Ker(Id_E)$\
      alors $x = 0$ car $Id_E$ est bijective\
      Or $x = 0 in Ker(f)$\
      #undermath[Donc $Ker(f^0) subset Ker(f)$]\
    ],
    [
      Pour #scr("I")m\
      Soit $x in ImE(f)$\
      alors $x in E = ImE(Id_E)$ car $f$ endomorphisme\
      #undermath[Donc $ImE(f) subset ImE(f^0)$]\
    ]
  )
)
- Hérédité :
Soit $k in NN$ tel que $ImE(f^(k+1)) subset ImE(f^k)$ et $Ker(f^k) subset Ker(f^(k+1))$\
#align(center,
    grid(
    columns: 2,
    column-gutter: 3cm,
    [
      Pour #scr("K")er\
      Soit $x in Ker(f^k)$\
      alors
      $
        f^(k+1) (x) = f (f^(k+1) (x)) = f(0) = 0
      $
      Donc $x in Ker(f^(k+1))$\
      #undermath[Donc $Ker(f^k) subset Ker(f^(k+1))$]\
    ],
    [
      Pour #scr("I")m\
      Soit $x in ImE(f^(k+1))$\
      alors $exists y in E, f^(k+1) (y) = x$
      $
        Donc x = f^(k+1) (y) = f^k (f (y)) in ImE(f^k)
      $
      Donc $x in ImE(f^k)$\
      #undermath[Donc $ImE(f^(k+1)) subset ImE(f^k)$]\
    ]
  )
)
Donc par le principe de récurrence, on a\
$ImE(f^(k+1)) subset ImE(f^k)$ et $Ker(f^k) subset Ker(f^(k+1))$ pour tout $k in NN$\
\
=== \
