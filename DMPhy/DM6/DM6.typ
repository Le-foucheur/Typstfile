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
#show heading : it => {
  if it.body == [] or it.level >= 3 [#parbreak() #linebreak() #counter(heading).display() #it.body] else [#parbreak() #linebreak() #counter(heading).display() #it.body]
}
#set underline(stroke: red + 1pt)
#set par(leading: 10pt)
#set page(numbering: "1/1", number-align: right)

Gaspar Daguet
#align(
  center,
  text(20pt)[DM n°5]
)

#align(center)[= Chute d'une tartine beurrée]

=== \
#t(1) On a dans la base $(ar(u_r), ar(u_theta))$:
$
ar(T) = cases(delim: "|", -T,0,0) et ar(N) = cases(delim: "|", 0,N,0)\
"Ainsi après changement dans la base " R " on trouve:"\
ar(T) = cases(delim: "|", -T cos theta , 0, -T sin theta) et ar(N) = cases(delim: "|", N sin theta , 0, -N cos theta)
$
#t(1) De plus on a: $ar(P) = cases(delim: "|", 0,0,m g)$\
#t(1) Et comme ce sont les seuls forces qui s'aplique au système {tartine}\
#t(1) On a par la seconde lois de Newton:
$
ar(a) = 1/m (ar(N) + ar(T)+ ar(P)) = cases(delim: "|", N/m sin theta , 0, -N/m cos theta) - cases(delim: "|", T/m cos theta , 0, T/m sin theta) + cases(delim: "|", 0,0,g) = cases(delim: "|", N/m sin theta - T/m cos theta, 0, -N/m cos theta - T/m sin theta + g)
$

=== \
#t(1) D'abord calculons le moment du poid:
$
cal(M)_O_y (ar(P)) = (ar("OG") and ar(P)).ar(u_y) = (cases(delim: "|", delta cos theta,0,delta sin theta) and cases(delim: "|", 0,0,m g)).ar(u_y)= -m g delta cos theta
$
#t(1) ainsi par le théorème du moment cinétique:
$
J_O_y diaer(theta) = cal(M)_O_y (ar(P)) = -m g delta cos theta
$
$
&donc diaer(theta) = -(m g delta)/J_O_y cos theta \
&donc dot(theta) diaer(theta) = -(m g delta)/J_O_y dot(theta) cos theta\
&donc dot(theta)^2/2 = omega^2 = (m g delta)/J_O_y sin theta\
$
#pagebreak()
$
donc omega^2 = 2(m g delta)/m(a^2/3 + delta^2) sin theta = g/a (6delta)/(a+3 delta^2/a) sin theta = g/a (6delta/a)/(1+3delta^2/a^2) sin theta = g/a (6 eta)/(1+3eta^2) sin theta
$
#t(1) Donc on a bien #undermath[$ omega^2 = g/a (6eta)/(1+3eta^2) sin theta $]\

=== \
#t(1) On a $E_c = 1/2 J_O_y omega^2$\
Donc par le théorème de la puissance cinétique:
$
(dif E_c)/dt= 1/2 J_O_y (dif omega^2)/dt = -m g cos theta times dot(theta)\
"donc en intégrant:"\
omega^2 = 2 (m g)/J_O_y sin theta
$
#t(1) On est donc ramené au même calcule qu'a la question précédente, \
#t(1) et donc on retombe bien sur le même résultat

=== \
#t(1) Comme on se réfère au centre barycentrique on a $cal(M)_G_y (ar(P)) = 0$\
#t(1) Ainsi par le théorème du moment cinétique: $J_G_y diaer(theta) = 0$\
#t(1) Donc $dot(theta) = omega_0$ et donc #undermath[$ theta(t) = omega_0 t + pi/2 $]

=== \
#t(1) Il est évident que l'angle limite $theta_1$ vaut $(3pi)/2$\

=== \
#t(1) Comme $eta << 1$, alors on peut étudier la chute de la tartine comme dans une chute libre\
#t(1) Ainsi par la seconde lois de Newton:
$
ar(a) =cases(delim: "|", 0,0,g) donc ar(v) = cases(delim: "|", 0,0,g t) et donc ar("OG") = cases(delim: "|", 0,0,g/2 t^2)
$
#pagebreak()
#t(1) On cherche donc a savoir à quel date $tau$, $||ar("OG")|| = h$, ainsi:
$
||ar("OG")|| = g/2 tau^2 = h\
donc tau^2 = (2h)/g\
donc tau = sqrt((2h)/g)
$
#t(1) On a donc bien #undermath[$ tau = sqrt((2h)/g) $]\

#t(1) #underline(stroke: red)[AN:] $tau = sqrt((2times 0,75)/(9,81)) approx #calc.round(digits: 3, calc.sqrt((2*0.75)/9.81))$s $approx #calc.round(digits: 0, calc.sqrt((2*0.75)/9.81)*1000)$ ms\
#t(1) Ce qui demmande de très bon réflexe pour éviter le destin funeste de cette pauvre tartine

=== \
#t(1) Comme $eta << 1$, On a $omega_0 = sqrt(g/a (6eta)/(1+3eta^2)) approx sqrt((6 g eta)/a)$,\
#t(1) Ainsi en injectant $tau$ dans la formule de la question 4.\
$
theta(tau) = omega_0 tau + pi/2
$
#t(1) Mais comme on veut que $theta(tau) >= theta_1 = (3pi)/2$, ainsi\
$
omega_0 tau + pi/2 >= (3pi)/2\
$
$
&donc omega_0 tau >= pi\
&donc sqrt((6g eta)/a) sqrt((2h)/g) >= pi\
&donc 12 eta h >= pi^2 a\
&donc eta >= (pi^2 a)/(12 h)
$
#t(1) Ainsi #undermath[$ eta_min approx (pi^2 a)/(12 h) $]\
#t(1) #undermath[AN:] $eta_min approx (pi^2 times 0,05)/(12 times 0,75) approx #calc.round((calc.pow(calc.pi,2) * 0.05)/(12 * 0.75) , digits: 3)$\
#t(1) Mais comme sur terre $eta approx 0,02$, on en déduit que le destin inévitable de notre tartine est de \
#t(1) retombé sur sa face beurrée\

=== \
#t(1) Comme on la vue à la question précédente $eta$ ne dépant que de $h et a$ et non pas de $g$\
#t(1) Donc en modifiant $g$ on ne change pas le destin de notre tartine\

#pagebreak()
=== \

#t(1) Cherchons tout d'abbord la vitesse à la quel un corps touche le sol après une chute de hauteur $h$\
#t(1) Comme notre tartine beurrée, ce corps metterais $tau = sqrt((2h)/g)$s avant de toucher le sol\
#t(1) De plus la seconde loi de Newton nous informe que la vitesse au cours de la chute est: $v(t) = g t$\
#t(1) Donc il toucheras la sol à une vitesse $v_"sol" = v(tau) = sqrt(2 h g)$ (1)\
#t(1) Ainsi en prenant $h$ comme la taille d'un être sur un astre quelconque,\
#t(1) on à particulièrement pour la terre, où un humain mesure environs $h_o = 1,70m$: $v_h = sqrt(2 g_T h_o)$\
#t(1) avec $g_T$ l'accélération de pensanteur sur terre\
#t(1) En supposant qu'un être sur un astre quelconque et constituer à peut près comme l'être humain\
#t(1) alors la vitesse $v_h$ devrait être le même quel que soit l'astre\
#t(1) Ainsi en modifiant notre formule (1), on à $h = v_h^2/(2g) = (2g_T h_o)/(2g) = g_T/g h_o$\
#t(1) Ainsi on trouve que la hauteur d'un être constitué comme l'homme sur un astre quelconque\
#t(1) est proportionel à la hauteur de l'être humain, avec un cœficient de $g_T/g$,\
#t(1) avec $g$ l'accélération de pensanteur pour l'astre considéré\
\
#t(1) #undermath[AN:] $h_m approx (9,81)/(3,7) times 1,7 approx #calc.round(digits: 1, 9.81/3.7 * 1.7)$m\
\
#t(1) Ainsi la hauteur d'un martien semblable à l'homme serait d'environs 4m\
\
#t(1) En supposant qu'une table fais environs la moitié de la hauteur de l'être qui l'utilise\
#t(1) alors une table martienne à une hauteur d'environs 2,3m\
\
#t(1) Ainsi en recalculant $eta_min$ pour cette nouvelle hauteur de table on trouve:
\
#t(1) #undermath[AN:] $eta_"mars" approx (pi^2 times 0,05)/(12 times 2,3) approx #calc.round((calc.pow(calc.pi,2) * 0.05)/(12 * 2.3) , digits: 3)$ < 0,02\
#t(1) Ainsi les martien ne sont pas affecté par ce destin qui accable la terre.
