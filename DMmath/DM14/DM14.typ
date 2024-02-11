#import "/template.typ": *

#set heading(
  numbering: (..numbers) => {
    let n = numbers.pos().len();
    if n == 1 { question.update(0); } else if n == 2 { [Partie ]; numbering("I", numbers.pos().at(1)) ;"." } else if n == 3 { [N=°];question.step(); question.display();"." } else if n == 4 { numbering("a.", numbers.pos().at(3) + 1) } else if n == 5 { numbering("i.", numbers.pos().at(4)) }
  },
)
#set underline(stroke: red + 1pt)
#set par(leading: 10pt)

Gaspar Daguet
#align(center, text(20pt)[Maths : DM 14])

= Problème : polynômes de Tchebychev et théorème de Block-Thielman

== Polynômes de Tchebychev (de première espèce) \

=== \
$ T_2 = 2X T_1 - T_0 = 2X times X -1 = 2X^2 -1\
T_3 = 2X T_2 - T_1 = 2X(2X^2-1) -X = 4X^3 - 3X \
T_4 = 2X T_3 - T_2 = 2X(4X^3-3X) - 2X^2 +1 = 8X^4 - 8X^2 +1 $

#t(1) #undermath[Ainsi on trouve que: $T_2 = 2X^2 -1, T_3 = 4X^3 - 3X et T_4 = 8X^4 - 8X^2 +1$ ]

=== \
#t(1) Prouvons par une récurrence double que $forall n in NN^*, deg T_n = n$\
- *Initialisation:*\
#t(1) Pour $n = 1$, $deg T_1 = deg X = 1 = n et 2^(1-1) = 1$ qui est bien le coefficent dominant\
#t(1) Pour $n=2$, $deg T_2 = deg 2X^2 -1 = 2 = n et 2^(2-1) = 2$ qui est bien le coefficent dominant \
#t(1) Donc l'Iiitialisation est vérifié
- *Hérédité:*\
$ deg T_(n+2) =  deg (2X T_(n+1) - T_n) &= max(deg(2X)+deg(T_(n+1)), deg(T_n))\ &= max(1 + n+1 , n) = n+2 $
#t(1) Donc l'hérédité est vérifié \
\
#t(1) #undermath[Donc par le principe de récurrence double et comme $deg T_0 = deg 1 = 0$, on a $forall n in NN, deg T_n = n$] \
\
#t(1) Soit $n in NN$\
#t(1) alors on a:
$T_(n+2) = 2X T_(n+1) - T_n$ Or on vient de montrer que le degré de $T_(n+1)$ est plus grand\
#t(1) que celuis de $T_n$\ 
#t(1) donc seul $T_(n+1)$ contribue au coefficent dominant.\
#t(1) Ainsi en répétant cette opération, il vient que 
$ T_(n+2) = underbrace(2X(2X(2X(2X(dots.h.c(2X(X(1))))))), n "fois") = 2^(n-1)X^n $
#t(1) #undermath[Donc le coefficent dominant est $2^(n-1)$]

#pagebreak()
=== \
#t(1) #soitn($theta$, $RR$)\
#t(1) #soitn($n$, $NN$)\

#let cost = $cos(theta)$
$ cos((n+2)theta) &= cos((n+1) theta + theta)\
&= cos((n+1) theta)cos(theta) - sin((n+1) theta) sin(theta) $\
#t(1) donc
$cos((n+1) theta)cos(theta) - cos((n+2) theta) &= sin((n+1) theta)sin(theta)
$\
#t(1) et
$
cos(n theta) &= cos((n+1)theta - theta)\
&= cos((n+1)theta)cos(theta) +sin((n+1)theta)sin(theta)\
$
#t(1) donc
$cos(n theta) - cos((n+1)theta)cos(theta) &= sin((n+1)theta)sin(theta)$

#t(1) Ainsi $cos((n+1) theta)cos(theta) - cos((n+2) theta) &= cos(n theta) - cos((n+1)theta)cos(theta)$\
#t(1) #undermath[donc $cos((n+2)theta) &=2 cos((n+1) theta)cos(theta) - cos(n theta)$]\
\
#t(1) Prouvons par récurrence double que $forall n in NN, T_n (cost) = cos(n theta)$\
- *Initialisation:*
#t(1) Pour $n=0$, $T_0 (cost) = 1 = cos( 0 theta)$\
#t(1) Pour $n=1$, $T_1 (cost) = cost = cost( 1 times theta)$
#t(1) Donc l'Iiitialisation est vérifié
- *Hérédité:*
$ T_(n+2) (cost) &= 2cost T_(n+1) (cost) - T_n (cost)\
&= 2cost cos((n+1) theta) - cos(n theta)
&= cos((n+2) theta) $
#t(1) Donc l'hérédité est vérifié \

#t(1) #undermath[Donc par le principe de récurrence double $forall theta in RR, forall n in NN, T_n (cost) = cos(n theta)$]\
\
#t(1) Ainsi #soitn($theta$, $RR$) \
$ #undermath[$cos(4 theta) = T_4 (cost) = 8cos^4 (theta) - 8 cos^2 (theta) +1$] $

=== \
#t(1) On a, pour $theta in RR$
$ (T_n compose T_m)(cos(theta)) = T_n (cos(m theta)) = cos(n m theta)  =T_(m n)(cost) $
#t(1) Or $cost$ est dans $[-1;1]$\
#t(1) donc le polynôme $T_n compose T_m - T_(m n)$ s'annule une infinité de fois sur $[-1;1]$\
#t(1) donc $T_n compose T_m - T_(m n) = 0$\
#t(1) #undermath[Donc $T_n compose T_m = T_(m n)$]\
#pagebreak()
== Le théorème de Block et Thielman\

=== \