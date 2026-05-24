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

  + Géométrie Riemannienne

  + La métrique de Schwarzschild
  + Chute dans un trou noir
  + Trou noir & blanc

]

#place(
  horizon + right,
  scale(figure(image("./image/cercle_limite.jpg"), caption: [Cercle Limite III — M.C. Escher]), 70%),
)

#pagebreak()

= 1) Géométrie Riemannienne

#pagebreak()

#place(
  center + top,
  align(left, [
    *Définition :* Tenseur Métrique
    $
      "     Soit "g "un "(2,0)"-tenseur tel que : " <u|v> = u^mu v^nu g_(mu nu)
    $
    il généralise le théorème de pythagore, en effet :
    $
      ds^2 = g_(mu nu)dx^mu dx^nu
    $
  ])
)

#place(
  bottom,
  align(left)[
    $
      mat(1,0;0,1)
    $
    Espace 2D euclidéen
  ]
)

#place(
  bottom + center,
  align(center)[
    $
      mat(column-gap: #10mm, 1, 0, 0; 0, r^2, 0;0, 0, r^2 sin^2(theta))
    $
    Espace 3D sphérique
  ]
)

#place(
  bottom + right,
  align(center)[
    $
      mat(column-gap: #5mm, 1, 0, 0, 0; 0, -1, 0, 0; 0, 0, -1, 0; 0, 0, 0, -1)
    $
    Espace de Minkowski
  ]
)

#pagebreak()

#place(
  horizon + center,
  align(left)[
    *Définition* Géodésique :\
    ~~~~~~courbe qui éxtrémise la distance entre deux points dans l’espace\
    \
    Équation des géodésique :
    $
      dot.double(x)^mu + Gamma^mu""_(rho sigma) dot(x)^rho dot(x)^sigma = 0
    $
    avec les symboles de Christofell :
    $
      Gamma^mu""_(nu lambda) = 1/2 g^(mu alpha) (g_(nu alpha, lambda) + g_(lambda alpha, nu) - g_(nu lambda, alpha))
    $
  ],
)

#pagebreak()

#place(
  top + center,
  align(left)[
    *Définition :* Dérivé Covariante :
    $
      nabla_(mu) v^nu = partial_mu v^nu + Gamma^nu""_(mu rho) v^rho
    $
  ],
)

#place(
  left + horizon,
  dy: 15mm,
  align(left)[
    *Définition :* Tenseur de Riemann
    #[$
      R^sigma""_(mu nu rho) v^mu = [nabla_nu, nabla_rho]v^sigma
    $]
    Seconde écriture :
    $
      R^sigma""_(mu nu rho) = &partial_nu Gamma^sigma""_(mu rho) - partial_rho Gamma^sigma""_(mu nu)\
      &+ Gamma^sigma""_(nu lambda) Gamma^lambda""_(mu rho) - Gamma^sigma""_(rho lambda) Gamma^lambda""_(mu nu)
    $
  ]
)

#place(
  right + horizon,
  dx: -35mm,
  dy: 15mm,
  figure(
    scale(
      image("./image/Riemann_curvature.gif")
    )
  )
)

#pagebreak()

#place(
  center,
  dy: 20mm,
  text(30pt)[
    *Deux contraction :*
  ]
)

#place(
  horizon,
  dx: 50mm,
  align(center)[
    Tenseur de Ricci :
    $
      R_(mu nu) = R^sigma""_(mu sigma nu)
    $
  ]
)

#place(
  horizon + right,
  dx: -50mm,
  align(center)[
    Courbure Scalaire :
    $
      R = g^(mu nu) R_(mu nu)
    $
  ]
)

#pagebreak()

= 2) Métrique de Schwarzschild

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
    - Masse ponctuelle\ $=>$ symétrie sphérique

    - Statique
    - Espace vide 
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
  dx: 10mm,
  dy: 7mm,
  align(center)[
    Équation d’Einstein
    $
      underbrace(R_(mu nu) - 1/2 g_(mu nu)R, = #[Géométrie\ de l’univers]) = underbrace(kappa T_(mu nu), = #[Contenue\ de l’univers]) = 0
    $],
)

#place(
  right,
  dx: -30mm,
  dy: 20mm,
  align(center)[
    $
      underbrace(g^(mu nu) R_(mu nu), = R) - 1/2 underbrace(g^(mu nu) g_(mu nu), = delta^mu_mu = n) R = 0
    $
  ],
)

#place(
  center,
  dy: 30mm,
  $
    ==>
  $,
)

#place(
  bottom + center,
  dx: -70mm,
  dy: -25mm,
  align(center)[
    Donc
    $R(2 - n) = 0$
  ],
)

#place(
  center + bottom,
  dy: -25mm,
  $
    ==>
  $,
)

#place(
  bottom + center,
  dx: 60mm,
  dy: -20mm,
  align(center)[

    Ainsi $R = 0$\
    Donc :
    $R_(mu nu) = 0$
  ],
)

#pagebreak()

#place(
  left,
  dy: 20mm,
  dx: 0mm,
  align(center)[
    Espace statique\ à symétrie sphérique :
    $
      ds^2 = A(r) dt^2 - B(r) dr^2 - r^2 dif Omega^2
    $
  ],
)

#place(
  center,
  dy: 35mm,
  dx: 5mm,
  $
    ==>
  $,
)

#place(
  right,
  dx: -30mm,
  dy: 19.5mm,
  align(center)[
    #text(17pt)[$
      Gamma^1""_(mu nu) = mat(A'/(2B), 0, 0, 0; 0, B'/(2B), 0, 0; 0, 0, -r/B, 0; 0, 0, 0, - (r sin(theta)^2)/B)
    $]
  ],
)

#place(
  bottom,
  dx: 6mm,
  align(center, text(17pt)[
    Or $R_(mu nu) = 0$
    #[$
      cases(
        R_(0 0) = A'/(r B) + A''/(2B) - A'/(4B) (A'/A + B'/B) = 0,
        R_(1 1) = B'/(r B) - A''/(2A) + A'/(4A) (A'/A + B'/B) = 0,
        R_(2 2) = (r B')/(2 B^2) - 1/B - (r A')/(2A B) + 1 = 0,
        R_(3 3) = sin(theta)^2 ((r B')/(2 B^2) - 1/B - (r A')/(2A B) + 1) = 0
      )
    $]
  ])
)

#place(
  bottom + center,
  dy: -16mm,
  dx: -20mm,
  $
    ==>
  $,
)

#place(
  bottom + center,
  dx: 20mm,
  dy: -8mm,
  align(center)[
    #text(20pt)[$
      cases(A'' + 2/r A' = 0,B = 1/A)
    $]
  ]
)

#place(
  bottom + right,
  dy: -16mm,
  dx: -80mm,
  $
    ==>
  $,
)

#place(
  bottom + right,
  dx: -20mm,
  dy: -6mm,
  align(center)[
    #text(20pt)[$
      cases(A = 1 - R_s / r,B = (1 - R_s/r)^(-1))
    $]
  ]
)

#pagebreak()

#place(
  top + center,
  dy: 15mm,
  align(center)[
    $
      ds^2 = (1 - R_s/r)dt^2 - (1 - R_s/r)^(-1) dr^2 -r^2 d Omega^2
    $
  ],
)

#place(
  horizon + center,
  dy: 20mm,
  align(left)[
    *Deux singularités :*\
     - Une #text(style: "italic")[vrais] en $r = 0$

     - Une #text(style: "italic")[fausse] en $r = R_s$
  ]
)

#pagebreak()

= 3) Chute dans un trou noir

#pagebreak()

#place(
  left,
  dy: 20mm + 10mm,
  dx: 12mm,
  align(center)[
    Lagrangien:\
    $
      cal(L) = g_(mu nu) dot(x)^mu dot(x)^nu
    $
  ],
)

#place(
  left,
  dy: 30mm + 10mm,
  dx: 75mm,
  $
    ==>
  $,
)

#place(
  center,
  dy: 20mm + 10mm,
  align(center)[
    $
      dt/(dif tau) = k /(1 - R_s/r)
    $
  ],
)

#place(
  center,
  dx: 50mm,
  dy: 25mm + 10mm,
  [et],
)

#place(
  right,
  dy: 15mm + 10mm,
  align(center)[
    Norme\
    du quadri-vecteur :
    $
      g_(mu nu) dot(x)^mu dot(x)^nu = 1
    $
  ],
)

#place(
  center + bottom,
  dy: -15mm,
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

#set text(20pt)

#place(
  center + horizon,
  figure(
    cetz.canvas({
      import cetz.draw: *

      let R0 = 1
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

      let temps(x,p) = x + Rs * calc.ln(calc.abs(x / Rs - 1 )) + p


      plot.plot(
        size: (10, 10),
        x-min: 0,
        x-max: R0,
        y-min: 0,
        y-max: 1,
        x-tick-step: none,
        y-tick-step: none,
        axis-style: "left",
        x-label: [#h(7mm)$r$],
        y-label: $#h(-5mm)tau$,

        {
          plot.add(
            samples: 200,
            domain: (0, R0 + 1),
            x => temprop(x, R0),
          )

          plot.add(
            samples: 200,
            domain: (0.756, R0),
            x => temps(x,-0.1),
            style: (stroke: (paint: red, dash: "dashed"))
          )

          plot.add(
            samples: 200,
            domain: (0.55, R0),
            x => temps(x,1.2),
            style: (stroke: (paint: red, dash: "dashed"))
          )

          plot.add-vline(
            Rs,
            style: (stroke: (paint: black, dash: "dashed")),
          )

          plot.add-vline(
            R0,
            style: (stroke: (paint: black)),
          )
        },
      )

      let cone_aux(x,y, angle) = {

        line((x -  2 * calc.tan(angle / 2),y), (x, y -1))
        line((x +  2 * calc.tan(angle / 2),y), (x, y -1))

        circle((x,y), radius: ( 2 * calc.tan(angle / 2), calc.tan(angle /4)))

      }

      let cone(x,y, angle) = {
        cone_aux(x , y +1, angle)
      }

      cone(10,0, 45deg)
      cone(10,8.97, 45deg)

      cone(7.56,3.2, 30deg)

      cone(5.5,5.6, 15deg/4)


      content((5.1, -0.6), $R_s$)
      content((10.1, -0.6), $R_0$)
      content((10.1, 10.7), text(20pt)[observateur])

    }),
  caption: [temps propre en fonction de r (en bleu)\ avec les cônes de lumières et la trajectoire du rayon de lumière (en rouge)],
  supplement: [Fig]
  )
)