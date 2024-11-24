#set page(
    paper: "presentation-16-9",
    header: context [
        #set text(15pt, fill: white)
        #place(
            dx:-20mm,
            box(fill: rgb("#171568"), height: 15mm, width: 109%)[
                #place(dx: -5mm, right+horizon,[#h(18mm) Gaspar Daguet, n=°XXXXXXX])
            ]
        )
    ],
    footer: context [
        #set align(right)
        #set text(20pt, fill: rgb("#ffffff"), weight: "extrabold")
        #place(
            dx:-7mm,
            box(height: 100%, width: 104%)[
                #scale(place(image("./image/methamorphose.jpg")),x: 148%)
                #place(dx: 94%, horizon,counter(page).display(
                    "1 / 1",
                    both: true
                    )
                )
            ]
        )
    ],
    footer-descent: 50%,
    margin: (x:5mm),
    numbering: ("1/1"),
)
#set text(25pt, font: "Linux Libertine")
#set heading(numbering: (..numbers) => {
    let n = numbers.pos().len()
    if n == 1 {
    } else if n == 2 {
    } else if n == 3 {
    } else if n == 4 {
    } else if n == 5 {
    }
})
#show heading.where(level: 2): it => place(dy:-17.5mm, text(fill: white)[#it])
#show heading.where(level: 1): it => place(dy: -10mm,center+horizon, text()[#it])
#set enum(numbering: "1)")
#set figure(kind: "", supplement: none)
#let sh = $"sh"$
#let ch = $"ch"$
#let th = $"th"$
#let cal(body, _font: "LT Perfume") = $text(font: #_font, body)$ + h(7pt)

#place(center+horizon, dy: -2cm)[
= Projection cartographique \ de la Pseudosphère sur le plan
#place(dy: 10mm,center+horizon)[Gaspar Daguet, n=° XXXXXXX]
]

#place(center+bottom, scale(x: 80%, y:  80%,figure( image("./image/seaChase.png"), caption:  [Sea Chase - Xkcd])))
#pagebreak()

== Table des Matières
#place(center+horizon, dx: -70mm)[
#set align(left)

+ La pseudosphère
+ La projection
+ projeté des droites et (des cercles ?)
+ non conservation des longueurs
+ conservation des angles

]

#place(dx: -10mm,horizon+right, scale(figure(image("./image/cercle limite.jpg"), caption: [Cercle Limite III — M. C. Escher]), x: 10cm, y:10cm))

#pagebreak()

#place(dx:45mm,center+horizon)[= 1) La Pseudosphère]

#place(dx: 8mm, dy: 7mm, scale(image("./image/ps1.jpg"), x: 9cm, y:9cm))

#pagebreak()

== 1) La Pseudosphère

#{
    set text(size: 30pt)
    place(
        left+horizon,
        dx: 7mm,
        dy: 0mm,
        $
        P : cases([0; 2pi] times RR_+ &--> "    " RR^3,
            "    "(u,v) &arrow.r.long.bar vec( cos(u)/ch(v), sin(u)/ch(v), v - th(v))
        )
        $
    )
}

#place(
    right+horizon,
    dx: -40mm,
    dy: 0mm, 
    figure(
        image("./image/PS.png"),
    )
)

#pagebreak()

== 1) La Pseudosphère

#place(
    horizon+left,
    dx:3cm,
    [L’application Normale :] + 
    $
      N:& [0; 2pi] times RR_+ --> RR^3\
      &"    "(u,v) "" arrow.long.bar  (P_u and P_v)/norm(P_u and P_v)
    $
)

#place(
    horizon+right,
    dx:-3cm,
    $
      E(u,v) = norm(f_u)^2 \
      \
      F(u,v) = <f_u | f_v> \
      \
      G(u,v) = norm(f_v)^2 \
      \
      cal(L)(u,v) = - <N_u | f_u> \
      \
      cal(M)(u,v) = - <N_v | f_u> \
      \
      cal(N)(u,v) = - <N_v | f_v> \
    $
)

#pagebreak()

== 1) La Pseudosphère

#place(
    center,
    dy: 3mm,
    [La courbure en $p in [0; 2pi] times RR_+$] + 
    $
      K(p) = (cal(L)(p)cal(N)(p) - cal(M)(p)^2)/(E(p)G(p) - F^2)
    $
)
#v(5.5cm)
Pour la pseudosphère :
#place(
    left+bottom,
    dx: 1cm,
    dy: 0mm,
    grid(
        columns: 2, 
        align: horizon + center,
        column-gutter: 7mm,
        row-gutter: 10mm,
        rows: 2,
        $
        F = cal(M) = 0 
        $,
        $
        cal(L) = -cal(N) = sh(v)/ch(v)\
        $,
        $
        E = 1/ch(v)
        $,
        $
        G = (sh^2(v))/(ch^2(v))
        $
        
    )
)
#place(
    right+bottom,
    dx: -2cm,
    dy: -1cm,
    $ forall p in [0; 2pi] times RR_+, K(p) = -1 $ + 
    [Donc surface hyperbolique]
)

#pagebreak()

== 2) La projection

projection de mercator, même idée : on présèreve les surface élémentaire

dèf surface élémentaire

les calcules !

#pagebreak()

== 3) projeté des droites et des sphère 

dèf droites et cercle

calcule par la projection

joli dessin

#pagebreak()

== 4) non conservation des longueurs

calcule de la distance sur S et sur P voir que diff

#pagebreak()

== 5) conservation des angles

faut que je travaille
#place(dx:-30mm,dy:0mm, scale(x: 80%,y: 80%,image("./image/notlikethis.jpg")))
