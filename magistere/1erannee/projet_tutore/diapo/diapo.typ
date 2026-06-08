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
      place(left + horizon, dy: -1mm, 
        text(fill: white, 30pt, weight: "bold")[#hydra()]
      )
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
  = #[Solution de Schwarzschild\ aux l’équations d’Einstein]\
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

      cone(7.56,3.2, 22deg)

      cone(5.5,5.6, 15deg/4)


      content((5.1, -0.6), $R_s$)
      content((10.1, -0.6), $R_0$)
      content((10.1, 10.7), text(20pt)[observateur])

    }),
  caption: [temps propre en fonction de r (en bleu)\ avec les cônes de lumières et la trajectoire du rayon de lumière (en rouge)],
  supplement: [Fig]
  )
)

#pagebreak()

= Conclusion

#pagebreak()

= Annexe

#set text(19pt)

#pagebreak()

== Différent types de trou noir

#place(
  center + horizon,
  table(
    columns: 3,
    align: center + horizon,
    table.vline(x: 1, start: 0, end: 1, stroke: 1pt),
    table.hline(y: 1, start: 0, end: 1, stroke: 1pt),
    table.cell(stroke: 0pt, []),table.cell(colspan: 2)[Moment Cinétique],
    table.header([Charge], $J = 0$, $J != 0$, level: 1),
    $Q = 0$, scale(75%, figure(image("./image/TrouNoir.gif"), caption: [Schwarzschild])), scale(90%, figure(image("./image/Kerr.gif"), caption: [Schwarzschild])),
    $Q != 0$, [Reissner-Nordström], [Kerr-Newman],
  )
)

#pagebreak()

== Remarque sur l’équation des géodésique

On peut en effet remarqué que 
$
  dot.double(x)^mu + Gamma^mu""_(rho sigma) dot(x)^rho dot(x)^sigma = 0 <==> dot.double(x)^mu = - Gamma^mu""_(rho sigma) dot(x)^rho dot(x)^sigma
$
Or la seconde loi de Newton s’écrit :
$
  m dot.double(x)^mu = sum upright(F)^mu
$
Ainsi on peut assimiler le terme $- Gamma^mu""_(rho sigma) dot(x)^rho dot(x)^sigma$ à une force.\
Donc la courbure de l’espace induie une force sur les objets

#pagebreak()

== Coordonnées d’Eddington–Finkelstein

#place(
  [
    État des cônes de lumière :
  ]
)

#let R0 = 2
#let Rs = 0.75

#figure(
  cetz.canvas({
    import cetz.draw: *

    let entr(r, p) = r + Rs * calc.ln(calc.abs(r / Rs - 1)) + p
    let sort(r, p) = -r - Rs * calc.ln(calc.abs(r / Rs - 1)) - p
    plot.plot(
      size: (10, 10),
      x-min: 0,
      x-max: 2 * Rs,
      y-min: 0,
      y-max: 3,
      x-tick-step: none,
      y-tick-step: none,
      axis-style: "left",
      x-label: $ r $,
      y-label: $ t $,
      {
        for i in (1, 2, 3) {
          plot.add(
            samples: 200,
            domain: (0, 2 * Rs),
            x => (x, entr(x, i)),
            style: (stroke: blue, marks: ">"),
          )
        }

        for i in (-0.5, -1.5, -2.5) {
          plot.add(
            samples: 200,
            domain: (0, 2 * Rs),
            x => (x, sort(x, i)),
            style: (stroke: red),
          )
        }

        plot.add-vline(
          Rs,
          style: (stroke: (paint: black, dash: "dashed")),
        )
      },
    )


    //les cones avant Rs
    circle((2.7, 2.5), radius: (0.7mm, 2mm))
    circle((2.7, 5.834), radius: (0.7mm, 2.03mm))
    circle((2.7, 9.17), radius: (0.7mm, 2mm))

    circle((3.9, 4.15), radius: (0.7mm, 6mm))
    circle((3.9, 7.52), radius: (0.7mm, 6mm))

    circle((4.39, 5.85), radius: (0.9mm, 9mm))

    //les cones apres Rs
    circle((6.08, 3), radius: (1.5mm, 0.5mm))
    circle((6.08, 6.35), radius: (1.5mm, 0.5mm))
    circle((6.08, 9.65), radius: (1.5mm, 0.5mm))

    circle((5.62, 4.8), radius: (1.3mm, 0.5mm))
    circle((5.62, 8.15), radius: (1.3mm, 0.5mm))

    circle((5.34, 6.7), radius: (1mm, 0.5mm))

    circle((6.805, 4.6), radius: (2mm, 0.6mm))
    circle((6.805, 7.93), radius: (2mm, 0.6mm))

    circle((7.848, 6.17), radius: (2.1mm, 0.6mm))

    //les tetes de fleches
    let tetfle(x, y, angl, color) = {
      let rotat(x, y, angl) = (calc.cos(angl) * x - calc.sin(angl) * y, calc.sin(angl) * x + calc.cos(angl) * y)

      let cood1 = (0, 0)
      let deucood1 = (0.33, 0)
      let cood2 = (0, 0)
      let deucood2 = rotat(0.33, 0, 50deg)
      deucood1 = rotat(deucood1.first(), deucood1.last(), angl)
      deucood2 = rotat(deucood2.first(), deucood2.last(), angl)
      cood1 = (cood1.first() + x, cood1.last() + y)
      deucood1 = (deucood1.first() + x, deucood1.last() + y)
      cood2 = (cood2.first() + x, cood2.last() + y)
      deucood2 = (deucood2.first() + x, deucood2.last() + y)
      line(cood1, deucood1, stroke: color)
      line(cood2, deucood2, stroke: color)
    }

    //rouge
    tetfle(3.41, 9.5, 22deg, red)
    tetfle(4.52, 8.6, 53deg, red)
    tetfle(4.74, 6.7, 58deg, red)

    tetfle(6.71, 1, -89deg, red)
    tetfle(8, 2.27, -78deg, red)
    tetfle(8.5, 4.96, -72deg, red)

    //bleu
    tetfle(3.7, 1.8, -80deg, blue)
    tetfle(4.58, 2.7, -102deg, blue)
    tetfle(4.8, 4.3, -108deg, blue)

    tetfle(6.387, 9.99, -138deg, blue)
    tetfle(7.51, 8.7, -147deg, blue)
    tetfle(9.02, 7.3, -156deg, blue)

    content((5.06, -0.5), $R_s$)
  }),
  caption: [
    structure des cônes de lumière ( seul le coté future est montré )\ pour la métrique de Schwarzschild
    en bleu les rayons sortants, et en rouge les rayons entrants
  ],
)

#pagebreak()

#place(
  align()[
    *l’idée :* se placé dans un système de coordonnées plus « naturel » pour d’écrire c’est objet\
    On à montré que les cônes de lumière était régie par ces équations :
    $
      t = - r - R_s ln abs(r/R_s - 1) + p_1 &"Rayon entrant"\
      t =  r + R_s ln abs(r/R_s - 1) + p_2 &"Rayon sortant"
    $
    Pour celà, on prend les deux constante d’intégration $p_1 \& p_2$ comme nouvelle coordonées de temps.\
    Ainsi la métrique devient :
    $
      ds^2 = (1- R_s/r) dif p^2 minus.plus 2 dr dif p - r^2 dif Omega^2 
    $
    avec $-$ pour les rayons entrants ( système dit avancées ) et $+$ pour les sortants ( système dit retardées ).\
    On remarque que la singularité en $R_s$ à disparut.
  ]
)

#pagebreak()

#place(
  center + horizon,
  [
    #figure(
      scale( 90%,grid(
        columns: 2,
        column-gutter: 3cm,
        cetz.canvas({
          import cetz.draw: *

          let ent(x, p) = p - x
          let sort(x, p) = x + 2 * Rs * calc.ln(calc.abs(x / Rs - 1)) + p
          plot.plot(
            size: (10, 10),
            x-min: 0,
            x-max: 2 * Rs,
            y-min: 0,
            y-max: 3,
            x-tick-step: none,
            y-tick-step: none,
            axis-style: "left",
            x-label: $r$,
            y-label: $t'$,

            {
              for i in range(0, 4) {
                plot.add(
                  domain: (0, 2 * Rs),
                  x => ent(x, i),
                  style: (stroke: red),
                )
              }

              for i in (0.5, 1.5, 2.5, 3.5) {
                plot.add(
                  domain: (0, 2 * Rs),
                  x => sort(x, i),
                  style: (stroke: blue),
                )
              }

              plot.add-vline(
                Rs,
                style: (stroke: (paint: black, dash: "dashed")),
              )
            },
          )

          rotate(-30deg)
          circle((1.1, 3.2499), radius: (1mm, 2mm))
          circle((-0.6, 6.156), radius: (1mm, 2mm))
          circle((-2.25, 9.04), radius: (1mm, 2mm))

          rotate(-12deg)
          circle((1.8, 3.85), radius: (1mm, 2.4mm))
          circle((-0.4, 6.32), radius: (1mm, 2.4mm))
          circle((2.5, 3.925), radius: (0.5mm, 1.2mm))

          rotate(-20deg)
          circle((2.97, 6.01), radius: (0.8mm, 2mm))
          circle((-0, 7.572), radius: (0.8mm, 2.1mm))
          circle((-2.94, 9.14), radius: (0.8mm, 2mm))

          circle((2.35, 5.51), radius: (0.6mm, 1.6mm))
          circle((-0.6, 7.07), radius: (0.6mm, 1.6mm))
          circle((-1.06, 6.767), radius: (0.6mm, 1.6mm))
          circle((-3.57, 8.64), radius: (0.6mm, 1.6mm))

          rotate(-10deg)

          circle((-0.5, 8.29), radius: (0.8mm, 2.5mm))
          circle((-3.67, 9.32), radius: (0.8mm, 2.5mm))

          rotate(-5deg)
          circle((-3.46, 10.16), radius: (1mm, 2.5mm))

          rotate((30 + 12 + 20 + 10 + 5) * 1deg)
          content((5.06, -0.4), $R_s$)
        }
      ),

      cetz.canvas({
        import cetz.draw: *

        let ent(x, p) = p + x
        let sort(x, p) = x - 2 * Rs * calc.ln(calc.abs(x / Rs - 1)) + p
        plot.plot(
          size: (10, 10),
          x-min: 0,
          x-max: 2 * Rs,
          y-min: 0,
          y-max: 3,
          x-tick-step: none,
          y-tick-step: none,
          axis-style: "left",
          x-label: $r$,
          y-label: $t'$,

          {
            for i in (0, 1, -1, 2) {
              plot.add(
                domain: (0, 2 * Rs),
                x => ent(x, i),
                style: (stroke: blue),
              )
            }

            for i in (0.5, 1.5, 2.5, -0.5) {
              plot.add(
                domain: (0, 2 * Rs),
                x => sort(x, i),
                style: (stroke: red),
              )
            }

            plot.add-vline(
              Rs,
              style: (stroke: (paint: black, dash: "dashed")),
            )
          },
        )

        rotate(37deg)
        circle((2.2, -0.2), radius: (1mm, 2mm))
        circle((4.2, 2.465), radius: (1mm, 2mm))
        circle((6.25, 5.135), radius: (1mm, 2mm))

        rotate(10deg)
        circle((6.25, 1.07), radius: (1mm, 2mm))
        circle((8.65, 3.329), radius: (1mm, 2mm))

        rotate(5deg)
        circle((9.77, 2.17), radius: (1mm, 2mm))

        rotate(15deg)
        circle((11.43, -1.73), radius: (0.5mm, 1.5mm))

        rotate(5deg)
        circle((8.9, -4.45), radius: (1.1mm, 3mm))

        rotate(10deg)
        circle((9.14, -7.46), radius: (1.2mm, 5mm))
        circle((5.83, -7.92), radius: (1.2mm, 5mm))


        rotate(-82deg)
        content((5.06, -0.4), $R_s$)
      }))),
      caption: [diagramme $(t',r)$, avec les cônes de lumière,\ avec en rouge les photons entrants, et en bleu les photons sortants\ le système avancées à gauche, et retardées à droite],
    )
  ]
)

#place(
  bottom + center,
  dx: -6.4cm,
  dy: -2cm,
  box[trou noir]
)

#place(
  bottom + center,
  dx: 6.4cm,
  dy: -2cm,
  box[trou blanc]
)

