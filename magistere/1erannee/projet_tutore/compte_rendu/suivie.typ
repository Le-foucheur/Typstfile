#import "../../../../template.typ": *
#import "../../../../transposition.typ": *
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot
#import "@preview/zebraw:0.6.1": *
#show: zebraw

#set page(paper: "a4")
#set text(lang: "fr")

#let equa = counter("equa")
#equa.step()

#show math.equation: set block(breakable: true)

#set math.equation(
  supplement: [l’équation],
  numbering: (..num) => context {
    "("
    let nb = counter(heading).get()
    (
      str(nb.first())
        + if nb.len() >= 2 { "." + str(nb.at(1)) }
        + if nb.len() >= 3 { "." + str(nb.at(2)) }
        + "."
        + str(equa.display())
    )
    equa.step()
    ")"
  },
  number-align: bottom,
)

#set heading(numbering: (..num) => {
  if num.pos().len() <= 3 {
    equa.update(1)
  }
  for j in range(num.pos().len()) {
    if j == 0 or j == 1 or j == 2 {
      str(num.pos().at(j))
    } else {
      str.from-unicode(num.pos().at(j) + 96)
    }
    if j != num.pos().len() - 1 { "." }
  }
})

#show ref: it => {
  let eq = math.equation
  let el = it.element
  if el == none or el.func() != eq {
    return it
  }
  let fun = {
    let nb = counter(heading).at(el.label)
    "("
    (
      str(nb.first())
        + if nb.len() >= 2 { "." + str(nb.at(1)) }
        + if nb.len() >= 3 { "." + str(nb.at(2)) }
        + "."
        + str(equa.at(el.label).last())
    )
    ")"
  }
  link(el.location(), [#el.supplement #fun])
}

// Pour simuler le LaTeX

#set page(margin: (y: 1.75in), number-align: center, numbering: (it, ..) => {
  if it != 1 { if it != 2 { it } }
})

#set par(leading: 0.55em, spacing: 0.55em, justify: true)
#set text(font: "Linux Libertine", historical-ligatures: true)
#show raw: set text(font: "Linux Libertine")
#show heading: set block(above: 1.4em, below: 1em)
#set document(title: text(20pt)[Sur la Résolution de Schwarzschild des Équations d’Einstein])
#set text(size: 11pt)
#set math.cancel(stroke: red)

#align(center, title())
#v(1.5cm)
#align(center, text(
  16pt,
  weight: "bold",
)[Gaspar Daguet\ #v(5pt) #text(11pt, weight: "thin")[gaspar.daguet\@etu.unistra.fr]])

#align(bottom + center)[
  UFR de Physique et Ingénierie\
  \
  Université de Strasbourg\
  \
  Année académique 2025-26
]

#pagebreak()

#align(center)[*Résumé*]\
#v(1mm)
Résumé (maximum 1/2 page) du travail effectué (contexte, résultats).

#let pagenub = context {
  let nbpage = counter(page)
  if nbpage != 1 or nbpage != 2 { counter(page).display("1") } else {}
}

#pagebreak()

#heading(outlined: false, numbering: none)[
  Table des matières
]
#context {
  let chapters = query(
    heading.where(
      outlined: true,
    ),
  )
  for chapter in chapters {
    let loc = chapter.location()
    let num = if chapter.numbering == none {} else {
      numbering(
        chapter.numbering,
        ..counter(heading).at(loc),
      )
    }
    let nr = numbering(
      loc.page-numbering(),
      ..counter(page).at(loc),
    )
    if (chapter.level < 4 and (num != none and type(num) != int)) {
      [#h(1cm * chapter.level) #link(loc)[#num #chapter.body] #box(width: 1fr, repeat[.]) #nr #v(2.5mm) ]
    } else if (chapter.level < 2 and num == none) {
      [#h(1cm * chapter.level) #link(loc)[#num #chapter.body] #box(width: 1fr, repeat[.]) #nr #v(2.5mm) ]
    }
  }
}

#pagebreak()

#show heading.where(body: [Introduction]): set heading(numbering: none)
= Introduction

L'introduction (maximum 2 pages) sert à donner le cadre du travail (domaine de recherche dans lequel il se situe) et l'état de l'art.
Il est normal de citer les références associées : articles Article01, livres Livre01, chapitres de livres Chapitre01, conférences Proceeding01 ou thèses These01.
Elle spécifie aussi comment les chapitres suivants sont structurés.
Tout comme le chapitre final « Conclusions », l'Introduction est rédigée après tout le reste.\
\

- Petite introduction historique : Schwarzschild
- Présentation de l'ouvrage utilisé et du fait qu'il soit le seul
- $c = h = G = 1$
- Objectif : métrique de Schwarzschild + Trou Noir/Blanc
 - Bases Théoriques : définition des objets + quelques propriétés
 - Solution de Schwarzschild : dérivation de la solution de Schwarzschild
 - Étude de la métrique : étude de la métrique trouvée plus haut, jusqu'à arriver aux solutions Trou Noir/Blanc

En 1916, alors sur le front russe, l'astronome Karl Schwarzschild trouve pour la première fois une solution exacte aux équations d'Einstein, décrivant la gravité dans le cadre de la théorie de la relativité générale aux abords d'une masse statique à symétrie sphérique.\
Il nous a été donné au cours de ce stage de redériver ainsi que d'étudier cette solution. Dans ce cadre, nous poserons que les constantes fondamentales de la physique $c$ et $G$ valent toutes deux $1$, nous plaçant dans un système d'unités dit « naturel », nous permettant d'omettre ces grandeurs dans nos équations.\
De plus, comme cette solution est la première qui résout les équations d'Einstein, qui plus est dans l'un des cas les plus simples (symétrie sphérique, univers vide, etc.), la dérivation et l'étude de cette solution se retrouvent dans de nombreux ouvrages portant sur la théorie de la relativité générale. C'est pourquoi nous nous baserons uniquement sur #text(style: "italic")[General Relativity, An Introduction for Physicists] @RGbook de M. P. Hobson, G. P. Efstathiou et A. N. Lasenby, qui couvre l'ensemble de nos besoins dans les chapitres $9$ et $11$.\
Ainsi, nous avons découpé notre travail en trois parties distinctes qui forment les trois chapitres de ce rapport : la première partie porte sur les bases théoriques dont nous avons besoin pour progresser dans la dérivation de la solution et de son étude ; la seconde partie porte exclusivement sur la redérivation de la solution, qui représentait le cœur de notre stage ; enfin, le dernier chapitre porte sur l'étude même de la métrique de Schwarzschild, notamment ses géodésiques et ses singularités à l'aide des coordonnées d'Eddington–Finkelstein, ce qui en fait le plus long des trois chapitres.

#pagebreak()

= Bases Théoriques

#align(center)[== Équation des géodésiques]

Dans un premier temps, nous avons cherché à déduire la trajectoire sur une surface d'une particule soumise à aucune force. Cette trajectoire est appelée #text(style: "italic")[géodésique].\
Nous ne donnerons pas de définition formelle de ce qu'est une géodésique, car ceci sort du cadre du stage effectué.\
Pour en donner une intuition, on pourra considérer que c'est la généralisation d'une ligne droite pour une surface courbe.\
\
Considérons donc une métrique $g_(mu nu)$ pour une surface à $n$ dimensions, et soit une particule restreinte à cette surface de coordonnées $x^alpha$, avec $alpha in [|1;n|]$\
\
D'après #text(style: "italic")[General Relativity, An Introduction for Physicists] @RGbook, pour déduire une équation des géodésiques, nous devons considérer le lagrangien suivant :\
$
  cal(L)(x^alpha, dot(x)^alpha) = [g_(mu nu)(x) dot(x)^mu dot(x)^nu]^(1/2)
$
avec $dot(x)^alpha = (dif x^alpha)/(dif s)$\
Ainsi on a :\
$
  (partial cal(L))/(partial x^alpha) & = 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) diff/(diff x^alpha) (g_(mu nu) dot(x)^mu dot(x)^nu)\
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) (partial g_(mu nu))/(diff x^alpha) dot(x)^mu dot(x)^nu\
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu, alpha) dot(x)^mu dot(x)^nu
$
où on note : $g_(mu nu, alpha) = (partial g_(mu nu))/(diff x^alpha)$\
Et
$
  (partial cal(L))/(partial dot(x)^alpha) &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) diff/(diff dot(x)^alpha) (g_(mu nu) dot(x)^mu dot(x)^nu) = 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) diff/(diff dot(x)^alpha) ( dot(x)^mu dot(x)^nu)\
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) ( dot(x)^nu underbrace(partial/(diff dot(x)^alpha) ( dot(x)^mu), = delta_alpha^mu) + dot(x)^mu underbrace(partial/(diff dot(x)^alpha) ( dot(x)^nu), = delta_alpha^nu))\
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) ( dot(x)^nu delta_alpha^mu + underbrace(dot(x)^mu delta_alpha^nu, = dot(x)^nu delta_alpha^mu "car" mu "et" nu "sont muets"))\
  &= cancel(1/2) [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) dot.c cancel(2) dot(x)^nu delta_alpha^mu\
  &= [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(alpha nu) dot(x)^nu
$
Ainsi, par les équations d'Euler-Lagrange, on obtient l'équation suivante :\
$
  dif/(dif s) ( [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(alpha nu) dot(x)^nu) = 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu, alpha) dot(x)^mu dot(x)^nu
$
\
En posant :\
$
             dif lambda & = [g_(mu nu)dot(x)^mu dot(x)^nu]^(1/2) dif s \
  "Donc " dif/(dif lambda) & = [g_(mu nu)dot(x)^mu dot(x)^nu]^(-1/2) dif/(dif s)
$
Ainsi, en réécrivant l'équation précédente :\
$
  dif/(dif s) ( [g_(mu nu) dot(x)^mu dot(x)^nu]^(- 1/2) g_(alpha nu) dif/(dif s) x^nu) &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu, alpha) dif/(dif s) x^mu dif/(dif s) x^nu\
  "donc " [g_(mu nu) dot(x)^mu dot(x)^nu]^(1/2) dif /(dif lambda) (cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(- 1/2)) g_(alpha nu) cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(1/2)) dif/(dif lambda) x^nu ) &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) [g_(mu nu) dot(x^mu) dot(x)^nu] g_(mu nu, alpha) dif/(dif lambda) x^mu dif/(dif lambda) x^nu\
  "donc " cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(1/2)) dif /(dif lambda) (g_(alpha nu) dif/(dif lambda) x^nu ) &= 1/2 cancel([g_(mu nu)dot(x)^mu dot(x)^nu]^(1/2)) g_(mu nu, alpha) dif/(dif lambda) x^mu dif/(dif lambda) x^nu\
  "donc " dif / (dif lambda) (g_(alpha nu) dif/(dif lambda) x^nu) &= 1/2 g_(mu nu, alpha) dif/(dif lambda) x^mu dif/(dif lambda) x^nu
$
\
Si on écrit l'action par rapport à $s$, on a :\
$
  S_1 = integral [g_(mu nu) dif/(dif s) x^mu dif/(dif s) x^nu]^(1/2) dif s
$
Alors en opérant le changement de variable, $S_1$ devient :\
$
  S_1 & = integral cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(1/2)) [g_(mu nu) dif/(dif lambda) x^mu dif/(dif lambda) x^nu]^(1/2) cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(-1/2)) dif lambda\
  &= integral [g_(mu nu) dif/(dif lambda) x^mu dif/(dif lambda) x^nu]^(1/2) dif lambda
$
Donc, comme $S_1$ est invariante par la transformation $s |-> lambda$ et que celle-ci est un difféomorphisme, on a alors :\
$
  dif/(dif s)(g_(alpha nu) dot(x)^nu) = 1/2 g_(mu nu, alpha) dot(x)^mu dot(x)^nu
$
Donc en calculant le terme de gauche :\
$
  d/(dif s)(g_(alpha nu)dot(x)^nu) &= dot(x)^nu dif/(dif s) g_(alpha nu) + g_(alpha nu) dot.double(x)^nu\
  &= g_(alpha nu) dot.double(x)^nu + dot(x)^nu underbrace((partial g_(alpha nu))/(partial mu), = g_(alpha nu, mu)) underbrace((dif x^mu)/(dif s), = dot(x)^mu)\
  &= g_(alpha nu) dot.double(x)^nu + g_(alpha nu, mu) dot(x)^nu dot(x)^mu
$
Ainsi :\
$
  underbrace(g^(alpha beta) g_(alpha nu), = delta_nu^beta) dot.double(x)^nu &= 1/2 g_(mu nu, alpha) dot(x)^mu dot(x)^nu - g_(alpha nu, mu) dot(x)^nu dot(x)^mu\
  "Donc " dot.double(x)^beta &= 1/2 g^(alpha beta) (g_(mu nu, alpha) - 2g_(alpha nu, mu)) dot(x)^nu dot(x)^mu\
  "Donc " dot.double(x)^beta &= 1/2 g^(alpha beta) (g_(mu nu, alpha) - g_(alpha nu, mu) - g_(alpha mu, nu)) dot(x)^nu dot(x)^mu
$
On définit donc les symboles de Christoffel par :\
$
  Gamma^beta""_(mu nu) = 1/2 g^(beta alpha) (g_(mu alpha, nu) + g_(nu alpha, mu) - g_(mu nu, alpha) )
$
On trouve alors :\
$
  &&dot.double(x)^beta = - Gamma^beta""_(mu nu) dot(x)^mu dot(x)^nu\
  &"Soit" &dot.double(x)^beta + Gamma^(beta)""_(mu nu) dot(x)^mu dot(x)^nu = 0
$ <eqgeo>

Ainsi, la trajectoire de toute particule ne subissant aucune force et naviguant sur une surface définie par une métrique est régie par l'équation précédente.

#align(center)[== Dérivée covariante]

Le second jour de stage a été consacré à l'étude plus détaillée des symboles de Christoffel et de la nécessité de définir une dérivée covariante, du fait que la dérivée d'un tenseur n'est pas un tenseur.\
\
Alors, dans un premier temps, nous avons cherché à réécrire les symboles de Christoffel sous une forme plus adéquate pour l'étude de la dérivée covariante.

=== Réécriture de $Gamma^lambda""_(mu nu)$

#h(5mm) *Propriétés :*
$
  Gamma^(mu)""_(alpha beta) = (diff x^mu)/(diff xi^nu) (diff^2 xi^nu)/(diff x^alpha diff x^beta)
$
#h(5mm) *Preuve :*

On se place dans un système de coordonnées $xi^alpha$, et on s'intéresse à un changement de coordonnées vers $x^alpha$.\
Tout d'abord :\
$
  0 = (dif^2 xi^alpha)/(dif tau^2) &= dif/(dif tau) ((dif xi^alpha)/(dif tau))\
  &= dif/(dif tau) ((diff xi^alpha)/(diff x^mu) (dif x^mu)/(dif tau))\
  &= (diff xi^alpha)/(diff x^rho) (dif^2 x^rho)/(dif tau^2) + (dif x^mu)/(dif tau) dif/(dif tau) (diff xi^alpha)/(diff x^mu)
$
Ainsi, comme $(diff xi^alpha)/(diff x^mu) times (diff x^mu)/(diff xi^beta) = delta_beta^alpha$, en multipliant des deux côtés :\
$
  0 &= (dif^2 x^rho)/(dif tau^2) + (diff x^rho)/(diff xi^alpha) dif/(dif tau) (diff xi^alpha)/(diff x^mu) (dif x^mu)/(dif tau) \
  &= (dif^2 x^rho)/(dif tau^2) + (diff x^rho)/(diff xi^alpha) (diff^2 xi^alpha)/(diff x^mu diff x^nu) (dif x^mu)/(dif tau) (dif x^nu)/(dif tau)
$
En posant : ${""_mu ""^lambda ""_(nu)} = (diff x^lambda)/(diff xi^beta) (diff^2 xi^beta)/(diff x^mu diff x^nu)$, on obtient finalement :
#let croh(m: sym.mu, l: sym.lambda, n: sym.nu) = ${""_#m ""^#l ""_(#n)} $
$
  0 & = (dif^2 x^rho)/(dif tau^2) + croh(l: rho) (dif x^mu)/(dif tau) (dif x^nu)/(dif tau)
$
\
\
En réécrivant le produit scalaire dans les coordonnées $x^alpha$ :\
$
  eta_(mu nu) dif xi^mu dif xi^nu = underbrace(eta_(mu nu) (diff xi^mu)/(diff x^alpha) (diff xi^nu)/(diff x^beta), = g_(alpha beta)) dif x^alpha dif x^beta
$
Donc :\
$
  g_(alpha beta) = eta_(mu nu) (diff xi^mu)/(diff x^alpha) (diff xi^nu)/(diff x^beta)
$
Alors en dérivant :\
$
  g_(alpha beta, lambda) = diff_lambda g_(alpha beta) &= eta_(mu nu) diff/(diff x^lambda) ((diff xi^mu)/(diff x^alpha) (diff xi^nu)/(diff x^beta))\
  &= underbrace(eta_(mu nu) (diff xi^mu)/(diff x^alpha), = g_(alpha mu) (diff x^mu)/(diff xi^nu)) (diff^2 xi^nu)/(diff x^beta diff x^lambda) + underbrace(eta_(mu nu) (diff xi^nu)/(diff x^beta), = g_(beta nu) (diff x^nu)/(diff xi^mu)) (diff^2 xi^mu)/(diff x^alpha diff x^lambda)\
  &= g_(alpha mu) underbrace((diff x^mu)/(diff xi^nu) (diff^2 xi^nu)/(diff x^beta diff x^lambda), = croh(l: mu, m: beta, n: lambda)) + g_(beta nu) underbrace((diff x^nu)/(diff xi^mu) (diff^2 xi^mu)/(diff x^alpha diff x^lambda), = croh(l: nu, m: alpha, n: lambda))\
  &= croh(m: beta, n: lambda, l: mu) g_(mu alpha) + croh(m: alpha, n: lambda, l: nu) g_(nu beta)\
$
Donc en sommant pour différentes dérivées :\
$
  g_(alpha beta, lambda) + g_(lambda beta, alpha) - g_(alpha lambda, beta) &= croh(l: mu, m: alpha, n: lambda) g_(mu beta) + cancel(croh(m: beta, n: lambda, l: nu) g_(nu alpha))\
  &+ cancel(croh(l: mu, m: beta, n: alpha) g_(mu lambda)) + croh(m: lambda, n: alpha, l: nu) g_(nu beta)\
  &- cancel(croh(l: mu, m: alpha, n: beta) g_(mu lambda)) cancel(- croh(m: lambda, n: beta, l: nu) g_(nu alpha))\
  &= croh(l: mu, m: alpha, n: lambda) g_(mu beta) + croh(m: lambda, n: alpha, l: nu) g_(nu beta) = 2 croh(l: mu, n: lambda, m: alpha)g_(mu beta)
$
Ainsi :\
$
  Gamma^(gamma)""_(alpha lambda) &= 1/2 g^(gamma beta) (g_(alpha beta, lambda) + g_(lambda beta, alpha) - g_(alpha lambda, beta)) = 1/2 g^(gamma beta) times 2 croh(l: mu, n: lambda, m: alpha) g_(mu beta)\
  &= croh(l: mu, n: lambda, m: alpha) delta^gamma_(mu) = croh(l: gamma, n: lambda, m: alpha)
$
On trouve que :
$
  Gamma^(mu)""_(alpha beta) = croh(l: mu, m: alpha, n: beta) = (diff x^mu)/(diff xi^nu) (diff^2 xi^nu)/(diff x^alpha diff x^beta)
$ <equchro>
#QED

=== Transformation de $Gamma^lambda""_(mu nu)$

De plus, nous avons vérifié si $Gamma^(lambda)""_(mu nu)$ est un tenseur.
Pour cela, regardons comment $Gamma$ se transforme d'après @equchro :\
\

#align(center, math.equation(numbering: none, block: true)[
  $
    Gamma^lambda""_(mu nu) ' &= croh()' = (diff x'^lambda)/(diff xi^beta) (diff^2 xi^beta)/(diff x'^mu diff x'^nu)\
    &= (diff x'^lambda)/(diff xi^beta) diff/(diff x'^mu) ((diff xi^beta)/(diff x'^nu))\
    &= (diff x'^lambda)/(diff xi^beta) diff/(diff x'^mu) ((diff x^alpha)/(diff x'^nu) (diff xi^beta)/(diff x^alpha))\
    &= (diff x'^lambda)/(diff xi^beta) ( (diff xi^beta)/(diff x^alpha) (diff^2 x^alpha)/( diff x'^mu diff x'^nu) + (diff x^alpha)/(diff x'^nu) (diff^2 xi^beta)/(diff x'^mu diff x^alpha) )\
    &= (diff x'^lambda)/(diff x^rho) (diff x^rho)/(diff xi^beta) ( (diff xi^beta)/(diff x^alpha) (diff^2 x^alpha)/( diff x'^mu diff x'^nu)
      + (diff x^alpha)/(diff x'^nu) (diff^2 xi^beta)/(diff x'^mu diff x^alpha) )\
    &= (diff x'^lambda)/(diff x^rho) (diff x^alpha)/(diff x'^nu) (diff x^sigma)/(diff x'^mu) underbrace((diff x^rho)/(diff xi^beta) (diff^2 xi^beta)/(diff x^sigma diff x^alpha), = croh(m: sigma, l: rho, n: alpha) = Gamma^rho""_(sigma alpha))
    + (diff x'^lambda)/(diff xi^beta) (diff xi^beta)/(diff x^alpha) (diff^2 x^alpha)/( diff x'^mu diff x'^nu) \
    &= (diff x'^lambda)/(diff x^rho) Gamma^rho""_(sigma alpha) (diff x^sigma)/(diff x'^mu) (diff x^alpha)/(diff x'^nu)
    + (diff x'^lambda)/(diff x^alpha) (diff^2 x^alpha)/( diff x'^mu diff x'^nu) \
  $
])
Ainsi $ Gamma^lambda""_(mu nu) ' = (diff x'^lambda)/(diff x^rho) Gamma^rho""_(sigma alpha) (diff x^sigma)/(diff x'^mu) (diff x^alpha)/(diff x'^nu)
+ (diff x'^lambda)/(diff x^alpha) (diff^2 x^alpha)/( diff x'^mu diff x'^nu) \ $ <pasbontenseur>

Donc d'après @pasbontenseur, on voit qu'après transformation il reste un terme additif.\
Ainsi $Gamma^alpha""_(mu nu)$ n'est pas un tenseur.

=== Définition de la dérivée covariante

Comme la dérivée d'un tenseur n'en est pas un, on définit la dérivée covariante pour un vecteur $v^nu$ par :\
$
  nabla_mu v^nu = diff_mu v^nu + Gamma^nu""_(mu rho) v^rho
$

*Propriétés :*\
#align(center)[$nabla_mu v^nu$ est un tenseur]

*Preuve :*

Vérifions que c'est bien un tenseur pour un vecteur $x^nu$ :\
\
#align(center, math.equation(numbering: none)[
  $
    nabla_mu ' x'^nu & = diff/(diff x'^mu) x'^nu + croh(l: nu, n: rho)' x'^rho \
    &= (diff x^alpha)/(diff x'^mu) diff/(diff x^alpha) ((diff x'^nu)/(diff x^beta) x^beta) + ((diff x'^nu)/(diff x^omega) croh(m: sigma, l: omega, n: alpha) (diff x^sigma)/(diff x'^mu) (diff x^alpha)/(diff x'^rho)
      - (diff x^alpha)/(diff x'^mu) (diff x^sigma)/(diff x'^rho) (diff^2 x'^nu)/( diff x^alpha diff x^sigma)) (diff x'^rho)/(diff x^beta) x^beta\
    &= cancel((diff x^alpha)/(diff x'^mu) (diff^2 x'^nu)/(diff x^alpha diff x^beta) x^beta) + (diff x^alpha)/(diff x'^mu) (diff x'^nu)/(diff x^beta) (diff x^beta)/(diff x^alpha) \
    &+ (diff x'^nu)/(diff x^omega) croh(m: alpha, l: omega, n: beta) (diff x^alpha)/(diff x'^mu) x^beta
    cancel(- (diff x^alpha)/(diff x'^mu) (diff^2 x'^nu)/( diff x^alpha diff x^beta) x^beta) \
    &= (diff x'^nu)/(diff x^beta) (diff x^alpha)/(diff x'^mu) (underbrace((diff x^beta) / (diff x^alpha) + croh(m: alpha, l: beta, n: tau) x^tau, = nabla_alpha x^beta))\
    &= (diff x'^nu)/(diff x^beta) (diff x^alpha)/(diff x'^mu) nabla_alpha x^beta
  $
])

Ainsi $nabla_mu$ se transforme comme il faut, et donc $nabla_mu$ est un $(1,0)$-tenseur.
#QED

=== Commutateur des dérivées covariantes & Tenseur de Riemann <CDCTR>

On définit le tenseur de Riemann $R^sigma""_(mu nu rho)$ par :\
$
  R^sigma""_(mu nu rho) v^mu = [nabla_nu, nabla_rho] v^sigma
$

*Propriété :*
$
  R^sigma""_(mu nu rho) = diff_nu Gamma^sigma""_(mu rho) - diff_rho Gamma^sigma""_(mu nu) + Gamma^sigma""_(nu lambda) Gamma^lambda""_(mu rho) - Gamma^sigma""_(rho lambda) Gamma^lambda""_(mu nu)
$

*Preuve :*

Soit $v^rho$ un vecteur :\
$
  [nabla_mu, nabla_nu] v^rho &= nabla_mu (nabla_nu v^rho) - nabla_nu (nabla_mu v^rho) \
  &= nabla_mu (partial_nu v^rho + Gamma^rho""_(nu alpha) v^alpha) - nabla_nu (partial_mu v^rho + Gamma^rho""_(mu alpha) v^alpha) \
  &= partial_mu (partial_nu v^rho + Gamma^rho""_(nu alpha) v^alpha) + Gamma^rho""_(mu beta) (partial_nu v^beta + Gamma^beta""_(nu alpha) v^alpha)
  -
  partial_nu (partial_mu v^rho + Gamma^rho""_(mu alpha) v^alpha) - Gamma^rho""_(nu beta) (partial_mu v^beta + Gamma^beta""_(mu alpha) v^alpha)\
  &= cancel(diff_(nu mu) v^rho) + diff_mu Gamma^rho""_(nu alpha) v^alpha + Gamma^rho""_(mu beta) diff_nu v^beta + Gamma^rho""_(mu beta) Gamma^beta""_(nu alpha) v^alpha
  -
  cancel(diff_(mu nu) v^rho) - diff_nu Gamma^rho""_(mu alpha) v^alpha - Gamma^rho""_(nu beta) diff_mu v^beta - Gamma^rho""_(nu beta) Gamma^beta""_(mu alpha) v^alpha\
  &= (Gamma^rho""_(mu beta) Gamma^beta""_(nu alpha)-Gamma^rho""_(nu beta) Gamma^beta""_(mu alpha)
    +
    diff_mu Gamma^rho""_(nu alpha) - diff_nu Gamma^rho""_(mu alpha)) v^alpha + underbrace(Gamma^rho""_(mu beta) diff_nu v^beta - Gamma^rho""_(nu beta) diff_mu v^beta, =0)
$
Ainsi, on trouve que :\
$
  R^rho""_(mu nu kappa) = [nabla_mu, nabla_nu] v^rho = diff_nu Gamma^sigma""_(mu kappa) - diff_kappa Gamma^sigma""_(mu nu) + Gamma^sigma""_(nu lambda) Gamma^lambda""_(mu kappa) - Gamma^sigma""_(kappa lambda) Gamma^lambda""_(mu nu)
$
#QED

On définit également les deux contractions du tenseur de Riemann suivantes :
- Le tenseur de Ricci : $R_(mu nu) = R^sigma""_(mu sigma nu)$
- La courbure scalaire : $R = g^(mu nu)R_(mu nu)$

= Solution de Schwarzschild

Maintenant que la base théorique est faite, nous avons pu nous intéresser au cœur du stage, c'est-à-dire à la solution des équations d'Einstein que Karl Schwarzschild développe en 1916. Cette solution s'intéresse à la métrique produite aux abords d'une masse ponctuelle sans rotation, ce qui induit une symétrie sphérique.\

== Équation sur $R_(mu nu)$

La première étape est de déduire une équation sur le tenseur de Ricci, $R_(mu nu)$.\

On se place dans un espace de dimension $n$. D'après l'équation d'Einstein :\
$
  R_(mu nu) - 1/2 g_(mu nu) R = kappa T_(mu nu)
$
où $g_(mu nu)$ est le tenseur métrique, $T_(mu nu)$ le tenseur énergie-impulsion, $kappa$ la constante d'Einstein, et $R$ et $R_(mu nu)$ la courbure scalaire et le tenseur de Ricci définis à la @CDCTR.\
\
On recherche une solution pour un espace vide, statique et à symétrie sphérique, donc $T_(mu nu) = 0$. L'équation devient :\
$
  R_(mu nu) - 1/2 g_(mu nu) R & = 0 \
  "donc " g^(mu nu) (R_(mu nu) - 1/2 g_(mu nu) R) & = 0 \
  "donc " underbrace(g^(mu nu) R_(mu nu), = R) - 1/2 underbrace(g^(mu nu)g_(mu nu), = delta_mu^mu = n) R & = 0 \
  "donc " R(1 - 1/2n) & = 0 \
  "donc " R(2 - n) & = 0
$

Ainsi, on a deux cas particuliers :
- Soit $n = 2$, auquel cas la gravité est topologique.
- Soit $R = 0$.

Or on recherche une solution pour un espace à 4 dimensions (3 d'espace + 1 de temps), ainsi $R = 0$. En injectant dans l'équation d'Einstein :\
$
  R_(mu nu) - 1/2 g_(mu nu) underbrace(R, = 0) = 0\
  "Donc " R_(mu nu) = 0
$ <Ricci>

== Écriture de la métrique dans un espace isotrope statique

D'après #text(style: "italic")[General Relativity, An Introduction for Physicists] @RGbook, pour un espace isotrope, la métrique doit ressembler à :\
$
  dif s^2 = A(r,t)dif t^2 - B(r, t) dif t (arrow(x) dot.c dif arrow(x)) - C(r, t) (arrow(x) dot.c dif arrow(x))^2 - D(r, t) dif arrow(x)^2
$
En opérant le changement de variables en coordonnées sphériques :\
$
  x^1 & = r sin(theta) cos(phi) \
  x^2 & = r sin(theta) sin(phi) \
  x^3 & = r cos(theta)
$
Dans ce cas on a :\
$
  arrow(x) dot.c arrow(x) = r^2, "    " arrow(x) dot.c dif arrow(x) = r dr, "    "dif arrow(x) dot.c dif arrow(x) = dr^2 + r^2 dif theta^2 + r^2 sin(theta)^2 dif phi^2
$
Ainsi, la métrique devient :\
$
  ds^2 & = A(t,r)dt^2 - B(t, r) r dt dr - C(t,r) r^2 dr^2 - D(t, r) dr^2 - D(t,r) r^2 dif^2 Omega \
       & = A(t,r)dt^2 - B'(t,r) dt dr - C'(r,t) dr^2 - D' dif^2 Omega
$
avec $dif^2 Omega = dif theta^2 + sin(theta)^2 dif phi^2$ l'angle solide et $B' = B r ; " " C' = C r^2 + D " et " D' = D$.\
On pose $dash(r)^2 = D'$, alors :\
$
  ds^2 = A(t, dash(r)) dt^2 - B'(t, dash(r)) dt dif dash(r) - C'(t, dash(r)) dif dash(r)^2 - dash(r)^2 dif^2 Omega
$
On pose également un nouveau temps : $dif dash(t) = Phi(t, dash(r))[A(t, dash(r)) dt - 1/2 B'(t, dash(r)) dif dash(r)]$, donc\
$
  dif dash(r)^2 = Phi(t, dash(r)) [A^2 dt^2 + 1/4 B'^2 dif dash(r)^2 - A B' dt dif dash(r) ]\
  "Donc " A dt^2 - B' dt dif dash(r) = 1/(A Phi) dif dash(t)^2 - B/(4 A) dif dash(r)^2
$
La métrique devient :\
$
  ds^2 = 1/(A Phi) dif dash(t)^2 -(B/(4A) + C')dif dash(r)^2 - dash(r)^2 dif^2 Omega
$
Ainsi, en posant deux nouvelles fonctions $dash(A) = 1/(A Phi)$ et $dash(B) = B/(4A) + C'$, la métrique devient :\
$
  ds^2 = dash(A)(dash(t), dash(r)) dif dash(t)^2 - dash(B)(dash(t), dash(r)) dif dash(r)^2 - dash(r)^2 dif^2 Omega
$
Comme à partir de maintenant l'on ne travaillera qu'avec les quantités avec une barre : $dash(A), dash(B), dash(t), dash(r)$, on les renotera sans la barre pour plus de clarté.\
De plus, comme l'on impose au système d'être statique, alors les grandeurs $A$ et $B$ sont indépendantes du temps ;\
ainsi la métrique s'écrit finalement :\
$
  ds^2 = A(r) dt^2 - B(r)dr^2 - r^2 dif^2 Omega
$

== Solution de Schwarzschild

D'après @Ricci, $R_(mu nu) = 0$, or\
$
  R_(mu nu) = diff_nu Gamma^sigma""_(mu sigma) - diff_sigma Gamma^sigma""_(mu nu) + Gamma^(rho)""_(mu sigma) Gamma^sigma""rho nu - Gamma^(rho)""_(mu nu) Gamma^(sigma)""rho sigma
$
Ainsi, en calculant les symboles de Christoffel, on obtiendra des équations sur $A$ et $B$.

=== Calcul des symboles de Christoffel <calcristo>
Pour calculer les symboles de Christoffel, on pourrait partir de la définition :\
$
  Gamma^mu""_(alpha beta) = 1/2 g^(mu rho)(g_(alpha rho, beta) + g_(beta rho, alpha) - g_(alpha beta, rho))
$
Cependant, ceci demande de calculer indépendamment chaque coefficient, or en dimension $4$, il y en a $4^3 = 64$, rendant les calculs longs et éreintants.\
Or, il existe une méthode plus rapide pour les calculer. Celle-ci se base sur le fait que l'équation des géodésiques, @eqgeo, dépend directement des symboles de Christoffel.\
Donc, pour les calculer, on prend le lagrangien $cal(L) = g_(mu nu)dot(x)^mu dot(x)^nu$, que l'on insère dans les équations d'Euler-Lagrange pour retomber sur l'équation des géodésiques.\
Ici, nous ne ferons que le calcul pour la variable $r$, le reste a été fait par un programme pour Xcas (`christoffel.cxx`, présent dans @programme).\
Ainsi, le lagrangien s'écrit : $cal(L) = A(r)dot(t)^2 - B(r) dot(r)^2 - r^2 dot(theta)^2 - r^2 sin(theta)^2 dot(phi)^2$. On a :\
$
  diff_(dot(r)) cal(L) = -2B(r)dot(r)\
  "donc " dif/(dif tau) diff_(dot(r)) cal(L) = -2 dif/(dif tau) (dot(r) B(r)) = -2 (dif dot(r))/(dif tau) B - 2dot(r) dr/(dif tau) (dif B(r))/dr = -2 dot.double(r) B - 2 dot(r)^2 B'(r)
$
Où on note les dérivées par un point pour les dérivées par rapport à $tau$, et $B'(r)$ et $A'(r)$ pour les dérivées par rapport à $r$.\
Nous avons également :\
$
  diff_r cal(L) = A'(r)dot(t)^2 - B'(r) dot(r)^2 - 2r dot(theta)^2 - 2 r sin(theta)^2 dot(phi)^2
$
Donc d'après les équations d'Euler-Lagrange :\
$
  -2 dot.double(r) B(r) - 2 dot(r)^2 B' = A'dot(t)^2 - B' dot(r)^2 - 2r dot(theta)^2 - 2r sin(theta)^2 dot(phi)^2 \
  "donc " dot.double(r) + A'/(2B) dot(t)^2 + B'/(2B) dot(r)^2 - r/(B) dot(theta)^2 - (r sin(theta)^2)/(B) dot(phi)^2 = 0
$ <eqr>
Or, comme l'équation des géodésiques s'écrit : $dot.double(x)^mu + Gamma^mu_(alpha beta) dot(x)^alpha dot(x)^beta = 0$, alors en identifiant avec @eqr, on trouve :\
$
  Gamma^1""_(mu nu) = mat( A'/(2B), 0, 0, 0; 0, B'/(2B), 0, 0; 0, 0, -r/B, 0; 0, 0, 0, - (r sin(theta)^2)/B )
$
À l'aide du programme de l'#ref(<programme>), on trouve :\
$
  Gamma^0""_(mu nu) = mat( 0, A'/(2A), 0, 0; A'/(2A), 0, 0, 0; 0, 0, 0, 0; 0, 0, 0, 0 )
$
$
  Gamma^2""_(mu nu) = mat( 0, 0, 0, 0; 0, 0, 1/r, 0; 0, 1/r, 0, 0; 0, 0, 0, -sin(theta) cos(theta); )
$
$
  Gamma^3""_(mu nu) = mat( 0, 0, 0, 0; 0, 0, 0, 1/r; 0, 0, 0, cot(theta); 0, 1/r, cot(theta), 0; )
$

=== Équations sur $A$ et $B$

De la même manière, les différents coefficients de $R_(mu nu)$ ont été calculés par le même programme; ainsi on obtient comme seuls coefficients non nuls :
$
  R_(0 0) = A'/(r B) + A''/(2B) - A'/(4B) (A'/A + B'/B)\
  R_(1 1) = B'/(r B) - A''/(2A) + A'/(4A) (A'/A + B'/B)\
  R_(2 2) = (r B')/(2 B^2) - 1/B - (r A')/(2A B) + 1\
  R_(3 3) = sin(theta)^2 ((r B')/(2 B^2) - 1/B - (r A')/(2A B) + 1)
$
Ainsi par @Ricci, on obtient le système suivant :
$
  cases(
    R_(0 0) = A'/(r B) + A''/(2B) - A'/(4B) (A'/A + B'/B) = 0,
    R_(1 1) = B'/(r B) - A''/(2A) + A'/(4A) (A'/A + B'/B) = 0,
    R_(2 2) = (r B')/(2 B^2) - 1/B - (r A')/(2A B) + 1 = 0,
    R_(3 3) = sin(theta)^2 ((r B')/(2 B^2) - 1/B - (r A')/(2A B) + 1) = 0
  )
$<sys>
On remarque que les deux dernières équations sont redondantes, donc le système se réduit à :
$
  cases(
    A'/(r B) + A''/(2B) - A'/(4B) (A'/A + B'/B) = 0,
    B'/(r B) - A''/(2A) + A'/(4A) (A'/A + B'/B) = 0,
    (r B')/(2 B^2) - 1/B - (r A')/(2A B) + 1 = 0
  )
$
Si on multiplie la première ligne par $B/A$ puis que l’on l'additionne à la seconde, on obtient :
$
  R_(0 0) times B/A + R_(1 1) = A'/(r A) + B'/(r B) = 0
$
$
  "Donc " A'B + B' A = 0 = dif/dr (A B)
$ <AB0>
$
  "Donc " A B = alpha in RR
$
Or, on veut que la métrique tende vers celle de Minkowski (univers plat) à grande distance, i.e. $A(r) tend(r, +oo) 1$ et $B(r) tend(r, +oo) 1$, donc :
$
  A B tend(r, +oo) alpha = 1
$
donc $alpha = 1$ et donc :
$
  B = 1/A
$ <B1A>

En mettant sur le même dénominateur la première équation du système @sys :
$
  (4A' A B + 2 A'' A B r - A'^2 B r - A' B' A r)/(4r A B^2) = 0
$
donc
$
  4A' A B + 2 A'' A B r - A'r underbrace(cancel((A' B + B'A)), #[selon @AB0]) = 0
$
alors :
$
  A'' + 2/r A' = 0
$
on reconnaît une équation du premier ordre par rapport à $A'$, soit :
$
  A' = K e^(-2 ln(r)) = K/r^2
$
avec $K in RR$\
on trouve enfin que :
$
  A(r) = C - K/r\
  "et " C in RR
$
Or comme $A tend(r, +oo) C = 1$
alors :
$
  A(r) = 1-K/r \
  "et"\
  B(r) = 1/A = (1 - K/r)^(-1)
$
De plus, à la limite des champs faibles, on a :
$
  A(r) = 1 + 2phi.alt
$
avec $phi.alt = -(G M)/r$ le potentiel gravitationnel.\
Donc $K = 2G M = R_s$ avec $R_s$ le rayon de Schwarzschild.\
On peut finalement écrire la métrique finale :
$
  ds^2 = (1 - R_s/r) dt^2 - (1-R_s/r)^(-1) dr^2 - r^2 dif^2 Omega
$ <metswart>


= Étude de la métrique

Maintenant que nous avons dérivé la métrique de Schwarzschild, nous allons nous intéresser au comportement 
d’objets aux abords de la masse ponctuelle, jusqu’à arriver aux solutions trou noir et trou blanc en fin de chapitre.

== Géodésique radiale d’un photon <géoradphot>

On s’intéresse maintenant aux géodésiques radiales, i.e. $dif theta = dif phi = 0$, ainsi la métrique donnée par @metswart devient :
$
  ds^2 = (1 - R_s/r)dif t^2 - (1 - R_s/r)^(-1) dif r^2
$
de plus pour une géodésique, on a : $ds = 0$, alors :
$
  dt = plus.minus (1 - R_s/r)^(-1) dr
$<georadialdiff>
Ainsi on obtient deux solutions, une pour les rayons sortants (signe $+$) et une pour les rayons entrants (signe $-$).\
On va s’intéresser, pour l’instant, seulement au rayon entrant, alors en intégrant @georadialdiff de $R_0 > R_s$ à $r$ :
$
  t (r) & = - integral_(R_0)^r dr'/(1 - R_s/r') \
        & = - integral_(R_0)^r (r' - R_s + R_s)/(r' - R_s) dr' \
        & = - integral_(R_0)^r dr' + integral_(R_0)^(r) R_s/(r' - R_s) dr' \
        & = R_0 - r + R_s ln((R_0 - R_s)/(r - R_s))
$
On obtient la figure suivante :

#let R0 = 2
#let Rs = 0.75
#figure(
  cetz.canvas({
    import cetz.draw: *

    let georad(x) = R0 - x + Rs * calc.ln((R0 - Rs) / (x - Rs))
    plot.plot(
      size: (10, 10),
      x-max: R0 + 0.1,
      x-min: 0,
      y-max: 6,
      x-tick-step: none,
      y-tick-step: none,
      axis-style: "left",
      x-label: $r$,
      y-label: $t$,
      {
        plot.add(
          domain: (Rs + 0.0001, R0),
          samples: 1000,
          georad,
        )
        plot.add-vline(
          Rs,
          style: (stroke: (paint: black, dash: "dashed")),
        )
      },
    )

    content((3.635, -0.35), $R_s$)
    content((9.6, -0.35), $R_0$)
  }),
  caption: [temps que met un photon à atteindre\ un observateur placé en $R_0$],
)
Ainsi on remarque que plus le photon est émis proche de $r = R_s$, plus celui-ci met du temps à atteindre un observateur distant ($R_0$), jusqu’à diverger quand celui-ci est émis au niveau de $r = R_s$.\
En effet :
$
  t(r) tend(r, R_s) +oo
$
Ainsi du point de vue d’un observateur distant, si un objet tombe dans la singularité, on le verra s’approcher de $R_s$ sans jamais l’atteindre.\
\
De plus on peut remarquer que plus le photon est émis loin de la singularité, plus on revient à un comportement non-relativiste.\
En effet, pour $R_s << r$ :

#align(center, math.equation(numbering: none)[$
  t(r) & = R_0 - r + R_s ln((R_0 - R_s)/(r - R_s)) \
       & = R_0 - r + R_s (ln(R_0 - R_s) - ln(r) - underbrace(ln(1 - R_s/r), = - R_s/r = o(r))) \
$])\
$
  & = R_0 - r - R_s ln(r/(R_0 - R_s)) + o(r) \
  & = R_0 - r + o(r) \
$

== Temps de chute d’un corps

Intéressons-nous maintenant au temps de chute de deux points de vue : premièrement du point de vue de l’objet lui-même, puis du point de vue d’un observateur lointain.\
On note $tau$ le temps propre de l’objet tombant,\
alors si l’on prend le lagrangien : $cal(L) = g_(mu nu) dot(x)^mu dot(x)^nu = (1 - R_s/r) ((dif t)/(dif tau))^2 - (1 - R_s/r)^(-1) ((dif r)/(dif tau))^2$.\
Alors d’après les équations d’Euler-Lagrange par rapport à $t$ :
$
               dif/(dif tau) diff_(dot(t)) cal(L) & = underbrace(diff_t cal(L), = 0) \
  dif/(dif tau) (2 (1 - R_s/r) (dif t)/(dif tau)) & = 0
$
Donc
$
  (dif t)/(dif tau) = k/(1 - R_s/r)
$ <constanteducul>
Or on a :
$
  g_(mu nu) dot(x)^mu dot(x)^nu = c^2 = 1\
  (1 - R_s/r) dot(t)^2 - (1 - R_s/r)^(-1) dot(r)^2 = 1
$
Ainsi en injectant @constanteducul :
$
  (1 - R_s/r)^(-1) (k^2 - dot(r)^2) = 1 \
  dot(r)^2 = k^2 -1 + R_s/r
$<eq324>
donc en dérivant :
#align(center, math.equation(numbering: none)[$
  2 dot(r) dot.double(r) & = - R_s dot(r)/r^2 \
$])
Ainsi en ré-intégrant de $r$ à $R_0$
$
  dot(r)^2 = -R_s [1/r]_r^(R_0) = R_s/r - R_s/R_0
$
On en déduit :
$
  k = sqrt(1 - R_s/R_0)\
$
Pour simplifier les calculs on considérera un objet lâché depuis l'infini.\
Ainsi $k = 1$.\

On s’intéressera d’abord au point de vue de l’objet lui-même, alors @eq324 devient :
$
  dr/(dif tau) = - sqrt(R_s/r)
$
donc
$
  (dif tau)/dr = - sqrt(r/R_s)
$
alors en intégrant de $R_0$ à $r$ :
$
  tau (r) & = - integral_(R_0)^(r) sqrt(r'/R_s) dr' \
          & = integral_r^(R_0) sqrt(r' /R_s)dr' \
          & = 2/3[sqrt(r'^3/R_s)]^(R_0)_r \
          & = 2/3sqrt(R_0^3/R_s) - 2/3sqrt(r^3/R_s)
$
Ainsi pour un objet tombant d’un point distant ($r = R_0$), il atteindra la singularité ($r = 0$) en :
$
  tau tend(r, 0) 2/3 sqrt(R_0^3/R_s)
$

Intéressons-nous maintenant au point de vue d’un observateur lointain ; comme $k = 1$, @constanteducul devient :
$
  dt/(dif tau) = (1 - R_s/r)^(-1)
$
Ainsi :
$
  dt/dr & = dt/(dif tau) (dif tau)/dr \
        & = (1 - R_s/r)^(-1) times (- sqrt(r/R_s)) \
        & = - (1 - R_s/r)^(-1)sqrt(r/R_s)
$
Alors en intégrant :
$
  t(r) & = integral_r^(R_0) sqrt(r'/R_s)/(1 - R_s/r') dr' \
  & = 2R_s integral_(u(r))^(u(R_0)) u^2/(1 - 1/u^2) dif u " en posant " u = sqrt(r'/R_s) \
  & = 2 R_s integral_(u(r))^(u(R_0)) u^4/(u^2 - 1) dif u \
  & = 2 R_s integral_(u(r))^(u(R_0)) u^2 (u^2 - 1 + 1)/(u^2 - 1) dif u \
  & = 2 R_s (integral_(u(r))^(u(R_0)) u^2 dif u + integral_(u(r))^(u(R_0)) u^2/(u^2 - 1) dif u) \
  & = 2 R_s (integral_(u(r))^(u(R_0)) u^2 dif u + integral_(u(r))^(u(R_0)) dif u + integral_(u(r))^(u(R_0)) 1/(u^2 - 1) dif u)
$
Ainsi on obtient :

#math.equation(
  numbering: numbering_joli,
  number-align: bottom,
)[$
  t(r) = 2/3 R_s ((R_0/R_s)^(2/3) - (r/R_s)^(2/3) ) + 2 R_s ((R_0/R_s)^(1/2) - (r/R_s)^(1/2) ) + R_s ln(((1 - sqrt(R_0/R_s)) (1 + sqrt(r/R_s)))/((1 + sqrt(R_0/R_s))(1 - sqrt(r/R_s))))
$]\

Or pour $r -> R_s$, on a
$
  ln(((1 - sqrt(R_0/R_s)) (1 + sqrt(r/R_s)))/((1 + sqrt(R_0/R_s))(1 - sqrt(r/R_s)))) tend(r, R_s) + oo
$
donc
$
  t(r) tend(r, R_s) + oo
$

Ainsi pour conclure, nous avons les deux grandeurs suivantes :
\
#align(
  center,
  grid(
    columns: 1,
    row-gutter: 1cm,
    align: center + horizon,
    $tau(r) tend(r, 0) 2/3 sqrt(R_0^3/R_s)$,
    $t(r) tend(r, R_s) + oo$,
  ),
)\
On a donc que de son point de vue, l’objet atteint la singularité en un temps fini,
mais du point de vue d’un observateur lointain, l’objet met un temps infini avant d’atteindre $r = R_s$.

== Cônes de lumière

Comme la lumière suit les géodésiques, sa trajectoire est une géodésique.

Alors, nous avons déjà vu dans la @géoradphot que les géodésiques pour un photon étaient régies par l’équation :
$
  dt/dr = plus.minus (1- R_s/r)^(-1)
$
où le signe correspond à un photon tantôt entrant ($-$), tantôt sortant ($+$). En intégrant, on obtient deux solutions :
#let lna(x) = $"ln"abs(#x)$
$
  "Rayon entrant : " t = -r - R_s lna(r/R_s - 1) + p_1
$ <rayentr>
$
  "Rayon sortant : " t = r + R_s lna(r/R_s - 1) +p_2
$ <raysort>
où $p_1$ et $p_2$ sont des constantes d’intégration.\
En traçant ces deux solutions pour des $p$ différents, on obtient le diagramme $(t,r)$ suivant :


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
      x-label: $r$,
      y-label: $t$,
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

    content((5.06, -0.3), $R_s$)
  }),
  caption: [
    structure des cônes de lumière pour la métrique de Schwarzschild\
    en bleu les rayons sortants, et en rouge les rayons entrants
  ],
) <fig2geolum>
On observe que dans la zone ${0<r<R_s}$, les cônes de lumière sont entièrement retournés vers la singularité ; ainsi les photons présents dans cette zone finiront au niveau de la singularité quelle que soit leur nature de départ. Ainsi toute particule massive doit également finir au niveau de la singularité.\
On aurait pu voir cette inversion temps $<=>$ espace via la métrique ; en effet pour $r < R_s$, $dt$ et $dr$ changent de signe, indiquant l’inversion temps $<=>$ espace.

=== Coordonnées d’Eddington–Finkelstein

Nous pouvons remarquer en regardant la métrique (@metswart) et la @fig2geolum que nous avons deux singularités : 
- en $r = 0$, qui est une #text(style: "italic")[vraie] singularité, car la courbure scalaire $R_(mu nu rho sigma)R^(mu mu rho sigma) = 12 R_s^2/r^6$ diverge en $0$,\
- en $r = R_s$, qui est une #text(style: "italic")[fausse] singularité ; en effet, ici la courbure scalaire est finie $R_(mu nu rho sigma)R^(mu mu rho sigma) = 12/R_s^4$.\
La seconde singularité est appelée #text(style: "italic")[singularité du système de coordonnées] ; comme son nom l’indique, il est possible de « retirer »
cette singularité en se plaçant dans un système de coordonnées plus « naturel ».\


On propose deux solutions dans les deux chapitres suivants.

==== Coordonnées d’Eddington–Finkelstein avancées <CEFA>

On cherchera d’abord à développer une meilleure description des photons entrants.\
On a donc :
$
  t = -r -R_s lna(r/R_s - 1) + p
$
avec $p$ une constante d’intégration.\
L’idée pour construire le nouveau système de coordonnées est de prendre cette constante d’intégration comme nouvelle coordonnée ; ainsi :
$
  p = t + r + R_s lna(r/R_s - 1)
$
En différentiant :
$
  dif p = dt + r / (r - R_s) dr
$
donc
$
  dt = dif p - (1 - R_s/r)^(-1) dr
$
Ainsi :
$
  dt^2 = dif p^2 + (1 - R_s/r)^(-2) dr^2 - (2 dr dif p)/(1 - R_s/r)
$
Alors en remplaçant $dt$ dans la métrique de Schwarzschild, on obtient :
$
  ds^2 = (1 - R_s/r) dif p^2 - 2 dr dif p - r^2 (dif theta^2 + sin(theta) dif phi^2)
$
On remarquera que la métrique est maintenant continue pour $r in RR^*_+$, résolvant ainsi la #text(style: "italic")[fausse]
singularité en $r = R_s$.\
Ici on prend toujours le cas radial, donc $dif theta = dif phi = 0$, d’où :
$
  ds^2 = (1 - R_s/r) dif p^2 - 2 dr dif p
$

Si on regarde les géodésiques, donc $ds = 0$, on a :
$
  (1 - R_s/r) dif p^2 - 2 dr dif p = 0
$
Donc
$
  (1 - R_s/r) ((dif p)/dr)^2 - 2 (dif p)/dr = 0
$
On reconnaît une équation du second degré, dont les deux solutions sont :
$
  (dif p)/dr = 0\
  (dif p)/dr = 2(1 - R_s/r)^(-1)
$
On trouve ainsi ces deux solutions :
$
  p = "const"\
  p = 2 r + 2 R_s lna(r/R_s - 1) + "const"
$
Pour se ramener à un diagramme $(t,r)$, on définit la variable de genre temps suivante :
$
  t' = p - r = t + R_s lna(r/R_s - 1)
$
Les coordonnées $(t', r, theta, phi)$ sont appelées les coordonnées d’Eddington–Finkelstein avancées.\
Ainsi on obtient les deux équations suivantes :
$
  t' = -r + "const"\
  t' = r + 2R_s lna(r/R_s - 1) + "const"
$

#figure(
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
    content((5.06, -0.3), $R_s$)
  }),
  caption: [diagramme $(t',r)$, avec les cônes de lumière,\ avec en rouge les photons entrants, et en bleu les photons sortants],
)

On remarque ainsi que les rayons entrants sont continus en $r = R_s$. De plus, si on regarde la structure des cônes de lumière, on remarque que ceux-ci sont entièrement tournés vers la singularité ;
ainsi le futur d’un photon est entièrement #text(style: "italic")[tourné] vers la singularité, donc un photon ne peut s’échapper de la région $r < R_s$.\
Le rayon $R_s$ forme ainsi une frontière appelée #text(style: "italic")[horizon des événements], et ainsi un photon émis en $r < R_s$ n’a aucune chance d’atteindre un observateur ; l’objet nous apparaît alors noir.\
Un tel objet est appelé #text(style: "italic")[trou noir].

==== Coordonnées d’Eddington–Finkelstein retardées <CEFR>

On cherche maintenant à fournir une meilleure description pour les rayons sortants.\
\
Pour cela, on peut remarquer que @rayentr et @raysort sont identiques au signe près ; alors les calculs seront identiques, moyennant un
signe moins en facteur.
On en déduit une nouvelle coordonnée, de la même manière que dans @CEFA, i.e. en prenant la constante d’intégration :
$
  q = t - r - R_s lna(r/R_s - 1)
$
la métrique devient ainsi :
$
  ds^2 = (1 - R_s/r) dif q^2 + 2 dif q dif r - r^2 (dif theta^2 + sin(theta) dif phi^2)
$
De même, on a bien résolu la singularité en $r = R_s$.\
Comme pour @CEFA, il est plus pratique de travailler avec la variable temporelle suivante :
$
  t' = q + r = t - R_s lna(r/R_s - 1)
$
les coordonnées $(t', r, theta, phi)$ sont elles appelées coordonnées d’Eddington–Finkelstein retardées.\
Si on s’intéresse aux géodésiques, on obtient les équations suivantes :
$
  t' = r + "const"\
  t' = r - 2 R_s lna(r/R_s - 1) + "const"
$

#figure(
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
    content((5.06, -0.3), $R_s$)
  }),
  caption: [diagramme $(t',r)$, avec les cônes de lumière,\ avec en rouge les photons entrants, et en bleu les photons sortants],
)

On remarque, comme attendu, qu'ici ce sont les rayons sortants qui sont continus pour $r = R_s$. De même, si l’on regarde la structure des
cônes de lumière : ceux-ci sont entièrement #text(style: "italic")[tournés] vers l’extérieur pour $r < R_s$, ainsi un rayon lumineux sera forcément éjecté de la région $r < R_s$.\
Le rayon $R_s$ forme aussi une frontière, également appelée #text(style: "italic")[horizon des événements], et ainsi, au contraire de la solution trou noir,
un photon émis en $r < R_s$ atteint forcément un observateur lointain ; l’objet nous apparaît alors blanc.\
Un tel objet est appelé #text(style: "italic")[trou blanc].

#set heading(numbering: none)

= Conclusions

Ainsi au cours de ce stage, nous avons pu dans un premier temps nous introduire aux mathématiques de la géométrie riemannienne, par l’introduction des différents tenseurs, tels que : le tenseur de Riemann, de Ricci, ou encore des symboles de Christoffel. Ce qui nous a permis, à l’aide de la mécanique lagrangienne, d’en déduire une équation pour les géodésiques d’une surface donnée.\
Ensuite nous avons pu mettre en pratique, dans le cas de la relativité générale, ce que nous avons appris dans le premier chapitre, ce qui nous a permis d’en déduire la métrique de Schwarzschild, qui est la solution aux équations d’Einstein pour une masse ponctuelle statique à symétrie sphérique. Bien que cette solution présente un cas particulier, celui-ci est tout de même utilisable en astrophysique pour des astres avec une période de rotation faible face à la vitesse de la lumière, permettant d’approximer la métrique aux alentours de tels astres.\
Enfin, nous avons poussé l’étude de la solution pour en déduire notamment ses géodésiques radiales, et donc du mouvement, réel et apparent, d’objets tombant dans une masse ponctuelle ; nous avons calculé que l’objet atteindra la singularité en un temps fini, mais paraîtra se stopper aux abords de l’horizon des événements pour un observateur lointain. Puis nous avons levé la singularité apparente présente au niveau du rayon de Schwarzschild, ce qui nous a permis d’en déduire deux solutions : les trous noirs et les trous blancs, qui forment une paire d’objets théoriques, dont le premier, les trous noirs, a été confirmé expérimentalement bien plus tard que la publication originale des travaux de Schwarzschild en 1916, jusqu’à en avoir une image courant 2019 du trou noir $upright(M)87^*$.\
Nous aurions pu continuer l’étude de la métrique de Schwarzschild jusqu’aux coordonnées de Kruskal-Szekeres, qui permettent de réunir les solutions trou noir et trou blanc, et de voir apparaître un passage entre les deux solutions, appelé #text(style: "italic")[pont d’Einstein-Rosen].

#pagebreak()

#bibliography("biblio.bib", title: [Bibliographie])

#pagebreak()

#set heading(supplement: [Annexe], numbering: (..nums) => {
  if nums.pos().len() == 2 {
    nums.pos().at(1)
  }
})

#align(center + horizon)[= Annexe]

#pagebreak()

#align(center)[== Programme<programme>]

Pour le calcul des symboles de Christoffel de la @calcristo, on a fait un programme, ici fait via le CAS : #link("https://xcas.univ-grenoble-alpes.fr/index.html", [giac/Xcas]).\

Pour exécuter ce programme, via Xcas, il faut se placer dans `cfg -> Mode (syntax) -> Xcas`
```
X := [t, r, theta, phi];

d := len(X);

g := [
    [1 - Rs/r ,0, 0, 0],
    [0,-(1 - Rs/r)^(-1), 0, 0],
    [0,0,-r^2 , 0],
    [0,0,0, -r^2 * sin(theta)^2]
];

ginv := g^-1;

G := makemat( matrix(d), 0, d)[0];

for ( j := 0; j < d; j++){
    for ( k := 0; k < d; k++){
        for( l:=0; l < d; l++){
            tmp := 0;
            for (m:=0; m < d; m++){
              tmp = tmp + 1/2 * ginv[j][m] * ( diff( g[k][m], X[l]) + diff( g[l][m], X[k]) - diff( g[k][l], X[m]))
            }
            G[j][k][l] := simplify(tmp)
        }
    }
};

dg := det(g);

Ri := makemat(d);

for (j := 0; j < d; j++){
  for (k := 0; k < d; k++){
    tmp1 := 0;
    tmp2 := 0;
    tmp3 := 0;
    tmp4 := 0;
    for(a := 0; a < d; a++){
      tmp1 := tmp1 + diff( G[a][j][k], X[a]);
      tmp3 := tmp3 + G[a][j][k] * diff( ln( sqrt(-dg) ), X[a]);
      for ( b := 0; b < d; b++) {
        tmp2 := tmp2 + G[b][a][j] * G[a][b][k];
      }
    }
    Ri[j][k] := simplify( - diff( diff (ln(sqrt(-dg)), X[k]), X[j]) + tmp1 - tmp2 + tmp3)
  }
};

R := 0;

for ( j := 0; j < d; j++){
  for( k := 0; k < d; k++){
    R = R + ginv[j][k] * Ri[j][k]
    }
}

```