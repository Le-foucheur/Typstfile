#import "../../../template.typ": *
#import "@preview/cetz:0.4.2"

#show: x => template(ancienne_lig: true, x)

#align(center)[= Les trucs à savoir en vue du CC2]

== TD6 Phonon

- Savoir écrire le PFD (signe des forces)
- Energie potentielle élastique: $1/2 kappa prop delta x^2$
- Différence entre longitudinaux & transversaux
- '~~~~~~~~~~~~~~~~~~~~~~~' acoustique & optique
- Relation de dispersion $omega(k)$
- Concepte de vietesse du son $omega(k) tend(k, 0) v_s k$

*Remarque :* pour l’exo II:
$
  u_(2n + 2) & = A e^(i[k(n a + b) - omega t])#h(5em) &     u_(2n) & = u_(2(n - 1) + 2) \
  u_(2n + 1) & = B e^(i[k n a - omega t]) #h(5em)     & u_(2n - 1) & = u_(2(n - 1) + 1)
$

- Tracé de la ZB : On détermine les limites de ZB par périodicité de $omega$
On retrouve la ZB du monoatomique par la celle du diatomique si l’on prend $m_1 = m_2$\
De plus l’on à $v_g = 0$ en le bord de la ZB

- Connaitre sa trigo ($cos(2x) = 2 cos^2 (x) - 1$)

- attention le bord de la ZB dépend de qui est $a$ :
#cetz.canvas({
  import cetz.draw: *

  for i in range(0, 4) {
    circle((2 * i, 0), radius: 2mm, fill: black, name: "s" + str(i))
  }
  for i in range(0, 3) {
    line((2 * i, 0), (2 * (i + 1), 0))
  }

  line((8, 0), (8 + 2, 0), mark: (end: "straight"))

  content((11, 0))[$k_"BZB" = pi/a$]

  for i in range(0, 4) {
    circle((2 * i, 0), radius: 2mm, fill: black, name: "s" + str(i))
  }
  for i in range(0, 3) {
    line((2 * i, 0), (2 * (i + 1), 0))
  }

  line((0, -0.5), (2, -0.5), mark: (symbol: "straight"), name: "a")
  content("a.mid", $a$, anchor: "north")

  line((8, 0), (8 + 2, 0), mark: (end: "straight"))

  content((11, 0))[$k_"BZB" = pi/a$]


  for i in range(0, 3) {
    line((2 * i, -2), (2 * (i + 1), -2), style: (stroke: if calc.rem(i, 2) == 0 { black } else { red }))
  }
  for i in range(0, 4) {
    circle((2 * i, -2), radius: 2mm, fill: if calc.rem(i, 2) == 0 { black } else { red }, name: "s" + str(i))
  }

  line((0, -2.5), (4, -2.5), mark: (symbol: "straight"), name: "a")
  content("a.mid", $a$, anchor: "north")

  line((8, -2), (8 + 2, -2), mark: (end: "straight"))

  content((11, -2))[$k_"BZB" = pi/(a)$]

  for i in range(0, 3) {
    line((2 * i, -4), (2 * (i + 1), -4), style: (stroke: if calc.rem(i, 2) == 0 { black } else { red }))
  }
  for i in range(0, 4) {
    circle((2 * i, -4), radius: 2mm, fill: if calc.rem(i, 2) == 0 { black } else { red }, name: "s" + str(i))
  }

  line((0, -4.5), (2, -4.5), mark: (symbol: "straight"), name: "a")
  content("a.mid", $a$, anchor: "north")

  line((0, -5), (4, -5), mark: (symbol: "straight"), name: "a")
  content("a.mid", $2a$, padding: 0.2, anchor: "north")

  line((8, -4), (8 + 2, -4), mark: (end: "straight"))

  content((11, -4))[$k_"BZB" = pi/(2a)$]
})

== TD7 Chaleur spécifique

- Théorème d’équipartition de l’énergie
- Densités d’état (cf. $phi$stat)
- $g(u)dif u = g(k) dif k$
- Debye: $integral_0^u_D g(u) dif u = N$
- $E = integral_0^u_D dif u underbrace(u, #[densité\ d’état]) underbrace(1/(e^((h u)/(k_B T))), #[Nombre de\ particule]) underbrace(h u, #[quanta\ d’énergie]) --> phi#[stat]$
- capacité calorifique (haute & basse Température)

== TD8 Kronig-Penny
- Idée générale: un potentiel modifie la structure de l’onde (autorisé/interdite)
- Théorème de Bloch

== TD9 $e^-$ quasi-libre
- $k_F$ $->$ lien avec n (cf. TD10)
- Par bande d’énergie: on a $2N$ états possibles (avec spin)
  - bande remplie $->$ $E_F$ était dans le gap $->$ isolant
  - gap en bord de ZB vient d’un potentiel

== TD10
- $E_F, T_F et k_F$
