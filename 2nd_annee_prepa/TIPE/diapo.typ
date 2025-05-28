#set page(
  paper: "presentation-4-3",
  header: context [
    #set text(15pt, fill: white)
    #place(
      dx: -20mm,
      box(fill: rgb("#171568"), height: 15mm, width: 110%)[
        #place(dx: -5mm, right + horizon, [#h(18mm) Gaspar Daguet, n°=21528])
      ],
    )
  ],
  footer: context [
    #set align(right)
    #set text(20pt, fill: rgb("#ffffff"), weight: "extrabold", stroke: 1pt, font: "FreeSans")
    #place(
      dx: -5mm,
      box(height: 100%, width: 105%)[
        #scale(place(image("./image/methamorphose.jpg"), dx: -1mm), x: 111%)
        #place(
          dx: -7mm,
          right + horizon,
          counter(page).display(
            "1 / 1",
            both: true,
          ),
        )
      ],
    )
  ],
  footer-descent: 50%,
  margin: (x: 5mm),
  numbering: "1/1",
)
#set text(25pt, font: "Linux Biolinum")
#set heading(
  numbering: (..numbers) => {
    let n = numbers.pos().len()
    if n == 1 { } else if n == 2 { } else if n == 3 { } else if n == 4 { } else if n == 5 { }
  },
)
#show heading.where(level: 2): it => place(dy: -21mm, text(fill: white)[#it])
#show heading.where(level: 1): it => place(dy: -10mm, center + horizon, text()[#it])
#set enum(numbering: "1)")
#set figure(kind: "", supplement: none)
#let sh = math.op("sh", limits: false)
#let ch = math.op($"ch"$, limits: false)
#let th = math.op($"th"$, limits: false)
#let cal(body, _font: "LT Perfume") = $text(font: #_font, body)$ + h(7pt)
#let scal(x, y) = math.op($< #x | #y >$)

#place(center + horizon, dy: -2cm)[
  = Projection cartographique \ de la pseudosphère sur le plan
  #place(dy: 10mm, center + horizon)[Gaspar Daguet, n°= 21528]
]

#place(center + bottom, scale(x: 80%, y: 80%, figure(image("./image/seaChase.png"), caption: [Sea Chase - Xkcd])))
#pagebreak()

== Table des matières
#place(center + horizon, dx: -60mm)[
  #set align(left)

  + Introduction et problématique

  + La pseudosphère
  + La projection
  + Projection des droites

]

#place(
  dx: 19mm,
  horizon + right,
  scale(figure(image("./image/cercle limite.jpg"), caption: [Cercle Limite III — M. C. Escher]), x: 10cm, y: 10cm),
)

#pagebreak()

= 1) Introduction et problématique

#pagebreak()

== 1) Introduction et problématique

#grid(
  columns: 4,
  column-gutter: 3mm,
  row-gutter: 1.3cm,
  figure(
    caption: [Cahill-Keyes : 1975],
    image("image/diffprojS/300px-World_Map,_Political,_2012,_Cahill-Keyes_Projection.jpg"),
  ),
  figure(caption: [Rétro-azimutale de Craig : 1909], image("image/diffprojS/Craig_projection_SW.jpg")),
  figure(caption: [Équirectangulaire : 120], image("image/diffprojS/Equirectangular_projection_SW.jpg")),
  figure(caption: [Goode : 1923], image("image/diffprojS/Goode_homolosine_projection_SW.jpg")),

  figure(caption: [Transverse Universelle de Mercator : 1822], image("image/diffprojS/MercTranEll.png", width: 80%)),
  figure(caption: [Globulaire de Nicolosi : ~1000], image("image/diffprojS/Nicolosi_globular_projections_SW.jpg")),
  figure(
    caption: [Stéréographique : ~200 av J.C.],
    image("image/diffprojS/Stereographic_projection_SW.JPG", format: "jpg", width: 80%),
  ),
  figure(
    caption: [Rétro-azimutale de Hammer : 1910],
    image("image/diffprojS/Hammer_retroazimuthal_projection_back_SW.JPG", width: 80%),
  ),
)

#pagebreak()

#place(
  center + horizon,
  dy: -3.5cm,
  text(30pt)[
    *Problématique :*\
    Comment projeter une surface hyperbolique\
    sur le plan ?
  ],
)

#place(
  dy: 6cm,
  figure(
    scale(image("./image/pringels.png"), x: 80%, y: 80%),
    caption: place(center + bottom, dy: -7mm, text(20pt)[une chips]),
  ),
)

#place(
  dy: 5.5cm,
  dx: 11cm,
  figure(
    scale(image("./image/carte_vielle.jpeg"), x: 50%, y: 60%),
    caption: place(center + bottom, dy: -1.5cm, text(20pt)[une carte]),
  ),
)

#place(
  center + horizon,
  dy: 3.5cm,
  dx: -3mm,
  text(60pt)[
    $
      ==>
    $
  ],
)

#pagebreak()

#place(dx: 45mm, center + horizon)[= 2) La pseudosphère]

#place(dx: 8mm, dy: 7mm, scale(image("./image/ps1.jpg"), x: 9cm, y: 9cm))

#pagebreak()

== 2) La pseudosphère

#{
  set text(size: 30pt)
  place(
    left + horizon,
    dx: 7mm,
    dy: 0mm,
    $
      P : cases(
        [0; 2pi] times RR_+ &--> "    " RR^3,
        "    "(u,v) &arrow.r.long.bar vec(cos(u) / ch(v), sin(u) / ch(v), v - th(v))
      )
    $,
  )
}

#place(
  right + horizon,
  dx: -40mm,
  dy: 0mm,
  figure(image("./image/PS.png")),
)

#pagebreak()

== 2) La pseudosphère

#place(
  horizon + left,
  dx: 1.5cm,
  dy: -4cm,
  [On note ] + $display((diff P) / (diff u) = P_u)$,
)
#place(
  horizon + left,
  dx: 1.5cm,
  dy: 2cm,
  [L’application Normale :]
    + $
      N:& [0; 2pi] times RR_+ --> RR^3\
      &"    "p "" arrow.long.bar (P_u (p) and P_v (p)) / norm(P_u (p) and P_v (p))
    $,
)

#place(
  horizon + right,
  dx: -2cm,
  $
    E(p) = norm(P_u)^2 \
    \
    F(p) = <P_u | P_v> \
    \
    G(p) = norm(P_v)^2 \
    \
    cal(L)(p) = <P_(u u) | N > \
    \
    cal(M)(p) = <P_(u v) | N> \
    \
    cal(N)(p) = < P_(v v) | N > \
  $,
)

#pagebreak()

== 2) La pseudosphère

#place(
  center,
  dy: 13mm,
  [La courbure en $p in [0; 2pi] times RR_+$]
    + $
      K(p) = (cal(L)(p)cal(N)(p) - cal(M)(p)^2) / (E(p)G(p) - F(p)^2)
    $,
)
#place(
  center + bottom,
  dy: -0cm,
  figure(
    image("image/courbure/courbureGauss.png", width: 65%),
    caption: text(10pt)[source : Localisation d'objets 3D industriels à l'aide d'un algorithme de SLAM contraint au modèle],
  ),
)

#pagebreak()

== 2) La pseudosphère

#place(
  center + horizon,
  grid(
    columns: 4,
    [Sphèrique : $K > 0$],
    image("image/courbure/sphere.jpg", width: 70%),
    [Plan : $K = 0$],
    image("image/courbure/cylindre.jpg", width: 70%),

    [Hyperbolique: $K < 0$],
    image("image/courbure/hyperboloide1nape.jpg", width: 70%),
    [Pseudosphère : $K = -1$],
    image("image/courbure/pseudosphere2.jpg", width: 70%),
  ),
)

#place(
  bottom + center,
  text(10pt)[source : https://mathcurve.com],
)

#pagebreak()

= 3) La projection

#pagebreak()

== 3) La projection

Idée de la projection de Mercator :

#place(
  top + center,
  dx: 0cm,
  dy: 2mm,
  figure(scale(image("./image/eleSphere.png"), x: 80%, y: 80%)),
)

#place(
  center + bottom,
  dy: -2cm,
  $
    (diff y) / (diff x) = A / B
  $,
)

#pagebreak()

== 3) La projection

#place(
  center + horizon,
  dy: -4cm,
  grid(
    columns: 2,
    column-gutter: 6cm,
    "Surface élémentaire :"
      + $
        cal(E) = norm(P_u and P_v) diff u diff v
      $,
    "Pour la pseudosphère :"
      + $
        cal(E) = (sh(v)) / (ch^2(v)) diff u diff v
      $,
  ),
)
#place(
  bottom + left,
  dx: 12cm,
  dy: -3cm,
  grid(
    columns: 2,
    column-gutter: 2cm,
    align: horizon,
    [
      Or : $ B = (diff u) / ch(v) $
    ],
    [
      Donc :
      $
        A / B = cal(E) / B^2 = (sh(v) diff v) / (diff u)
      $
    ],
  ),
)

#place(
  bottom + left,
  dx: -4cm,
  dy: 3cm,
  scale(image("image/elePS.png"), x: 60%, y: 60%),
)

#pagebreak()

== 3) La projection



#{
  set text(30pt)
  place(
    dy: 15mm,
    dx: 2cm,
    left + top,

    [
      La projection :
      $
        C : cases([0; 2pi] times RR_+--> RR^2, " " p = (u,v) arrow.long.bar vec(u, ch(v)))
      $
    ],
  )
}
#{
  set text(30pt)
  place(
    dy: -15mm,
    dx: 2cm,
    left + bottom,
    [
      Celle de Mercator :
      $
        M: cases([0;2pi] times [-pi;pi] --> RR^2, p = (u,v) arrow.long.bar vec(u, ln(tan(v / 2 + pi / 4))))
      $
    ],
  )
}
#place(
  right + horizon,
  image("image/projTerrePS.png", height: 18cm),
)

#pagebreak()

== 3) La projection

#place(
  horizon,
  dx: 2cm,
  figure(image("./image/cadir.png", width: 40%)),
)

#place($ 1 $, dx: 1.5cm, dy: 15cm)
#place(sym.arrow.t, dx: 1.2cm)
#place($ +oo $, dx: 0.5cm, dy: 0.9cm)
#place($0$, dx: 2.04cm, dy: 15.7cm)
#place($ 2pi $, dx: 12.2cm, dy: 15.7cm)

#place(
  right + horizon,
  dx: -2cm,
  figure(image("./image/cadirPS.png")),
)

#pagebreak()

== 3) La projection

#place(
  horizon,
  dx: 2cm,
  figure(image("./image/Cercle.png", width: 40%)),
)

#place(
  right + horizon,
  dx: -2cm,
  figure(image("./image/CerclePS.png")),
)

#pagebreak()

= 4) Projection des droites

#pagebreak()

== 4) Projection des droites

#place(
  dx: 7.5cm,
  dy: 6cm,
  [
    Équation des droites ( géodésique ) :
    - Méridiens : $g : t |-> P(u,t)$
    - Autres droites : $ g : t |-> P(t, ch(sqrt(k^2 - (t + c)^2))) $
  ],
)

#pagebreak()

== 4) Projection des droites

#place(
  dx: 6cm,
  dy: 1cm,
)[Méridiens :]

#place(
  bottom,
  figure(image("./image/DroiteM.png", width: 40%)),
)

#place(
  right + bottom,
  figure(image("./image/DroiteMPS.png")),
)

#pagebreak()

== 4) Projection des droites

#place(
  dx: 6cm,
  dy: 1cm,
)[Droites quelconques :]

#place(
  bottom,
  figure(image("./image/DroiteCK.png", width: 40%)),
)

#place(
  right + bottom,
  figure(image("./image/DroiteCKPS.png")),
)

#pagebreak()

== 4) Projection des droites

#place(
  horizon,
  dx: 1cm,

  [
    Longueur d'arc :
    $
      d(A, B) = integral_(t_A)^t_B norm(g'(t)) dif t
    $
  ],
)

#place(
  right,
  dx: -3cm,
  [
    Sur les méridiens ($v_A = v_B$) :
  ],
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
  ],
)

#place(
  dx: 18.5cm,
  horizon,
  text(40pt, $eq.not$),
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
  ],
)

#place(
  bottom + center,
  [
    Donc la projection n'est pas équivalente
  ],
)

#pagebreak()

== 4) Projection des droites


#place(
  left + horizon,
  dx: 1.5cm,
  figure(
    image("./image/distAB.png", width: 40%),
    caption: $d(A,B) = 1,99$,
  ),
)

#place(
  right + horizon,
  dx: -1.5cm,
  figure(
    image("./image/distABPS.png", width: 40%),
    caption: $d(A,B) = 0,57$,
  ),
)



#pagebreak()

== 4) Projection des droites


#place(
  dx: 2cm,
  image("image/Tissot.png"),
)
#place(
  dx: -2cm,
  right,
  image("image/TissotPS.png"),
)

#pagebreak()

#place(
  center + horizon,
  image("prog/merci.png", width: 200%),
)

#pagebreak()

= Annexes

#pagebreak()

== Annexes - Première forme fondamentale

La première forme fondamentale est l'écriture formelle du produit scalaire dans le plan tangent au point $p$ de la surface $S$

Or le produit scalaire entre deux vecteur du plan tangent peut s'écrire comme la combinaison linéaire entre $P_u (p)$ et $P_v (p)$, donc le produit scalaire peut s'écrire :
$
  I (a P_u + b P_v, c P_u + d P_v) = < a P_u + b P_v | c P_u + d P_v > \
  = a c underbrace((P_u)^2, = E) + (a d + b c) underbrace(<P_u | P_v >, = F) + b d underbrace(norm(P_v)^2, = G)
$

Ainsi sous forme matricielle pour les vecteur $x$ et $y$ du plan tangent :
$
  I(x,y) = x^T mat(E, F; F, G) y
$

#pagebreak()

== Annexes - Seconde forme fondamentale

Dans le repère $(P_u(p), P_v(p), N(p))$, on peut faire un dévelopement limité de la surface de la forme :
$
  z = underbrace(<P_(u u) | N >, = cal("L")) x^2 / 2 + underbrace(<P_(u v) | N >, cal("M")) + underbrace(<P_(v v) | N >, = cal("N")) x^2 / 2
$
Ainsi on définit la seconde forme fondamentale par :
$
  upright(I I) = L dif x^2 + 2 M dif x dif y + N dif y^2
$
Et donc sous forme matricielle :
$
  upright(I I) = mat(cal(L), cal(M); cal(M), cal(N))
$

#pagebreak()

== Annexes - Endomorphisme de Weingarten

L'endomorphisme de Weingarten (ou opérateur de forme) est définis par :
$
  W = dif N
$
De plus, ses valeurs propres sont les courbures principales au point $p$, \ et ses vecteurs propres sont la direction des courbures principales\

Comme l'on définit la courbure de Gauss par le produit des valeurs propres,\
alors le déterminant de l'endomorphisme de Weingarten est la courbure de Gauss \
$
  K(p) = det(W)
$

Nous avons également que la seconde forme fondamentale est la forme quadratique associée à l'endomorphisme de Weingarten

#pagebreak()

== Annexes - Démonstation courbure de Gauss

Soit $arrow(x), arrow(y)$ deux vecteurs du plan tangent au point $p$ sur notre surface $P$\
tel que $arrow(y)$ soit un vecteur propre de $W$ associé a la valeur propre $lambda$\
Ainsi la première forme fondamentale nous donne le produit scalaire entre ces deux vecteurs :
$
  <arrow(x) | arrow(y) > = X^T mat(E, F; F, G) Y
$
Et comme la seconde forme fondamentale est la quadratique associé à l'endomorphisme de Weingarten :
$
  <arrow(x) | W(arrow(y)) > = X^T mat(cal(L), cal(M); cal(M), cal(N)) Y
$

#pagebreak()

== Annexes - Démonstation courbure de Gauss

Donc comme $arrow(y)$ est vecteur propre :
$
  X^T mat(cal(L), cal(M); cal(M), cal(N)) Y = <arrow(x) | W(arrow(y)) > = lambda <arrow(x) | arrow(y) > = lambda X^T mat(E, F; F, G) Y
$
Comme ceci est vrai pour tout $arrow(x)$, on a :
$
  mat(cal(L), cal(M); cal(M), cal(N)) Y = lambda mat(E, F; F, G) Y
$
Donc
$
  (mat(cal(L), cal(M); cal(M), cal(N)) - lambda mat(E, F; F, G)) Y = 0
$

#pagebreak()

== Annexes - Démonstation courbure de Gauss

Donc
$mat(cal(L), cal(M); cal(M), cal(N)) - lambda mat(E, F; F, G) = mat(cal(L) - lambda E, cal(M) - lambda F; cal(M) - lambda F, cal(N) - lambda G)$ est non inversible\
\
Et donc $mat(cal(L) - lambda E, cal(M) - lambda F; cal(M) - lambda F, cal(N) - lambda G) = 0$\

Soit $(E G - F^2) lambda^2 + (E cal(N) + G cal(L) - 2 cal(M)F)lambda + cal(L) cal(N) - cal(M)^2 = 0$\

Ainsi le terme $(cal(L)cal(N) - cal(M)^2) / (E G - F^2)$ vaut le produit des valeurs propres et donc des courbures principales, donc :
$
  K = (cal(L)cal(N) - cal(M)^2) / (E G - F^2)
$

#pagebreak()

== Annexes - Géogébra

#place(figure(image("image/geogebraex.png")))

#pagebreak()

== Annexes - Projection

Donc on a :
$
  (diff y) / (diff x) = A / B = (sh(v)diff v) / (diff u)
$
Ainsi en posant $x(u) = u <=> (diff x) / (diff u) = 1$,
$
  (diff y) / (diff v) = sh(v) underbrace((diff x) / (diff u), = 1)
$
Donc
$
  y(v) = ch(v)
$



#pagebreak()

== Annexes - Calculs

#place(
  center + horizon,
  grid(
    columns: 1,
    column-gutter: 1cm,
    row-gutter: 1.5cm,
    $ E = norm(P_u)^2 = 1 / ch(v)^2 $,
    $
      F = <P_u | P_v > = cos(u) sin(u) sh(v) / ch(v)^3 - cos(u) sin(u) sh(v) / ch(v)^3 = 0
    $,

    $
      G = norm(P_v)^2 = sh(v)^2 / ch(v)^4 + sh(v)^4 / ch(v)^4 = sh(v)^2 / ch(v)^4 underbrace((1 + sh(v)^2), = ch(v)^2) = sh(v)^2 / ch(v)^2
    $,
  ),
)

#pagebreak()

== Annexes - Calculs des Dérivés

#place(
  center + horizon,
  grid(
    columns: 2,
    column-gutter: 2cm,
    row-gutter: 1.5cm,
    $ P_u (u,v) = vec(-sin(u) / ch(v), cos(u) / ch(v), 0) $,
    $ P_v (u, v) = vec(-cos(u) sh(v) / ch(v)^2, -sin(u) sh(v) / ch(v)^2, th(v)^2) $,

    $ P_(u u) (u, v) = vec(-cos(u) / ch(v), -sin(u) / ch(v), 0) $,
    $
      P_(v v) (u, v) = vec(cos(u) (2sh(v)^2 -ch(v)^2) / ch(v)^3, sin(u) (2sh(v)^2 -ch(v)^2) / ch(v)^3, 2 sh(v) / ch(v)^3)
    $,

    $
      P_(u v) = vec(sin(u) sh(v) / ch(v)^2, - cos(u) sh(v) / ch(v)^2, 0)
    $,
  ),
)

#pagebreak()

== Annexes - Application Normale

#grid(
  columns: 2,
  column-gutter: 1.5cm,
  [Tout d’abord :
    $
      P_u and P_v = vec(gap: #5mm, cos(u) sh(v)^2 / ch(v)^3, sin(u) sh(v)^2 / ch(v)^3, sh(v) / ch(v)^3)
    $],
  [Donc :
    $
      norm(P_u and P_v) &= sqrt(sh(v)^4 / ch(v)^6 + sh(v)^2 / ch(v)^6)\
      &= sh(v) / ch(v)^3 underbrace(sqrt(sh(v)^2 + 1), = ch(v)) = sh(v) / ch(v)^2
    $],
)
Donc :
$
  N = (P_u and P_v) / norm(P_u and P_v) = vec(gap: #5mm, cos(u) sh(v) / ch(v), sin(u) sh(v) / ch(v), 1 / ch(v))
$

#pagebreak()

== Annexes - Encore du Calculs

#place(
  center + horizon,
  grid(
    columns: 1,
    row-gutter: 1.5cm,
    $
      cal(L) = scal(P_(u u), N) = - sh(v) / ch(v)^2
    $,

    $
      cal(M) = scal(P_(u v), N) = sh(v)^2 / ch(v)^3 (cos(u) sin(u) - cos(u) sin(u) ) = 0
    $,

    $
      cal(N) &= scal(P_(v v), N) = sh(v) / ch(v)^4 (2sh(v)^2 - ch(v)^2 + 2) \
      &= sh(v) / ch(v)^4 (2(ch(v)^2 - 1) - ch(v)^2 + 2 )\
      &= sh(v) / ch(v)^4 ch(v)^2 = sh(v) / ch(v)^2
    $,
  ),
)

#pagebreak()

== Annexes - Calculs courbure

On a :
#place(
  center + horizon,
  $
    K = (cal(L) cal(N) - cal(M)^2) / (E G - F^2) &= -sh(v)^2 / ch(v)^4 times 1 / (sh(v)^2 / ch(v)^4) \
    &= - sh(v)^2 / ch(v)^4 times ch(v)^4 / sh(v)^2 = -1
  $,
)

#pagebreak()

== Annexes - Demi plan de Poincarré

#place(
  center + horizon,
  dy: -2cm,
  grid(
    columns: 2,
    [
      Le demi plan de Poincarré est un modèle de géométrie hyperbolique\
      Il est définis par :\
      $frak(H)_2 = {x + i y in CC, y > 0}$\
      munis de la métrique :
      $
        dif s^2 = (dif x^2 + dif y^2) / y^2
      $
    ],
    figure(image("image/demiPlandePoincarre.png", width: 100%)),
  ),
)

#place(
  bottom,
  [
    *NB*:  Une métrique est une application $g$ qui permet de définir le produit scalaire entre deux vecteurs, dans notre cas on note $dif s^2 = g_(i j) dif x_i dif x_j$\
    où $g_(i j)$ sont les composante de la matrice associé et où $dif s^2$ est la longueur d’arc infinitésimal
  ],
)

#pagebreak()

== Annexes - Lien demi plan $<=>$ projection

Tout d’abord on peut définir la métrique sur notre surface par :
$
  dif s^2 = E dif x^2 + 2 F dif x dif y + G dif y^2
$
Sur notre surface, la métrique s’écrit :
$
  dif s^2 = (dif u^2) / ch(v)^2 + sh(v)^2 / ch(v)^2 dif v^2 = (dif u^2 + sh(v)^2 dif y^2) / ch(v)^2
$
En appliquant notre porjection sur la métrique :
$
  cases(delim: "{", x = u, y = ch(v)) <=> cases(delim: "{", dif x = dif y, dif y = sh(v) dif v)
$
donc :
#v(-11mm)
$
  dif s^2 = (dif x^2 + dif y^2) / y^2
$
