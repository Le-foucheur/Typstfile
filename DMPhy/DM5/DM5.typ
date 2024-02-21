#import "/template.typ": *

#let question = counter("questions")

#set heading(
  numbering: (..numbers) => {
    let n = numbers.pos().len();
    if n == 1 { question.update(0); } else if n == 2 { [Partie ]; numbering("I", numbers.pos().at(1)) ;"." } else if n == 3 { [N=°];question.step(); question.display();"." } else if n == 4 { numbering("a.", numbers.pos().at(3) + 1) } else if n == 5 { numbering("i.", numbers.pos().at(4)) }
  },
)
#show heading : it => {
  if it.body == [] or it.level >= 3 [#parbreak() #linebreak() #counter(heading).display() #it.body] else [#parbreak() #linebreak() #counter(heading).display() #it.body]
}
#set underline(stroke: red + 1pt)
#set par(leading: 10pt)

Gaspar Daguet
#align(
  center,
  text(20pt)[DM n°5]
)

#align(center)[= Exercice 2 : Chauffage d'un gaz par effet Joule]

=== \
#t(1) On a $R (T_0) = R_0 = alpha T_0$\
#t(1) Donc $alpha = R_0/T_0$\
#t(1) La loi donner dans l'énoncer nous informe que $R prop T$, Donc si $T$ double, $R$ double

=== \
#t(1) La transformation est isobare car le piston viendras équilibé le volume\ 
#t(1) pour que la pression reste constante \

=== \
#t(1) Par la loi des gaz parfaits, on a:
$ P_f V_f = R n T_f $

=== \
#t(1) On a le travaille éléctrique élémentaire qui vaut:
$ delta W_(è l) = E i dt = E^2/R(T) dt $
#t(1) Or ce travaille va se transformer en chaleur par effet joule pour le gaz donc on a: $delta Q = delta W_(è l)$\
#t(1) De plus comme la transformation est isobare et que $C_(p m)$ est constant on a:
$ dif H = n C_(p m) dif T $
#pagebreak()
#t(1) Ainsi, comme la transformation est isobare, \
#t(1) on peut appliquer le premier principe de la termodynamie, ce qui nous donne
$ &dif H = delta Q\
  &"Donc" n C_(p m) dif T = E^2/R(T) dt \
  &"Donc" (dif T)/dt = E^2/(n C_(p m) R(T)) = E^2/(C_(p) alpha T)\
  &"Donc" 2T (dif T)/dt = (dif T^2)/dt = (2E^2)/(C_(p) alpha)\
  &"Donc" T^2 = (2E^2)/(C_(p) alpha)(t_f - t_i) =(2E^2 T_0)/(C_(p) R_0)(t_f - t_i) \
  &"Donc" T(t) = E sqrt((2 T_0)/(C_(p) R_0) (t_f - t_i))
$
#t(1) Donc en prenant $t_i = 0$ à l'instant où on commance à faire chauffer le système\
#t(1) #undermath[On obtient: $display(T(t) = E sqrt((2 T_0)/(C_p R_0)t))$]

=== \
#t(1) #undermath[On a que: $display(T_f = T(tau) = E sqrt((2 T_0)/(C_p R_0) tau))$]\
\

#align(center,text[ = Exercice 3 : Circuit $R L C$ parallèle])
=== \
#t(1) Si on applique un pont diviseur de tension pour trouver $u_s$, on trouve:
$ underline(U_(s m)) = underline(E_m) Z_(é q)/(Z_(é q) + R_0) = underline(E_m) 1/(1+R_0/Z_(é q)) $
#t(1) avec
$ Z_(é q) = 1/(1/R_0 + j(omega C - 1/(omega L))) $
#t(1) Soit encore:
$ underline(U_(s m)) = (1/2 underline(E_m))/(1+j Q(omega/omega_0 - omega_0/omega)) $
#t(1) avec $display(omega_0 = sqrt(1/(C L)) et Q = R_0/2 sqrt(C/L))$\
#t(1) Ainsi:
$ U_(s m) = abs(underline(U_(s m))) =(1/2 E_m)/abs(1+j Q(omega/omega_0 - omega_0/omega)) =(1/2 E_m)/(sqrt(1+ Q^2(omega/omega_0 - omega_0/omega)^2)) $
#t(1) et
$ phi.alt = arg(underline(U_(s m))) &= arg((1/2 E_m)/(1+j Q(omega/omega_0 - omega_0/omega))) = underbrace(arg(1/2 E_m),=0) - arg(1+j Q(omega/omega_0 - omega_0/omega))\ &= -arctan( Q(omega/omega_0 - omega_0/omega))  $

=== \
#t(1) il est claire que $U_(s m)$ est maximale quand $omega = omega_0$ \
#t(1) Donc $f_r = omega_0/(2pi) = 1/(2pi) sqrt(1/(C L))$\
\
#t(1) #undermath[AN:] $f_r = 1/(2pi) sqrt(1/( 2,53 dot.basic 10^(-6)times 10 dot.basic 10^(-3))) = #calc.round(1/(2*calc.pi) *calc.sqrt(1/(2.53 * calc.pow(10,-6)* 10 * calc.pow(10,-3))),digits: 1) "Hz"$
#let o =calc.sqrt(1/(2.53 * calc.pow(10,-6)* 10 * calc.pow(10,-3)))

=== \
#t(1) Comme $pi/4>0$ alors $u_s$ est en avance \
#t(1) On cherche $omega_c tq display((1/2 E_m)/(sqrt(1+ Q^2(omega/omega_0 - omega_0/omega)^2)) = U_(s m,max)/sqrt(2) = E_m/(2 sqrt(2)))$\
$  &"Donc" (omega_c/omega_0 - omega_0/omega_c)^2 =1/Q^2\
&"Donc" omega_c^2 - omega_0/Q omega_c - omega_0^2 = 0 "ou" omega_0^2 - omega_0/Q omega_c - omega_c^2 = 0  \
&"Donc" omega_(c,1) = omega_0/(2Q) + sqrt(1/(4Q^2) + 1) "ou" omega_(c,2) = -omega_0/(2Q) + sqrt(1/(4Q^2) + 1)
$
#t(1) #undermath[Ainsi: $f_(c,1) = 1/(2 pi)( omega_0/(2Q) + sqrt(1/(4Q^2) + 1)) "ou" f_(c,2) =1/(2pi) (-omega_0/(2Q) + sqrt(1/(4Q^2) + 1))$]
#pagebreak()
#t(1) Deplus on a:
$ pi/4 = Delta phi_(u_s,e) = arg(U_(s m)) - underbrace(arg(e),=0) = phi.alt = arctan(Q(omega_0/omega - omega/omega_0)) $
$ &"Donc" Q(omega_0/omega - omega/omega_0) = 1\
&"Donc" R_0/2 sqrt(C/L)= Q = 1/(omega_0/omega - omega/omega_0) = 1/(omega_0/(2 pi f_(c l)) - (2 pi f_(c l))/omega_0)\
&"Ainsi" R_0 = 2/(omega_0/(2 pi f_(c l)) - (2 pi f_(c l))/omega_0) sqrt(L/C)
$

#t(1) #undermath[AN:]
$ R_0 = #calc.round(2/(o/(2* calc.pi*900)-(2* calc.pi*900)/o)* calc.sqrt((10 *calc.pow(10,-3))/(2.53*calc.pow(10,-6))),digits: 1) Omega\
et\
Q = #calc.round(1/(o/(2* calc.pi*900)-(2* calc.pi*900)/o),digits: 1) $

=== \
#t(1) Ajouter un condensateur reviens à ajouter leur capacités \
#t(1) Donc on a $f'_r = 1/(2pi) sqrt(1/((C'+C) L)) donc C' =1/(4pi^2 L f'_r^2) - C $\
#t(1) #undermath[AN:] $C' = 1.43 mu F$