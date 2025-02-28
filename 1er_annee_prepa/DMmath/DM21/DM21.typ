#import "/template.typ": *
#import "/transposition.typ": *
#import "@preview/drafting:0.2.2":*

#set heading(
  numbering: (..numbers) => {
    let n = numbers.pos().len();
    if n == 1 { question.update(1); } 
    else if n == 2 { [Partie ]; numbering("I", numbers.pos().at(1)) ;"." }
    else if n == 3 { question.step(); margin-note(side:left, dy: -16.4pt, stroke: none)[#h(14pt)N=° #question.display().] } 
    else if n == 4 { margin-note(side:left, dy: -16.5pt, stroke: none)[#h(34pt)#numbering("a.", numbers.pos().at(3)+1) ]} 
    else if n == 5 { numbering("i.", numbers.pos().at(4)) }
  },
)
#set underline(stroke: red + 1pt)
#set par(leading: 0.7em)
#set page(numbering: (..nums) => nums.pos().map(na).join("/"), number-align: right)

Gaspar Daguet
#align(center, text(20pt)[Maths : DM 21])
#set-page-properties()

= Exercice: un calcul de l'intégrale de Gauss\
\
=== \
 #soietn($x,y$,$RR$) #tq $y >= x$, alors\
$
f(x)-f(y) &= integral_0^(pi/4) e^(-x(1+tan^2t))dt - integral_0^(pi/4) e^(-y(1+tan^2t))dt\
&= integral_0^(pi/4) e^(-x(1+tan^2t)) - e^(-y(1+tan^2t))dt\
$
 Mais, $-x >= -y$ donc $e^(-x) >= e^(-x)$, et pour tout $t in [0, pi/4], 1+tan^2t >=0$\
 Donc $x |-> x^(1+tan^2t)$ est c roissante\
 donc $(e^(-x))^(1+tan^2t)>=(e^(-y))^(1+tan^2t) donc e^(-x(1+tan^2t)) -e^(-y(1+tan^2t))>= 0$\
 Ainsi par croissance de l'intégrale $integral_0^(pi/4) e^(-x(1+tan^2t)) - e^(-y(1+tan^2t))dt >= 0$\
 et donc $f(x) -f(y) >= 0$ et donc $f(x) >= f(y)$\
 #undermath[Ainsi $f$ est décroissante ] \

=== \
#let intf(body) = $display(integral_0^(pi/4) #body dt)$
 #soitn($x$, $RR$), alors
$
f(x)/e^(-x) = integral_0^(pi/4) e^(-x(1+tan^2t)+x)dt = integral_0^(pi/4) e^(-x tan^2t)dt
$
 Comme $forall t in [0;pi/4], 0<=tan t<=1$, soit un telle $t$, alors\
 $0>= -x tan^2t >= -x donc e^0 =1 >= e^(-x tan^2 t) >= e^(-x)$\
 Et donc $#intf($e^(-x)$) <= #intf($e^(-x tan^2t)$) <= pi/4 = #intf($$)$\
 Et comme:
$ #intf($e^(-x)$) = pi/4 e^(-x) tend(x, +oo) 0 $
 On a donc que $f(x)/e^(-x)$ est bornée au voisinage de l'infinie\
 Et donc #undermath[$ f(x) =_(tend(x, +oo))O(e^(-x)) $]

=== \
#soitn($y$, $[-A;A]$),et soit $f: y|-> e^y$ alors comme $f$ est convexe car $f''$ est strictement positive\
On a que $f$ est supérieur à toute ses tangentes, en particulier à $y |-> y +1$\
Donc $e^y >= y+1$ donc #undermath[$0<= e^y -y -1$] \
\
On a $e^A>=f''(y) = e^y>=0$, donc par l'inégalit de Taylor-Lagrange:
$
f(y) - 1 -  y = |f(y) -  f(0) - f'(0) y|<= e^A y^2/2
$
=== #h(-16pt)a.\
#soitn($h$, $RR$), alors
$
f(a+h) - f(a) + h g(a) &= #intf($e^(-(a+h)(1+tan^2 t))$) - intf(e^(-a(1+tan^2 t))) + h intf((1+tan^2 t)e^(-a(1+tan^2 t)))\
&= intf(e^(-a(1+tan^2 t))(e^(-h(1+tan^2t))-1+h(1+tan^2t)))
$
Or par la question précédente pour tout $t in [0;pi/4]$:\
$0<=e^(-h(1+tan^2t))-1+h(1+tan^2t) <= e^(pi/4)h^2/2(1+tan^2t)^2$ avec $A = 2 abs(h)$\
$
&donc 0<=e^(-a(1+tan^2 t))(e^(-h(1+tan^2t))-1+h(1+tan^2t))<=e^(2|h|)h^2/2e^(-a(1+tan^2 t))(1+tan^2t)^2 <= e^(pi/4)2h^2 e^(-a(1+tan^2 t))\
&donc 0 <= intf(e^(-a(1+tan^2 t))(e^(-h(1+tan^2t))-1+h(1+tan^2t))) <= intf(e^(2|h|)2h^2e^(-a(1+tan^2 t)))\
&donc 0 <= f(a+h) - f(a) + h g(a) <=e^(2|h|)2h^2 intf(e^(-a(1+tan^2 t))^2) = e^(2|h|)2h^2 f(a)
$
Ainsi #undermath[$ forall h >0, 0 <= f(a+h) - f(a) + h g(a) <= e^(2|h|)2h^2 f(a) $]

==== \
D'après la question précédente, pour tout $h>0$: \
$0 <= f(a+h) - f(a) + h g(a) <= e^(2|h|)2h^2 f(a)$ soit $0 <= (f(a+h) - f(a))/h + g(a) <= underbrace(e^(2|h|)2h f(a), tend(h, 0))$\
Donc par le théorème des gendarmes $limits(lim)_(h-> 0) (f(a+h) - f(a))/h + g(a) =0$\
Et donc $f'(a) = limits(lim)_(h-> 0) (f(a+h) - f(a))/h = -g(a)$

=== #h(-16pt)a.\
On vient de prouver que $f$ étais dérivable et par le théorème fondamentale de l'analyse \
$display(integral_0^x e^(-u^2))dif u$ est dérivable, de dérivé $x|->e^(-x^2)$\
Donc par somme et composition de fonction dérivable $h$ est dérivable

==== \
En possant $u = x tan t$, on a $dif u = x (1+tan^2 t) dif t$\
donc $display(integral_0^x e^(-u^2)dif u  = integral_0^(arctan(x/x) = pi/4)) e^(-x^2 tan^2t) x (1+tan^2t) dif t$
\
#soitn($x$, $RR$), alors 
$
h'(x) &= -2x g(x^2) +2 e^(-x^2) integral_0^x e^(-u^2)dif u\
&= -2 intf(x(1+tan^2 t)e^(-x^2(1+tan^2t))) + 2intf(e^(-x^2(1+tan^2t))(1+tan^2t)) = 0
$
Ainsi #undermath[$forall x in RR, h'(x) = 0$]

==== \
Par la question précédente $forall x in RR, h'(x) =0$, donc $forall x in RR, h(x) = l in RR$ donc $limits(lim)_(x->+oo) h(x) = l$\
Deplus comme $f(x) limits(=)_(x -> +oo) O(e^(-x))$ et comme $e^(-x) tend(x, +oo) 0$ alors $f(x) tend(x, +oo)0 $\

Donc $display(l= limits(lim)_(x -> +oo) h(x) = limits(lim)_(x-> +oo) underbrace(f(x^2), -> 0) + (integral_0^x e^(-u^2)dif u)^2 = limits(lim)_(x-> +oo) (integral_0^x e^(-u^2)dif u)^2)$\
donc $display(limits(lim)_(x-> +oo) integral_0^x e^(-u^2)dif u = sqrt(l))$\
Et $l = h(0) = f(0) = intf(1) = pi/4$\
Et donc #undermath[$ limits(lim)_(x-> +oo) integral_0^x e^(-u^2)dif u = sqrt(pi)/2 $]
