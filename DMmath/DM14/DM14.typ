#import "/template.typ": *

#set heading(
  numbering: (..numbers) => {
    let n = numbers.pos().len();
    if n == 1 { question.update(0); } else if n == 2 { [Partie ]; numbering("I", numbers.pos().at(1)) ;"." } else if n == 3 { [N=°];question.step(); question.display();"." } else if n == 4 { numbering("a.", numbers.pos().at(3) + 1) } else if n == 5 { numbering("i.", numbers.pos().at(4)) }
  },
)
#set underline(stroke: red + 1pt)
#set par(leading: 0.7em)
#set page(numbering: "1/1", number-align: right)

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
#t(1) #soietn($m,n$, $NN^*$)\
#t(1) Alors
$ X^n compose X^m =(X^m)^n = X^(m n) = (X^n)^m = X^m compose X^n $
#t(1) et 
$ T_n compose T_m = T_(n m) = T_(m n) = T_m compose T_n $
#t(1) De plus \
$ deg X^n = n $
#t(1) et on a déjà montré que $deg T_n = n$\
#t(1) #undermath[Ainsi $(X^n)_(n in NN^*) et (T_n)_(n in NN^*)$ sont comutante ]

=== a.\
#t(1) #soitn($P$, $calC_p$) et #soietn($a,p$, $RR$), le coefficent dominant de $P$\
#t(1) Alors $P$ doit vérifier: $P compose (X^2+p) = (X^2+1)compose P$\
#t(1) Or le coefficent dominant de $P compose (X^2+p)$ est $a$\
#t(1) et celuis de $(X^2+1)compose P$ est $a^2$ \
#t(1) Donc $a^2 = a <=> a = 1 #underline("ou", stroke: black) a = 0$\
#t(1) Or si $a = 0$ alors $a$ n'est pas le coefficent dominant de $P$, \
#t(1) ce qui est impossible par définition de $a$\
#t(1) #undermath[Donc $a =1$]

==== \
#t(1) Supposons par l'absurde que $P_1 != P_2$\
#t(1) Tout d'abord on a, 
$ P_1 compose (X^2+p) - P_2 (X^2 + p) = (P_1 - P_2) compose (X^2 +p) $
#t(1) De plus 
$ P_1 compose (X^2+p) - P_2 (X^2 + p) &= (X^2+p) compose P_1 - (X^2+p) compose P_2 \
&= P_1^2+p - P_2^2 - p = P_1^2 -P_2^2 $ 
#t(1) Ainsi $(P_1 - P_2) compose (X^2 +p) = P_1^2 - P_2^2$\
#t(1) Sauf que $P_1 et P_2$ sont tout deux unitaire par la question précédente\
#t(1) et de même degrés donc $deg(P_1 - P_2) = beta.alt in [|1;n-1|]$\
#t(1) Ainsi:
$ deg((P_1 - P_2) compose (X^2 +p)) = deg(P_1^2 - P_2^2) &= deg((P_1 + P_2)(P_1 - P_2)) $
#t(1) Donc:
$ 2 beta.alt = n + beta.alt $
#pagebreak()
#t(1) Donc:
$ beta.alt = n $ 
#t(1) #undermath[Ce qui est absurde, donc $P_1 = P_2$]

==== \
#t(1) Si $calC_p$ contient un polynôme de degré 3, alors soit $P = X^3 + a X^2 + b X + c $ un telle polynôme.\
#t(1) Alors 
$ P compose (X^2+p) &= (X^2+p)^3 + a (X^2+p)^2 + b (X^2+p) + c \
&= X^6 +(3p+a) X^4 + (3p^2 + 2a p + b) X^2 + p^3 + a p^2 + b p+c $
#t(1) et 
$ (X^2 + p) compose P &= (X^3 + a X^2 + b X + c)^2 + p\
&= X^6 + 2a X^5 + (a^2 + 2b)X^4 + 2( a b+c )X^3 + (b^2 +2a c )X^2 + 2b c X + c^2 + p $
#t(1) Il en vient donc:
$ cases(2a = 0, a^2 + 2b = 3p + a, 2(a b+c) = 0, b^2 + 2a c = (3p^2 + 2a p+ b), 
2 b c = 0, c^2 + p = p^3 + a p^2 + b p + c) <=> 
cases(a=0, 3 p = 2b, c = 0,b^2 = 3 p^2 + b  , p^3 + 3/2p^2 = p) <=> 
cases(a=0,c=0, , 12 p^2 - 9p^2 + 6 p = 3p(p +2),
p(2p^2+3p-2)=p(p - 1/2)(p+2)) $
#t(1) #undermath[Donc les deux dernière lignes du système nous donne que $p = 0 #underline(stroke: black)[ou] p =-2$]

==== \
#t(1) #soitn($X^n$, $RR_n [X]$)\
#t(1) Alors
$ X^n compose X^2 = (X^2)^n = X^(2n) = (X^n)^2 = X^2 compose X^n $
#t(1) Donc $X^n in calC_0 $\
#t(1) Donc ${X^n, n in NN^*} subset calC_0$\
#t(1) Or on a montré à la question *6.b* que si il y avais un polynôme de degré $n$ dans $calC$\
#t(1) alors il est le seul de ce degré \
#t(1) #undermath[Ainsi ${X^n, n in NN^*} = calC_0$]


=== a\

#t(1) #soietn($U,P$, $RR[X]$) de degrés respectif $n et m$ tel que $U compose P = P compose U = X$\
#t(1) Alors $deg(U compose P) = deg(P compose U) = deg X <=> m n = n m = 1 <=> m = n = 1$ car $n, m in NN$\
#t(1) #undermath[Donc $U$ est inversible #ssi $deg U = 1$]

==== \
#t(1) Soit $U = a X+b in RR[X]$, vérifions que $P =1/a X - b/a $ est bien l'inverse de $U$\
#t(1) Alors \
$ U compose P = a P +b = X = a (X-b)/a + b = X-b + b = X $
#t(1) Et 
$ P compose U = ((a X + b) - b)/a = (a X)/a = X $
#t(1) Donc $P = U^(-1) = 1/a X - b/a$

=== \

#t(1) #soietn($n, m$, $NN^*$)\
#t(1) Alors, on a 
$ deg(U compose P_n compose U^(-1)) = 1 times n times 1 = n $
#t(1) Et
$ (U compose P_n compose U^(-1)) compose (U compose P_m compose U^(-1) ) &= U compose P_n compose U^(-1) compose U compose P_m compose U^(-1)\
&= U compose P_n compose P_m compose U^(-1) = U compose P_m compose P_n compose U^(-1)\
&= U compose P_m compose U^(-1) compose U compose P_n compose U^(-1) = (U compose P_m compose U^(-1)) compose (U compose P_n compose U^(-1)) $
#t(1) #undermath[Donc $(U compose P_n compose U^(-1))_(n in NN^*)$ est une suite commutante]

=== \
#t(1) On a selon la question *7.b*, $U^(-1) = 1/a X -b/(2a) $\
#t(1) Donc 
$ U compose P compose U^(-1) &= U(P(U^(-1))) = U(P(1/a X - b/(2a)))\
&= U(a(1/a X - b/(2a))^2+b(1/a X - b/(2a))+c)\
&= U(1/a X^2 -cancel(stroke: #red, b/a X) + cancel(stroke: #red,b^2/(2a)) + cancel(stroke: #red,b/a X ) -cancel(stroke: #red,  b^2/(2a)) + c)\
&= U(1/a X^2 + c)\
&= a(1/a X^2+ c) + b/2 = X^2 + underbrace(a c +b/2, = p)
$
#t(1) #undermath[Donc $U compose P compose U^(-1) = X^2 + p$ avec $p = a c + b/2$]

#pagebreak()
=== \
#t(1) Montrons que $V = 1/2 X in RR[X]$ est un tel polynôme \
#t(1) Soit $V$ un tel polynôme, alors:
$ V compose (X^2 -2) compose V^(-1) = 1/2((2X)^2 - 2) = 1/2 (4X^2 - 2) = 2X^2 - 1 = T_2 $
#t(1) #undermath[Donc $V$ est un tel polynôme]

=== \
#str.from-unicode(0x16A1)