#import "/template.typ": *
#import "/transposition.typ": *

#set heading(
  numbering: (..numbers) => {
    let n = numbers.pos().len();
    if n == 1 { question.update(1); } 
    else if n == 2 { [Partie ]; numbering("I", numbers.pos().at(1)) ;"." }
    else if n == 3 { [N=°];question.step(); question.display();"." } 
    else if n == 4 { numbering("a.", numbers.pos().at(3) + 1) } 
    else if n == 5 { numbering("i.", numbers.pos().at(4)) }
  },
)
#set underline(stroke: red + 1pt)
#set par(leading: 0.7em)
#set page(numbering: (..nums) => nums.pos().map(na).join("/"), number-align: right)

Gaspar Daguet
#align(center, text(20pt)[Maths : DM 18])

= Problème 1: formule de Taylor-Lagrange et méthode de Newton\
== Formule de Taylor-Lagrange à l'odre 2.\

=== a.\
#t(1) On à bien $psi$ deux fois dérivable sur $]a;b[$ car $f$ est $#C(2)$\
#t(1) De plus
$ 
psi'(t) = f'(t) -f'(c) - 2 lambda (t - c)
\
"Et"
\
psi''(t) = f''(t) - 2lambda
$

==== \
#t(1) On cherche $lambda in RR tq forall x in ]a,b[,psi(x) = psi(c)$\
#t(1) De plus $psi(c) = f(c) - f(c) -(c-c)f'(c) - lambda(c-c)^2 = 0$\
#t(1) Ainsi soit $x in ]a,b[$, alors
$ 
psi(x) = psi(c) &<=> f(x) - f(c) -(x-c)f'(c) - lambda(x-c)^2 = 0\
&<=> lambda(x-c)^2 =  f(x) - f(c) -(x-c)f'(c)\
&<=> #undermath[$ lambda = (f(x) - f(c) -(x-c)f'(c))/(x-c)^2 $]
$

==== \
#t(1) Ainsi avec le bon $lambda$ on à $psi(c) = psi(x)$ et comme $psi$ est continue sur $[c;x]$ \
#t(1) car somme est produit de fonction continue\
#t(1) Donc en utilisant un première fois le théorème de Rolle sur $[c;x]$\
#t(1) On a qu'il existe $c_x in ]c;x[, psi'(c_x) = 0$\
#t(1) Et comme $psi'(c) = f'(c) - f'(c) - 2lambda(c-c) = 0$\
#t(1) On peut réapliquer le théorème de Rolle, Ainsi on obtiens:\
$ exists theta_x in ]c;x[, psi''(theta_x) = 0 $
#t(1) Donc soit un telle $theta_x in ]c;x[$
$
psi''(theta_x) = 0 <=> f''(theta_x) - 2lambda = 0
$
#t(1) Ainsi comme $lambda = (f(x) - f(c) -(x-c)f'(c))/(x-c)^2$
$
f''(theta_x) = 2lambda &= 2(f(x) - f(c) -(x-c)f'(c))/(x-c)^2 <=> (x-c)^2/2 f''(theta_x) = f(x) - f(c) -(x-c)f'(c)\
&<=> f(x) = f(c) + (x-c)f'(c) + (x-c)^2/2 f''(theta_x)
$
#pagebreak()
== Méthode de Newton\
=== \
#t(1) Le point deux nous informe que $f$ est strictement décroisante sur $[a;b]$\
#t(1) et comme $f(a) > 0 et f(b) < 0$\
#t(1) #undermath[Ainsi par le théorème de la bijection $exists ! c in ]a;b[, f(c) = 0$]\
=== \
#t(1) L'équation de la tangente à $#C("")_f$ en u est $forall x in [a;b], Delta_u (x) = f(u) + f'(u)(x-u)$\
#t(1) Et coupe l'axe des absice en $x = u - (f'(u))/f(u)$

=== \
#t(1) $x_(n+1) - x_n = x_n - (f(x_n))/(f'(x_n)) - x_n = - (f(x_n))/(f'(x_n)) > 0$ car $forall x in [a;b], f'(x) < 0$\
#t(1) #undermath[Donc $(x_n)$ est croissante]\
#t(1) Et prouvons que $(x_n)$ est majorée par $c$ par récurance simple\
#t(1) Prouvons d'abord que $g$ est croissante\
#t(1) Pour ça, on a 
$
forall x in [a;b], g'(x) = 1-(f'(x)^2 - f(x) f''(x))/(f'(x)^2) = (f(x) f''(x))/underbrace(f'(x)^2, >= 0)
$
#t(1) et comme $f$ est convexe, on a $forall x in [a,b], f''(x) >= 0$\
#t(1) Ainsi sur $[a,c], f$ est positif et donc $g$ est croissante sur $[a,c]$
- *Initialisation:*
#t(1) On a: $f(x_0) > 0 = f(c)$ donc $f(x_0) > f(c)$ et par décroissance de $f$ sur $[a;b]$, on a #undermath[$x_0 < c$]\
- *Hérédité:* Soit $n in NN tq x_n < c$, alors
$
&x_n <= c\
&<=> g(x_n) <= g(c) "car" g " est croissante sur "[a,c]\
&<=> x_(n+1) <= c - underbrace((f(c))/(f'(c)), =0) = c
$
#t(1) #undermath[Ainsi par principe de récurance $(x_n)$ est majorée par $c$]

=== \
#t(1) Comme $x_n$ est croissante et majoré, alors\
#t(1) par le théorème de la limite monotone $(x_n)$ converge\
#t(1) De plus par la théorème du point fixe $(x_n)$ converge vers le point fixe de $g$\
#t(1) Ainsi soit $l in [a,b]$ $g(l) = l <=> l - (f(l))/(f'(l)) = l <=> f(l) = 0 <=> l = c$ car $c$ est l'unique nombre\
#t(1) #tq $f(c) = 0$\
#t(1) #undermath[Ainsi $(x_n)$ converge vers $c$]\

=== \
#t(1) Comme $f$ est #C(2), alors $f'$ est continue sur $[a;b]$ est donc par le théorème des borne atteintes \
#t(1) $f'$ admet un maximum qui, par hypothèse (2) de $f$, est strictement negative\
#t(1) Et #undermath[donc $abs(f')$ admet un minimum $m$ qui est strictement positive]\

#pagebreak()


#t(1) Comme $f$ est #C(2), alors $f''$ est continue sur $[a;b]$ est donc par le théorème des borne atteintes\
#t(1) et comme $f$ est convexe, $f''$ est strictement positive, car $f$ n'est pas affine\
#t(1) Ainsi #undermath[$abs(f'')$ admet un maximum $M$ strictement positif]\

=== \
#t(1) Comme $f$ est $#C(2)$ et que $x_n,c in ]a;b[$\
#t(1) D'après la question 1. on obtient:
$
underbrace(f(c),=0) = f(x_n) + (c-x_n)f'(x_n)+(c-x_n)^2/2 f''(theta_n)
$
$
&<=> f(x_n) = -(c-x_n)f'(x_n)-(c-x_n)^2/2 f''(theta_n)\
&<=> f(x_n) = (x_n-c)f'(x_n)-(c-x_n)^2/2 f''(theta_n)
$
#t(1) On a donc bien #undermath[$f(x_n) = (x_n-c)f'(x_n)-(c-x_n)^2/2 f''(theta_n)
$]
=== \
#t(1) Transformont l'égalité de de la question précédente de sorte à obtenir ce que l'on cherche, ainsi:\
$
f(x_n) = (x_n-c)f'(x_n)-(c-x_n)^2/2 f''(theta_n)\
$
$
&<=> -f(x_n)/(f'(x_n)) = -x_n + c + (c-x_n)^2/2 (f''(theta_n))/(f'(x_n))\
&<=> x_(n+1) = x_n - f(x_n)/(f'(x_n)) = c +  (c-x_n)^2/2 (f''(theta_n))/(f'(x_n))\
&<=> abs(x_(n+1) -c) = (c-x_n)^2/2(overbrace(abs(f''(theta_n)),<=M))/underbrace(abs(f'(x_n)), <= m)
$
#t(1) Ainsi #undermath[$ abs(x_(n+1)) <= M/(2m) (x_n - c)^2 $]\

=== \
#t(1) comme $x_n #tend($n$, $+oo$) c$, alors par définition de limite:\
$
forall epsilon > 0, exists n_0 in NN, forall n >= n_0, abs(x_n_0 - c) <= epsilon
$
#t(1) Ainsi en prenant $epsilon = m/M$, on a:
#t(1) #undermath[$ exists n_0 in NN, forall n >= n_0, abs(x_n_0 - c) <= m/M $]

#t(1) Prouvons par récurance que $forall n >= n_0, display(abs(x_n - c) <= (2m)/M 1/2^2^(n-n_0))$\
- *Initialisation:*
#t(1) Pour $n = n_0$, on a: $display(abs(x_n - c) <= (2m)/M 1/2^2^(n_0-n_0) = m/M)$\
#t(1) ce qui à été prouvé au début de cette question\
#t(1) Donc l'initialisation est vérifié\

- *Hérédité:*
#t(1) Soit $n >= n_0$ tel que $display(abs(x_n - c) <= (2m)/M 1/2^2^(n-n_0))$, alors\
$
abs(x_(n+1) -  c) &<= M/(2m) (x_n - c)^2 "par la question 8."\
&<= (M)/(2m) ((2m)/M 1/2^2^(n-n_0))^2\
&<= (2m)/M 1/2^(2^(n-n_0)+2) <= (2m)/M 1/2^(2^(n+1-n_0))
$
#t(1) Ainsi l'hérédité est vérifié\
\
#t(1) Donc par principe de récurance simple: #undermath[$forall n >= n_0, display(abs(x_n - c) <= (2m)/M 1/2^2^(n-n_0))$]

=== \
#t(1) Soit $q in ]0;1[$\
#t(1) la question revient à prouver que $abs(x_n - c)/q^n$ #cv vers 0\
#t(1) Ainsi, à partir d'un certins rang:
$
0<=abs(x_n - c)/q^n &<= (2m)/M 1/(2^2^(n-n_0)q^n) "par la question précédente"\
&<= (2m)/M exp(-ln(2^2^(n-n_0)q^n))\
&<= (2m)/M exp(-2^(n-n_0)ln(2)-n ln(q))\
&<= (2m)/M exp(overbrace(-2^(n-n_0)(ln(2)+underbrace(n/2^(n-n_0),tend(n, +oo) 0) ln(q)),tend(n,+oo)-oo)) tend(n, +oo) 0
$
#t(1) Donc par le théorème des Gendarme, $abs(x_n - c)/q^n tend(n,+oo) 0$\
#t(1) #undermath[Ainsi, $abs(x_n - c) limits(=)_(n -> +oo) o(q^n) $]\
\
Je vous met en plus un petit shéma intéractif via desmos fait par mes soins:
#link("https://www.desmos.com/calculator/ifqjbo98as?lang=fr",figure(image("shame.png",width: 36%), caption: [cliquer sur l'image pour avoir accès au site] ))