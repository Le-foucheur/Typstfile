#import "../../../../template.typ": *
#import "@preview/hydra:0.6.2": hydra
#import "@preview/cetz:0.5.2"

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

#place(center + horizon, dy: -1.5cm)[
  = Double Pendule\
  \
  Gaspar Daguet
]

#place(
  center + bottom,
  dy: 25mm,
  scale( 50%,
    figure(image(
      "./image/pendulum_types.png"
    ),
    caption: [Pendulum Types - Xkcd],
    )
  )
)

#pagebreak()
=
== Table des matières
#place(center + horizon, dx: -60mm)[
  #set align(left)

  + Le TUI

  + Double Pendule
  + Chaîne

]

#place(
  horizon + right,
  scale(figure(image("./image/fractale.webp"), caption: [Cercle Limite III — M.C. Escher]), 70%),
)

#pagebreak()

= 1) TUI

#pagebreak()

#place(
  dx: 14mm + 20mm,
  dy: 5mm,
  [En machine]
)

#let noir = table.cell(fill: black)[]
#place(
  bottom,
  dx: 0mm + 20mm,

  table(
    inset: 0.9cm,
    columns: 4,
    rows: 6,

    table.vline(x: 2,start: 0, end: 6, stroke: red + 2pt),
    table.hline(y: 3,start: 0, end: 4, stroke: red + 2pt),

    noir,[],       [],[],
    [], noir,      [],[],
    [], noir,      [],[],


    [],[],          noir,[],
    [],noir,        noir,noir,
    [],[],          noir,[],
  )
)

#place(
  horizon + center,
  dy: 9.2mm,
  dx: -45mm + 20mm,

  $==>$
)

#place(
  center + horizon,
  dy: 10mm,
  dx: 0mm + 20mm,

  table(
    inset: 0.9cm,
    columns: 2,

    [🬧],[ ],
    [🬇],[🬛]

  )
)

#place(
  horizon + center,
  dy: 9.2mm,
  dx: 45mm + 20mm,

  $<==>$
)

#place(
  right,
  dx: -30mm + 20mm,
  dy: 30mm,
  [ce qui est affiché]
)

#place(
  right + horizon,
  dy: 10mm,
  dx: -40mm + 20mm,

  align(left,par(leading: 8.1mm, text(60pt)[
    🬧\
    🬇🬛
  ]))
)

#pagebreak()

= 2) Double Pendule

#pagebreak()

#place(
  right + horizon,
  dx: -3cm,
  cetz.canvas({
    import cetz.draw: *

    circle((0,0), fill: black, radius: 0.25, name: "attache")
    circle((30deg - 90deg, 5), radius: 0.25, fill: black, name: "p1")
    line("attache", "p1", name: "l1")
    line("p1", (rel: (-20deg - 90deg, 5)),name: "lignep1p2")

    circle("lignep1p2.end", radius: 0.25, fill: black, name: "p2")

    line("attache", (rel: (0,-3)), stroke: (dash: "dashed"), name: "hatta")
    line("p1", (rel: (0,-3)), stroke: (dash: "dashed"), name: "hp1")

    cetz.angle.angle("attache", "hatta.start", "l1.start", radius: 500%, label: text(15pt, $theta_1$), label-radius: 1.6)
    cetz.angle.angle("p1", "lignep1p2", "hp1", radius: 100%, label: text(15pt, $theta_2$), label-radius: 2)

    content("p1", text(15pt,$M_1$), padding: 0.15, anchor: "south-west")
    content("p2", text(15pt,$M_2$), padding: 0.15, anchor: "north-west")

    content("l1.50%", text(15pt, $L_1$), padding: 0.1, angle: "l1.end", anchor: "south")
    content("lignep1p2.50%", text(15pt, $L_2$), padding: 0.1, angle: "l1.end", anchor: "south")
  })
)

#place(
  left + horizon,
  dx: 0.5cm,

  align(center)[
    Équation différentielle :\
    #text(20pt, $
                  cases(
                    #box($
                    &(M_1 + M_2) L_1 dot.double(theta)_1 + M_2 L_2 dot.double(theta)_2 cos(theta_1 - theta_2)\
                     &+ M_2 L_2 dot(theta)_2^2 sin(theta_1 - theta_2) + (M_1 + M_2) g sin(theta_1) = 0
                    $),
                    ,
                    L_1 dot.double(theta)_1 cos(theta_1 - theta_2) + L_2 dot.double(theta)_2 - M_2 L_1 dot(theta)_1^2 sin(theta_1 - theta_2) + g sin(theta_2) = 0,
                    delim: #none
                  )
                $)
  ]
)

#pagebreak()

#place(
  dy: 5mm,
  center,
  $Delta theta_2 = 10^(-6)$
)

#place(
  center + horizon,
  dx: -75mm,
  dy: 10mm,
  scale(60%, figure(
    image(
      "./image/nonchaos.pdf",
    ),
    caption: [
      $Delta x et Delta y$ en fonction du temps
    $
    "pour " theta_1 &= 2.439\
     "et " theta_2 &= -0.553
    $]
  ))
)

#place(
  center + horizon,
  dx: 75mm,
  dy: 10mm,
  scale(60%, figure(
    image(
      "./image/chaos.pdf"
    ),
    caption: [
      $Delta x et Delta y$ en fonction du temps
    $
    "pour " theta_1 &= 1.004\ 
    "et " theta_2 &= 1.968
    $]
  ))
)

#pagebreak()

#place(
  center+top,
  align(center)[
    Sans frottement :
    #v(-1.45cm)
    #grid(
    columns: 2,  
      scale(
        100%,
        figure(
          image("./image/phaseSansFrot.pdf")
        )
      ),
      scale(
        100%,
        figure(
          image("./image/energieSansFrot.pdf")
        )
      )
    )
    #v(-1.5cm)
    Avec frottement :
    #v(-1.45cm)
    #grid(
    columns: 2,  
      scale(
        100%,
        figure(
          image("./image/phaseFrot.pdf")
        )
      ),
      scale(
        100%,
        figure(
          image("./image/energieFrot.pdf")
        )
      )
    )
  ]
)

#pagebreak()

= 3) Chaîne

#pagebreak()

#place(
  dx: -2cm,
  grid(
    columns: 2,
    column-gutter: -4cm,
    
    scale(
      50%,
      figure(
        image(
          "./image/chaine.jpg"
        )
      )
    ),

    scale(
      50%,
      cetz.canvas({
        import cetz.draw: *

        for i in range(0,10) {
          circle((i,-i - i* calc.pow(1.1, -i)), radius: 0.25, fill: black, name: "p" + str(i))
        }
        for i in range(0,9){
          line("p" + str(i), "p" + str(i+1))
        }
      })
    )
  )
)

#place(
  horizon,
  dx: 7.2cm,
  dy: -0.7cm,
  $
    <==>
  $
)

#place(
  right + horizon,
  align(center)[
    Équation différentielle :
    #text(15pt)[$
      forall k &in [|1;n|]\
      (n + 1 - k)&(dot.double(theta)_k + g/l_k sin(theta_k))\
      &+ (n+1-k)sum_(i = 1)^(k-1) (dot.double(theta)_i cos(theta_k - theta_i) + dot(theta)_i^2 sin(theta_k - theta_i))\
      &+ sum_(i = k + 1)^n (n + 1 - j) (dot.double(theta)_i cos(theta_i - theta_k) - dot(theta)_i^2 sin(theta_i theta_k)) = 0 
    $]
  ]
)

#pagebreak()

#place(
  horizon + left,
  dy: 15mm,
  dx: 20mm,
  align(center)[
    potition initiale\ de la chaine :
    #v(-3.5cm)
    #scale(
      50%,
      image("./image/chaineinitiale.png")
    )
  ]
)

#place(
  horizon,
  dx: 7.5cm,
  dy: 10mm,
  $
    ==>
  $
)

#place(
  horizon + left,
  dy: 15mm,
  dx: 9cm,
  align(center)[
    après quelque\ seconde :
    #v(-3.5cm)
    #scale(
      50%,
      image("./image/chainetapres.png")
    )
  ]
)

#place(
  horizon + right,
  dy: 15mm,
  dx: 4cm,
  align(center)[
    position en $x$\ du 50ième et 100ième\ pendule :
    #v(-3.5cm)
    #scale(
      50%,
      image("./image/posxchaine.png")
    )
  ]
)
