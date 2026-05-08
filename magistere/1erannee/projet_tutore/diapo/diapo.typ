#import "../../../../template.typ": *
#import "@preview/hydra:0.6.2": hydra
#import "@preview/cetz:0.5.2"
#import "@preview/cetz-plot:0.1.3": *

#set page(
  paper: "presentation-16-9",
  header: context [
    #set text(15pt, fill: white)
    #place(
      dx: -20mm,
      box(fill: rgb("#171568"), height: 15mm, width: 110%)[
        #place(dx: -5mm, right + horizon, [#h(18mm) Gaspar Daguet])
      ],
    )

    #if counter(heading).at(here()).first() != 0 {
      place(left + horizon, dy: -1mm, text(fill: white, 30pt, weight: "bold")[#hydra(1)])
    }
  ],
  footer: context [
    #set align(right)
    #set text(20pt, fill: rgb("#ffffff"), weight: "extrabold", stroke: 1pt, font: "FreeSans")
    #place(
      dx: -5mm,
      box(height: 100%, width: 105%)[
        #scale(place(image("./image/methamorphose.jpg"), dx: -1mm), x: 149%)
        #place(
          dx: -7mm,
          right + horizon,
          counter(page).display(
            "1 / 1",
            both: true,
          ),
        )
        #place(left + horizon, [#image("./image/btUnistra-logo.jpg")])
      ],
    )
  ],
  footer-descent: 50%,
  margin: (x: 5mm),
  numbering: "1/1",
)
#set text(25pt, font: "Linux Libertine", lang: "fr")
#set heading(
  numbering: (..numbers) => {
    let n = numbers.pos().len()
    if n == 1 {} else if n == 2 {} else if n == 3 {} else if n == 4 {} else if n == 5 {}
  },
)

#show heading.where(level: 2): it => place(dy: -17mm, text(fill: white)[#it])
#show heading.where(level: 1): it => place(dy: -10mm, center + horizon, text()[#it])


#place(center + horizon, dy: -10mm)[
  = #[Résolution de Schwarzschild\ à l’équation d’Einstein]\
  \
  \
  Gaspar Daguet
]

#pagebreak()
=
== Table des matières
#place(center + horizon, dx: -60mm)[
  #set align(left)

  + Introduction

  + La métrique de Schwarzschild
  + Chute dans un trou noir
  + Trou noir & blanc

]

#place(
  horizon + right,
  scale(figure(image("./image/cercle_limite.jpg"), caption: [Cercle Limite III — M.C. Escher]), 70%),
)

#pagebreak()

= 1) Introduction

#pagebreak()

#place(
  dy: 10mm,
  center,
  [*Histoire*],
)

#place(right + horizon, figure(scale(image("./image/KarlSchwarzschild.jpg"), y: 50%, x: -50%)))

#place(left + horizon, figure(scale(image("./image/Albert_Einstein_sticks_his_tongue.jpg"), y: 50%, x: -50%)))


#place(
  center + horizon,
  [
    1907 - 1915: dévelopement\ de la théorie par Einstein\
    $arrow.b.double$\
    1915 : Schwarzschild dévelope\ sa solution
  ],
)

#pagebreak()

B (= brouillon)

#place(
  center,
  dy: 10mm,
  [*Quelques outils mathématiques*],
)

#place(
  horizon,
  [
    Géodésique : courbe qui maximise la distance entre deux points dans l’espace\
    \
    Métrique :
    - forme tensorielle : produit scalaire entre les éléments de la base ($g_(mu nu)$)
    - forme « distance » : $ds$ = distance entre deux points infiniment voisin\
    $
      ds^2 = g_(mu nu) dx^mu dx^nu
    $
  ],
)

#pagebreak()

B

#place(
  horizon,
  [
    Tenseur de Riemann : $R^rho""_(mu nu kappa) v^mu = [nabla_mu, nabla_nu] v^rho$ « Défaut de comutation »\
    \
    Tenseur de Ricci : $R_(mu nu) = R^rho""_(mu rho nu)$\
    \
    Courbure scalaire : $R = g^(mu nu) R_(mu nu)$
  ],
)

#pagebreak()

= 2) Métrique de Schwarzschild

#pagebreak()

#place(
  center + horizon,
  [
    Équation d’Einstein :\
    $
      underbrace(R_(mu nu) + 1/2 g_(mu nu) R, #[Géométrie de\ l’espace]) = underbrace(kappa T_(mu nu), #[contenue de\ l’espace]) + cases(#[Espace statique], #[à symétrie shérique], delim: #none) \
      arrow.b.double
    $
    Métrique Schwarzschild :\
    $
      ds^2 = (1 - R_s / r)dt^2 - (1 - R_s/r)^(-1) dr - r^2 dif Omega^2
    $
  ],
)

#place(
  horizon + left,
  dy: 20mm,
  $R_s = (2G M)/(c^2)$,
)

#pagebreak()

#place(
  center,
  [
    *Hypotèse de Schwarzschild*
  ],
)

#place(
  horizon + left,
  dx: 35mm,
  [
    *Cas le plus simple :*
    - masse ponctuelle

    - statique
  ],
)

#place(
  right + horizon,
  dx: 35mm,
  figure(
    scale(
      image(
        "./image/TrouNoir.gif",
      ),
      50%,
    ),
  ),
)

#pagebreak()

#place(
  left + horizon,
  dx: 10mm,
  dy: -20mm,
  [
    Espace vide : $T_(mu nu) = 0$\
    \
    Alors $R = 0$ et donc $R_(mu nu) = 0$
  ],
)

#place(
  center + horizon,
  dy: -20mm,
  [
    $
      +
    $
  ],
)

#place(
  right + horizon,
  dy: -20mm,
  align(center)[
    Espace statique\ à symétrie sphérique :
    $
      ds^2 = A(r) dt^2 - B(r) dr^2 - r^2 dif Omega^2
    $
  ],
)

#place(
  center + bottom,
  dy: -10mm,
  [
    $
      arrow.b.double\
      A(r) = 1 - R_s / r et B(r) = (1 - R_s / r)^(-1)
    $
  ],
)

#pagebreak()

= 3) Chute dans un trou noir

#pagebreak()

#place(
  left,
  dy: 20mm,
  align(center)[
    Lagrangien:\
    $
      cal(L) = g_(mu nu) dot(x)^mu dot(x)^nu
    $
  ],
)

#place(
  left,
  dy: 30mm,
  dx: 75mm,
  $
    ==>
  $,
)

#place(
  center,
  dy: 20mm,
  align(center)[
    $
      dt/(dif tau) = k /(1 - R_s/r)
    $
  ],
)

#place(
  bottom + center,
  dy: -10mm,
  align(center)[
    Norme\
    du quadri-vecteur :
    $
      g_(mu nu) dot(x)^mu dot(x)^nu = 1
    $
  ],
)

#place(
  center + horizon,
  dx: 25mm,
  $
    & + "           " & ==>
  $,
)

#place(
  right + horizon,
  align(center)[
    $
      ((dif r)/(dif tau))^2 = k^2 - 1 + R_s/r
    $
  ],
)

#pagebreak()

#place(
  center + horizon,
  grid(
    columns: 2,
    column-gutter: 45mm,
    row-gutter: 30mm,
    [Du point de vue\ de l’objet], [Du point de vue\ d’un observateur lointain],
    $
      tau(r) tend(r, R_s) 2/3 (sqrt(R_0^3/R_s) - R_s)
    $,
    $
      t(r) tend(r, R_s) +oo
    $,
  ),
)

#line(start: (50%, 10%), end: (50%, 90%))

#pagebreak()

#place(
  center + horizon,
  cetz.canvas({
    import cetz.draw: *

    let R0 = 2
    let Rs = 0.5

    let temprop(x, R) = 2 / 3 * (calc.sqrt(calc.pow(R, 3) / Rs) - calc.sqrt(calc.pow(x, 3) / Rs))
    let tempob(x, R) = (
      2 / 3 * Rs * (calc.pow(R / Rs, 2 / 3) - calc.pow(x / Rs, 2 / 3))
        + 2 * Rs * (calc.pow(R / Rs, 1 / 2) - calc.pow(x / Rs, 1 / 2))
        + Rs
          * calc.ln(calc.abs(
            (1 - calc.sqrt(R / Rs)) * (1 + calc.sqrt(x / Rs)) / ((1 + calc.sqrt(R / Rs)) * (1 - calc.sqrt(x / Rs))),
          ))
    )


    plot.plot(
      size: (10, 10),
      x-min: 0,
      x-max: R0,
      y-min: 0,
      y-max: 3,
      x-tick-step: none,
      y-tick-step: none,
      axis-style: "left",
      x-label: [#h(7mm)$r$],
      y-label: $#h(-5mm)t$,

      {
        plot.add(
          samples: 200,
          domain: (Rs + 0.001, R0 + 1),
          x => tempob(x, R0),
        )

        plot.add-vline(
          Rs,
          style: (stroke: (paint: black, dash: "dashed")),
        )
      },
    )
  }),
)

#pagebreak()

= 4) Trou noir & blanc

#pagebreak()
