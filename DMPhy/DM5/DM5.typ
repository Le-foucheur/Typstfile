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
#t(1) Or ce travaille va se transformer en chaleur pour le gaz donc on a: $delta Q = delta W_(è l)$\
#t(1) De plus comme la transformation est isobare et que $C_(p m)$ est constant on a:
$ dif H = n C_(p m) dif T $
#pagebreak()
#t(1) Ainsi, comme la transformation est isobare, \
#t(1) on peut appliquer le premier principe de la termodynamie, ce qui nous donne
$ dif H &= delta Q\
  "Donc" n C_(p m) dif T &= E^2/R(T) dt \
  "Donc" (dif T)/dt &= E^2/(n C_(p m) R(T)) = E^2/(C_(p) alpha T)\
  "Donc" T (dif T)/dt &= (dif T^2)/dt = (2E^2)/(C_(p) alpha)\
  "Donc" T^2 &= (2E^2)/(C_(p) alpha)(t_f - t_i) =(2E^2 T_0)/(C_(p) R_0)(t_f - t_i) \
  "Donc" T(t) &= E sqrt((2 T_0)/(C_(p) R_0) (t_f - t_i))
$
#t(1) Donc en prenant $t_i = 0$ à l'instant où on commance à faire chauffer le système\
#t(1) #undermath[On obtient: $display(T(t) = E sqrt((2 T_0)/(C_p R_0)t))$]

=== \
#t(1) #undermath[On a que: $display(T_f = T(tau) = E sqrt((2 T_0)/(C_p R_0) tau))$]\
\

#align(center,text[ = Exercice 3 : Circuit $R L C$ parallèle])
=== \
