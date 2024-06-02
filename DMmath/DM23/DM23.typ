#import "/template.typ": *
#import "/transposition.typ": *
#import "@preview/drafting:0.2.0": *
#import "/tabvar.typ": *

#set heading(numbering: (..numbers) => {
  let n = numbers.pos().len()
  if n == 1 {
    question.update(1)
  } else if n == 2 {
    [Partie ]
    numbering("I", numbers.pos().at(1) - 1)
    "."
  } else if n == 3 {
    question.step()
    if question.get().last() < 10 {
      margin-note(side: left, dy: -16.4pt, stroke: none)[#h(14pt)N=° #question.display().]
    } else {
      margin-note(side: left, dy: -16.4pt, stroke: none)[#h(8pt)N=° #question.display().]
    }
  } else if n == 4 {
    margin-note(side: left, dy: -16.5pt, stroke: none)[#h(34pt)#numbering("a.", numbers.pos().at(3) + 1) ]
  } else if n == 5 {
    numbering("i.", numbers.pos().at(4))
  }
})
#set underline(stroke: red + 1pt)
#set par(leading: 0.8em)
#set page(numbering: (..nums) => nums.pos().map(na).join("/"), number-align: right)
#set math.cancel(stroke: red)

Gaspar Daguet
#align(center, text(20pt)[Maths : DM 21])
#set-page-properties()

= Problème 2 : une construction rigoureuse des fonctions trigonométriques

=== \
Soit $z in CC$ et $N in NN$ alors
$
  sum_(n=0)^(N) abs(z^n/n!) = sum_(n=0)^(N) abs(z)^n / n! tend(N,+oo) e^abs(z)
$
Donc $sum z^n/n!$ converge absolument

== Un théorème de dérivation terme à terme\

=== \
Soit $z in ZZ$, alors
$
  abs(a_(n+1) z^(n+1)) / abs(a_n z^n) =abs(z) o(r^(n+1) / r^n) =abs(z) o(r) = o(1) tend(n,+oo) 0 < 1
$
Donc la série de terme générale $a_n z^n$ converge absolument

=== \
Soit $r,r’ in RR_+^* tq 0 <r’<r$, alors $(r’)/r < 1$\
Donc $n((r’)/r)^n = n o(1/n) = o(1)$\
\
Donc $display((r’^n)/(r^n 1/n) tend(n,+oo) 0)$ et donc $r’^n = o(r^n/n)$ \
Et comme $a_n = o(r’^n) = o(r^n/n)$\
#undermath[Donc $n a_n = o(r^n)$]

=== \
Comme $forall r in RR_+^*,n a_n = o(r^n)$, alors par la question 2. $display(forall z in CC\, sum_(n>=0) n a_n z^n)$ converge absolument\
Donc en particulier pour $x in RR$ et $N in NN^*$, $ sum_(n=1)^(N) n a_n x^(n-1) = 1/x sum_(n=1)^(N) n a_n x^n "converge absolument" $ \
De plus pour $N in NN$:
$
  sum_(n=1)^(N) abs(n(n-1)a_n x^(n-2)) <= sum_(n=1)^(N) abs(n^2a_n x^(n-2)) - sum_(n=1)^(N) abs(n a_n x^(n-2))
$
On a montré juste avant que $display(sum_(n=1)^(N) abs(n a_n x^(n-2)))$ converge absolument\
Et comme $forall r in RR^*_+,n a_n = o(r^n)$, alors par la série précédente \
$display(sum_(n=1)^(N) abs(n(n a_n) x^(n-2)))$ converge absolument\
#undermath[Ainsi $display(display(sum_(n=1)^(N))) n(n-1)a_n x^(n-2)$ converge absolument]\
\
=== #h(-15pt) a.\
Soit $n in NN$ et $h in ]-1;1[$, alors\
Soit $f : x |-> (x + h)^n$, donc $forall x in RR, f’(x) = n(x + h)^(n-1) $ et $x_0 - h <= abs(x_0) +1$ \
Alors par l’inégalité de Taylor-Lagrange avec $a = x_0 - h et b = x_0$:
$
  abs(f(x_0) -f(x_0 - h) - f’(x_0 - h) ) <= h^2 / 2 n(n-1)(abs(x_0)+1)^(n-2)\
  <=> abs((x_0 + h)^n -x_0^n - h n x_0^(n-1)  ) <= h^2 / 2 n(n-1)(abs(x_0)+1)^(n-2)
$

==== \

$
  sum_(n=0)^(+oo) abs((x_0 + h)^n -x_0^n - h n x_0^(n-1)  ) <= abs(f(x_0+h) - f(x_0) - h sum_(n=0)^(+oo) n a_n x_0^(n-1)) <= h^2 / 2 sum_(n=0)^(+oo) n(
    n-1
  )(abs(x_0)+1)^(n-2)\
  <=> abs(f(x_0+h) - f(x_0) - h sum_(n=1)^(+oo) n a_n x_0^(n-1)) <= h^2 / 2 sum_(n=2)^(+oo) n(n-1)(abs(x_0)+1)^(n-2)
$

==== \

Pour $h != 0$, alors par la question précédente
$
  &#h(16pt)abs(f(x_0 + h) - f(x_0) - h display(sum_(n=1)^(+oo)n a_n x_0^(n-1)) )/abs(h) <= h^2/(2abs(h)) sum_(n=2)^(+oo) abs(a_n)n(n-1)(abs(x_0)+1)^(n-2)\
&<=> 0<=abs(underbrace((f(x_0 + h) - f(x_0))/h, tend(h, 0) f'(x_0)) - sum_(n=1)^(+oo)n a_n x_0^(n-1)) <= underbrace(abs(h)/2 sum_(n=2)^(+oo) abs(a_n)n(n-1)(abs(x_0)+1)^(n-2), tend(h, 0) 0)
$
Donc par théorème des gendarmes $f'(x_0) = display(sum_(n=1)^(+oo))n a_n x_0^(n-1)$

=== #h(-16pt) a. \
On a pour spécialement pour tout $n,k in NN$
$
  binom(n,k) = n! / (k!(n-k)!) = (n times (n-1) times dots.c times (n-k+2) times (n-k+1)) / (k!) equi() n^k / k!
$
Soit $r,r' in RR^*_+, tq 0 <r <r'$\
donc $n^k (r'/r)^n po(ele: n, vers: +oo) n^k o(1/n^k) po(ele: n, vers: +oo) o(1)$\
Donc $r'^n po(ele: n, vers: +oo) o(r^n/n^k)$
Donc $n^k a_n = o(r^n)$\
Ainsi $a_n binom(n,k) po(ele: n, vers: +oo) o(r^n)$

#pagebreak()
==== \
Prouvons par récurance $P(k):f "est" #C^k et forall x in RR f^((k))(x) = display(sum_(n=k)^(+oo))k! binom(n,k) a_n x^(n-k) $
- *Initialisation :*
Pour $k = 0$ : \
On a prouvé à la question précédente que $f$ est dérivable, donc $f "de classe" #C$\
et $forall x in RR, f^((0))(x) = display(sum_(n=0)^(+oo)0! binom(n,0)a_n x^(n-0) ) = display(sum_(n=0)^(+oo)0! binom(n,0)a_n x^(n-0) ) = f(x)$

- *Hérédité :*
Soit $k in NN tq P(k)$ soit vérifiée\
Soit $x in RR$, alors
$
  f^((k+1))(x) &=(f^((k)))'(x) = sum_(n = k+1)^(+oo)k! (n-k)binom(n,k) a_n x^(n-k-1) \
  &=sum_(n = k+1)^(+oo)(k+1) / (k+1) k!(n-k) n! / (k!(n-k)!) a_n x^(n-(k+1))\
  &= sum_(n = k+1)^(+oo) (k+1)! n! / ((k+1)!(n-(k+1))!)a_n x^(n-(k+1)) = sum_(n = k+1)^(+oo) (
    k+1
  )! binom(n,k+1) a_n x^(n-(k+1))
$
Ainsi par principe de récurance simple $P(k)$ est vraie pour tout $k in NN$\
Donc comme $f$ est dérivable autemps de fois que l'on veux elle est $#C^(+oo)$

== produit de Cauchy de deux séries absolument convergentes \

=== #h(-16pt) a. \

Soit $n in NN$
$
  C_n = sum_(k=0)^(n) c_k = sum_(k=0)^(n) sum_(0<=p,q<=k\ p+q = k) a_p b_q =sum_(k=0)^(n) sum_(0<=p,q<=n\ p+q = k) a_p b_q = sum_(0<=p,q<=n\ p+q = n) a_p b_q
$
De plus $C_n = display(sum_(0<=p,q<=n \ p+q = n) a_p b_q ) <= display(sum_(0<=p,q<=n ) a_p b_q ) = A_n B_n$\
Car la somme $C_n$ comporte moins de terms à sommer car on viens sommer sur les même indices que $A_n B_n$ mais avec une condition en plus sur les indices

==== \
$C_n >=0$ car somme de de termes positifs, Ainsi
$0<= C_n <= A_n B_n tend(n,+oo) A B$\
Donc par téhorème des gendarmes $C$ converge\

==== \
Soit $n in NN$\

Donc $A_n B_n <= C_(2n)$\
Donc pour $n$ paire, $A_(n/2) B_(n/2) <= C_n$, prenons donc $n$ paire pour la fin de cette exercice\
Ainsi par la question 7.a. $underbrace(A_(n/2) B_(n/2), tend(n, +oo) A B) <= C_n <= underbrace(A_n B_n, tend(n, +oo) A B)$\
Donc par le théorème des gendarmes $C_n tend(n, +oo) A B$

=== #h(-16pt) a.\

==== \
Soit $n in NN$,\
D'après la question précédente on à : $0 <= display(sum_(k=0)^(n) abs(c_k)) <= (display(sum_(n=0)^(+oo)abs(a_k)))(display(sum_(k=0)^(+oo)abs(b_k)))$\
Or comme $display(sum_(n=0)^(+oo)abs(a_k))$ et $display(sum_(k=0)^(+oo)abs(b_k))$ converge car $sum a_n et sum b_n$ sont absolument convergentes\
Donc par théorème des gendarmes $sum c_n$ converge absolument

=== \

Soit $(a,b) in CC^2$, \
Comme $display(sum_(n=0)^(+oo)) a^n/n! $ vaut $e^a$, de même pour $display(sum_(n=0)^(+oo)) b^n/n!  = e^b$,\

Alors par tout ce qui à étais fais avant $(display(sum_(n=0)^(+oo)) a^n/n!)(display(sum_(n=0)^(+oo)) b^n/n!)$ converge et vaut:
$
  e^a e^b = (display(sum_(n=0)^(+oo)) a^n / n!)(
    display(sum_(n=0)^(+oo)) b^n / n!
  ) &= sum_(n=0)^(+oo)sum_(k=0)^(n)a^k / k! b^(n-k) / (n-k!) \
  &=sum_(n=0)^(+oo)1 / n!sum_(k=0)^(n) n! / (k!(n-k)!) a^k b^(n-k)\
  &= sum_(n=0)^(+oo) 1 / n! sum_(k=0)^(n) binom(n,k)a^k b^(n-k)\
  &= sum_(n=0)^(+oo) (a+b)^k / n! = e^(a+b)
$#QED

#pagebreak()

== Fonctions trigonométriques\
\
=== \
Soit $t in RR$
$
  (e^(i t)+ e^(-i t)) / 2 &= (sum_(n=0)^(+oo) (i t)^n / n! + sum_(n=0)^(+oo)(-1)^n (
    i t
  )^n / n!) / 2 = 1 / 2sum_(n=0)^(+oo) (i t)^n / n! overbrace((1+(-1)^n), =0" si n impaire"\ "2 sinon")\
  &= 1 / 2 sum_(n=0\ n "paire")^(+oo) 2i^n t^n / n! = sum_(n=0)^(+oo)i^(2n) t^(2n) / (2n)! = sum_(n=0)^(+oo) (
    -1
  )^n t^(2n) / (2n)! = c(t)
$
Et
$
  (e^(i t)- e^(-i t)) / (2i) &= (sum_(n=0)^(+oo) (i t)^n / n! - sum_(n=0)^(+oo)(-1)^n (
    i t
  )^n / n!) / (2i) = 1 / (2i)sum_(n=0)^(+oo) (i t)^n / n! overbrace((1-(-1)^n), =0" si n paire"\ "2 sinon")\
  &= 1 / (2) sum_(n=0\ n "impaire")^(+oo) 2i^(n-1) t^n / n! = sum_(n=0)^(+oo)i^(2n) t^(2n+1) / (
    2n+1
  )! = sum_(n=0)^(+oo) (-1)^n t^(2n+1) / (2n+1)! = s(t)
$ #QED

=== \
#let s(t) = $(e^(i #t)- e^(-i #t)) / (2i)$
#let c(t) = $(e^(i #t)+ e^(-i #t)) / (2)$
Soient $(a,b) in RR^2$
$
  s(a)c(b) + c(a)s(b) &= #s("a")#c("b") + #c("a") #s("b")\
&= 1/(4i)(e^(i a + i b) + cancel(e^(i a- i b)) - cancel(e^(i b - i a)) -  e^(-i a -i b)+ e^(i a + i b) - cancel(e^(i a- i b)) + cancel(e^(i b - i a)) - e^(-i a -i b))\
&= 1/(4i) (2 e^(i(a+b)) - 2 e^(-i(a+b))) = #s($a+b$) = s(a+b)
$
Et
$
  c(a)c(b) - s(a)s(b) &= #c("a")#c("b") - #s("a") #s("b")\
&= 1/(4)(e^(i(a+b)) + cancel(e^(i(a-b))) + cancel(e^(i(b-a))) + e^(-i(a+b)) +e^(i(a+b)) - cancel(e^(i(a-b))) - cancel(e^(i(b-a))) + e^(-i(a+b)))\
&= 1/4(2e^(i(a+b))+2e^(-i(a+b))) = #c($(a+b)$) = c(a+b)
$
#QED

=== \
Comme on l'a justifié dans la partie I, on a que $forall x in RR, forall a in CC, x |->e^(a x)$ est dérivable, de dérivée:\
$
  forall x in RR, x |-> sum_(n=1)^(+oo) a^(n)(x)^(n-1) / (n-1)! = a sum_(n=0)^(+oo) (a x)^(n) / n! = a e^(a x)
$

Soit $ t in RR$
$
  s'(t) = (i e^(i t) + i e^(- i t))/(2i) = #c($t$) = c(t)
$
Et
$
  c'(t) = (i e^(i t) - i e^(-i t))/2 = - #s($t$) = -s(t)
$#QED

=== \
Soit $t in RR$
$
  c(t)^2 + s(t)^2 &= (#c($t$))^2 + (#s($t$))^2\ &= 1 / 4 (
    cancel(e^(2i t)) +2+ cancel(e^(-2i t)) - cancel(e^(2i t))+ 2 - cancel(e^(-2i t))
  ) = 4 / 4 = 1
$
#undermath[Donc $c(t)^2 + s(t)^2 = 1$]
#QED\
Ainsi $c(t)^2 = 1- s(t)^2 <= 1$\
Donc $abs(c(t)) <=1$\
De même pour $s(t)$\
$s(t)^2 = 1- c(t)^2 <= 1$\
Donc $abs(s(t)) <=1$\
#undermath[Ainsi $s et c$ sont bornée entre $[-1;1]$]

=== #a\
On a prouvé à la question 12. que $s' = c$ \
Or $c(0) = (e^0+ e^0)/2 = 2/2 = 1 > 0$ \
et comme on a suppossé que $c$ ne s'annulais pas, alors $forall x in RR, c(x) >= 0$\
Ainsi $s' = c >= 0$\
Donc $s$ est strictement croissante\ #QED

==== \

On a $forall x in RR, g'(x)= -s(x)+ s(1)$, Comme $-s$ est strictement décroissante\
alors pour $x in ]1, +oo[$, $g'(x) = -s(x) + s(1) < 0$\
Donc $g$ est décroissante sur $]1, +oo[$ #QED
\
==== \
Soit $x in RR$
$
  g(x) = c(x) +x s(1) tend(x, +oo) +oo "car " c(x) "bornée"
$
Ce qui est Absurde car $g$ décroissante\
Donc $c(x)$ s'annule au moins une fois

=== \

=== #a \
Soit $x in [0, p/2]$\
alors on vient de prouver que $c(x) != 0$ comme $c(0) = 1$\
Alors $forall t in [0, p/2], c(t) >= 0$\
Donc comme $s'(x) = c(x) >= 0$, Donc $s$ est croissante sur $[0, p/2]$\
De plus $s(0) = 0$ et $s(p/2)^2 = 1- c(p/2)^2 = 1 (i)$ \
Mais comme $s$ est croissante sur $[0;p/2]$, et que $s(0) = 0$,alors $s(p/2) >=0$, Donc par $(i), s(p/2) = 1$ \
Ainsi
#align(center)[
  #table(
    columns: (5em, 20em),
    align: center,
    $x$, $0$ + h(17.97em) + $p / 2$,
    [Signe de $s'$], $\ \ +$,
    [Variation de $s$], [],
  )
]
#move(dx: 32.45em, dy: -3.9em, $1$)
#move(dx: 13.5em, dy: -4em, $0$)
#line(start: (14.1em, -5.6em), end: (32em, -7.14em))
#move(dx: 31.9em, dy: -8.8em)[#rotate(-7deg)[#sym.triangle.filled]]
#v(-7em)
On vient de prouvé que $s$ étais croissante et comme $c' = -s <= 0$, donc $c $ est décroissante\
de plus $c(0) = 1 et c(p/2) = 0$ par définition de $p$\
Ainsi
#align(center)[
  #table(
    columns: (5em, 20em),
    align: center,
    $x$, $0$ + h(17.97em) + $p / 2$,
    [Variation de $c$], [],
  )
]
#move(dx: 13.5em, dy: -3.9em, $1$)
#move(dx: 32.4em, dy: -4em, $0$)
#line(start: (14.1em, -7.3em), end: (31.7em, -5.6em))
#move(dx: 31.6em, dy: -7.23em)[#rotate(7deg)[#sym.triangle.filled]]
#v(-7em)

#pagebreak()
==== \
Soit $x in RR$
$
  c(x+p / 2) = c(x)underbrace(c(p/2), =0) -s(x)underbrace(s(p/2), =1) = -s(x)\
  "Et"\
  s(x+p / 2) = c(x)underbrace(s(p/2), =1) +s(x)underbrace(c(p/2), =0) = c(x)\
  "Et"\
  c(x+p) = c((x+p / 2)+p / 2) = -s(x+p / 2) = -c(x)\
  "Et"\
  s(x+p) = s((x+p / 2)+p / 2) = c(x + p / 2) = -s(x)\
  "Et"\
  c(x+(3p) / 2) = c((x+p / 2)+p) = -c(x+p / 2) =s(x)\
  "Et"\
  s(x+(3p) / 2) = s((x+p / 2)+p) = -s(x+p / 2) = -c(x)
$
Donc $forall x in [0; 2p], forall t in [0;p/2], c(x) =
cases(
  c(t) "si " x in [0;p/2],
  -s(t) "si " x in [p/2; p],
  -c(t) "si " x in [p;(3p)/2],
  s(t) "si " x in [(3p)/2, 2p]
)
et s(x) =
cases(
  s(t) "si " x in [0;p/2],
  c(t) "si " x in [p/2; p],
  -s(t) "si " x in [p;(3p)/2],
  -c(t) "si " x in [(3p)/2, 2p]
)
$\
Ainsi, à l'aide de la question précédente, on obtient les tableaux de variation suivant:

// #tabvar(
//   init:(
//     "variable": $x$,
//     "label": (([variation de $s$], variation))
//   ),
//   T: ($0$, $p/2$, $p$, $(3p)/2$, $2p$),
//   content: (
//     ((top, $1$), (center,$0$), (bottom, $-1$), (center, $0$), (top, $1$))
//   ),
// )

#align(center)[
  #tabvar(
    init: (
      "variable": $x$,
      "label": (([varation de $s$], variation),),
    ),
    interval: ($0$, $p / 2$, $p$, $(3p) / 2$, $2p$),
    content: (((center, $0$), (top, $1$), (), (bottom, $-1$), (center, $0$)),),
  )
]

Et
#align(center)[
  #tabvar(
    init: (
      "variable": $x$,
      "label": (([variation de $c$], variation),),
    ),
    interval: ($0$, $p / 2$, $p$, $(3p) / 2$, $2p$),
    content: (((top, $1$), (), (bottom, $-1$), (), (top, $1$)),),
  )
]
#QED

#pagebreak()
==== \
Soit $x in RR$
Avec ce qui a été fait à la question précédente on a:
$
  c(x+2p) = c((x+p)+p) = -c(x+p) = c(x)\
  "Et"\
  s(x+2p) = s((x+p)+p) = -s(x+p) = s(x)
$
Donc $s et c$ sont $2p$--perdiodiques\
Prouvons que $2p$ est leur plus petite période\
Soit $T in RR tq$ $T$ soit la plus petite période de $s$ et $c$\
Alors $exists n in NN^*, 2p = n T$, soit $n in NN^*$ un telle $n$\
donc $T = (2p)/n$\
Supposons par l'absudre que $n != 1$, alors
- si $n=2$, \
on a: $forall x in RR, s(p/2 + T) =s(p/2+(2p)/2) = s(p/2+p) = -s(p/2) = -1 != 1 =s(p/2)$\
et $1 = c(0) = c(0+T) = c(p) = -1$\
Absurde !
- si $n > 2$,\
alors $(2p)/n in ]0; p[$\
Or par la question 16.b., on sais que $forall x in ]0; p[, s(x) != 0 et c(x) != 1$\
sauf que $s((2p)/n) = s(0+(2p)/n) = s(0+T) = s(0) = 0 et c((2p)/n) = c(0 +T) = c(0) = 1$\
ce qui est Absurde\
Donc $n = 1$ et donc $T = 2p$\
Ainsi $2p$ est la plus petite période de $s$
#QED