#set page(
    paper: "presentation-4-3",
    header: context [
        #set text(15pt, fill: white)
        #place(
            dx:-20mm,
            box(fill: rgb("#171568"), height: 15mm, width: 110%)[
                #place(dx: -5mm, right+horizon,[#h(18mm) Gaspar Daguet, n=°XXXXXXX])
            ]
        )
    ],
    footer: context [
        #set align(right)
        #set text(20pt, fill: rgb("#ffffff"), weight: "extrabold", stroke: 1pt, font: "FreeSans")
        #place(
            dx:-5mm,
            box(height: 100%, width: 105%)[
                #scale(place(image("./image/methamorphose.jpg")),x: 111%)
                #place(dx: -7mm, right+horizon,counter(page).display(
                    "1 / 1",
                    both: true,
                    )
                )
            ]
        )
    ],
    footer-descent: 50%,
    margin: (x:5mm),
    numbering: ("1/1"),
)
#set text(25pt, font: "Linux Biolinum")
#set heading(numbering: (..numbers) => {
    let n = numbers.pos().len()
    if n == 1 {
    } else if n == 2 {
    } else if n == 3 {
    } else if n == 4 {
    } else if n == 5 {
    }
})
#show heading.where(level: 2): it => place(dy:-21mm, text(fill: white)[#it])
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
#place(center+horizon, dx: -60mm)[
#set align(left)

+ Introduction & Problématique
+ La pseudosphère
+ La projection
+ projeté des droites et des cercles
+ non conservation des longueurs
+ conservation des angles

]

#place(dx: 19mm,horizon+right, scale(figure(image("./image/cercle limite.jpg"), caption: [Cercle Limite III — M. C. Escher]), x: 10cm, y:10cm))

#pagebreak()

= 1) Introduction & Problématique

#pagebreak()

== 1) Introduction & Problématique

#grid(
    columns: 4,
    column-gutter: 3mm,
    row-gutter: 1.1cm,
    figure(caption: [Cahill-Keyes],image("image/diffprojS/300px-World_Map,_Political,_2012,_Cahill-Keyes_Projection.jpg")),
    figure(caption: [Rétro-azimutale de Craig],image("image/diffprojS/Craig_projection_SW.jpg")),
    figure(caption: [Équirectangulaire],image("image/diffprojS/Equirectangular_projection_SW.jpg")),
    figure(caption: [Goode],image("image/diffprojS/Goode_homolosine_projection_SW.jpg")),
    figure(caption: [Transverse Universelle de Mercator],image("image/diffprojS/MercTranEll.png")),
    figure(caption: [Globulaire de Nicolosi],image("image/diffprojS/Nicolosi_globular_projections_SW.jpg")),
    figure(caption: [Stéréographique],image("image/diffprojS/Stereographic_projection_SW.JPG", format: "jpg")),
    figure(caption: [Rétro-azimutale de Hammer],image("image/diffprojS/Hammer_retroazimuthal_projection_back_SW.JPG")),
)

#pagebreak()

#place(
    center+horizon,
    dy: -3.5cm,
    text(30pt)[
        *Problématique :*\
        Comment projeter une surface hyperbolique\
        sur le plan
    ]
)

#place(
    dy: 6cm,
    figure(scale(image("./image/pringels.png"), x: 80%, y: 80%), caption: place(center+bottom, dy: -7mm,text(20pt)[un pringle]))
)

#place(
    dy: 5.5cm,
    dx: 11cm,
    figure(scale(image("./image/carte_vielle.jpeg"), x: 50%, y: 60%), caption: place(center+bottom, dy: -1.5cm, text(20pt)[une carte]))
)

#place(
    center+horizon,
    dy: 3.5cm,
    dx: -3mm,
    text(60pt)[
        $
            ==>
          $
    ]
)

#pagebreak()

#place(dx:45mm,center+horizon)[= 2) La Pseudosphère]

#place(dx: 8mm, dy: 7mm, scale(image("./image/ps1.jpg"), x: 9cm, y:9cm))

#pagebreak()

== 2) La Pseudosphère

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

== 2) La Pseudosphère

#place(
    horizon+left,
    dx:1.5cm,
    dy: -4cm,
    [On note ] + $display((diff P)/(diff u) = P_u)$
)
#place(
    horizon+left,
    dx:1.5cm,
    dy: 2cm,
    [L’application Normale :] + 
    $
      N:& [0; 2pi] times RR_+ --> RR^3\
      &"    "p "" arrow.long.bar  (P_u (p) and P_v (p))/norm(P_u (p) and P_v (p))
    $
)

#place(
    horizon+right,
    dx:-1.5cm,
    $
      E(p) = norm(P_u)^2 \
      \
      F(p) = <P_u | P_v> \
      \
      G(p) = norm(P_v)^2 \
      \
      cal(L)(p) = - <N_u | P_u> \
      \
      cal(M)(p) = - <N_v | P_u> \
      \
      cal(N)(p) = - <N_v | P_v> \
    $
)

#pagebreak()

== 2) La Pseudosphère

#place(
    center,
    dy: 13mm,
    [La courbure en $p in [0; 2pi] times RR_+$] + 
    $
      K(p) = (cal(L)(p)cal(N)(p) - cal(M)(p)^2)/(E(p)G(p) - F^2)
    $
)
#v(7cm)
Pour la pseudosphère :
#place(
    left+bottom,
    dx: 1cm,
    dy: -20mm,
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
    dy: -3cm,
    $ forall p in [0; 2pi] times RR_+, K(p) = -1 $ + 
    [Donc surface hyperbolique]
)

#pagebreak()

= 3) La projection

#pagebreak()

== 3) La projection

Idée de la projection de Mercator :

#place(
    top+center,
    dx: 0cm,
    dy: 2mm,
    figure(
        scale(image("./image/eleSphere.png"), x: 80%, y: 80%)
    )
)

#place(
    center+bottom,
    dy:-2cm,
    $
    (diff y)/(diff x)  = A/B
    $
)

#pagebreak()

== 3) La projection

#place(
    center+horizon,
    dy: -4cm,
    grid(
        columns: 2,
        column-gutter: 6cm,
        "Surface élémentaire :" + 
        $
        cal(E) = norm(f_u and f_v) diff u diff v
        $, 
        "Pour la pseudosphère :"+ 
        $
          cal(E) = (sh(v))/(ch^2(v)) diff u diff v
        $
    )
)
#place(
    bottom+left,
    dx: 12cm,
    dy: -3cm,
    grid(
        columns: 2,
        column-gutter: 2cm,
        align: horizon,
        [
            Or : $ B = (diff u)/ch(v) $
        ],
        [
            Donc 
            $
            A = cal(E)/B = th(v) diff v
            $
        ]
    
    )
)

#place(
    bottom+left,
    dx: -4cm,
    dy: 3cm,
    scale(image("image/elePS.png"), x:60%, y:60%)
)

#pagebreak()

== 3) La projection



#{
    set text(30pt)
    place(
        center + horizon,

        [
            La projection :
            $
            C : cases([0; 2pi] times RR_+--> RR^2, " " p = (u,v) arrow.long.bar vec(u,ch(v)))
            $
        ]
    )
}

#pagebreak()

== 3) La projection

#place()[Droites Quelconques :]

#place(
    bottom,
    figure(
        image("./image/carre.png", width: 40%),
    )
)

#place(
    right + bottom,
    figure(
        image("./image/carrePS.png"),
    )
)

#pagebreak()

Trouver un moyen pour proj’ter une image

#pagebreak()

= 4) Projeté des droites

#pagebreak()

== 4) projeté des droites

#place(
    dx: 7.5cm,
    dy: 6cm,
    [
        Équation des droites :
         - Méridiens : $g : t |-> P(u,t)$
         - Autres : $
            g : t |-> P(t, ch(sqrt(k^2 - (t + c)^2)))
                    $
    ]
)

#pagebreak()

== 4)  projeté des droites

#place(
    dx: 6cm,
    dy:1cm,
)[Méridiens :]

#place(
    bottom,
    figure(
        image("./image/DroiteM.png", width: 40%),
    )
)

#place(
    right + bottom,
    figure(
        image("./image/DroiteMPS.png"),
    )
)

#pagebreak()

== 4)  projeté des droites

#place(
    dx: 6cm,
    dy:1cm,
)[Droites Quelconques :]

#place(
    bottom,
    figure(
        image("./image/DroiteCK.png", width: 40%),
    )
)

#place(
    right + bottom,
    figure(
        image("./image/DroiteCKPS.png"),
    )
)

#pagebreak()

== 4) projeté des droites

#place(
    horizon,
    dx: 1cm,

    [
        Longueur d'arc :
        $
        d(A, B) = integral_(t_A)^t_B norm(g'(t)) dif t
        $
    ]
)

#place(
    horizon,
    dx: 14cm,
    dy: -3.5cm,
    [
        Sur la pseudosphère :
        $
        d(A,B) = ln(ch(u_B) / ch(u_A))
        $
    ]
)

#place(
    dx: 18.5cm,
    horizon,
    text(40pt,$eq.not$)
)

#place(
    horizon,
    dx: 14cm,
    dy: 3.5cm,
    [
        Sur la carte :
        $
        d(A,B) = ch(u_B) - ch(u_A)
        $
    ]
)

#place(
    bottom + center,
    [
        Donc la projection n'est pas équivalente
    ]
)

#pagebreak()

#place(
    left + horizon,
    dx: 1.5cm,
    figure(
        image("./image/distAB.png", width: 40%),
        caption: $d(A,B) = 1,99$
    ),
)

#place(
    right + horizon,
    dx: -1.5cm,
    figure(
        image("./image/distABPS.png", width: 40%),
        caption: $d(A,B) = 0,57$
    ),
)

#pagebreak()

= 5) Conservation des angles

#pagebreak()

== 5) conservation des angles

faut que je travaille

#pagebreak()

#place(
    image("image/Tissot.png")
)
#place(
    right,
    image("image/TissotPS.png")
)

#place(
    center+horizon,
    [
        Merci\
        De vortre attention
    ]
)