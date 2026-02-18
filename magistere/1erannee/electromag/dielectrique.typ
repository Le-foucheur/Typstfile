#import "@preview/cetz:0.4.2"
#import "../../../template.typ": *

#show: template

#align(center)[= Milieux Diélectriques]

== I.1 Milieux diélectriques

Un milieu diélectrique est un milieu de charge globalement neutre, ainsi le champ électrique est également globalement neutre.\
Ce qui faits que les porteurs de charge ne peuvent se déplacer librement, et sont donc appelées « charge liées », ce qui fait que les diélectriques sont généralement des isolants comme le vide, le verre, etc.\

Bien que le milieu soit globalement neutre et ne génère pas de champ électrique, à l’échelle atomique ces constituants peuvent se comporter comme des dipoles électriques, ce qui permet d’interpréter toutes les propriétées des diélectriques.\
Ce phénomène est appelé : « Polarisation ».

On caractérise ces milieux par un moment dipolaire par unité de volume $arrow(P)$ tel que :
$
  Delta arrow(P) = arrow(P) Delta tau
$
avec $Delta arrow(P)$ le dipole formé par les charges locales

== II Développement multipolaire

=== II.1 Cas du monopole et du dipole

Nous avons pour un monople : $V prop 1/r$ (lois de Coulomb)

Regardons pour un dipole :

#cetz.canvas({
    import cetz.draw: *

    circle((1, 0), radius: 3.5mm, name: "q1")
    circle((-2, 0), radius: 3.5mm, name: "q2")

    content("q1", text(fill : red)[$-q$])
    content("q2", text(fill : red)[$+q$])

    line((-2+0.4,0), (1-0.4, 0), stroke: (dash: "dashed"), name: "q1q2")
    line((1+0.4, 0), (4, 0), stroke: (dash: "dashed"), mark: (end: (symbol: ">", stroke: (dash: "solid"))))
    content((4.2,0), $z$)

    circle((4,3), radius: 1mm, fill: black, name: "M")
    content((4.3,3.3), $M(r, theta)$)

    line("q1", "M", stroke: (dash: "dashed"), name: "r1")
    line("q2", "M", stroke: (dash: "dashed"), name: "r2")
    line("q1q2", "M", stroke: (dash: "dashed"), name: "r")

    content("q1q2", $O$, anchor: "north", padding: .1)

    line((-2+0.4,-0.5), (1-0.4, -0.5), mark: (symbol: "straight"), name: "2a")
    content("2a", $2a$, anchor: "north", padding: 0.1)

    cetz.angle.angle("q1q2.mid", "q1q2", "r", label: $theta$, radius: 10mm)

    content("r.35%", $arrow(r)$, anchor: "south", padding: 0.15)
    content("r2.35%", $arrow(r)_1$, anchor: "south", padding: 0.15)
    content("r1.55%", $arrow(r)_2$, anchor: "north", padding: 0.3)

})
On suppose que $a << r$, ainsi :
$
  V(arrow(r)) = 1/(4pi epsilon_0) (q/(r_1) - q/(r_2)) = q/(4pi epsilon_0) (1/(r_1) - 1/r_2)
$
Or 
$
  1/r_1 &= (r^2 + a^2 - 2 a r cos(theta))^(-1/2) = 1/r (1 + cancel(a^2/r^2, stroke: #red) - 2 a/r cos(theta))^(-1/2) approx 1/r (1 + a/r cos(theta))\
  &= 1/r + a/r^2 cos(theta)
$
De même pour $display(1/r_2 = 1/r - a/r^2 cos(theta))$, Ainsi :
$
  V(arrow(r)) = q/(4pi epsilon_0) (1/(r_1) - 1/r_2) = q/(4pi epsilon_0) (2a cos(theta))/(r^2)
$
Ainsi, on trouve que $V(arrow(r)) prop 1/r^2$ 

=== II.2 Généralisation du multipole

