#import "/template.typ": *

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
#set page(numbering: "1/1", number-align: right)

Gaspar Daguet
#align(center, text(20pt)[Maths : DM 16])

= Exercice 1: endomorphisme laissant stables toutes les droites \
=== \
#t(1) Soit $x in E\\{0_E}$ \
#t(1) alors $u(x) in vect(x)$ car $vect(x)$ est stable par $u$\
#t(1) #undermath[Donc $exists!lambda, u(x) = lambda x$]

=== a.\
#t(1) Si $(x,y)$ est liée, alors $exists ateb in KK, x = ateb y$\
#t(1) Supposon $ateb = 0$\
#t(1) alors $x = ateb y = 0$ ce qui est absurde car $x in E\\{0}$ \
#t(1) Donc $ateb != 0$\
#t(1) Ainsi $u(x) = u(ateb y)$ donc $lambda_x x = ateb lambda_y y$\
#t(1) Donc $lambda_x underbrace(ateb y, != 0) = lambda_y underbrace(ateb y, !=0) $\
#t(1) #undermath[Donc $lambda_x = lambda_y$]
==== \
#t(1) Calculons $u(x+y)$ de deux manières différentes
$ u(x+y) = lambda_(x+y)(x+y) = lambda_(x+y)x + lambda_(x+y)y $
#t(1) et
$ u(x+y) = u(x) + u(y) = lambda_x x + lambda_y y $
#t(1) Or comme $(x,y)$ est libre, il vient que $lambda_x = lambda_(x+y) = lambda_y$\
#t(1) #undermath[Donc $lambda_x = lambda_y$]

=== \
#t(1) Les points précédents nous montre que $forall x,y in E \\{0}, exists!lambda in KK, u(x) = lambda x #underline(et, stroke: black) u(y) = lambda y$\
#t(1) Donc $forall x in E\\{0}, exists! lambda in KK, u(x) = lambda x$\
#t(1) Or comme $u(0) = 0 = lambda times 0$\
#t(1) #undermath[Donc $forall x in E, exists! lambda in KK, u(x) = lambda x$, autrement dit, $u$ est une homothétie]
#pagebreak()
= Exercice 2bis: endomorphisme de $cal(M)_n(CC)$ colinéaires à la trace \
\
#t(1) Pour montrer que $phi in vect(tr) <=> forall A,B in cal(M)_n (CC), phi (A B) = phi (B A) $\
#t(1) On va procéder par double implication\
- ($=>$) Supposons que $phi in vect(tr)$
#t(1) alors $exists ateb in CC, phi = ateb tr$\
#t(1) Donc soient $A,B in cal(M)_n (CC)$\
#t(1) alors $phi (A B) = ateb tr(A B) = ateb tr(B A) = phi (B A)$\
#t(1) #undermath[ Donc $phi in vect(tr) => forall A,B in cal(M)_n (CC), phi (A B) = phi (B A)$]\
\
- ($arrow.l.double$) Supposons que $forall A,B in cal(M)_n (CC), phi (A B) = phi (B A)$

= Exercice 3: composée de deux projecteurs qui commutent \
\
- Prouvons d'abord que $p compose q$ est un projecteur
#t(1) alors
$ (p compose q) compose (p compose q) &= p compose q compose p compose q = p compose q compose q compose p\
&= p compose q compose p = p compose p compose q\
&= p compose q $
#t(1) Et soient $x,y in E$ et soit $ateb in RR$, alors
$ (p compose q)(ateb x + y) &= p(q(ateb x + y)) = p(ateb q(x) + q(y))\
&=ateb p(q(x)) + p(q(y)) = ateb (p compose q)(x) + (p compose q)(y) $
#t(1) #undermath[Ainsi $p compose q$ est un projecteur]\
\
- Prouvons maintenant par double incusion que $Ker(p compose q) = Ker(p) + Ker(q)$\
  + d'abord #soitn($x$,$Ker(p)+Ker(q)$), alors $exists x_p, x_q in Ker(p)times Ker(q), x = x_p + x_q$\
#t(2) Alors $(p compose q)(x) = (p compose q)(x_p + x_q) = p(q(x_p)+underbrace(q(x_q),=0)) = q(p(x_p)) = q(0) =0$\
#t(2) Donc $x in Ker(p compose q)$\
#t(2) Donc $Ker(p)+Ker(q) subset Ker(p compose q)$\
\
#t(1) 2. De plus #soitn($x$, $Ker(p compose q)$)

- Enfin prouvons également par double inclusion que $Im(p compose q) = Im(p) sect Im(q)$
#t(1) 1. #Soitn($x$, $Im(p compose q)$) alors 
$ exists y in E, x = p(q(x))$, soit un telle $y$\
#t(2) donc $x in Im(p)$\
#t(2) et $x = p(q(x)) = q(p(x)) in Im(q)$\
#t(2) Donc $x in Im(p) sect Im(q)$\
#t(2) Donc $Im(p compose q) subset Im(p) sect Im(q) $\
#t(1) 2. #Soitn($x$, $Im(p) sect Im(q)$) alors $x in Im(p) #underline(stroke : black)[et] x in Im(q)$\
#t(2) Donc $exists y,y' in E, x = p(y) #underline(et, stroke: black) x =q(y')$