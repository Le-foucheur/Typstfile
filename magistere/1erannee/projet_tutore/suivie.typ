#import "../../../template.typ": *
#import "../../../transposition.typ": *
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot

#let equa = counter("equa")
#equa.step()

#show outline.entry: set block(above: 5mm)
#set outline(depth: 3)
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
  if el == none or el.func() != eq { return it }
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

//Pour simili le Latex

#set page(margin: (y: 1.75in), number-align: center, numbering: (it, ..) => {
  if it != 1 { if it != 2 { it } }
})

#set par(leading: 0.55em, spacing: 0.55em, justify: true)
#set text(font: "Linux Libertine", historical-ligatures: true)
#show raw: set text(font: "Linux Libertine")
#show heading: set block(above: 1.4em, below: 1em)
#set document(title: text(20pt)[Résolution de Schwarzschild])
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
Résume (maximum 1/2 page) du travail effectue (contexte, résultats).

#let pagenub = context {
  let nbpage = counter(page)
  if nbpage != 1 or nbpage != 2 { counter(page).display("1") } else {}
}

#pagebreak()

#context counter(page).update(3)
#outline(title: [Table des matières])

#pagebreak()

#show heading.where(body: [Introduction]): set heading(numbering: none)
= Introduction

L'introduction (maximum 2 pages) sert à donner le cadre du travail
(domaine de recherche dans lequel il se situe) et l'état de l'art. Il est normal de citer les références associées: articles @Article01, livres @Livre01, chapitres de livres @Chapitre01, conférences @Proceeding01 ou thèses @These01.
Elle spécifie aussi comment les chapitres suivants sont structurés.
Tout comme le chapitre final ``Conclusions'', l'Introduction est
rédigée après tout le reste.

#pagebreak()

= Bases Théoriques

La première partie du texte a comme objectif de fournir un rappel des
connaissances nécessaires pour comprendre le travail effectue.  Le
titre tout comme son contenu dépendent du type de travail effectue.
Dans le cas d'un travail théorique ou de simulation, il est important de fournir les équations qui seront utilises dans les calculs ou simulations.  Si on s'appuie sur des travaux précédents, il faut (logiquement) les citer\cite{Article01}.  Pour un travail expérimental, il est important de
rappeler ici les phénomènes physiques qui seront utilisés.  Dans le
cas ou on s'appuie sur un système expérimental déjà existant, on
utilise ce chapitre pour en donner une description.

#align(center)[== Équation des géodésiques]

Soit, le lagrangien suivant :
$
  cal(L)(x^alpha, dot(x)^alpha) = [g_(mu nu)(x) dot(x)^mu dot(x)^nu]^(1/2)
$
avec $dot(x)^alpha = (dif x^alpha)/(dif s)$\
Ainsi on a :
$
  (partial cal(L))/(partial x^alpha) & = 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) diff/(diff x^alpha) (g_(mu nu) dot(x)^mu dot(x)^nu)\
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) (partial g_(mu nu))/(diff x^alpha) dot(x)^mu dot(x)^nu\
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu, alpha) dot(x)^mu dot(x)^nu
$
où on note : $g_(mu nu, alpha) = (partial g_(mu nu))/(diff x^alpha)$\
Et
$
  (partial cal(L))/(partial dot(x)^alpha) &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) diff/(diff dot(x)^alpha) (g_(mu nu) dot(x)^mu dot(x)^nu) = 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) diff/(diff dot(x)^alpha) ( dot(x)^mu dot(x)^nu)\
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) ( dot(x)^nu underbrace(partial/(diff dot(x)^alpha) ( dot(x)^mu), = delta_alpha^mu) + dot(x)^mu underbrace(partial/(diff dot(x)^alpha) ( dot(x)^nu), = delta_alpha^nu))\
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) ( dot(x)^nu delta_alpha^mu + underbrace(dot(x)^mu delta_alpha^nu, = dot(x)^nu delta_alpha^mu "car" mu "et" nu "sont muets"))\
  &= cancel(1/2) [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) dot.c cancel(2) dot(x)^nu delta_alpha^mu\
  &= [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(alpha nu) dot(x)^nu
$
Ainsi par les équations d’Euleur-La Grange, on obtient l’équation suivante :
$
  dif/(dif s) ( [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(alpha nu) dot(x)^nu) = 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu, alpha) dot(x)^mu dot(x)^nu
$
\
En posant :
$
             dif lambda & = [g_(mu nu)dot(x)^mu dot(x)^nu]^(1/2) dif s \
  Donc dif/(dif lambda) & = [g_(mu nu)dot(x)^mu dot(x)^nu]^(-1/2) dif/(dif s)
$
Ainsi, en réécrivant l’équation précédente :
$
  dif/(dif s) ( [g_(mu nu) dot(x)^mu dot(x)^nu]^(- 1/2) g_(alpha nu) dif/(dif s) x^nu) &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu, alpha) dif/(dif s) x^mu dif/(dif s) x^nu\
  donc [g_(mu nu) dot(x)^mu dot(x)^nu]^(1/2) dif /(dif lambda) (cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(- 1/2)) g_(alpha nu) cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(1/2)) dif/(dif lambda) x^nu ) &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) [g_(mu nu) dot(x^mu) dot(x)^nu] g_(mu nu, alpha) dif/(dif lambda) x^mu dif/(dif lambda) x^nu\
  donc cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(1/2)) dif /(dif lambda) (g_(alpha nu) dif/(dif lambda) x^nu ) &= 1/2 cancel([g_(mu nu)dot(x)^mu dot(x)^nu]^(1/2)) g_(mu nu, alpha) dif/(dif lambda) x^mu dif/(dif lambda) x^nu\
  donc dif / (dif lambda) (g_(alpha nu) dif/(dif lambda) x^nu) &= 1/2 g_(mu nu, alpha) dif/(dif lambda) x^mu dif/(dif lambda) x^nu
$
\
Si on écrit l’action par rapport à $s$, on a :
$
  S_1 = integral [g_(mu nu) dif/(dif s) x^mu dif/(dif s) x^nu]^(1/2) dif s
$
Alors en oprérant le changement de variable $S_1$ devient :
$
  S_1 & = integral cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(1/2)) [g_(mu nu) dif/(dif lambda) x^mu dif/(dif lambda) x^nu]^(1/2) cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(-1/2)) dif lambda\
  &= integral [g_(mu nu) dif/(dif lambda) x^mu dif/(dif lambda) x^nu]^(1/2) dif lambda
$
Donc comme $S_1$ est invariante par la transformation $s --> lambda$ et que celle-ci est un diféomorphisme, on a alors :
$
  dif/(dif s)(g_(alpha nu) dot(x)^nu) = 1/2 g_(mu nu, alpha) dot(x)^mu dot(x)^nu
$
Donc en calculant le terme de gauche :
$
  d/(dif s)(g_(alpha nu)dot(x)^nu) &= dot(x)^nu dif/(dif s) g_(alpha nu) + g_(alpha nu) dot.double(x)^nu\
  &= g_(alpha nu) dot.double(x)^nu + dot(x)^nu underbrace((partial g_(alpha nu))/(partial mu), = g_(alpha nu, mu)) underbrace((dif x^mu)/(dif s), = dot(x)^mu)\
  &= g_(alpha nu) dot.double(x)^nu + g_(alpha nu, mu) dot(x)^nu dot(x)^mu
$
Ainsi :
$
  underbrace(g^(alpha beta) g_(alpha nu), = delta_nu^beta) dot.double(x)^nu &= 1/2 g_(mu nu, alpha) dot(x)^mu dot(x)^nu - g_(alpha nu, mu) dot(x)^nu dot(x)^mu\
  Donc dot.double(x)^beta &= 1/2 g^(alpha beta) (g_(mu nu, alpha) - 2g_(alpha nu, mu)) dot(x)^nu dot(x)^mu\
  Donc dot.double(x)^beta &= 1/2 g^(alpha beta) (g_(mu nu, alpha) - g_(alpha nu, mu) - g_(alpha mu, nu)) dot(x)^nu dot(x)^mu
$
En introduisant les symboles de Christoffel $Gamma^beta_(mu nu) = 1/2 g^(beta alpha) (g_(mu alpha, nu) + g_(nu alpha, mu) - g_(mu nu, alpha) )$ on a :
$
  dot.double(x)^beta = - Gamma^beta_(mu nu) dot(x)^mu dot(x)^nu\
  "Soit" dot.double(x)^beta + Gamma^(beta)_(mu nu) dot(x)^mu dot(x)^nu = 0
$ <eqgeo>

#align(center)[== Commuteur des Co-dérivés covariante]

On définit les dérivés covariantes par :
$
  nabla_mu v^nu = partial_mu v^nu + Gamma^nu_(mu rho) v^rho
$
Ainsi, soit $v^rho$ un vecteur :
$
  [nabla_mu; nabla_nu]v^rho &= nabla_mu (nabla_nu v^rho) - nabla_nu (nabla_mu v^rho) \
  &= nabla_mu (partial_nu v^rho + Gamma_(nu alpha)^rho v^alpha) -nabla_nu (partial_mu v^rho + Gamma_(mu alpha)^rho v^alpha) \
  &= partial_mu (partial_nu v^rho + Gamma_(nu alpha)^rho v^alpha) + Gamma_(mu beta)^rho (partial_nu v^beta + Gamma_(nu alpha)^beta v^alpha)
  -
  partial_nu (partial_mu v^rho + Gamma_(mu alpha)^rho v^alpha) - Gamma_(nu beta)^rho (partial_mu v^beta + Gamma_(mu alpha)^beta v^alpha)\
  &= cancel(diff_(nu mu) v^rho) + diff_mu Gamma_(nu alpha)^rho v^alpha + Gamma_(mu beta)^rho diff_nu v^beta + Gamma_(mu beta)^rho Gamma_(nu alpha)^beta v^alpha
  -
  cancel(diff_(mu nu) v^rho) - diff_nu Gamma_(mu alpha)^rho v^alpha - Gamma_(nu beta)^rho diff_mu v^beta - Gamma_(nu beta)^rho Gamma_(mu alpha)^beta v^alpha\
  &= (Gamma_(mu beta)^rho Gamma_(nu alpha)^beta-Gamma_(nu beta)^rho Gamma_(mu alpha)^beta
    +
    diff_mu Gamma_(nu alpha)^rho - diff_nu Gamma_(mu alpha)^rho) v^alpha + underbrace(Gamma_(mu beta)^rho diff_nu v^beta - Gamma_(nu beta)^rho diff_mu v^beta, =0)
$
Ainsi, on reconnait le tenseur de Riemann définis par :$R^sigma_(mu nu kappa) = diff_nu Gamma^sigma_(mu kappa) - diff_kappa Gamma^sigma_(mu nu) + Gamma^sigma_(nu lambda) Gamma^lambda_(mu kappa) - Gamma^sigma_(kappa lambda) Gamma^lambda_(mu nu)$\
Donc on obtient la relation suivante :
$
  [nabla_mu; nabla_nu]v^rho = R^rho_(alpha mu nu) v^alpha
$

#align(center)[== Dérivé covariante]

On se place dans un système de coordonnée $xi^alpha$, et on s’intérèse à un changement de coordonée vers $x^alpha$\
Tout d’abord :
$
  0 = (dif^2 xi^alpha)/(dif tau^2) &= dif/(dif tau) ((dif xi^alpha)/(dif tau))\
  &= dif/(dif tau) ((diff xi^alpha)/(diff x^mu) (dif x^mu)/(dif tau))\
  &= (diff xi^alpha)/(diff x^rho) (dif^2 x^rho)/(dif tau^2) + (dif x^mu)/(dif tau) dif/(dif tau) (diff xi^alpha)/(diff x^mu)
$
Ainsi comme $(diff xi^alpha)/(diff x^mu) times (diff x^mu)/(diff xi^beta) = delta_beta^alpha$, en multipliant des deux cotés :
$
  0 &= (dif^2 x^rho)/(dif tau^2) + (diff x^rho)/(diff xi^alpha) dif/(dif tau) (diff xi^alpha)/(diff x^mu) (dif x^mu)/(dif tau) \
  &= (dif^2 x^rho)/(dif tau^2) + (diff x^rho)/(diff xi^alpha) (diff^2 xi^alpha)/(diff x^mu diff x^nu) (dif x^mu)/(dif tau) (dif x^nu)/(dif tau)
$
En posant : ${""_mu ""^lambda ""_(nu)} = (diff x^lambda)/(diff xi^beta) (diff^2 xi^beta)/(diff x^mu diff x^nu)$, on obtient finalement :
#let croh(m: sym.mu, l: sym.lambda, n: sym.nu) = ${""_#m ""^#l ""_(#n)}$
$
  0 & = (dif^2 x^rho)/(dif tau^2) + croh(l: rho) (dif x^mu)/(dif tau) (dif x^nu)/(dif tau)
$
\
\
En réécrivant le produit scalaire dans les coordonnées $x^alpha$ à:
$
  eta_(mu nu) dif xi^mu dif xi^nu = underbrace(eta_(mu nu) (diff xi^mu)/(diff x^alpha) (diff xi^nu)/(diff x^beta), = g_(alpha beta)) dif x^alpha dif x^beta
$
Donc :
$
  g_(alpha beta) = eta_(mu nu) (diff xi^mu)/(diff x^alpha) (diff xi^nu)/(diff x^beta)
$
alors en dérivant :
$
  g_(alpha beta, lambda) = diff_lambda g_(alpha beta) &= eta_(mu nu) diff/(diff x^lambda) ((diff xi^mu)/(diff x^alpha) (diff xi^nu)/(diff x^beta))\
  &= underbrace(eta_(mu nu) (diff xi^mu)/(diff x^alpha), = g_(alpha mu) (diff x^mu)/(diff xi^nu)) (diff^2 xi^nu)/(diff x^beta diff x^lambda) + underbrace(eta_(mu nu) (diff xi^nu)/(diff x^beta), = g_(beta nu) (diff x^nu)/(diff xi^mu)) (diff^2 xi^mu)/(diff x^alpha diff x^lambda)\
  &= g_(alpha mu) underbrace((diff x^mu)/(diff xi^nu) (diff^2 xi^nu)/(diff x^beta diff x^lambda), = croh(l: mu, m: beta, n: lambda))
  +
  g_(beta nu) underbrace((diff x^nu)/(diff xi^mu) (diff^2 xi^mu)/(diff x^alpha diff x^lambda), = croh(l: nu, m: alpha, n: lambda))\
  &= croh(m: beta, n: lambda, l: mu) g_(mu alpha) + croh(m: alpha, n: lambda, l: nu) g_(nu beta)\
$
Donc en sommant pour différante dérivé :
$
  g_(alpha beta, lambda) + g_(lambda beta, alpha) - g_(alpha lambda, beta) &= croh(l: mu, m: alpha, n: lambda) g_(mu beta) + cancel(croh(m: beta, n: lambda, l: nu) g_(nu alpha))\
  &+ cancel(croh(l: mu, m: beta, n: alpha) g_(mu lambda)) + croh(m: lambda, n: alpha, l: nu) g_(nu beta)\
  &- cancel(croh(l: mu, m: alpha, n: beta) g_(mu lambda)) cancel(- croh(m: lambda, n: beta, l: nu) g_(nu alpha))\
  &= croh(l: mu, m: alpha, n: lambda) g_(mu beta) + croh(m: lambda, n: alpha, l: nu) g_(nu beta) = 2 croh(l: mu, n: lambda, m: alpha)g_(mu beta)
$
Ainsi :
$
  Gamma^(gamma)_(alpha lambda) &= 1/2 g^(gamma beta) (g_(alpha beta, lambda) + g_(lambda beta, alpha) - g_(alpha lambda, beta)) = 1/2 g^(gamma beta) times 2 croh(l: mu, n: lambda, m: alpha) g_(mu beta)\
  &= croh(l: mu, n: lambda, m: alpha) delta^gamma_(mu) = croh(l: gamma, n: lambda, m: alpha)
$
On trouve que : $Gamma^(mu)_(alpha beta) = croh(l: mu, m: alpha, n: beta)$, et pas concéquant : $Gamma_(alpha beta)^mu = (diff x^mu)/(diff xi^nu) (diff^2 xi^nu)/(diff x^alpha diff x^beta)$

=== Transformation de $Gamma_(mu nu)^lambda$

Regardons comment $Gamma$ se transforme, pour voir si c’est un tenseur\
\

#align(center, math.equation(numbering: none, block: true)[
  $
    Gamma_(mu nu)^lambda ' &= croh()' = (diff x'^lambda)/(diff xi^beta) (diff^2 xi^beta)/(diff x'^mu diff x'^nu)\
    &= (diff x'^lambda)/(diff xi^beta) diff/(diff x'^mu) ((diff xi^beta)/(diff x'^nu))\
    &= (diff x'^lambda)/(diff xi^beta) diff/(diff x'^mu) ((diff x^alpha)/(diff x'^nu) (diff xi^beta)/(diff x^alpha))\
    &= (diff x'^lambda)/(diff xi^beta) ( (diff xi^beta)/(diff x^alpha) (diff^2 x^alpha)/( diff x'^mu diff x'^nu) + (diff x^alpha)/(diff x'^nu) (diff^2 xi^beta)/(diff x'^mu diff x^alpha) )\
    &= (diff x'^lambda)/(diff x^rho) (diff x^rho)/(diff xi^beta) ( (diff xi^beta)/(diff x^alpha) (diff^2 x^alpha)/( diff x'^mu diff x'^nu)
      + (diff x^alpha)/(diff x'^nu) (diff^2 xi^beta)/(diff x'^mu diff x^alpha) )\
    &= (diff x'^lambda)/(diff x^rho) (diff x^alpha)/(diff x'^nu) (diff x^sigma)/(diff x'^mu) underbrace((diff x^rho)/(diff xi^beta) (diff^2 xi^beta)/(diff x^sigma diff x^alpha), = croh(m: sigma, l: rho, n: alpha))
    + (diff x'^lambda)/(diff xi^beta) (diff xi^beta)/(diff x^alpha) (diff^2 x^alpha)/( diff x'^mu diff x'^nu) \
    &= (diff x'^lambda)/(diff x^rho) croh(m: sigma, l: rho, n: alpha) (diff x^sigma)/(diff x'^mu) (diff x^alpha)/(diff x'^nu)
    + (diff x'^lambda)/(diff x^alpha) (diff^2 x^alpha)/( diff x'^mu diff x'^nu) \
  $
])
Ainsi $ Gamma_(mu nu)^lambda ' = (diff x'^lambda)/(diff x^rho) croh(m: sigma, l: rho, n: alpha) (diff x^sigma)/(diff x'^mu) (diff x^alpha)/(diff x'^nu)
+ (diff x'^lambda)/(diff x^alpha) (diff^2 x^alpha)/( diff x'^mu diff x'^nu) \ $ <pasbontenseur>

Donc d’après @pasbontenseur, $Gamma^alpha_(mu nu)$ n’est pas un tenseur

=== Définition de la dérivé covariante

Comme la dérivé d’un tenseur n’en est pas un, alors, on définis la dérivé covariante pour un vecteur $v^nu$ par :
$
  nabla_mu v^nu = diff_mu v^nu + Gamma^nu_(mu rho) v^rho
$

Vérifions que c’est bien un tenseur, soit un vecteur $x^nu$ :\
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

Ainsi $nabla_mu$ se transforme comme il faut, et donc $nabla_mu$ est un (1,0)–tenseur.

= Théorie & Algorithmes

Le cadre théorique défini, on passe a une description plus précise du
travail spécifique effectué. Tout comme dans les sections précédentes, il est normal de faire référence @Livre01 @Chapitre01 aux textes d'où on a pris les méthodes utilisées.

- Dans le cas d'un travail théorique on montre ici les calculs
effectues et les étapes pour traiter / simplifier / résoudre les
équations.

- item Pour des simulations, on discute des algorithmes numériques,
des choix effectues, approximations, etc.

- item Pour un travail expérimental on présente la mise en place du
système (si elle fait partie du travail), les procédures de mesure
et de traitement des données.

Le chapitre sert à montrer la démarche utilisée pour arriver aux
résultats qui seront ensuite analysées et discutes dans le chapitre
suivant.

#align(center)[== Solution de Schwarzschild]


=== Équation sur $R_(mu nu)$

On se place dans un espace de dimension $n$\
D’après l’équation de Einstein :
$
  R_(mu nu) - 1/2 g_(mu nu) R = kappa T_(mu nu)
$
On recherche une solution pour un espace vide, statique et à symétrie sphérique\
donc $T_(mu nu) = 0$, ainsi l’équation devient :
$
                                                                        R_(mu nu) - 1/2 g_(mu nu) R & = 0 \
                                                       donc g^(mu nu) (R_(mu nu) - 1/2 g_(mu nu) R) & = 0 \
  donc underbrace(g^(mu nu) R_(mu nu), = R) - 1/2 underbrace(g^(mu nu)g_(mu nu), = delta_mu^mu = n) & = 0 \
                                                                                   donc R(1 - 1/2n) & = 0 \
                                                                                      donc R(2 - n) & = 0
$

Ainsi on a deux cas particulier :
- Soit $n = 2$, dans ce cas la gravité est topologique
- Soit $R = 0$

Or on recherche une solution pour un espace à 4 dimension ( 3 d’espace + 1 de temps), ainsi $R = 0$\
En injectant dans l’équation d’Einstein :
$
  R_(mu nu) - 1/2 g_(mu nu) underbrace(R, = 0) = 0\
  Donc R_(mu nu) = 0
$ <Ricci>

=== Écriture de la métrique dans un espace isotropique statique

On sait que dans un espace isotropique, la métrique doit ressembler à :
$
  dif s^2 = A(r,t)dif t^2 - B(r, t) dif t (arrow(x) dot.c dif arrow(x)) - C(r, t) (arrow(x) dot.c dif arrow(x))^2 - D(r, t) dif arrow(x)^2
$
En opérant le changement de variables en coordonnées sphérique :
$
  x^1 & = r sin(theta) cos(phi) \
  x^2 & = r sin(theta) sin(phi) \
  x^3 & = r cos(theta)
$
Dans ce cas on a :
$
  arrow(x) dot.c arrow(x) = r^2, "    " arrow(x) dot.c arrow(x) = r dr, "    "dif arrow(x) dot.c dif arrow(x) = dr^2 + r^2 dif theta^2 + r^2 sin(theta)^2 dif phi^2
$
Ainsi la métrique devient :
$
  ds^2 & = A(t,r)dt^2 - B(t, r) r dt dr - C(t,r) r^2 dr^2 - D(t, r) dr^2 - D(t,r) r^2 dif^2 Omega \
       & = A(t,r)dt^2 - B'(t,r) dt dr - C'(r,t) dr^2 - D' dif^2 Omega
$
avec $dif^2 Omega = dif theta^2 + sin(theta)^2 dif phi^2$ l’angle solide et $B' = B r;" " C' = C r^2 + D et D' = D$\
On pose $dash(r)^2 = D'$, alors :
$
  ds^2 = A(t, dash(r)) dt^2 - B'(t, dash(r)) dt dif dash(r) - C'(t, dash(r)) dif dash(r)^2 - dash(r)^2 dif^2 Omega
$
On pose également un nouveau temps : $dif dash(t) = Phi(t, dash(r))[A(t, dash(r)) dt - 1/2 B'(t, dash(r)) dif dash(r)]$, donc
$
  dif dash(r)^2 = Phi(t, dash(r)) [A^2 dt^2 + 1/4 B'^2 dif dash(r)^2 - A B' dt dif dash(r) ]\
  Donc A dt^2 - B' dt dif dash(r) = 1/(A Phi) dif dash(t)^2 - B/(4 A) dif dash(r)^2
$
la métrique devient :
$
  ds^2 = 1/(A Phi) dif dash(t)^2 -(B/(4A) + C')dif dash(r)^2 - dash(r)^2 dif^2 Omega
$
Ainsi en posant deux nouvelles fonctions $dash(A) = 1/(A Phi) et dash(B) = B/(4A) + C'$, la métrique devient :
$
  ds^2 = dash(A)(dash(t), dash(r)) dif dash(t)^2 - dash(B)(dash(t), dash(r)) dif dash(r)^2 - dash(r)^2 dif^2 Omega
$
Comme à partir de maintenant l’on ne travaillera qu’avec les quantités avec une barre : $dash(A), dash(B), dash(t), dash(r)$, on les renotera sans la barre, pour plus de claireté\
De plus comme l’on imposse au système d’être statique, alors les grandeurs $A et B$ sont indépendantes du temps \
ainsi la métrique s’écrit finalement :
$
  ds^2 = A(r) dt^2 - B(r)dr^2 - r^2 dif^2 Omega
$
=== Solution de Schwarzschild

D’après @Ricci, $R_(mu nu) = 0$, or
$
  R_(mu nu) = diff_nu Gamma^sigma_(mu sigma) - diff_sigma Gamma^sigma_(mu nu) + Gamma^(rho)_(mu sigma) Gamma^sigma_(rho nu) - Gamma^(rho)_(mu nu) Gamma^(sigma)_(rho sigma)
$
Ainsi en calculant les symboles de Christoffel, on obtiendra des équations sur $A et B$

==== Calcule des Christoffel
Pour calculer les symboles de Christoffel, on pourrait partir de la définition :
$
  Gamma^mu_(alpha beta) = 1/2 g^(mu rho)(g_(alpha rho, beta) + g_(beta rho, alpha) - g_(alpha beta, rho))
$
Cependant, ceci demande de calculer indépendament chaque coefficient, or en dimension $4$ il y en a $4^3 = #calc.pow(4, 3)$, rendant les calcules longs et éreintant.\
Or, il existe une méthode plus rapide pour les calculer, celle-ci ce base sur le faits que l’équation des géodésiques, @eqgeo, dépend directement des symboles de Christoffel.\
Donc pour les calculer, on prend le lagrangien $cal(L) = g_(mu nu)dot(x)^mu dot(x)^nu$, que l’on insère dans les équations d’Euleur-La Grange, pour retomber sur l’équation des géodésiques.\
Ici nous ne ferons que le calcule pour la variable $r$, le reste à été faits par un programme en MatLab (`cristofell.m`, présent dans le même dossier).\
Ainsi, le lagrangien s’écrit : $cal(L) = A(r)dot(t)^2 - B(r) dot(r)^2 - r^2 dot(theta)^2 - r^2 sin(theta)^2 dot(phi)^2$, alors on a :
$
  diff_(dot(r)) cal(L) = -2B(r)dot(r)\
  donc dif/(dif cal(s)) diff_(dot(r)) cal(L) = -2 dif/(dif cal(s)) (dot(r) B(r)) = -2 (dif dot(r))/(dif cal(s)) B - 2dot(r) dr/(dif cal(s)) (dif B(r))/dr = -2 dot.double(r) B - 2 dot(r)^2 B'(r)
$
Où on note les dérivés par un point les dérivés par à $cal(s)$ et $B'(r) et A'(r)$ les dérivés par rapport à $r$.\
Nous avons également :
$
  diff_r cal(L) = A'(r)dot(t)^2 - B'(r) dot(r)^2 - 2r dot(theta)^2 - 2 r sin(theta)^2 dot(phi)^2
$
Donc d’après les équations d’Euleur-La Grange :
$
  -2 dot.double(r) B(r) - 2 dot(r)^2 B' = A'dot(t)^2 - B' dot(r)^2 - 2r dot(theta^2) - 2r sin(theta)^2 dot(phi)^2
$
$
  donc dot.double(r) + A'/(2B) dot(t)^2 + B'/(2B) dot(r)^2 - r/(B) dot(theta)^2 - (r sin(theta)^2)/(B) dot(phi)^2
$ <eqr>
Or comme l’équation des géodésiques s’écrit : $dot.double(x)^mu + Gamma^mu_(alpha beta) dot(x)^alpha dot(x)^beta = 0$, alors en identifiant avec @eqr, on trouve :
$
  Gamma^1_(mu nu) = mat(
    A'/(2B), 0, 0, 0;
    0, B'/(2B), 0, 0;
    0, 0, -r/B, 0;
    0, 0, 0, - (r sin(theta)^2)/B
  )
$
Donc après calcule, on touve que :
$
  Gamma^0_(mu nu) = mat(
    0, A'/(2A), 0, 0;
    A'/(2A), 0, 0, 0;
    0, 0, 0, 0;
    0, 0, 0, 0
  )
$
$
  Gamma^2_(mu nu) = mat(
    0, 0, 0, 0;
    0, 0, 1/r, 0;
    0, 1/r, 0, 0;
    0, 0, 0, -sin(theta) cos(theta);
  )
$
$
  Gamma^3_(mu nu) = mat(
    0, 0, 0, 0;
    0, 0, 0, 1/r;
    0, 0, 0, cot(theta);
    0, 1/r, cot(theta), 0;
  )
$

==== Équation de $A$ et $B$

De la même manière les différent coefficient de $R_(mu nu)$ on été calculé par le même programme, ainsi on obtient comme seul coefficient non nul :
$
  R_(0 0) = A'/(r B) + A''/(2B) - A'/(4B) (A'/A + B'/B)\
  R_(1 1) = B'/(r B) - A''/(2A) + A'/(4A) (A'/A + B'/B)\
  R_(2 2) = (r B')/(2 B^2) - 1/B - (r A')/(2A B) + 1\
  R_(3 3) = sin(theta)^2 ((r B')/(2 B^2) - 1/B - (r A')/(2A B) + 1)
$
Ainsi par @Ricci, on obtient le système suivant :
$
  cases(
    R_(0 0) = A'/(r B) + A''/(2B) - A'/(4B) (A'/A + B'/B) = 0,
    R_(1 1) = B'/(r B) - A''/(2A) + A'/(4A) (A'/A + B'/B) = 0,
    R_(2 2) = (r B')/(2 B^2) - 1/B - (r A')/(2A B) + 1 = 0,
    R_(3 3) = sin(theta)^2 ((r B')/(2 B^2) - 1/B - (r A')/(2A B) + 1) = 0
  )
$<sys>
On remarque que les deux dernières équations sont redontantes, donc le système ce réduit à :
$
  cases(
    A'/(r B) + A''/(2B) - A'/(4B) (A'/A + B'/B) = 0,
    B'/(r B) - A''/(2A) + A'/(4A) (A'/A + B'/B) = 0,
    (r B')/(2 B^2) - 1/B - (r A')/(2A B) + 1 = 0
  )
$
Si on multiplie la première ligne avec $B/A$ puis que l’on la somme avec la seconde, on obtient :
$
  R_(0 0) times B/A + R_(1 1) = A'/(r A) + B'/(r B) = 0
$
$
  Donc A'B + B' A = 0 = dif/dr (A B)
$ <AB0>
$
  Donc A B = alpha in RR
$
Or, on veut que la métrique tende vers celle de minkovski (univers plat) à grande distance, i.e. $A(r) tend(r, +oo) 1 et B(r) tend(r, +oo) 1$, donc :
$
  A B tend(r, +oo) alpha = 1
$
donc $alpha = 1$ et donc :
$
  B = 1/A
$ <B1A>

En métant sur le même dénominateur la première équation du système à @sys :
$
  (4A' A B + 2 A'' A B r - A'^2 B r - A' B' A r)/(4r A B^2) = 0
$
donc
$
  4A' A B + 2 A'' A B r - A'r underbrace(cancel(A' B + B'A), #[selon @AB0]) = 0
$
alors :
$
  A'' + 2/r A' = 0
$
on reconnait une équation du premier ordre par rapport à $A'$, soit :
$
  A' = K e^(-2 ln(r)) = K/r^2
$
avec $K in RR$\
on trouve enfin que :
$
  A(r) = C - K/r\
  et C in RR
$
Or comme $A tend(r, +oo) C = 1$
alors :
$
  A(r) = 1-K/r \
  et\
  B(r) = 1/A = (1 - K/r)^(-1)
$
De plus à la limite des champs faible, on a :
$
  A(r) = 1 + 2phi.alt
$
avec $phi.alt = -(G M)/r$ le potentiel gravitationnel\
Donc $K = 2G M = R_s$ avec $R_s$ le rayon de Schwarzschild\
On peut finalement écrire la métrique final :
$
  ds^2 = (1 - R_s/r) dt^2 - (1-R_s/r)^(-1) dr^2 - r^2 dif^2 Omega
$ <metswart>


= Résultats

Dans ce dernier chapitre on fournit les résultats obtenus et on les
analyse afin de mettre en évidence les nouvelles connaissances
générées et acquises lors du stage.

== Géodésique Radial d’un photon <géoradphot>

On s’intérèse maintenant au géodésique radial, i.e. $dif theta = dif phi = 0$, ainsi la métrique donné par @metswart devinet :
$
  dif s^2 = (1 - R_s/r)dif t^2 - (1 - R_s/r)^(-1) dif r^2
$
Or comme l’on s’intérèse au géodésique : $ds = 0$, donc :
$
  dt = plus.minus (1 - R_s/r)^(-1) dr
$<georadialdiff>
Ainsi on obtient deux solutions, une pour les rayons sortant ( signe $+$ ) et une pour les rayons entrant (signe $-$)\
On va s’intérésser, pour l’instant, seulement au rayon entrant, alors en intégrant @georadialdiff de $R_0 > R_s$ à $r$ :
$
  t (r) & = - integral_(R_0)^r dr'/(1 - R_s/r') \
        & = - integral_(R_0)^r (r' - R_s + R_s)/(r' - R_s) dr' \
        & = - integral_(R_0)^r dr' + integral_(R_0)^(r) R_s/(r' - R_s) dr' \
        & = R_0 - r + R_s ln((R_0 - R_s)/(r - R_s))
$
On obtient la figure suivante :

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
  caption: [temps que mets un photon à atteindre\ un observateur placé en $R_0$],
)
Ainsi on remarque que plus le photon est émis proche de $r = R_s$ plus celuis ci mets du temps à atteindre un observateur distant ( $R_0$ ), jusqu’à divergé quand celui-ci est émis au niveau de $r = R_s$.\
En effet :
$
  t(r) tend(r, +oo) +oo
$
Ainsi du point de vue d’un observateur distant, si un objet tombe dans la singularité, on le verra s’approcher de $R_s$ sans jamais l’atteindre\
\
De plus on peut remarquer que plus le photon est émis loin de la singularité, plus on revient à un comportement non-relativiste.\
En effet, pour $R_s << r$ :\

#align(center, math.equation(numbering: none)[$
  t(r) & = R_0 - r + R_s ln((R_0 - R_s)/(r - R_s)) \
       & = R_0 - r + R_s (ln(R_0 - R_s) - ln(r) - underbrace(ln(1 - R_s/r), = - R_s/r = o(r))) \
$])\
$
  & = R_0 - r - R_s ln(r/(R_0 - R_s)) + o(r) \
  & = R_0 - r + o(r) \
$

== Temps de chute d’un corps

Intérésons-nous, maintenant au temps de chute de deux points de vue : premièrement du point de vue de l’objet lui-même, puis du point de vue d’un observateur lointain.\
On note $tau$ le temps propre de l’objet tombant,\
alors si l’on prend le lagrangien : $cal(L) = g_(mu nu) dot(x)^mu dot(x)^nu = (1 - R_s/r) ((dif t)/(dif tau))^2 - (1 - R_s/r)^(-1) ((dif r)/(dif tau))^2$\
Alors d’après les équation d’Euleur-La Grange par rapport à $t$ :
$
               dif/(dif tau) diff_(dot(t)) cal(L) & = underbrace(diff_t cal(L), = 0) \
  dif/(dif tau) (2 (1 - R_s/r) (dif t)/(dif tau)) & = 0
$
Donc
$
  (dif t)/(dif tau) = k/(1 - R_s/r)
$ <constanteducul>
Or on a :
$
  g_(mu nu) dot(x)^mu dot(x)^nu = c^2 = 1\
  (1 - R_s/r) dot(t)^2 - (1 - R_s/r)^(-1) dot(r)^2 = 1
$
Ainsi en injéctant @constanteducul :
$
  (1 - R_s/r)^(-1) (k^2 - dot(r)^2) = 1 \
  dot(r)^2 = k^2 -1 + R_s/r
$<eq324>
donc en dérivant :
#align(center, math.equation(numbering: none)[$
  2 dot(r) dot.double(r) & = - R_s dot(r)/r^2 \
$])
Ainsi en ré-intégrant de $r$ à $R_0$
$
  dot(r)^2 = -R_s [1/r]_r^(R_0) = R_s/r - R_s/R_0
$
On en déduis :
$
  k = sqrt(1 - R_s/R_0)\
$
Pour s’implifier les calcules on considèras un objet laché depuis l’infinie.\
ainsi $k = 1$\

On s’intéreseras d’abord au point de vue de l’objet luis même, alors @eq324 devient :
$
  dr/(dif tau) = - sqrt(R_s/r)
$
donc
$
  (dif tau)/dr = - sqrt(r/R_s)
$
alors en intégrant de $R_0$ à $r$ :
$
  tau (r) & = - integral_(R_0)^(r) sqrt(r'/R_s) dr' \
          & = integral_r^(R_0) sqrt(r' /R_s)dr' \
          & = 2/3[sqrt(r'^3/R_s)]^(R_0)_r \
          & = 2/3sqrt(R_0^3/R_s) - 2/3sqrt(r^3/R_s)
$
Ainsi pour un objet tombant d’un point distant à $r = R_s$, alors il atteindra la singularité ($r = 0$) en :
$
  tau tend(r, 0) 2/3 sqrt(R_0^3/R_s)
$

Intérésons-nous maintenant au point de vue d’un observateur lointain, alors comme $k = 1$, @constanteducul devient :\
$
  dt/(dif tau) = (1 - R_s/r)^(-1)
$
Ainsi :
$
  dt/dr & = dt/(dif tau) (dif tau)/dr \
        & = (1 - R_s/r)^(-1) times (- sqrt(r/R_s)) \
        & = - (1 - R_s/r)^(-1)sqrt(r/R_s)
$
Alors en intégrant :
$
  t(r) & = integral_r^(R_0) sqrt(r'/R_s)/(1 - R_s/r') dr' \
  & = 2R_s integral_(u(r))^(u(R_0)) u^2/(1 - 1/u^2) dif u " en posant " u = sqrt(r'/R_s) \
  & = 2 R_s integral_(u(r))^(u(R_0)) u^4/(u^2 - 1) dif u \
  & = 2 R_s integral_(u(r))^(u(R_0)) u^2 (u^2 - 1 + 1)/(u^2 - 1) dif u \
  & = 2 R_s (integral_(u(r))^(u(R_0)) u^2 dif u + integral_(u(r))^(u(R_0)) u^2/(u^2 - 1) dif u) \
  & = 2 R_s (integral_(u(r))^(u(R_0)) u^2 dif u + integral_(u(r))^(u(R_0)) dif u + integral_(u(r))^(u(R_0)) 1/(u^2 - 1) dif u)
$
Ainsi on obtient :

#math.equation(
  numbering: numbering_joli,
  number-align: bottom,
)[$
  t(r) = 2/3 R_s ((R_0/R_s)^(2/3) - (r/R_s)^(2/3) ) + 2 R_s ((R_0/R_s)^(1/2) - (r/R_s)^(1/2) ) + R_s ln(((1 - sqrt(R_0/R_s)) (1 + sqrt(r/R_s)))/((1 + sqrt(R_0/R_s))(1 - sqrt(r/R_s))))
$]\

Or pour $r -> R_s$, on à
$
  ln(((1 - sqrt(R_0/R_s)) (1 + sqrt(r/R_s)))/((1 + sqrt(R_0/R_s))(1 - sqrt(r/R_s)))) tend(r, R_s) + oo
$
donc
$
  t(r) tend(r, R_s) + oo
$

Ainsi pour conclure nous avons les deux grandeur suivante :\
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
On a donc que de sont point de vue l’objet atteind la singularité en un temps finis,\
mais du point de vue d’un observateur lointain l’objet met un temps infinis avant d’atteindre $r = R_s$

== Cônes de lumière

Nous avons déjà vu dans la @géoradphot que les géodésique pour un photons était régis par l’équation :
$
  dt/dr = plus.minus (1- R_s/r)^(-1)
$
où le signe correspond à un photon tantôt entrant ($-$), tantôt sortant ($+$), en intégrant, on obtient deux solutions :
#let lna(x) = $"ln"abs(#x)$
$
  "Rayon entrant :" t = -r - R_s lna(r/R_s - 1) + p_1
$ <rayentr>
$
  "Rayon sortant :" t = r + R_s lna(r/R_s - 1) +p_2
$ <raysort>
où $p_1$ & $p_2$ sont des constantes\
En tracant ces deux solutions pour des $p$ différents, on obtient le diagramme $(t,r)$ suivant :


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
    structure des cones de lumière pour la métrique de Schwarzschild\
    en bleu les rayons sortant, et en rouge les rayons entrant
  ],
) <fig2geolum>
On observe que dans la zone ${0<r<R_s}$ les cônes de lumière sont entièrement retourné vers la singularité, ainsi les photons présent dans cette zone finirons au niveau de la singularité quelque soit leur nature de départ. Ainsi toute particule massive doit également finir au niveau de la singularité.

=== Coordonnées d’Eddington–Finkelstein

Nous pouvons remarquer en regardans la métrique (@metswart) et la @fig2geolum que nous avons deux singularité : une permière pour $r = 0$, qui est une #text(style: "italic")[vraie] singularité, car la courbure scalaire $R_(mu nu rho sigma)R^(mu mu rho sigma) = 12 R_s^2/r^6$ diverge en $0$,\
une seconde en $r = R_s$, qui est une #text(style: "italic")[fausse] singularité, en effet, ici la courbure scalaire est finis $R_(mu nu rho sigma)R^(mu mu rho sigma) = 12/R_s^4$, pour « retirer » cette singularité on peut se mettre dans un système de coordonnée plus « naturel » et qui rend une meilleurs description des lignes-univers.\
\
On propose deux solutions dans les deux chapitre suivant

==== Coordonnées d’Eddington–Finkelstein Avancé <CEFA>

On chercheras d’abord à dévlopé une meilleurs déscription des photons entrant.\
On à donc :
$
  t = -r -R_s lna(r/R_s - 1) + p
$
avec $p$ une constante d’intégration\
L’idée pour construire le nouveau système de coordonée, est de prendre cette constante d’intégration comme nouvelle coordonnée, ainis :
$
  p = t + r + R_s lna(r/R_s - 1)
$
En différentiant :
$
  dif p = dt + r / (r - R_s) dr
$
donc
$
  dt = dif p - (1 - R_s/r)^(-1) dr
$
Ainsi :
$
  dt^2 = dif p^2 + (1 - R_s/r)^(-2) dr^2 - (2 dr dif p)/(1 - R_s/r)
$
Alors en remplacant $dt$ dans la métrique de Schwarzschild, on obtient :
$
  ds^2 = (1 - R_s/r) dif p - 2 dr dif p - r^2 (dif theta^2 + sin(theta) dif phi^2)
$
On remarqueras que la métrique est maintenant continue pour $r in RR^*_+$, résolvant, ainsi, la #text(style: "italic")[fausse]
singularité en $r = R_s$\
Ici on prend toujours le cas radial, donc $dif theta = dif phi = 0$, d’où :
$
  ds^2 = (1 - R_s/r) dif p^2 - 2 dr dif p
$
On remarque ainsi que la singularité en $r = R_s$ à disparu.\

Si on regarde les géodésiques, donc $ds = 0$, on à :
$
  (1 - R_s/r) dif p^2 - 2 dr dif p = 0
$
Donc
$
  (1 - R_s/r) ((dif p)/dr)^2 - 2 (dif p)/dr = 0
$
On reconnait une équation du second degré, dont les deux solutions sont :
$
  (dif p)/dr = 0\
  (dif p)/dr = 2(1 - R_s/r)^(-1)
$
On trouve ainsi ces deux solutions :
$
  p = "const"\
  p = 2 r + 2 R_s lna(r/R_s - 1) + "const"
$
Pour se remener à un diagramme $(t,r)$, on définit la variable de genre temps suivante :
$
  t' = p - r = t + R_s lna(r/R_s - 1)
$
Les coordonnées $(t', r, theta, phi)$ sont appelées, les coordonnées d’Eddington–Finkelstein avancé\
Ainsi on obtient les deux équations suivante :
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
  caption: [diagramme $(t',r)$, avec les cônes de lumière,\ avec en rouge les photons entrant, et en bleu les photons sortant],
)

On remarque ainsi, les rayons entrant sont continue en $r = R_s$. De plus, si on regarde la structure des cônes de lumière, on remarque que cecis sont entièrement tourné vers la singularité,
ainsi le futur d’un photon est entièrement #text(style: "italic")[tourné] vers la singularité, donc un photon ne peut s’échapé de la régions $r < R_s$.\
le rayon $R_s$ forme ainsi une frontière appelée #text(style: "italic")[horizon des évènements], et ainsi un photon émis en $r < R_s$ n’a aucune chance d’atteinder un observateur, l’objet nous apprait alors noir.\
Un tel objet est appelée #text(style: "italic")[trou noir]

==== Coordonnées d’Eddington–Finkelstein Retardé <CEFR>

On cherche maintenant à fournir une meilleur déscription pour les rayon sortant.\
\
Pour celà, on peut remarquer que @rayentr et @raysort sont identique au signe près, alors les calcules seront identique, moyénnant un
signe moins en facteur.
On en déduis une nouvelle coordonnée, de la même manière que dans @CEFA, i.e. en prenant la constante d’intégration :
$
  q = t - r - R_s lna(r/R_s - 1)
$
la métrique devient ainsi :
$
  ds^2 = (1 - R_s/r) dif q^2 + 2 dif q dif r - r^2 (dif theta^2 + sin(theta) dif phi^2)
$
De même, on a bien résolut la singularité en $r = R_s$\
Comme pour @CEFA, il est plus pratique de travailler avec la variable temporelle suivante:
$
  t' = q + r = t - R_s lna(r/R_s - 1)
$
les coordonnée $(t', r, theta, phi)$ sont elle appelées coordonnée d’Eddington–Finkelstein retardé.\
Si on s’intérèsse au géodésique, on obtient les équations suivantes :
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
  caption: [diagramme $(t',r)$, avec les cônes de lumière,\ avec en rouge les photons entrant, et en bleu les photons sortant],
)

#set heading(numbering: none)

= Conclusions

Les conclusions sont le symétrique de l'Introducion: on résume ici le
chemin effectue, les résultats marquants et les éventuels
développements futurs que ces résultats vont permettre.

#pagebreak()

#bibliography("biblio.bib", title: [Bibliographie])

Le travail scientifique n'existe pas dans le vide et s'appuie toujours
sur des connaissances préexistantes. On liste ici les textes (livres,
articles, conférences) auxquels on a fait référence dans le texte.

#pagebreak()

= Annexe

Les annexes (une ou plusieurs) servent à indiquer des détails qui
sont importants pour reproduire le travail mais qui alourdiraient trop
le texte principal.
