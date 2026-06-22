#import "../../../template.typ": *
#import "../../../transposition.typ": *
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot
#import "@preview/zebraw:0.6.3": *
#import "@preview/mitex:0.2.7": *
#show: zebraw

#show: template

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

#set page(number-align: right, numbering: (it, ..) => {
  if it != 1 { if it != 2 { text[#na(it) / #na(counter(page).final().first())] } }
})

#set par(leading: 0.55em, spacing: 0.55em, justify: true)
#set text(font: "Linux Libertine", historical-ligatures: true)
#show raw: set text(font: "Linux Libertine")
#show heading: set block(above: 1.4em, below: 1em)
#set document(title: text(20pt)[Théorie classique (et quantique ?)\ des champs])
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
    let nr = na(counter(page).at(loc).at(0))
    if (chapter.level < 4 and (num != none and type(num) != int)) {
      [
        #if counter(heading).at(loc).len() <= 1 and counter(heading).at(loc).first() == 1 {
          align(center)[\ *Chapitre I : Théorie classique\ des champs* \ \ ]
        }
        #if counter(heading).at(loc).len() <= 1 and counter(heading).at(loc).first() == 5 {
          align(center)[\ *Chapitre II : Théorie quantique\ des champs* \ \ ]
        }
        #h(1cm * chapter.level) #link(loc)[#num #chapter.body] #box(width: 1fr, repeat[.]) #nr #v(
          2.5mm,
        )
      ]
    } else if (chapter.level < 2 and num == none) {
      [#h(1cm * chapter.level) #link(loc)[#num #chapter.body] #box(width: 1fr, repeat[.]) #nr #v(2.5mm) ]
    }
  }
}

#pagebreak()

#show heading.where(body: [Introduction]): set heading(numbering: none)
= Introduction

Cette ouvrage à été écrit comme suivie d’un stage portant initialement sur la théorie classique des champs. Ce stage à été en grande partie basé sur l’ouvrge #text(style: "italic")[Quantum Field Theory] par le Dr. David Tong @Tong pour la partie classique et sur #text(style: "italic")[An Introduction to Quantum Field Theory] de M.E. Peskin & D. V. Schroeder @Peskin, nous nous somme également appuyer sur l’œuvre #text(style: "italic")[Quantum Field Theory and the Standard Model] de M. D. Schwartz @Schwartz et sur des notes de notre maître de satge. il n’est donc pas étonnant de croisé par endroit une structure similaire au deux ouvrages de référence, voir une paraphrase de leur œuvres (que l’on pourrait parfois qualifier de plagia…). Cependant, comme le but de notre stage étant de nous familiariser et d’apprendre la théorie classique des champs, alors vous trouverez ici quasiment toute les démonstration & définition de chaque objet présenté, exépté les objets, normalement, commun et ceux dont la démonstration ou la définition rigoureuse nous étais hors de notre porté.

#pagebreak()


= Convention

On liste ici l’ensembe des conventions utilisé de manière plus ou moins implicite dans le reste de l’œuvre. On représenteras cette ensemble de convention sous forme d’un tableau, en donnant la raison de ce choix quand celle-ci peut être ultile.

#align(
  center + horizon,
  figure(
    table(
      columns: 2,
      inset: 5mm,
      table.header([convention], [raison]),
      $eta^(mu nu) = mat(+, -, -, -)$, [C’est la convention la plus courante\ contrairement à $mat(-, +, +, +)$],
      $T_mu F^mu = sum_mu T_mu F^mu$,
      [La convention de somation d’Einstein\ ($mu$ dépend du contexte et peut être mal définis)],

      $(partial f)/(partial x_mu) = partial^mu f$,
      [Cette notation permet de condensé les expression\ sans perte d’information.\ De plus, elle se comporte comme il faut vis à vis\ de la convention d’Einstein, la rendants pratique],

      $partial^0 f = dot(f)$, [On utiliseras la notation de Newton, uniquement\ pour les dérivées au temps],
    ),
    caption: [Ensemble des conventions utilisé],
  ),
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

= Théorie lagrangienne des champs <lagrchamps>

Dans un permier tant, il nous faut réécrire la mécanique lagrangienne, non plus pour des variables réél ou complexe, mais pour des champs, qui serons scalaire @spin0, spinorielle @spin12 ou vectorielle @spin1, c’est ce qu’il seras faits dans cette partie, on nous réécrirons les équations d’Euler-Lagrange et le théorème de Noether pour un nouveau genre de lagrangien.\

== Équation d’Euler-Lagrange <1.1>

*Définition :*\
On définis un nouveau genre de lagrangien $cal(L) (phi.alt, partial_mu phi.alt)$ sur les champs, que l’on nome : densité lagrangienne, par :
$
  S = integral upright(L) dt = integral integral cal(L) dx^3 dt = integral cal(L) dx^4
$
On l’appelle par abus de language seulement lagrangien, au lieux de #text(style: "italic")[densité] lagrangienne
\
\
*Équation d’Euler-Lagrange :*\
Le théorème d’Euler-Lagrange reste vrais pour ce nouveau lagrangien, en effet :\
Soit $phi.alt_a$ un champs, labélisé par $a$, tel que $delta phi.alt (arrow(x), t_1) = delta phi.alt (arrow(x), t_1) = 0$, alors sont lagrangien respecte l’équation suivante :
$
  forall a, partial_mu ( (partial lagr) / (partial(partial_mu phi.alt_a))) - (partial lagr) / (partial phi.alt_a) = 0
$<equlagr>

*Preuve :*\
Par le principe de moindre action, l’on cherche $delta S = 0$, or :
$
  delta lagr &= (partial lagr)/(partial phi.alt_a) delta phi.alt_a + (partial lagr)/(partial(partial_mu phi.alt_a)) delta (partial_mu phi.alt_a)\
  &= (partial lagr)/(partial phi.alt_a) delta phi.alt_a + partial_mu ((partial lagr)/(partial(partial_mu phi.alt_a)) delta phi.alt_a) - partial_mu ((partial lagr)/(partial(partial_mu phi.alt_a))) delta phi.alt_a\
  &= ((partial lagr)/(partial phi.alt_a) - partial_mu ( (partial lagr)/(partial(partial_mu phi.alt_a)))) delta phi.alt_a + partial_mu ((partial lagr)/(partial(partial_mu phi.alt_a)) delta phi.alt_a)
$
Ainsi, la variation d’action s’écrit :
$
  delta S = integral dx^4 ((partial lagr)/(partial phi.alt_a) - partial_mu ( (partial lagr)/(partial(partial_mu phi.alt_a)))) delta phi.alt_a + integral dx^4 partial_mu ((partial lagr)/(partial(partial_mu phi.alt_a)) delta phi.alt_a)
$
Comme $phi.alt_a$ respecte le faits que $delta phi.alt_a (arrow(x), t_1) = delta phi.alt_a (arrow(x), t_2) = 0$, et que $partial_mu ((partial lagr)/(partial(partial_mu phi.alt_a)) delta phi.alt_a)$ est la dérivé totale, alors sont intégrale est null, donc :
$
  delta S = integral dx^4 ((partial lagr)/(partial phi.alt_a) - partial_mu ( (partial lagr)/(partial(partial_mu phi.alt_a)))) delta phi.alt_a
$
et par le principe de moindre action $delta S = 0$, par conséquant :
$
  (partial lagr)/(partial phi.alt_a) - partial_mu ( (partial lagr)/(partial(partial_mu phi.alt_a))) = 0
$
#QED

=== Exemple 1 : Équations de Maxwel
On propose dans cette exemple de retrouvé les équations de Maxwel dans le vide.\
Pour celà, on considére le lagrangien suivant, où $A^mu$ représente le potentielle vecteur de l’éléctromagnétisme :
$
  lagr = - 1/2 (partial_mu A_nu) (partial^mu A^nu) + 1/2 (partial_mu A^mu)^2
$

Alors :
$
  (partial lagr)/(partial (partial_mu A_nu)) &= -1/2 (underbrace((partial(partial_rho A_sigma))/(partial(partial_mu A_nu)), = delta_(rho)^mu delta_(sigma)^nu) partial^(rho) A^(sigma) + eta^(rho alpha) eta^(sigma beta) underbrace((partial(partial_alpha A_beta))/(partial(partial_mu A_nu)), = delta_(alpha)^mu delta_(beta)^nu) partial_(rho) A_(sigma)) + 1/2 (eta^(rho sigma))^2 underbrace((partial (partial_rho A_sigma )^2)/(partial(partial_mu A_nu)), = 2 delta^mu_rho delta^nu_sigma partial_rho A_sigma)\
  & = - partial^mu A^nu + (partial_rho A^rho) eta^(mu nu)
$
Donc
$
  partial_mu ((partial lagr)/(partial (partial_mu A_nu))) &= partial_mu (- partial^mu A^nu + (partial_rho A^rho) eta^(mu nu))\
  &= -partial^2 A^nu + partial^nu partial_mu A^mu\
  &= - partial_mu (underbrace(partial^mu A^nu - partial^nu A^mu, = F^(mu nu)))\
  &= -partial_mu F^(mu nu)
$
Et
$
  (partial lagr)/(partial A_mu) = 0
$
Donc d’après les équations d’Euler-Lagrange, on trouve :
$
  partial_mu F^(mu nu) = 0
$
On montreras que cette équation perment de retrouver les équations de Maxwel (@maxweleq). On peut également réécrire le lagrangien sous une forme plus compacte à l’aide du tenseur $F^(mu nu)$.
$
  lagr &= -1/4 F_(mu nu) F^(mu nu)\
  &= -1/4 (partial_mu A_nu - partial_nu A_mu)(partial^mu A^nu - partial^nu A^mu)\
  &= -1/4 (partial_mu A_nu partial^mu A^nu - partial_mu A_nu partial^nu A^mu - partial_nu A_mu partial^mu A^nu + partial_nu A_mu partial^nu A^mu )\
  &= -1/4 (2 partial_mu A_nu partial^mu A^nu - 2 partial_mu A_nu partial^nu A^mu)\
  &= -1/2 ( partial_mu A_nu partial^mu A^nu - eta^(mu rho) partial_mu A_nu partial^nu A_rho)\
  &= -1/2 ( partial_mu A_nu partial^mu A^nu - partial^rho A_nu partial^nu A_rho)\
  &= -1/2 partial_mu A_nu partial^mu A^nu + 1/2 (partial^nu A_nu)^2\
$
#QED

== Invariance de Lorentz
L’une des première motivation du dévelopement de la théorie des champs, à été de
réconcillier la mécanique quantique avec la relativité, ainsi, nous cherchons à
construire une théorie qui reste invariante sous les transformations de lorentz
$
  x^mu --> (x^mu)' = Lambda^mu""_nu x^nu
$
où $Lambda^mu""_nu$ satisfait :
$
  eta^(mu nu) = Lambda^mu""_rho Lambda^nu_sigma eta^(rho sigma)
$
Ici $Lambda$ est la matrice de transformations entre deux référentielles,\
\
\
#align(center, grid(
  column-gutter: 3cm,
  row-gutter: 0.5cm,
  columns: 2,
  $Lambda^nu""_mu = mat(1, 0, 0, 0; 0, cos(theta), sin(theta), 0; 0, -sin(theta), cos(theta), 0; 0, 0, 0, 1)$,
  $Lambda^nu""_mu = mat(gamma, -gamma v, 0, 0; -gamma v, gamma, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1)$,

  [Rotation de $theta$, autour de $x^3$], [Boost de Lorentz le long de $x^1$\ où $gamma = sqrt(1 - v^2)$],
))

Ainsi, l’on veut que le champs scalaire soit invariant sous ces transformation, i.e. que si $phi.alt(x)$ est solution
des équations du mouvement, alors $phi.alt'(x) = phi.alt(Lambda^(-1)x)$ le soit aussi. On chercheras en réalité à ce que tout les champs que l’on décriras ici le soit également. Car d’après le principe de relativité, si nos champs ne sont pas invariant par ces transformation, alors il ne décrive rien de physique (ou du moins une approximation).\
On remarquera que l’exposant $-1$, sur $Lambda$ dans le champs, est du au faits que l’on considère une transformation active.

== Symétrie

=== Théorème de Noether

*Théorème de Noether :*\
Si le lagrangien possède une symétrie continue dépendante d’un paramètre $alpha$, alors
il existe un courant $J^mu = display(sum_a (partial lagr)/(partial (partial_mu phi.alt_a)) (delta phi.alt_a)/(delta alpha)) - F^mu$,
appelé courant de Noether, associé à la symétrie, qui est conservé,\
i.e. $partial_mu J^mu = 0$\
\
*Preuve :*\
Quand le lagrangien est invariant sous une certaine variation du type $phi.alt -> phi.alt + delta phi.alt$,
alors cette transformation est appelée #text(style: "italic")[symétrie].\
Alors notre lagrangien peut se réécrire :
$
  delta lagr &= sum_a { (partial lagr)/(partial phi.alt_a) delta phi.alt_a + (partial lagr)/(partial (partial_mu phi.alt_a))delta(partial_mu phi.alt_a)}\
  &= sum_a { (partial lagr)/(partial phi.alt_a) delta phi.alt_a + partial_mu ((partial lagr)/(partial (partial_mu phi.alt_a))delta phi.alt_a) - partial_mu ((partial lagr) / (partial(partial_mu phi.alt_a)))delta phi.alt_a}\
  &= sum_a {[(partial lagr)/(partial phi.alt_a) - partial_mu ((partial lagr)/(partial (partial_mu phi.alt_a)))] delta phi.alt_a + partial_mu ((partial lagr)/(partial (partial_mu phi.alt_a)) delta phi.alt_a)}
$
Or quand les équations du mouvement sont satisfaite, alors le terme entre croché disparait, on se retrouve donc avec :
$
  delta lagr = sum_a partial_mu ((partial lagr)/(partial (partial_mu phi.alt_a))delta phi.alt_a)
$
Or dans le cas d’un symétrie, la variation du lagrangien suivant le paramètre est la dérivé totale d’un scalaire :
$
  (delta lagr)/(delta alpha) = partial_mu F^mu
$
Ainsi :
$
  partial_mu (sum_a (partial lagr)/(partial (partial_mu phi.alt_a)) (delta phi.alt_a)/(delta alpha) - F^mu)
$
Ainsi, on peut définir le courant par :
$
  J^mu = sum_a (partial lagr)/(partial (partial_mu phi.alt_a)) (delta phi.alt_a)/(delta alpha) - F^mu
$
On se retrouve donc avec :
$
  partial_mu J^mu = 0
$
On a donc bien que le courant de Noether est conservé
#QED

==== Exemple 1: Tenseur Energie-Impulsion <TenseurEP>
Si l’on considère une symétrie de translation par un quadri-vecteur $xi$ constant et très petit, soit $x^nu -> x^nu + xi^nu$, alors le champs peut se réécrire :
$
  phi.alt(x + xi) = phi.alt(x) + xi^nu partial_nu phi.alt(x) + o (xi)
$
alors la lois de transformation est :
$
  (delta phi.alt)/(delta xi^nu) = partial_nu phi.alt(x)
$
Il en va de même pour le lagrangien, en effet :
$
  lagr(x + xi) = lagr(x) + xi^nu partial_nu lagr(x)
$
donc
$
  (delta lagr)/(delta xi^nu) = partial_nu lagr(x)
$
On a, alors notre courant de Noether pour chaque $nu = 0, 1, 2, 3$ :
$
  (J^mu)_nu = (partial lagr)/(partial (partial_mu phi.alt)) partial_nu phi.alt - delta^mu""_nu lagr
$
On définis alors un nouveau tenseur, le tenseur energie-impulsion par :
$
  T^mu""_nu = (J^mu)_nu = (partial lagr)/(partial (partial_mu phi.alt)) partial_nu phi.alt - delta^mu""_nu lagr
$
qui vérifie, par le théorème de Noether, la propriété suivante :
$
  partial_mu T^mu""_nu = 0
$

Ce tenseur encode deux grandeur importante :
- L’énergie :
$
  cal(E) = T^0""_0 = (partial lagr)/(partial dot(phi.alt)) dot(phi.alt) - lagr
$
On reconnais l’éxprésion de l’énergie en mécanique lagrangienne classique, avec :
$
  E = integral dx^3 T^0""_0 = integral dx^3 cal(E)
$

- Impulsion :
$
  cal(P)^i = T^i""_0
$
avec ici aussi
$
  P^i = integral dx^3 cal(P)^i
$<impulsion>

= Particules de spin null <spin0>

Le but de ce chapitre est de décrire le comprotement d’une particule de spin null, pour celà on va considéré tout du long un champs scalaire noté $phi.alt$, qui seras dans un premier tant réél. Mais l’on verra que pour décrire le couplage entre une telle particule et le photon (l’éléctromagnétisme) on sera obligé de passé par un champs scalaire complexe.

== Équation de Klein-Gordon

Considérons, tout d’abord un champs scalaire réél $phi.alt$, décrit par le lagrangien suivant :
$
  lagr & = 1/2 eta^(mu nu) partial_mu phi.alt partial_nu phi.alt - m^2 phi.alt^2 \
       & = 1/2 partial_mu phi.alt partial^mu phi.alt - m^2 phi.alt^2
$
où $m$ est un coefficient de couplage, physiquement il représenete la masse, et où on à définis $eta^(mu nu) partial_nu = partial^mu$

Regardons comment se comporte le lagrangien sous les transformations de Lorentz :
$
  phi.alt(x) --> phi.alt'(x) = phi.alt(Lambda^(-1)x)
$
alors :
$
  partial_mu phi.alt(x) --> (Lambda^(-1))^nu""_mu partial_nu phi.alt(y)
$
où $y = Lambda^(-1) x$, ainsi, le lagrangien deviens sous cette transformation :
$
  lagr'(x) & = 1/2 partial_mu phi.alt'(x) partial_nu phi.alt'(x) eta^(mu nu) - m^2 phi.alt'^2 \
  & = (Lambda^(-1 ))^sigma_mu partial_sigma phi.alt(y) times (Lambda^(-1))^rho_nu partial_rho phi.alt(y) eta^(mu nu) - m^2 phi.alt(y)^2\
  & = partial_sigma phi.alt(y) partial_rho phi.alt(y) underbrace((Lambda^(-1))^sigma""_mu (Lambda^(-1))^rho""_nu eta^(mu nu), = eta^(sigma rho)) - m^2 phi.alt(y)^2 \
  &= partial_sigma phi.alt(y) partial_rho phi.alt(y) eta^(sigma rho) - m^2 phi.alt(y)^2 = lagr(y)
$
On a par conséquant que l’action est invariante sous cette transformation :
$
  S' = integral dif y^4 lagr'(y) = integral dif y^4 lagr(x) = integral dx^4 lagr(x) = S
$
On pourra noté que l’on à omis le terme jacobien sur le changement de $dif y -> dx$, car
ici on à que $det(Lambda) = 1$\
\
On peut alors calculer à l’aide de l’équation d’Euler-Lagrange, l’équation du mouvement pour une telle particules.\
Donc nous avons d’une part :
$
  partial_mu ((partial lagr)/(partial(partial_mu phi.alt))) &= partial_mu (1/2 eta^(sigma nu)( underbrace((partial(partial_sigma phi.alt)) / (partial (partial_mu phi.alt)), = delta_(sigma)^mu) partial_nu phi.alt + underbrace((partial(partial_nu phi.alt)) / (partial(partial_mu phi.alt)), = delta_(nu)^mu) partial_sigma phi.alt))\
  &= partial_mu (1/2(underbrace(eta^(sigma nu) delta_sigma^(mu), = eta^(mu nu)) partial_nu phi.alt + underbrace(eta^(sigma nu) delta_nu^(mu), = eta^(sigma mu) = eta^(mu sigma)) partial_sigma phi.alt))\
  &= partial_mu (1/2 times 2 underbrace(eta^(mu nu) partial_nu phi.alt, = partial^mu phi.alt))\
  &= partial_mu partial^mu phi.alt
$
Et d’autre part :
$
  (partial lagr)/(partial phi.alt) = - m^2 phi.alt
$
Donc d’après l’équation d’Euler-Lagrange (@equlagr) :
$
  partial_mu partial^mu phi.alt + m^2 phi.alt = 0
$<eqmouvementkleinGordon>
Cette équation est connue sous le nom d’équation de Klein-Gordon, elle permet de décrire l’évolution d’un champs scalaire massique. Un telle champs peut être assimilé à une particule de spin 0, comme le bosons de Higgs.

== Courant de Noether

Si l’on considère maintenant le champs scalaire complexe $phi.alt$, avec le lagrangien suivant, analogue à celui étudier précédemment :
$
  lagr = |partial^mu phi.alt|^2 - m^2 |phi.alt|^2
$
Comme il y a deux degrée de libérté dans un champs complexe : $phi.alt et phi.alt^star$, alors le lagrangien se réécrit :
$
  lagr = partial^mu phi.alt partial_mu phi.alt^star - m^2 phi.alt phi.alt^star
$
On peut remarquer que ce lagrangien est maintenant invariant également sous la transformation : $phi.alt -> e^(-i alpha) phi.alt$, avec $alpha in RR$, que l’on décriras plus en détail dans le sous-chapitre suivant (@scalaireele).\
Cette transformation est donc une symétrie du lagrangien, ainsi, nous avons :
$
  (delta phi.alt)/(delta alpha) = -i phi.alt " " et " " (delta phi.alt^star)/(delta alpha) = i phi.alt^star
$
De plus le lagrangien est inchangé, donc :
$
  (delta lagr)/(delta alpha) = 0
$
donc $F^mu = "const"$, on peut choisir $F^mu = 0$ sans perte de généralité\
On trouve alors :
$
  J^mu &= -i phi.alt (partial lagr)/(partial(partial_mu phi.alt)) + i phi.alt^star (partial lagr)/(partial (partial_mu phi.alt^star))\
  &= -i (phi.alt partial^mu phi.alt^star - phi.alt^star partial^mu phi.alt)
$ <courantKleinGordon>
Et donc d’après le théorème de Noether, l’on a :
$
  partial_mu J^mu = -i( phi.alt partial_mu partial^mu phi.alt^star - phi.alt^star partial_mu partial^mu phi.alt) = 0
$
Ce qui peut également ce vérifier par l’équation de mouvement trouvé précédemment (@eqmouvementkleinGordon). \
En effet, nous avions trouvés que les équations de mouvement s’écrivait :
$
  partial_mu partial^mu phi.alt = - m^2 phi.alt
$
Donc @courantKleinGordon se réduit à :
$
  J^mu = i m^2 ( cancel(phi.alt phi.alt^star) - cancel(phi.alt^star phi.alt)) = 0
$


== Couplage avec l’éléctromagnétisme <scalaireele>

On va tout d’abord montrer que le lagrangien $lagr = partial_mu phi.alt partial^mu phi.alt^star - m^2 phi.alt phi.alt^star$ est invariant sous le groupe $upright(U)(1)$ tant que cette symétrie est globale. ensuite quand on va passer sur une symétrie local, notre lagrangien ne seras plus invariant, on va donc chercher à le rendre de nouveaux invariant mais par cette symétrie $upright(U) (1)$ local

=== Préliminaire sur le groupe $upright(U)(1)$

On à que dans notre cas $upright(U) (1)$ est isomorphe, et coïncide donc avec le groupe $(UU, dot.c)$, le cercle complexe unité munis de la multiplication, i.e. $UU = {|z| = 1, z in CC} = {e^(i alpha), alpha in RR}$. On va donc montrer ici, que $(UU, dot.c)$, et donc $upright(U) (1)$ est bien un groupe.\
Pour celà, on à la définition de groupe suivante :\
\
Soit un ensemble $G$ et $dot.c$ une lois de compositions interne, alors $(G, dot.c)$ est un groupe, si et seulement si :\
\

#set enum(indent: 1cm, spacing: 4mm)
+ $exists e in G, forall z in G, e z = z e = z$
+ $forall z in G, exists u in G, z u = u z = e$
+ $forall x, y, z in G, (x y) z = x (y z)$
\
Regardons ce qu’il en est pour notre groupe,\
soit $z in UU$, alors :\

- $1$ est bien un élément neutre, en effet
$
  |1| = 1 donc 1 in UU
$
et
$
  1 dot.c z = z = z dot.c 1
$

- $z^star$ est bien l’inverse de $z$, en effet :
$
  |z^star| = |z|^star = 1^star = 1 donc z^star in UU
$
et
$
  z z^star = z^star z = |z|^2 = 1
$

- Enfin pour $u, v in UU$, on a bien l’assosiativité :
$
  (z u) v = z u v = z (u v)
$
Donc $UU$ est bien un groupe, et donc $upright(U) (1)$ aussi\

=== Symétrie globale

À partir de maintenant on travailleras avec $upright(U) (1) = {e^(i q alpha), alpha, q in RR}$ comme définition de $upright(U) (1)$ globale\
On peut alors montré que notre lagrangien est invariant par les éléments de ce groupe, autrement dit on procède à la transformation suivante :
$
  forall alpha in RR, phi.alt -> phi.alt' = e^(i q alpha) phi.alt
$
donc pour $alpha in RR$,
$
  lagr' & = partial_mu phi.alt' partial^mu phi.alt'^star - m phi.alt' phi.alt'^star \
  & = e^(i q alpha) e^(- i q alpha) partial_mu phi.alt partial^mu phi.alt^star - m e^(i q alpha) e^(- i q alpha) phi.alt phi.alt^star\
  & = partial_mu phi.alt partial^mu phi.alt^star - m phi.alt phi.alt^star = lagr\
$
Donc notre lagrangien est bien invariant par la symétrie globale induit par $upright(U) (1)$

Nous avons déjà montrée (@courantKleinGordon) que sous cette symétrie, le courant de Noether induit était :
$
  J^mu = - i q ( phi.alt partial^mu phi.alt^star - phi.alt^star partial^mu phi.alt)
$

=== Symétrie local

On va maintenant chercher à rendre la symétrie par $upright(U) (1)$ local, pour celà, on va faire d’épendre notre paramètre $alpha$ de la potition, i.e. :
$
  alpha in RR --> alpha in CC^(RR^4)
$
autrement dit, $alpha$ deviens une fonction de la potition.\
Ainsi la transformation devient :
$
  forall x in RR^4, phi.alt --> phi.alt' = e^(i q alpha(x)) phi.alt
$
malheuresement la dérivé ne se comporte plus comme il faudrais :
$
  partial_mu phi.alt' &= partial_mu (e^(i q alpha) phi.alt) = partial_mu (e^(i q alpha)) phi.alt + e^(i q alpha) partial_mu phi.alt\
  &= i q (partial_mu alpha) e^(i q alpha) phi.alt + e^(i q alpha) partial_mu phi.alt
$
A cause de cecis notre lagrangien n’est plus invariant, en effet :
$
  lagr' &= partial_mu phi.alt' partial^mu phi.alt'^star - m phi.alt' phi.alt'^star\
  &= (i q (partial_mu alpha) e^(i q alpha) phi.alt + e^(i q alpha) partial_mu phi.alt) ( - i q (partial^mu alpha) e^( - i q alpha) phi.alt^star + e^( -i q alpha) partial^mu phi.alt^star) - m phi.alt phi.alt^star\
  &= q^2 partial_mu alpha partial^mu alpha phi.alt phi.alt^star + underbrace(partial_mu phi.alt partial^mu phi.alt^star - m phi.alt phi.alt^star, lagr)\
  &= lagr + q^2 partial_mu alpha partial^mu alpha phi.alt phi.alt^star
$

Pour rétablire la symétrie, on va devoir introduire une nouvelle dérivé, appelé #text(style: "italic")[dérivé covariante], que l’on définis par :
$
  D_mu = partial_mu - i q A_mu
$
tel que :
$
  D_mu phi.alt --> (D_mu phi.alt)' = e^(i q alpha) D_mu phi.alt
$
Où $A_mu$ est le potentielle vecteur de l’éléctromagnétisme, qui ici, encode donc le photon. Typiquement les équations de Maxwel, que l’on redémonteras dans le @spin1, sont invariante par la transformation de jauge $A_mu -> A_mu - partial_mu chi$ où $chi$ est une fonction arbitraire. Dans ce cadre on est capable de trouvé une relation entre $chi$ et $alpha$.\
*Propriété :*
$
  chi = - alpha + C
$
où $c$ est une constante\
\
*Preuve :*\
Ici on se place dans le cas des transformation suivante :
$
  phi.alt' = e^(i q alpha) phi.alt
  D_mu phi.alt --> (D_mu phi.alt)' = e^(i q alpha) D_mu phi.alt\
  A_mu --> A'_mu = A_mu - partial_mu chi
$
L’idée de la preuve est d’écrire $(D_mu phi.alt)'$ de deux mainère, pour ensuite égalisé les deux expression trouvé, ainsi on a d’une part :
$
  (D_mu phi.alt)' & = e^(i q alpha) D_mu phi.alt \
                  & = e^(i q alpha) (partial_mu phi.alt - i q A_mu phi.alt)
$
Et d’autre part :
$
  (D_mu phi.alt)' & = D'_mu phi.alt' = partial_mu phi.alt' - i q A'_mu phi.alt' \
  & = i q (partial_mu alpha) e^(i q alpha) phi.alt + e^(i q alpha) partial_mu phi.alt - i q e^(i q alpha) A_mu phi.alt + i q e^(i q alpha) partial_mu chi phi.alt\
  &= e^(i q alpha) (i q (partial_mu alpha) phi.alt + partial_mu phi.alt - i q A_mu phi.alt + i q partial_mu chi phi.alt)
$
On trouve donc
$
  cancel(partial_mu phi.alt) - cancel(i q A_mu phi.alt) = i q (partial_mu alpha) phi.alt + cancel(partial_mu phi.alt) - cancel(i q A_mu phi.alt) + i q partial_mu chi phi.alt
$
Donc
$
  partial_mu chi = - partial_mu alpha
$
ainsi on retrouve bien
$
  chi = - alpha + c
$
#QED

=== Équation du mouvement avec symétrie local

On peut alors, regarder ce que deviens notre lagrangien avec cette nouvelle dérivé, et s’assurer que celui-ci est bien invariant par $upright(U)(1)$ local.\
Donc notre lagrangien devient :
$
  lagr &= D_mu phi.alt D^mu phi.alt^star - m^2 phi.alt phi.alt^star\
  &= (partial_mu - i q A_mu) phi.alt (partial^mu - i q A^mu) phi.alt^star - m^2 phi.alt phi.alt^star\
  &= partial_mu phi.alt partial^mu phi.alt^star - i q partial_mu phi.alt A^mu phi.alt^star - i q A_mu phi.alt partial^mu phi.alt^star - q^2 A_mu A^mu phi.alt phi.alt^star - m^2 phi.alt phi.alt^star\
  &= partial_mu phi.alt partial^mu phi.alt^star - i q (phi.alt A_mu partial^mu phi.alt^star + phi.alt^star A_mu partial^mu phi.alt) - phi.alt phi.alt^star (q^2 A^mu A_mu + m^2)
$
Il est facile, à l’aide de la toute première forme du lagrangien, de montré que celui-ci est invariant par le groupe $upright(U)(1)$ local.\
Enfin on va pouvoir en déduire $3$ équation du mouvement pour $phi.alt$, $phi.alt^star$ et $A_mu$\
\
+ Pour $phi.alt$ :
On a d’une part :
$
  partial_mu ((partial lagr)/(partial (partial_mu phi.alt))) = partial_mu (partial^mu phi.alt^star - i q phi.alt^star A^mu) = square phi.alt^star - i q partial_mu phi.alt^star A^mu
$
Et d’autre part :
$
  (partial lagr)/(partial phi.alt) = - i q A_mu partial^mu phi.alt^star - phi.alt^star (q^2 A^mu A_mu + m^2)
$
Donc d’après les équations d’Euler-Lagrange :
$
  square phi.alt^star + i q (A_mu partial^mu phi.alt^star - partial^mu phi.alt^star A_mu) + phi.alt^star (q^2 A^mu A mu + m^2) = 0
$\
\

#h(1cm) 2.~~ Pour $phi.alt^star$ :
On a d’une part :
$
  partial_mu ((partial lagr)/(partial (partial_mu phi.alt^star))) = partial_mu (partial^mu phi.alt - i q phi.alt A^mu) = square phi.alt - i q partial_mu phi.alt A^mu
$
Et d’autre part :
$
  (partial lagr)/(partial phi.alt^star) = - i q A^mu partial_mu phi.alt - phi.alt (q^2 A^mu A_mu + m^2)
$
Donc d’après les équations d’Euler-Lagrange :
$
  square phi.alt + i q (A^mu partial_mu phi.alt - partial_mu phi.alt A^mu) + phi.alt (q^2 A^mu A mu + m^2) = 0
$

#h(1cm) 3.~~ Pour $A_mu$ :
On a d’une part :
$
  partial_mu ((partial lagr)/(partial (partial_mu A_nu))) = 0
$
Et d’autre part :
$
  (partial lagr)/(partial A_mu) &= - i q (phi.alt partial^mu phi.alt^star + phi.alt^star partial^mu phi.alt) - q^2 phi.alt phi.alt^star (partial (A^nu A_nu))/(partial A_mu)\
  &= - i q (phi.alt partial^mu phi.alt^star + phi.alt^star partial^mu phi.alt) - q^2 phi.alt phi.alt^star (A^mu + A^mu)\
  &= - i q (phi.alt partial^mu phi.alt^star + phi.alt^star partial^mu phi.alt) - 2 q^2 phi.alt phi.alt^star A^mu\
$
Donc d’après les équations d’Euler-Lagrange :
$
  i q (phi.alt partial^mu phi.alt^star + phi.alt^star partial^mu phi.alt) + 2 q^2 phi.alt phi.alt^star A^mu = 0
$

On peut alors résumé les 3 équation dans le tableau suivant :
#align(
  center + horizon,
  figure(
    grid(
      columns: 1,
      row-gutter: 5mm,
      $
        square phi.alt + i q (A^mu partial_mu phi.alt - partial_mu phi.alt A^mu) + phi.alt (q^2 A^mu A mu + m^2) = 0
      $,
      $
        square phi.alt^star + i q (A_mu partial^mu phi.alt^star - partial^mu phi.alt^star A_mu) + phi.alt^star (q^2 A^mu A mu + m^2) = 0
      $,
      $
        i q (phi.alt partial^mu phi.alt^star + phi.alt^star partial^mu phi.alt) + 2 q^2 phi.alt phi.alt^star A^mu = 0
      $,
    ),
    caption: [équations du mouvement pour un champs scalaire\ couplé avec l’éléctromagnétisme],
  ),
)

= Particules de spin $1 \/2$ <spin12>

Dans le paragraphe précédent, on a dévelopé la théorie pour des champs scalaires, ce qui nous à permis de décrire les particules de spin 0, on propose dans ce chapitre le dévelopement pour des particules de spine demi-entier.\
Pour celà, on va devoire introduire un nouveaux genre d’objet : les spineurs

== Spineurs

Pour l’instant, nous avons traité seulement des champs scalaire, mais la plupart des praticules on plusieur degrées de libérté interne. Ce qui nous oblige à considéré des champs qui ne se transforme pas trivialement dans le groupe de Lorentz, ainsi pour décrire des particules de spin $1/2$, nous devons explicité et étudier une représentation du groupe de Lorentz.\
De manière générale, les champs se transforme par :
$
  phi.alt^a (x) --> D[Lambda]^a""_b phi.alt^b (x)
$
où les matrices $D[Lambda]$ sont une représentation du groupe de Lorentz.\
Étant donnée que $D$ est une représentation, alors celui-ci est un morphisme, autrement dit, il respecte les propriété suivante :
$
  D[Lambda_1 Lambda_2] = D[Lambda_1] D[Lambda_2]
$
$
  D[Lambda^(-1)] = D[Lambda]^(-1)
$
$
  D[1] = 1
$
\

Pour trouver cette représentation, on peut regardé ce qu’il se passe pour des transformation de Lorentz infinitésimal et étudier l’algèbre de lie qui en résulte.
$
  Lambda^mu""_nu = delta^mu""_nu + omega^mu""_nu
$
où $omega$ est infinitésimal.\
En utilisant le faites que $Lambda^mu""_rho Lambda^nu""_sigma eta^(rho sigma) = eta^(mu nu)$, alors il vient :
$
  eta^(mu nu) & = (delta^mu""_rho + omega^mu""_rho) (delta^nu""_sigma + omega^nu""_sigma) eta^(rho sigma) \
              & = eta^(mu nu) + omega^(mu nu) + omega^(nu mu) + underbrace(omega^(mu nu) omega^(nu mu), = 0)
$
Ainsi, on a comme condition que $omega$ est anti-symétrique :
$
  omega^(mu nu) = - omega^(nu mu)
$
\
On pourra noter que les matrice $4 times 4$ on $(4 times (4 - 1)) /2 = 6$ composante, comme pour les transformé de Lorentz qui on 3 rotation & 3 boost soit 6 transformation au totale. On va donc pouvoir décrire les transformé de Lorentz par des matries $4 times 4$.\
Nous introduisons donc les matrices $(cal(M)^(rho sigma))^(mu nu)$ où $mu, nu in [|0; 3|]$ représente l’indice de la matrice  $rho, sigma in [|0; 3|]$ représente l’indice des axes sur les quels on faits notre transformation\
\
#align(
  center,
  math.equation(numbering: none)[$
    forall i in [|1, 3|], (cal(M)^(0 i))^(mu nu) --> "Boost de Lorentz sur l’axe" x^i\
    forall i,j in [|1, 3|], (cal(M)^(i j))^(mu nu) --> "Rotation dans le plan" (x^i, x^j)\
  $],
)
Or avec $rho$ & $sigma$ sans restriction on à $4 times 4 = #{ 4 * 4 }$ composante, c’est pourquoi, on impose à $cal(M)$ à être anti-symétrique sur $rho$ & $sigma$, i.e. $cal(M)^(rho sigma) = - cal(M)^(sigma rho)$, ainsi, il ne reste plus que $(4 times (4 - 1))/2 = #{ 4 * (4 - 1) / 2 }$ composante.\
On pose donc la base suivante :
$
  (cal(M)^(rho sigma))^(mu nu) = eta^(rho mu)eta^(sigma nu) - eta^(sigma mu) eta^(rho nu)
$
Attention, si l’on multiplie cette expression par la métrique, pour obtenir un des indice en bas, ce qui peut être utile dans certain calcul, on obtient :
$
  (cal(M)^(rho sigma))^(mu)""_nu = eta^(rho mu)delta^sigma""_nu - eta^(sigma mu)delta^rho""_nu
$
C’est matrice ne sont plus forcément anti-symétrique !\
\
Maintenant, nous pouvons donc écrire $omega$ dans cette base :
$
  omega^mu""_nu = 1/2 Omega_(rho sigma) (cal(M)^(rho sigma))^mu""_nu
$
où le coefficient $1/2$ est pour compensé le faits que l’on prenne des termes 2 fois, dû à l’anti-symétrie de $cal(M)$, et $Omega_(rho sigma)$ représente le ce que faits la transformation de Lorentz.\
De telle matrice $cal(M)^(rho sigma)$ sont appelées générateur des transformation de Lorentz, il vérifie la relation des algèbre de Lie de Lorentz :
$
  [cal(M)^(rho sigma); cal(M)^(tau nu)] = eta^(sigma tau) cal(M)^(rho nu) - eta^(rho tau) cal(M)^(sigma nu) + eta^(rho nu) cal(M)^(sigma tau) - eta^(sigma nu) cal(M)^(rho tau)
$
En ayant retiré les indices des matrices\
*Preuve :*\
Nous cherchons donc à réécrire :
$
  [cal(M)^(rho sigma); cal(M)^(tau nu)]^alpha""_beta = (cal(M)^(rho sigma))^alpha""_ateb (cal(M)^(tau nu))^ateb""_beta - (cal(M)^(tau nu))^alpha""_ateb (cal(M)^(rho sigma))^ateb""_beta
$
Pour celà, calculons d’abord seulement un des deux termes :
$
  (cal(M)^(rho sigma))^alpha""_ateb (cal(M)^(tau nu))^ateb""_beta &= (eta^(rho alpha) delta^sigma""_ateb - eta^(sigma alpha) delta^rho""_ateb)
  (eta^(tau ateb) delta^nu""_beta - eta^(nu ateb) delta^tau""_beta)\
  &= eta^(rho alpha) eta^(tau sigma) delta^nu""_beta - eta^(rho alpha) eta^(nu sigma) delta^tau""_beta\
  &""+ eta^(sigma alpha) eta^(nu rho) delta^(tau)""_beta - eta^(sigma alpha) eta^(tau rho) delta^(nu)""_beta
$
En fesant le même calcule pour $(cal(M)^(tau nu))^alpha""_ateb (cal(M)^(rho sigma))^ateb""_beta$ (ce qui reviens à permuté $rho <-> tau$ et $sigma <-> nu$), on obtient :
$
  (cal(M)^(tau nu))^alpha""_ateb (cal(M)^(rho sigma))^ateb""_beta &= eta^(tau alpha) eta^(rho nu) delta^sigma""_beta - eta^(tau alpha) eta^(nu sigma) delta^rho""_beta\
  &""+ eta^(nu alpha) eta^(sigma tau) delta^(rho)""_beta - eta^(nu alpha) eta^(rho tau) delta^(sigma)""_beta
$<commutateurM>
Ainsi en soustraisant (entre 10 et 13 ans maximum) les deux quantité, on obtient :
$
  [cal(M)^(rho sigma); cal(M)^(tau nu)]^alpha""_beta &= (cal(M)^(rho sigma))^alpha""_ateb (cal(M)^(tau nu))^ateb""_beta - (cal(M)^(tau nu))^alpha""_ateb (cal(M)^(rho sigma))^ateb""_beta\
  &= eta^(tau sigma) underbrace((eta^(rho alpha) delta^nu""_beta - eta^(nu alpha) delta^alpha""_beta), = (cal(M)^(rho nu))^alpha""_beta) - eta^(rho tau) underbrace((eta^(sigma alpha) delta^nu""_beta - eta^(nu alpha) delta^sigma""_beta), = (cal(M)^(sigma nu))^alpha""_beta)\
  &+ eta^(rho nu) underbrace((eta^(sigma alpha) delta^tau""_beta - eta^(tau alpha) delta^sigma""_beta), (cal(M)^(sigma tau))^alpha""_beta) - eta^(sigma nu) underbrace((eta^(rho alpha) delta^tau""_beta - eta^(tau alpha) delta^rho""_beta), (cal(M)^(rho tau))^alpha""_beta)\
  &= eta^(sigma tau) (cal(M)^(rho nu))^alpha""_beta - eta^(rho tau) (cal(M)^(sigma nu))^alpha""_beta + eta^(rho nu) (cal(M)^(sigma tau))^alpha""_beta - eta^(sigma nu) (cal(M)^(rho tau))^alpha""_beta
$
#QED

Enfin on peut récrire $Lambda$ sous forme exponantielle :
$
  Lambda &= underparen(1, = delta^(mu nu)\ "sans les indices"\ "matricielles") + omega = 1 + 1/2 Omega_(rho sigma) cal(M)^(rho sigma)\
  \
  \
  &= e^(1/2 Omega_(rho sigma) cal(M)^(rho sigma))
$

=== Algèbre de Clifford

Pour définir une représentation des spineurs, nous devons définir un algèbre de Clifford :
$
  {gamma^mu; gamma^nu} = gamma^mu gamma^nu + gamma^nu gamma^mu = 2 eta^(mu nu) upright(I)_4
$
où $gamma^mu$ sont des matrices et $upright(I)_n$ la matrices identité de dimension $4$.\
autrement dit $gamma^mu$ respecte ces propriété :
- pour $alpha != beta$
$
  gamma^alpha gamma^beta + gamma^beta gamma^alpha = 0\
  ==> gamma^alpha gamma^beta = - gamma^beta gamma^alpha
$
et
$
                         2 (gamma^0)^2 = 2 upright(I)_4 & ==> (gamma^0)^2 = upright(I)_4 \
  forall i in [|1; 3|], 2 (gamma^i)^2 = -2 upright(I)_4 & ==> (gamma^i)^2 = - upright(I)_4 \
$
Ces matrices sont nécessairement de dimension $4$, en effet en dimension $2$ seul $i upright(I)_2$ vaut $-upright(I)_2$ or il nous faut encore $2$ autre matrices pour décrire cette représentation. De même en dimension 3, il n’est pas dur de se convaicre qu’il n’y a pas assez de matrice vérifiant $A^2 = -upright(I)_3$.\
Dans notre cas, on peut, par exemple, considéré les matrices par bloc suivantes :
$
  gamma^0 = mat(upright(0)_2, upright(I)_2; upright(I)_2, upright(0)_2), forall i in [|1,3|], gamma^i = mat(upright(0)_2, sigma^i; -sigma^i, upright(0)_2)
$
où $sigma^i$ sont des matrices $2 times 2$, dite matrices de Pauli, qui se définissent par :
$
  sigma^1 = mat(0, 1; 1, 0); sigma^2 = mat(0, -i; i, 0); sigma^3 = mat(1, 0; 0, -1)
$
*Porpriété :*
$
  forall i,j in [|1; 3|], {sigma^i; sigma^j} = 2 delta^(i j)
$
Pour comprendre quel est le liens entre cette algèbre et les groupes de Lorentz, nous allons démontré qu’une certaine grandeur respecte la relation de comutation définis par @commutateurM, pour celà nous allons démontré plusieurs propriété sur l’objet suivant, jusqu’a atteindre la même relation de commutation.\
Définisons alors $S^(mu nu)$ par :\
*Définition & propriété :*
$
  S^(rho sigma) = 1/4[gamma^rho; gamma^sigma] = vec(0 &"si " rho = sigma, 1/2 gamma^rho gamma^sigma &"sinon", delim: "{") = 1/2 gamma^rho gamma^sigma - 1/2 eta^(rho sigma)
$<defS>
*Preuve :*\
- Pour $mu = nu$ :
$
  1/4 [gamma^mu; gamma^mu] = 1/4 ((gamma^mu)^2 - (gamma^mu)^2) = 0 = 1/2 (gamma^mu)^2 - 1/2 eta^(mu mu)
$
- Pour $rho != sigma$ :
$
  1/4 [gamma^rho; gamma^sigma] = 1/4 (gamma^rho gamma^sigma - underbrace(gamma^sigma gamma^rho, = - gamma^rho gamma^sigma)) = 1/2 gamma^rho gamma^sigma = 1/2 gamma^rho gamma^sigma - underbrace(1/2eta^(rho sigma), = 0)
$
#QED

*Propriété :*
$
  [S^(mu nu), gamma^rho] = gamma^mu eta^(nu rho) - gamma^nu eta^(mu rho)
$

*Preuve :*
$
  [S^(mu nu), gamma^rho] &= 1/2((gamma^mu gamma^nu - eta^(mu nu))gamma^rho - gamma^rho (gamma^mu gamma^nu - eta^(mu nu)))\
  &= 1/2 (gamma^mu gamma^nu gamma^rho - gamma^rho gamma^mu gamma^nu + cancel(eta^(mu nu)gamma^rho) - cancel(gamma^rho eta^(mu nu)))\
  &= 1/2 (gamma^mu underbrace((gamma^nu gamma^rho + gamma^rho gamma^nu), = {gamma^nu; gamma^rho}) - underbrace((gamma^mu gamma^rho + gamma^rho gamma^mu), = {gamma^mu; gamma^rho}) gamma^nu )\
  &= gamma^mu eta^(nu rho) - gamma^nu eta^(mu rho)
$
#QED

*Propriété :*
$
  [S^(mu nu); S^(rho sigma)] = S^(mu sigma) eta^(nu rho) - S^(nu sigma) eta^(rho mu) + S^(rho mu) eta^(nu sigma) - S^(rho nu) eta^(sigma mu)
$
*Preuve :*
$
  [S^(mu nu); S^(rho sigma)] & = 1/2[S^(mu nu); (gamma^rho gamma^sigma) - eta^(rho sigma)]\
  &= 1/2 [S^(mu nu); gamma^rho gamma^sigma] - 1/2 underbrace([S^(mu nu); eta^(rho sigma)], = 0)\
  &= 1/2 gamma^rho [S^(mu nu); gamma^sigma] + 1/2 [S^(mu nu); gamma^rho] gamma^sigma\
  &= 1/2 (gamma^rho gamma^mu eta^(nu sigma) - gamma^rho gamma^nu eta^(mu sigma) + gamma^mu gamma^sigma eta^(nu rho) - gamma^nu gamma^sigma eta^(mu rho))
$<commutS>
Or d’après @defS : $gamma^mu gamma^nu = 2 S^(mu nu) + eta^(mu nu)$, ainsi :
$
  [S^(mu nu); S^(rho sigma)] &= S^(rho mu) eta^(nu sigma) + cancel(1/2 eta^(rho mu) eta^(nu sigma)) - S^(rho nu) eta^(mu sigma) - cancel(1/2 eta^(rho nu) eta^(mu sigma)) + S^(mu sigma) eta^(nu rho) + cancel(1/2 eta^(mu sigma) eta^(nu rho)) - S^(nu sigma) eta^(mu rho) - cancel(1/2 eta^(nu sigma) eta^(mu rho))\
  &= S^(rho mu) eta^(nu sigma) - S^(rho nu) eta^(mu sigma) + S^(mu sigma) eta^(nu rho) - S^(nu sigma) eta^(mu rho)
$
#QED

Ainsi on retombe sur la relation de commutation pour $cal(M)$ pour $S$, donc ces deux représentation représente bien le même groupe, à savoir celuis de Lorentz

=== Spineurs de Dirac

On définis les spineurs de dirac par le champs spinorielle, qui est un objet à 4 composante complexe et qui se transforme comme suit par transformation de Lorentz :
$
  forall alpha in [|1; 4|], psi^alpha --> S[Lambda]^alpha""_beta psi^beta (Lambda^(-1) x)
$
où
$
  Lambda = exp(1/2 Omega_(rho sigma) cal(M)^(rho sigma))\
  S[Lambda] = exp(1/2 Omega_(rho sigma) S^(rho sigma))
$
ici $S[Lambda]$ représente $Lambda$ écrit dans la représentation de la base $S$. On pourrat également noté que l’on utilise les même $Omega$ pour les deux représentation, cecis nous assure que l’on fasse la même transformation de Lorentz.\

Pour s’assurer que $Lambda$ et $S[Lambda]$ sont effectivement bien différent nous considérons l’exemple suivant :\
\
_Exemple :_ Rotation\
Considérons une rotation dans le plans $forall i,j in [|1,3|], (x^i, x^j)$, alors, pour $i != j$ :
$
  S^(i j) &= 1/2 gamma^i gamma^j = 1/2 mat(0, sigma^i; -sigma^i, 0) mat(0, sigma^j; -sigma^j, 0) = 1/2 mat(-sigma^i sigma^j, 0; 0, - sigma^i sigma^j)\
  &= -i/2 epsilon^(i j k) mat(sigma^k, 0; 0, sigma^k)
$
De plus le paramètre $Omega$ dans le cas d’une rotation dans le plan $(x^i, x^j)$ peut s’écrire :
$
  Omega_(i j) = - epsilon_(i j k)phi^k
$
où $arrow(phi) = (phi^1, phi^2, phi^3)$ et $arrow(sigma) = (sigma^1, sigma^2, sigma^3)$, où chaque composante représente une rotation de $phi^i$ autour de l’axe $x^i$\
Alors, la matrice de rotation deviens :
$
  S[Lambda] & = exp(1/2 Omega_(rho sigma) S^(rho sigma)) \
            & = exp(1/4 i epsilon^(i j k) epsilon_(i j l) phi^l mat(sigma^k, 0; 0, sigma^k)) \
            & = exp(1/2 i delta^k_l phi^l mat(sigma^k, 0; 0, sigma^k)) \
            & = exp(1/2 i phi^k mat(sigma^k, 0; 0, sigma^k)) \
            & = mat(exp(i/2 phi^k sigma^k), 0; 0, exp(i/2 phi^k sigma^k)) \
            & = mat(e^(i (arrow(phi) dot.c arrow(sigma))/2), 0; 0, e^(i (arrow(phi) dot.c arrow(sigma))/2)) \
$
Ainsi dans le cas d’une rotation de $theta$ autour de l’axe $x^3$, $arrow(phi) = (0, 0, theta)$, alors :
$
  S[Lambda] = mat(e^(i (theta sigma^3)/2), 0; 0, e^(i (theta sigma^3)/2))
$
ainsi dans le cas d’une rotation de $theta$, un spineurs n’effecturas seulement la moitier de cette rotation, par exemple dans le cas d’une rotation entière ($theta = 2pi$), on a :
$
  S[Lambda] = - upright(I)_4
$
et donc le spineurs suiveras la transformation suivante :
$
  psi^alpha (x) --> - psi^alpha (x)
$\
\
Pour que l’objet fasse une rotation entière, il faut donc que celui-ci fasse une rotation de $4 pi$.\
Ces objets sont relativement contre-intuitive, mais il existe plusieurs exemple abordable, comme la rotation d’une mains comme dans la danse du Tari Piring, ou encore quand vous faites le tours d’un ruban de Moëbius (ce qui n’a rien à voir avec les myrtilles !), au quelcas quand vous avez effectuer un tour, vous vous retrouvez de l’autre coté de la feuille !\
\
*Achtung !*\
La représentation du groupe de Lorentz n’est pas unitaire, en effet pour quelle le soit, il faut que $S^(rho sigma)$ soit anit-hermitien, i.e. $(S^(rho sigma))^dagger = - S^(rho sigma)$, or on a :
$
  (S^(rho sigma))^dagger = 1/4 [(gamma^rho)^dagger; (gamma^sigma)^dagger]
$
Sauf que $(gamma^0)^dagger = gamma^0$ et $(gamma^i)^dagger = -gamma^i$, donc notre représentation ne peut être unitaire. En réalité, on peut généralisé ce résulta en montrant qu’il n’existe pas de représentation unitaire de dimension finis des groupes de Lorentz

== Action de Dirac <actiondedirac>

Maintenant le but est de construire une action qui soit invariante par les transformé de Lorentz, sur les nouveaux champs que nous venons de construire : les spineurs de Dirac. Pour celà on cherche une action qui soit un scalaire par les transformé de Lorentz.\
\
Naïvement, on pourras regardé comment se transforme $psi^dagger (x) psi(x)$, où $psi^dagger$ se définis par :
$
  psi^dagger (x) = (psi^star)^t (x)
$
Regardons donc, comme ce produit se transforme sous cette transformation :
$
  psi --> S[Lambda] psi(Lambda^(-1) x)\
  psi^dagger --> psi^dagger (Lambda^(-1) x) S[Lambda]^dagger
$
Alors le produit deviens :
$
  (psi')^dagger (x) psi' (x) & = psi^dagger (Lambda^(-1) x) S[Lambda]^dagger S[Lambda] psi (Lambda^(-1) x)
$
Or nous avons montré (discuté) que la représentation du groupe de Lorentz n’étais pas unitaire donc $S[Lambda]^dagger S[Lambda] != 1$, ainis ce produit ne se transforme pas comme un scalaire, et n’a pas de bonne transformation dans le groupe de Lorentz. Maintenant que nous avons vue pourquoi celà ne marche pas. Pour construire un élément qui marche, considérons un algèbre de Clifford, tel que : $(gamma^0)^dagger = gamma^0$ et $forall i in [|1, 3|], (gamma^i)^dagger = - gamma^i$, ainsi, on pourra d’abord remarquer que :
$
                        & gamma^0 gamma^0 gamma^0 = gamma^0 = (gamma^0)^dagger \
  forall i in [|1, 3|], & gamma^0 gamma^i gamma^0 = - gamma^i = (gamma^i)^dagger
$
Ainsi, on peut réécrire ces formules en une seul bien plus pratique :
$
  forall mu in [|0, 3|], (gamma^mu)^dagger = gamma^0 gamma^mu gamma^0
$
De plus, on a :\
*Propriété :*
$
  (S^(rho sigma))^dagger = - gamma^0 S^(rho sigma) gamma^0
$
*Preuve :*
$
  (S^(rho sigma))^dagger & = 1/4 [(gamma^sigma)^dagger; (gamma^rho)^dagger] \
                         & = 1/4 [gamma^0 gamma^sigma gamma^0; gamma^0 gamma^rho gamma^0] \
                         & = - 1/4 gamma^0 [gamma^rho; gamma^sigma] gamma^0 \
                         & = - gamma^0 S^(rho sigma) gamma^0
$
#QED

Alors, on peut voir comment se comporte $S[Lambda]$ sous la dague :\
*Propriété :*
$
  (S[Lambda])^dagger = gamma^0 S[Lambda]^(-1) gamma^0
$
*Preuve :*
$
  (S[Lambda])^dagger & = exp(1/2 Omega_(rho sigma) (S^(rho sigma))^dagger) \
                     & = exp(- 1/2 Omega_(rho sigma) gamma^0 S^(rho sigma) gamma^0) \
                     & = underbrace(1, = gamma^0 gamma^0) - 1/2 Omega_(rho sigma) gamma^0 S^(rho sigma) gamma^0 \
                     & = gamma^0 (1 - 1/2 Omega_(rho sigma) S^(rho sigma)) \
                     & = gamma^0 exp(-1/2 Omega_(rho sigma)S^(rho sigma)) gamma^0 = gamma^0 S[Lambda]^(-1) gamma^0
$
#QED
\
Ainsi, on peut définir l’adjoins de Dirac par :
$
  dash(psi) = (psi)^dagger gamma^0
$
Voyons donc comment celui-ci se transforme par le groupe de Lorentz :

*Propriété :*
$
  dash(psi) (x) psi(x) "est un scalaire de Lorentz"
$\

*Preuve :*
$
  dash(psi') (x) psi'(x) &= (psi')^dagger (x) gamma^0 psi'(x)\
  &= psi^dagger (Lambda^(-1) x) S[Lambda]^dagger gamma^0 S[Lambda] psi(Lambda^(-1) x)\
  &= psi^dagger (Lambda^(-1) x) gamma^0 cancel(S[Lambda]^(-1) gamma^0 gamma^0 S[Lambda]) psi(Lambda^(-1) x)\
  &= psi^dagger (Lambda^(-1) x) gamma^0 psi(Lambda^(-1) x)\
  &= dash(psi) (Lambda^(-1) x) psi(Lambda^(-1) x)\
$\
\
Par cette même méthode, on peut construire deux autre invariant par transformé de Lorentz, des vecteurs et des tenseurs, en effet :\
\
*Propriété :*
$
  dash(psi) gamma^mu psi "est un vecteur de Lorentz, i.e. :"\
  dash(psi) (x) gamma^mu psi (x) --> Lambda^mu""_nu dash(psi) (Lambda^(-1) x) gamma^nu psi (Lambda^(-1) x)
$\

*Preuve :*
Voir Tong\
\
\
*Propriété :*
$
  dash(psi) gamma^mu gamma^nu psi "est un tenseur de Lorentz"\
  dash(psi) (x) gamma^mu gamma^nu psi (x) --> Lambda^mu""_rho Lambda^nu""_sigma dash(psi) (Lambda^(-1) x) gamma^rho gamma^sigma psi (Lambda^(-1) x)
$\

*Preuve :*
Voir Tong
\
\
\
Nous povons donc maintenant construire une action invariante pas groupe de Lorentz, grâce au 3 forme bilinéaire que l’on viens de construire : $dash(psi) psi, dash(psi) gamma^mu psi$ et $dash(psi) gamma^mu gamma^nu psi$, en réalité seul les deux première serons utile, alors nous définisons l’action de Dirac par :
$
  S = integral dx^4 dash(psi) (x) (i gamma^mu partial_mu - m) psi (x)
$ <ActionDirac>

== Équation de Dirac

A partir de l’action de Dirac, définis ci-dessus, on peut en déduire le lagrangien suivant :
$
  cal(L) = dash(psi) (i gamma^mu partial_mu - m) psi
$
\
Ainsi on a :
$
        partial_mu ((partial lagr)/(partial (partial_mu psi))) & = i partial_mu dash(psi) gamma^mu \
                                                          "et" \
  partial_mu ((partial lagr)/(partial (partial_mu dash(psi)))) & = 0
$
Or
$
        (partial lagr)/(partial psi) & = -m dash(psi) \
                                "et" \
  (partial lagr)/(partial dash(psi)) & = i gamma^mu partial_mu psi - m psi
$
Donc par les équations d’Euler-Lagrange, on trouve les deux équations suivante :
$
  (i gamma^mu partial_mu - m) psi = 0
$<eqDirac>
$
  i partial_mu dash(psi) gamma^mu + m dash(psi) = 0
$
Ces équations sont des fois, également, appelé « racine carré » de la solution de l’équation de Klein-Gordon, en effet ces équations sont solution de l’équation de Klein-Gordon :
$
  (i gamma^nu partial_nu - m)(i gamma^mu partial_mu + m) psi = - (gamma^mu gamma^nu partial_nu partial_mu + m^2) psi = 0
$
Or, on peut montré que dans notre cas : $gamma^mu gamma^nu = eta^(mu nu)$, ainsi, on trouve :
$
  - (eta^(mu nu) partial_mu partial_nu + m^2) psi = -(partial^mu partial_mu + m^2)psi = 0\
$
cette équation ne dépend plus de $gamma^mu$ ainsi, elle s’applique de la même manière à toute les composante de $psi$\
\
*Le Slash*\
Dans de nombreux ouvrages on trouve l’équation de Dirac écirt comme suit :
$
  (i fey(partial) - m)psi = 0
$
où on définis la notation, relativement pratique, suivante :
$
  fey(A) = gamma^mu A_mu
$

== Spineurs Chiraux

Nous avons vue dans l’exemple, que $S[Lambda]$ s’écrivais dans le cas d’une rotation comme :
$
  S[Lambda_"rot"] = mat(e^(i (arrow(phi) dot.c arrow(sigma))/2), 0; 0, e^(i (arrow(phi) dot.c arrow(sigma))/2))
$
On peut montré que dans le cas d’un Boost $S[Lambda]$ peu s’écrire :
$
  S[Lambda_"boost"] = mat(e^(arrow(chi) dot.c arrow(sigma) \/ 2), 0; 0, e^(- arrow(chi) dot.c arrow(sigma) \/ 2))
$
où $arrow(chi)$ est le paramètre du boost ($forall i in [|1;3|], Omega_(i 0) = chi_i$)\
\
On remarque que ces matricet sont diagonale par bloc, ce qui veut dire que la représentation des spineur de Dirac du groupe de Lorentz est réductible, i.e. qu’il existe deux (car deux blocs dans la diagonale) sous groupes iréductible, suplémentaire de notre représentation. Ainsi on peut décomposé un spineur $psi$ de Dirac en deux composantes $u_plus.minus$, que l’on définis comme suit :
$
  psi = vec(u_+, u_-)
$
Les deux composantes $u_plus.minus$ sont appelé spineurs de Weyl ou spineurs chiraux, comme il corresponde à un bloc de notre transformation, il se transforme comme :
- pour les rotations :
$
  u_plus.minus --> e^(i arrow(phi) dot.c arrow(sigma) \/2) u_plus.minus
$
- pour les boosts :
$
  u_plus.minus --> e^(plus.minus i arrow(chi) dot.c arrow(sigma) \/2) u_plus.minus\
$\
\
On peut regarder ce que deviens l’équation de #link(<eqDirac>)[Dirac], pour celà calculons d’avance les grandeurs : $psi^dagger$ & $gamma^0 gamma^mu$\
\
*Propriété :*
$
  psi^dagger = ((u_plus)^dagger " " (u_minus)^dagger )
$\
*Preuve :*
$
  psi^dagger & = vec(u_+, u_-)^dagger = (vec(u_+, u_-)^star)^t \
             & = ((u_+^star)^t " " (u_-^star)^t) = (u_+^dagger " " u_-^dagger)
$
#QED\
\
*Propriété :*
$
  gamma^0 gamma^mu = mat(dash(sigma)^mu, 0; 0, sigma^mu)
$
où nous nous redéfinisson $sigma = (1, sigma^i)$ et $dash(sigma) = (1, - sigma^i)$, dénoté par l’indice $mu$, ce qui ne seras pas à confondres avec $sigma^i$ qui réfaire toujours au $sigma$ originaux\
\
*Preuve :*
$
  gamma^0 gamma^mu &= cases(gap: #5mm, gamma^0 gamma^0 = upright(I)_4 &"si" mu = 0, mat(0, 1; 1, 0) mat(0, sigma^i; - sigma^i, 0) = mat(- sigma^i, 0; 0, sigma^i) &"sinon")\
  &= mat(dash(sigma)^mu, 0; 0, sigma^mu)
$
#QED\
\
Maintenant, nous somme paré pour réécrire le lagrangien de Dirac, pour les spineurs de Weyl
$
  lagr &= dash(psi) (i gamma^mu partial_mu -m) psi\
  &= i psi^dagger gamma^0 gamma^mu partial_mu psi - m psi^dagger gamma^0 psi\
  &= i mat(u_+^dagger, u_-^dagger) mat(dash(sigma)^mu, 0; 0, sigma^mu) vec(partial_mu u_+, partial_mu u_-) - m mat(u_+^dagger, u_-^dagger) mat(0, 1; 1, 0) vec(u_+, u_-)\
  &= i mat(u_+^dagger, u_-^dagger) vec(dash(sigma)^mu partial_mu u_+, sigma^mu partial_mu u_-) - m mat(u_+^dagger, u_-^dagger) vec(u_-, u_+)\
  &= i u_+^dagger dash(sigma)^mu partial_mu u_+ + i u_-^dagger sigma^mu partial_mu u_- - m (u_+^dagger u_- + u_-^dagger u_+)
$
Or nous avons si on respecte les équations de mouvement $lagr = 0$, donc :
$
  i u_+^dagger dash(sigma)^mu partial_mu u_+ + i u_-^dagger sigma^mu partial_mu u_- - m (u_+^dagger u_- + u_-^dagger u_+) = 0
$
Ainsi, on remarque que dans le cas d’un fermions massif, on a besoin de décrire $u_+$ ou $u_-$ car ces deux terme sons couplé, dans le terme de masse, cependant, dans le cas d’un fermion non-massif ce termes disparait, il ne suffi que de $u_+$ ou $u_-$ pour décrire un tel fermion, qui doit donc respécté l’équation de mouvement suivant :
$
  i dash(sigma)^mu partial_mu u_+ = 0 "décrit par" u_+\
  i sigma^mu partial_mu u_- = 0 "décrit par" u_-\
$

*Preuve :*\
Comme le fermion est non-massif, alors le lagrangien ce réécrit :
$
  lagr = i u_+^dagger dash(sigma)^mu partial_mu u_+ + i u_-^dagger sigma^mu partial_mu u_-
$
On a donc, d’une part :
$
  partial_mu ((partial lagr)/ (partial (partial_mu u_+^dagger))) = 0
$
et d’autre part :
$
  (partial lagr)/(partial u_+^dagger) = i dash(sigma)^mu partial_mu u_+
$
Donc d’après les équations d’Euler-Lagrange, on trouve :
$
  i dash(sigma)^mu partial_mu u_+ = 0
$
On retrouve la seconde équation par le même calcul par le paramètre $u_-^dagger$
#QED

== Projection sur d’autre représentation <projection>
Dans notre représentation $S[Lambda]$ nous apparait diagonale par bloc, c’est d’ailleurs pourquoi cette représentation est aussi appelé la représentation chiral, car elle explicite cette décomposition en spineurs chiraux. Regardons ce qu’il se passerais pour une autre représentation $gamma^mu$ de l’algèbre de Clifford :
$
  gamma^mu --> U gamma^mu U^(-1) et psi --> U psi
$
Ainsi $S[Lambda]$ n’a plus aucune raisons d’être diagonale par bloc, il nous faut maintenant trouver un invariant pour définir les spineurs chiraux.\
Pour celà on peut définir l’objet suivant :\
*Définition :*
$
  gamma^5 = - i gamma^0 gamma^1 gamma^2 gamma^3
$\
\
*Propriété :*
$
  {gamma^5, gamma^mu} = 0 et (gamma^5)^2 = upright(I)_4
$\
\
*Preuve :*\
soit $mu in [|0; 3|]$
$
  {gamma^5, gamma^mu} & = gamma^5 gamma^mu + gamma^mu gamma^5 \
                      & = - i gamma^0 gamma^1 gamma^2 gamma^3 gamma^mu -i gamma^mu gamma^0 gamma^1 gamma^2 gamma^3 \
                      & = i gamma^mu gamma^0 gamma^1 gamma^2 gamma^3 - i gamma^5 gamma^0 gamma^1 gamma^2 gamma^3 = 0
$
Et
$
  (gamma^5)^2 & = (-i gamma^0 gamma^1 gamma^2 gamma^3) (-i gamma^0 gamma^1 gamma^2 gamma^3) \
              & = - gamma^0 gamma^1 gamma^2 gamma^3 gamma^0 gamma^1 gamma^2 gamma^3 \
              & = - gamma^0 gamma^1 gamma^2 gamma^0 gamma^1 gamma^2 \
              & = gamma^0 gamma^1 gamma^0 gamma^1 \
              & = gamma^0 gamma^0 = upright(I)_4
$
#QED\
\
*Propriété :*\
$
  [S_(mu nu); gamma^5] = 0
$\
*Preuve :*
$
  S_(mu nu) gamma^5 &= 1/2 (eta_(mu rho) eta_(nu sigma) gamma^rho gamma^sigma - eta_(mu nu)) gamma^5 = 1/2 (eta_(mu rho) eta_(nu sigma) gamma^rho gamma^sigma gamma^5 - gamma^5 eta_(mu nu))\
  &= 1/2 ( - eta_(mu rho) eta_(nu sigma) gamma^rho gamma^5 gamma^sigma - gamma^5 eta_(mu nu))\
  &= 1/2 ( eta_(mu rho) eta_(nu sigma) gamma^5 gamma^rho gamma^sigma - gamma^5 eta_(mu nu))\
  &= 1/2 gamma^5 ( eta_(mu rho) eta_(nu sigma) gamma^rho gamma^sigma - eta_(mu nu))\
  &= gamma^5 S_(mu nu)\
$
Donc on a bien :
$
  [S_(mu nu); gamma^5] = S_(mu nu) gamma^5 - gamma^5 S_(mu nu) = 0
$
#QED

Cette dernière propriété, nous indique que $gamma^5$ est un scalaire sous les rotations et les boosts et comme $(gamma^5)^2 = upright(I)_4$, on peut définir les projections suivantes, qui sont donc invariante par le groupe de Lorentz :
$
  P_plus.minus = 1/2 (upright(I)_4 plus.minus gamma^5)
$
*Propriété :*
$
  P_plus.minus "est une projection" et P_+ P_- = 0
$\
*Preuve :*
$
  (P_plus.minus)^2 & = 1/4 (upright(I)_4 plus.minus gamma^5) (upright(I)_4 plus.minus gamma^5) \
                   & = 1/4 (upright(I)_4 plus.minus 2 gamma^5 + underbrace((gamma^5)^2, = upright(I)_4)) \
                   & = 1/4 (2 upright(I)_4 plus.minus 2 gamma^5 ) \
                   & = 1/2 ( upright(I)_4 plus.minus gamma^5 ) = P_plus.minus
$
Et
$
  P_+ P_- & = (upright(I)_4 + gamma^5) (upright(I)_4 - gamma^5) \
          & = upright(I)_4 - (gamma^5)^2 = upright(I)_4 - upright(I)_4 = 0
$
#QED\
\
Dans notre représentation $gamma^5$ s’écrit :
$
  gamma^5 & = - i gamma^0 gamma^1 gamma^2 gamma^3 \
  & = - i mat(0, id_2; id_2, 0) mat(0, sigma^1; -sigma^1, 0) mat(0, sigma^2; -sigma^2, 0) mat(0, sigma^3; -sigma^3, 0)\
  &= -i mat(0, id_2; id_2, 0) mat(0, sigma^1; -sigma^1, 0) mat(-sigma^2 sigma^3, 0; 0, - sigma^2 sigma^3)\
  &= -i mat(0, id_2; id_2, 0) mat(0, sigma^1; -sigma^1, 0) mat(-i sigma^1, 0; 0, - i sigma^1)\
  &= - mat(0, id_2; id_2, 0) mat(0, (sigma^1)^2; -(sigma^1)^2, 0)\
  &= - mat(0, id_2; id_2, 0) mat(0, id_2; -id_2, 0)\
  &= - mat(- id_2, 0; 0, id_2)\
  &= mat(id_2, 0; 0, -id_2)\
$
On remarque donc que dans notre représentation $P_plus.minus$ projete le spineur de Dirac $psi$ sur ses composantes chiral. On peu donc définir les composante chiral pour toute représentation confondus par :
$
  psi_plus.minus = P_plus.minus psi
$
qui sont donc des représentation iréductible du groupe de Lorentz.

=== Parité
En mécanique quantique, il y a deux symétrie discrete relativement importante :
$
  "Renversement du temps :" & (x^0, x^i) --> (-x^0, x^i) \
                 "Parité :" & (x^0, x^i) --> (x^0, -x^i)
$
On ne s’interesseras qu’a la symétrie de parité. Regardons comment se transforme alors les spineurs chiraux, pour celà on vas regarder ce qu’il se passe pour les éléments du groupe $(1/2, 0)$, ces éléments de définisse donc comme se transformant comme suit :
- Rotation :
$
  S[Lambda_"Rot"] u = e^(i/2 arrow(phi) dot.c arrow(sigma)) u
$
- Boost :
$
  S[Lambda_"Boost"] u = e^(1/2 arrow(chi) dot.c arrow(sigma)) u
$
Or quand on applique la projection à ces transformation on obtient :
- Rotation :
$
  P(S[Lambda_"Rot"] u) = e^(i/2 arrow(phi) dot.c arrow(sigma)) u
$
- Boost :
$
  P(S[Lambda_"Boost"] u) = e^( - 1/2 arrow(chi) dot.c arrow(sigma)) u
$
Ce qui est exactement la définition d’ un éléments du groupe $(0, 1/2)$, on pourrais montré par la même méthode qu’un éléments du groupe $(0, 1/2)$ deviens un éléments du groupe $(1/2, 0)$, ainsi $P$ réalise une bijection entre $(0, 1/2)$ et $(1/2, 0)$, autrement dit, on a :
$
  P(u_plus.minus) = u_minus.plus
$

Ainsi un spineur de Dirac se transforme par :\
*Propriété :*
$
  P (psi) = gamma^0 psi
$\
*Preuve :*
$
  gamma^0 psi & = mat(0, 1; 1, 0) vec(psi_+, psi_-) = vec(psi_-, psi_+) \
              & = vec(P(psi_+), P(psi_-)) = P(vec(psi_+, psi_-)) = P(psi)
$
#QED

On peut regrader ce que deviens l’équation de Dirac par cette symétrie :
$
  (i gamma^mu partial_mu - m) psi' = (i gamma^0 partial_t + i gamma^i partial_i - m) gamma^0 psi = gamma^0 (i gamma^0 partial_t - gamma^i partial_i - m) psi = 0
$
où le signe gagné par le passage de $gamma^5$ est compensé par la dérivé sur $- arrow(x)$\
\
==== Interaction chiral
On peut également regarder comment se transforme les termes de couplage sous la symétrie de parité, ainsi l’on va calculer pour chaque forme bilinéaire trouvé au @actiondedirac.\
Pour les scalaire, on a :
$
  P (dash(psi) psi) = dash(P(psi)) P(psi) = dash(gamma^0 psi) gamma^0 psi = dash(psi) gamma^0 gamma^0 psi = dash(psi) psi
$
Ce qui est la transformation des scalaire.\
Pour le vecteur, on va distingé le cas temporelle au cas spatiaux :
$
  P(dash(psi) gamma^0 psi) = dash(P(psi)) gamma^0 P(psi) = dash(psi) gamma^0 gamma^0 gamma^0 psi = dash(psi) gamma^0 psi\
  P(dash(psi) gamma^i psi) = dash(P(psi)) gamma^0 P(psi) = dash(psi) gamma^0 gamma^i gamma^0 psi = - dash(psi) gamma^i psi\
$
On observe, comme attendue, une inversion de signe sur les composantes spatial des vecteurs, et que cecis se transforme bien comme des vecteurs.\
On pourrais montré que un tenseur $S^(mu nu)$ se transforme également comme il faut, cependant, on s’interesseras plus aux deux forme bilinéaire que nous avons put construire dans le @projection à l’aide de $gamma^5$ : $dash(psi) gamma^5 psi$ & $dash(psi) gamma^5 gamma^mu psi$
$
  P(dash(psi) gamma^5 psi) = dash(P(psi)) gamma^5 P(psi) = dash(psi) gamma^0 gamma^5 gamma^0 psi = - dash(psi) gamma^5 psi\
  P(dash(psi) gamma^5 gamma^mu psi) = dash(P(psi)) gamma^5 gamma^mu P(psi) = dash(psi) gamma^0 gamma^5 gamma^mu gamma^0 psi = cases(- dash(psi) gamma^5 gamma^0 psi &"si" mu = 0, + dash(psi) gamma^5 gamma^mu psi &"si" mu != 0)
$
On a donc que $dash(psi) gamma^5 psi$ se transforme comme un pseudo-scalaire et $dash(psi) gamma^5 gamma^mu psi$ se transforme comme un pseudo-vecteur\
\
On peut résumé le type des différentes formes bilinéaire que nous avons construit jusqu’ici, dans le tableau suivant :
#figure(
  grid(
    columns: 2,
    column-gutter: 1cm,
    row-gutter: 0.5cm,
    align: center + horizon,
    $dash(psi) psi$, [scalaire],
    $dash(psi) gamma^mu psi$, [vecteur],
    $dash(psi) S^(mu nu) psi$, [Tenseur],
    $dash(psi) gamma^5 psi$, [pseudo-scalaire],
    $dash(psi) gamma^5 gamma^mu psi$, [pseudo-vecteur],
  ),
  gap: 7mm,
  caption: [Type des formes bilinéaires],
)\

On a donc trouvé $1 + 4 + (4 times 3\/2) + 1 + 4 = #{ 1 + 4 + (4 * 3 / 2) + 1 + 4 } = 4^2$ forme bilinéaires, ce qui est donc le nombre maximal que l’on peut espéré trouver.\

== Symétrie & Courant conservé

Le lagrangien de Dirac encode 4 symétrie : \
\
#set enum(indent: 1cm, spacing: 4mm)
+ Translation spatio-temporelle

+ transformation de Lorentz
+ symétrie interne des vecteurs
+ symétrie axial

On propose dans ce chapitre de calculer le courant de Noether associé à chaque symétrie.\
Tout d’abord nous avons :
$
  (partial lagr)/(partial(partial psi)) = i dash(psi) gamma^mu
$
et
$
  (partial lagr)/(partial(partial dash(psi))) = 0
$
Donc nous avons :
$
  J^mu = i dash(psi) gamma^mu (delta psi)/(delta alpha) - F^mu
$

=== Translation spatio-temporelle
Nous avons déjà vue que dans le cas d’une translation spatio-temporelle $x --> x + epsilon$, nous avons :
$
  delta psi = epsilon^nu partial_nu psi
$
Et que
$
  delta lagr = epsilon^nu partial_nu lagr
$
Ainsi, notre courant deviens :
$
  T^mu""_nu = (J^mu)_nu = i dash(psi) gamma^mu partial_nu psi - delta^mu""_nu lagr
$
Or si l’on respecte les équations du mouvement, on a que $lagr = 0$, d’où :
$
  T^(mu nu) = i dash(psi) gamma^mu partial^nu psi
$

=== transformation de Lorentz

Sous une transformation de Lorentz infinitésimal, $psi$ se transforme comme suit :
$
  psi'^alpha (x) & = S[Lambda] psi^alpha (Lambda^(-1) x) \
  & = e^(1/2 Omega_(rho sigma) (S^(rho sigma))^alpha""_beta) psi^beta ((delta^mu""_nu - omega^mu""_nu) x^nu) \
  & = (delta^alpha + 1/2 Omega_(rho sigma) (S^(rho sigma))^alpha""_beta) psi^beta (x^mu - omega^mu""_nu x^nu)\
  & = (delta^alpha""_beta + 1/2 Omega_(rho sigma) (S^(rho sigma))^alpha""_beta) (psi^beta - omega^mu""_nu x^nu partial_mu psi^beta)\
  & = psi^alpha - omega^mu""_nu x^nu partial_mu psi^alpha + 1/2 Omega_(rho sigma) (S^(rho sigma))^alpha""_beta psi^beta - 1/2 Omega_(rho sigma) omega^mu""_nu (S^(rho sigma))^alpha""_beta psi^beta \
$ <2.6.2.1>
Or nous avons $omega^mu""_nu = 1/2 Omega_(rho sigma) (cal(M)^(rho sigma))^mu""_nu$ et $(cal(M)^(rho sigma))^mu""_nu = eta^(rho mu) delta^(sigma)""_nu - eta^(sigma mu) delta^rho""_nu$, donc :
$
  omega^mu""_nu &= 1/2 Omega_(rho sigma) (cal(M)^(rho sigma))^mu""_nu = omega^mu""_nu = 1/2 Omega_(rho sigma) (eta^(rho mu) delta^(sigma)""_nu - eta^(sigma mu) delta^rho""_nu)\
  &= 1/2 (Omega^mu""_nu - Omega_nu""^mu) = 1/2 times 2 Omega^mu""_nu = Omega^mu""_nu
$
Donc en substituant $Omega^(mu nu)$ par $omega^(mu nu)$ dans @2.6.2.1 on obtiens :
$
  psi'^alpha (x) &= psi^alpha - omega^mu""_nu x^nu partial_mu psi^alpha + 1/2 omega_(rho sigma) (S^(rho sigma))^alpha""_beta psi^beta - underbrace(1/2 omega_(rho sigma) omega^mu""_nu (S^(rho sigma))^alpha""_beta psi^beta, = o(omega^(mu nu)))\
  &= psi^alpha underbrace(- omega_(mu nu) (x^nu partial^mu psi^alpha - 1/2 (S^(mu nu))^alpha""_beta psi^beta), = delta psi^alpha)
$
Donc
$
  delta psi^alpha & = - omega_(mu nu) (x^nu partial^mu psi^alpha - 1/2 (S^(mu nu))^alpha""_beta psi^beta)
$
Or par anti-symétrique le premier termes se réécrit :
$
  -omega_(mu nu) x^nu partial^mu psi^alpha &= -1/2 (omega_(mu nu) - omega_(nu mu)) x^nu partial^mu psi^alpha\
  &= -1/2(omega_(mu nu)x^nu partial^mu psi^alpha - omega_(nu mu)x^mu partial^nu psi^alpha)
$
Et donc on a enfin :
$
  delta psi^alpha = -1/2(omega_(mu nu)x^nu partial^mu psi^alpha - omega_(nu mu)x^mu partial^nu psi^alpha) + 1/2 omega_(mu nu)(S^(mu nu))^alpha""_beta psi^beta
$
Comme dans le cas d’une translation spatio-temporelle nous avons $F^mu = 0$, donc :
$
  (J^(mu))^(rho sigma) &= i dash(psi) gamma^mu (-1/2(x^sigma partial^rho psi - x^rho partial^sigma psi) + 1/2 (S^(rho sigma)) psi)\
  &= -1/2 x^sigma underbrace(i dash(psi)gamma^mu partial^rho psi, = T^(mu rho)) + 1/2 x^rho underbrace(i dash(psi)gamma^mu partial^sigma psi, = T^(mu sigma)) + 1/2 dash(psi) gamma^mu S^(rho sigma) psi\
  &= 1/2 (x^rho T^(mu sigma) - x^sigma T^(mu rho) + dash(psi) gamma^mu S^(rho sigma) psi)
$
Étant donnée que les courant sont définis à un facteur près, on définis le courant ci-dessous :
$
  (cal(J)^mu)^(rho sigma) = 2 (J^mu)^(rho sigma) = x^rho T^(mu sigma) - x^sigma T^(mu rho) + dash(psi) gamma^mu S^(rho sigma) psi
$

=== Symétrie interne au vecteur

Il est aisé de vérifier que le lagrangien est invariant par changement de phase : $psi -> e^(i alpha) psi$, ainsi celui-ci constitue naturellement une symétrie, ainsi, on a :
$
  delta psi = i alpha
$
et comme le lagrangien est invariant $F^mu = 0$\
On obtient donc le courant suivant :
$
  j^mu & = i dash(psi) gamma^mu times i psi \
       & = - dash(psi) gamma^mu psi
$
On défins là aussi un second courant positif, par rapport à celuis donnée par le théorème de Noether directement, par :
$
  j^mu_V = - j^mu = dash(psi) gamma^mu psi
$
On reconnais ici l’expression d’un vecteurs

=== Symétrie axial

Quand la masse est null ($m = 0$) le lagrangien admet une symétrie supplémentaire qui faits tourné les fermions gauche et droit dans des sens opposé :
$
  psi -> e^(i alpha gamma^5) psi
$
Donc
$
  delta psi = i alpha gamma^5
$
Ainsi par le même résonement que dans la symétrie précédente, mais avec un $gamma^5$ en plus, on trouve le courant suivant :
$
  j_A^mu = dash(psi) gamma^mu gamma^5 psi
$
Et on reconnais ici, l’expression d’un pseudo-vecteur

== Couplage au photon <spineurele>

Pour faire apparaitre le couplage avec le couplage, il faut remplacé toute les dérivé par des dérivés covariantes $D_mu = partial_mu - i q A_mu$, dans le lagrangien de Dirac (@eqDirac), ainsi on obtient :
$
  lagr & = dash(psi)(i fey(D) - m) psi \
       & = dash(psi) (i gamma^mu D_mu - m) psi \
       & = dash(psi) (i gamma^mu (partial_mu - i q A_mu) - m)psi = dash(psi) (i fey(partial) + q fey(A)- m)psi
$
On peut alors dérivé deux nouvelles équation du mouvement :
d’un part :
$
  partial_mu ((partial lagr)/(partial (partial psi))) = i partial dash(psi)\
  partial_mu ((partial lagr)/(partial (partial dash(psi)))) = 0\
$
d’autre part :
$
  (partial lagr)/(partial psi) = i q dash(psi) fey(A) - m dash(psi)\
  (partial lagr)/(partial psi) = (i fey(partial) + q fey(A) - m) psi\
$
Donc par les équations d’Euler-Lagrange on trouve les deux équations du mouvement suivantes :\
\
$
  (i fey(partial) + q fey(A) - m) psi = (i fey(D) - m) psi = 0\
$
$
  i partial_mu dash(psi) gamma^mu - i q dash(psi) fey(A) - m dash(psi) = 0
$\
\
Nous avions vue que l’équation de Dirac était la #text(style: "italic")[racine carré] de l’équation de Klein-Gordon, ainsi on peut refaire les calcul avec ces nouvelles équations.
$
  (i fey(D) - m)(i fey(D) + m) & = -fey(D)^2 - m^2 \
  & = - gamma^mu D_mu gamma^nu D_nu - m^2 \
  & = 1/4 (4D_mu D_nu gamma^mu gamma^nu) -m^2 \
  cases("les termes en bleu", "sont ajouté,", " et s’annulent", delim: #none) "  " & = -1/4 [D_mu D_nu gamma^mu gamma^nu + #text(fill: blue)[$D_mu D_nu gamma^nu gamma^mu$] + #text(fill: blue)[$D_nu D_mu gamma^mu gamma^nu$] + D_nu D_mu gamma^nu gamma^mu \
    &"     "+ D_mu D_nu gamma^mu gamma^nu - #text(fill: blue)[$D_mu D_nu gamma^nu gamma^mu$] - #text(fill: blue)[$D_nu D_mu gamma^mu gamma^nu$] + D_nu D_mu gamma^nu gamma^mu] - m^2\
  &= -1/4 [(D_mu D_nu + D_nu D_mu)(gamma^mu gamma^nu + gamma^nu gamma^mu) + (D_mu D_nu - D_nu D_mu)(gamma^mu gamma^nu - gamma^nu gamma^mu)] - m^2\
  &= -1/4 {D_mu ; D_nu}{gamma^mu; gamma^nu} - 1/4 [D_mu; D_nu][gamma^mu; gamma^nu] - m^2
$<2.7.6>
Or on peut réécrire $[D_mu; D_nu]$ en fonction du tenseur $F_(mu nu) = partial_mu A_nu - partial_nu A_mu$, en effet :
$
  [D_mu; D_nu] & = [partial_mu - i q A_mu; partial_nu - i q A_nu] \
  & = (partial_mu - i q A_mu)(partial_nu - i q A_nu) - (partial_nu - i q A_nu)(partial_mu - i q A_mu) \
  & = cancel(partial_mu partial_nu) - i q partial_mu A_nu - i q A_mu partial_nu - cancel(q^2 A_mu A_nu) \
  & ""- cancel(partial_nu partial_mu) + i q partial_nu A_mu + i q A_nu partial_mu + cancel(q^2 A_nu A_mu) \
  & = -i q underbrace((partial_mu A_nu - partial_nu A_mu), = F_(mu nu)) {- i q (A_mu partial_nu - A_nu partial_mu )??}\
  &= -i q F_(mu nu)
$
Et comme nous avons :
$
  {gamma^mu; gamma^nu} = 2 eta^(mu nu);" "[gamma^mu; gamma^nu] = 4 S^(mu nu)
$
On peut, alors, réécrire @2.7.6 :
$
  (i fey(D) - m)(i fey(D) + m) & =-1/4 {D_mu ; D_nu}underbrace({gamma^mu; gamma^nu}, = 2 eta^(mu nu)) - 1/4 underbrace([D_mu; D_nu], = - i q F_(mu nu))underbrace([gamma^mu; gamma^nu], = 4 S^(mu nu)) - m^2\
  &=- 1/2 (D_mu D_nu eta^(mu nu) + D_nu D_mu eta^(mu nu)) + i q F_(mu nu) S^(mu nu) - m^2\
  &=- 1/2 underbrace((D_mu D^mu + D_nu D^nu), = 2 D_mu D^mu) + i q F_(mu nu) S^(mu nu) - m^2\
  &=- D_mu D^mu + i q F_(mu nu) S^(mu nu) - m^2\
$
On a, alors, l’équation suivante :
$
  (i fey(D) - m)(i fey(D) + m)psi = (- D_mu D^mu + i q F_(mu nu) S^(mu nu) - m^2)psi = 0
$
Soit finalement :
$
  (D_mu D^mu - i q F_(mu nu) S^(mu nu) + m^2)psi = 0
$

= Particules de spin 1 <spin1>

Dans ce chapitre nous allons nous intérer au particules de spin 1, plus particulièrement au photon, donc sans masse. On verras dans les deux dernier sous-chapitre le couplage avec les fermions et bosons.\

== Équation de Maxwel <maxweleq>

En l’absance de source, le lagrangien de Maxwel s’écrit :
$
  lagr = -1/4 F_(mu nu) F^(mu nu)
$
Où l’on défins $F_(mu nu)$ par :
$
  F_(mu nu) = partial_mu A_nu - partial_nu A_mu
$
On pourras noté que $F_(mu nu)$ est anti-symétrique\

*Propriété :* Identité de Bianchi
$
  partial_lambda F_(mu nu) + partial_mu F_(nu lambda) + partial_nu F_(lambda mu) = 0
$<Bianchi>
\
On peut dès à présent calculer l’équation du mouvement, on a d’une part :
$
  partial_mu ((partial lagr)/(partial (partial_mu A_nu))) &= - 1/4 partial_mu ((partial (partial_rho A_sigma - partial_sigma A_rho))/(partial (partial_mu A_nu))F^(rho sigma) + F_(rho sigma) times eta^(rho ateb) eta^(sigma alpha) (partial (partial_ateb A_alpha - partial_alpha A_ateb))/(partial (partial_mu A_nu)))\
  &= -1/4 partial_mu ((delta^mu""_rho delta^nu""_sigma - delta^mu""_sigma delta^nu""_rho)F^(rho sigma) + F^(ateb alpha)(delta^mu""_ateb delta^nu""_alpha - delta^mu""_alpha delta^nu""_ateb))\
  &= -1/4 partial_mu (F^(mu nu) - F^(nu mu) + F^(mu nu) - F^(nu mu))\
  &= - 1/4 times 4 partial_mu F^(mu nu)\
  &= - partial_mu F^(mu nu)
$
d’autre part on a :
$
  (partial lagr)/(partial A_nu) = 0
$
Ainsi par les équation d’Euler-Lagrange, on se retrouve avec :
$
  partial_mu F^(mu nu) = 0
$

Pour retrouver les équations de Maxwel classique, on définis le champs éléctrique et magnétique comme suit :\
*Définition :*
$
  arrow(E) = - nabla phi.alt - partial_t arrow(A) et arrow(B) = nabla and arrow(A)
$
Avec $A^mu = (phi.alt, arrow(A))$\
Soit en écriture tensorielle :
$
  E^i = partial^i A^0 -partial^0 A^i
$
$
  B^i = epsilon^(i j)""_k partial_j A^k
$
On peut alors écrire $F_(mu nu)$ à partir ce ces deux champs.\
*Propriété :*
$
  F_(mu nu) = mat(
    0, E^1, E^2, E^3;
    - E^1, 0, -B^3, B^2;
    -E^2, B^3, 0, -B^1;
    -E^3, -B^2, B^1, 0
  )
$\
\
*Preuve :*\
On a d’une part:
$
  F_(i 0) & = partial_i A_0 - partial_0 A_i \
          & = eta_(i k) partial^k A^0 - eta_(i k) partial^0 A^k \
          & = eta_(i k) underbrace((partial^k A^0 - partial^0 A^k), = E^k) \
          & = eta_(i k) E^k
$
Et d’autre part :
$
  F_(i j) &= partial_i A_j - partial_j A_i\
  &= delta^l""_i delta^m""_j partial_l A_m - delta^m""_i delta^l""_j partial_l A_m\
  &= underbrace((delta^l""_i delta^m""_j - delta^m""_i delta^l""_j), = epsilon_(i j k) epsilon^(k l m)) partial_l A_m\
  &= epsilon_(i j k) epsilon^(k l m) partial_l A_m\
  &= - epsilon_(i j k) underbrace(epsilon^(k l)""_m partial_l A^m, = B^k)\
  &= - epsilon_(i j k) B^k
$
Ainsi en regroupant les deux expréssion précédente dans un tableau, on arrive à la forme souhaité.
#QED
Dans les faits on utiliseras plus ces deux expréssion, au lieu du tableau, car plus aisé à manipulé algébriquement.\
\
Maintenant que nous avons définis nos champs éléctrique et magnétique, et que l’on à faits le liens avec $F_(mu nu)$, on va pouvoir dès à présent retrouvé nos équations de Maxwel classique.\
Dans un premier tant #link(<Bianchi>)[l’identité de Bianchi] nous permet de retrouvé :
$
  nabla dot.c arrow(B) = 0 et partial_t arrow(B) = - nabla and arrow(E)
$\
*Preuve* :\
Dans un premier tant, soit $lambda = 0, mu = i et nu = j$
Donc l’identité deviens :
$
  partial_0 F_(i j) + partial_i F_(j 0) + partial_j F_(0 i) & = - epsilon_(i j k) partial_0 B^k + eta_(j k) partial_i E^k - eta_(i k) partial_j E^k\
  &=- epsilon_(i j k) partial_0 B^k + (eta_(j k) partial_i - eta_(i k) partial_j) E^k\
  &=- epsilon_(i j k) partial_0 B^k + (delta^l""_j delta^m""_i - delta^l""_i delta^m""_j)eta_(l k) partial_m E^k\
  &=- epsilon_(i j k) partial_0 B^k - epsilon_(i j n) epsilon^(n m l) eta_(l k) partial_m E^k\
  &=- epsilon_(i j k) partial_0 B^k - epsilon_(i j k) epsilon^(k m)""_n partial_m E^n\
  &=- epsilon_(i j k) (partial_0 B^k + epsilon^(k m)""_n partial_m E^n) = 0\
$
Donc pour une permutation $(i j k)$ valide, on trouve
$
  partial_0 B^i + epsilon^(i k)""_l partial_k E^l = 0
$
On retrouve bien
$
  partial_t arrow(B) + nabla and arrow(E) = 0
$\
\
Ensuite en prenant $mu, nu, lambda in [|1; 3|]$ que l’on renome donc $i, j, k$, on obtient :
$
  partial_k F_(i j) + partial_i F_(j k) + partial_j F_(k i) &= - epsilon_(i j l) partial_k B^l - epsilon_(j k l) partial_i B^l - epsilon_(k i l) partial_j B^l\
  &= - (epsilon_(i j l) partial_k + epsilon_(j k l) partial_i + epsilon_(k i l) partial_j) B^l = 0
$<3.1.17>
Or, nous avons bien que $epsilon_(i j l) partial_k + epsilon_(j k l) partial_i + epsilon_(k i l) partial_j = epsilon_(i j k) partial_l$, en effet :\
\
$
  epsilon_(i j l) partial_k + epsilon_(j k l) partial_i + epsilon_(k i l) partial_j &= overbrace(6, = epsilon_(i j k) epsilon^(i j k))/6 (epsilon_(i j l) partial_k + epsilon_(j k l) partial_i + epsilon_(k i l) partial_j)\
  &= (epsilon_(i j k) epsilon^(i j k))/6 (epsilon_(i j l) partial_k + epsilon_(j k l) partial_i + epsilon_(k i l) partial_j)\
  &= (epsilon_(i j k) )/6 ( epsilon^(i j k) epsilon_(i j l) partial_k + epsilon^(i j k) epsilon_(j k l) partial_i + epsilon^(i j k) epsilon_(k i l) partial_j)\
  &= (epsilon_(i j k) )/6 ( underbrace(epsilon^(i j k) epsilon_(i j l), = 2 delta^k""_l) partial_k + underbrace(epsilon^(j k i) epsilon_(j k l), = 2 delta^i""_l) partial_i + underbrace(epsilon^(k i j) epsilon_(k i l), = 2 delta^j""_l) partial_j)\
  &= (epsilon_(i j k) )/6 ( 2 delta^k""_l partial_k + 2 delta^i""_l partial_i + 2 delta^j""_l partial_j)\
  &= (epsilon_(i j k) )/3 ( partial_l + partial_l + partial_l)\
  &= epsilon_(i j k) partial_l\
$
\
Donc @3.1.17 deviens :
$
  epsilon_(i j k) partial_l B^l = 0
$
Soit :
$
  partial_l B^l = 0
$
Donc on retrouve bien :
$
  nabla dot.c arrow(B) = 0
$
#QED

À l’aide de l’équatoin de mouvement, on peut retrouver :
$
  nabla dot.c arrow(E) = 0 et partial_t arrow(E) = nabla and arrow(B)
$\
*Preuve :*\
D’après l’équation du mouvement, on a d’une part pour $nu = i in [|1;3|]$ :
$
  partial_mu F^(mu i) &= partial_0 F^(0 i) + partial_l F^(l i)\
  &= - eta^(i l) partial_0 F_(l 0) + eta^(i k) eta^(l m) partial_l F_(m k)\
  &= - underbrace(eta^(i l) eta_(l k), = delta^i""_k) partial_0 E^k - epsilon_(m k n) eta^(i k) eta^(l m) partial_l B^n\
  &= - delta^i""_k partial_0 E^k + epsilon^(l i)""_n partial_l B^n\
  &= - partial_0 E^i + epsilon^(i l)""_n partial_l B^n = 0\
$
On retrouve bien ici :
$
  partial_t arrow(E) = nabla and arrow(B)
$\
Et d’autre part pour $nu = 0$ :
$
  partial_mu F^(mu 0) & = partial_0 overparen(F^(0 0), = 0) + partial_i F^(i 0) \
                      & = eta^(i j) partial_i F_(i 0) \
                      & = underbrace(eta^(i j) eta_(j k), = delta^i""_k) partial_i E^k \
                      & = delta^i""_k partial_i E^k \
                      & = partial_i E^i = 0
$
On retrouve bien la seconde équation chercher, i.e. $nabla dot.c arrow(E) = 0$
#QED
\
\
Étant donnée que le lagrangien ne dépend pas de $dot(A)^0$, alors la physique décrite n’est pas dynamique, donc pour un jeux de condition initial $A^i$ & $dot(A)^i$, la composante est entièrement determiné par\ $nabla dot.c arrow(E) = 0$, autrement dit par l’équation suivante :
$
  nabla dot.c arrow(E) & = nabla dot.c (- nabla phi.alt - partial_t arrow(A)) \
                       & = - nabla^2 A^0 - nabla dot.c (partial_t arrow(A)) = 0
$
On obtient donc l’équation :
$
  nabla^2 A^0 + nabla dot.c (partial_t arrow(A)) = 0
$

== Couplage avec la matière

On va maintenant couplé l’éléctromagnétisme avec la matière, cecis à déjà été faits en partie dans le @scalaireele et le @spineurele. Écrivons alors un lagrangien qui couples $A_mu$ avec un champs de matière, on traitreras d’abord les fermions, des bosons séparément, pour ensuite les décrires dans un même lagrangien. Ici on peut donc prendre, par exemple, le lagrangien suivant :
$
  lagr = - 1/4 F_(mu nu)F^(mu nu) - j^mu A_mu
$
Où $j^mu$ est une certaine fontion de la matière. On peut, comme d’habitude, s’intéréser au équation du mouvement.\
On à donc d’une part :
$
  partial_mu ((partial lagr)/(partial (partial_mu A_nu))) &= - 1/4 partial_mu ((partial (partial_rho A_sigma - partial_sigma A_rho))/(partial (partial_mu A_nu))F^(rho sigma) + F_(rho sigma) times eta^(rho ateb) eta^(sigma alpha) (partial (partial_ateb A_alpha - partial_alpha A_ateb))/(partial (partial_mu A_nu)))\
  &= -1/4 partial_mu ((delta^mu""_rho delta^nu""_sigma - delta^mu""_sigma delta^nu""_rho)F^(rho sigma) + F^(ateb alpha)(delta^mu""_ateb delta^nu""_alpha - delta^mu""_alpha delta^nu""_ateb))\
  &= -1/4 partial_mu (F^(mu nu) - F^(nu mu) + F^(mu nu) - F^(nu mu))\
  &= - 1/4 times 4 partial_mu F^(mu nu)\
  &= - partial_mu F^(mu nu)
$<dF>
et d’autre part :
$
  (partial lagr)/(partial A_nu) = - j^nu
$
Donc d’après les équations d’Euler-Lagrange :
$
  partial_mu F^(mu nu) = j^nu
$ <eqsourceele>
Or on avais que
$
  partial_mu partial_nu F^(mu nu) = 0
$
Donc
$
  partial_mu j^mu = 0
$
Ainsi $j^mu$ doit être un courant conservé, fort heuresement, le théorème de Noether, nous donne relativement facilement des courant conservé.

=== fermion

Dans le cas des fermions, le théorème de Noether, nous avais donnée comme courant conservé $j^mu_V = dash(psi) gamma^mu psi$ et pour décrire également les fermions, on ajoute le lagrangien de Dirac, à celui que l’on est entrain de reconstruire, ainsi le lagrangien deviens :
$
  lagr = -1/4 F_(mu nu) F^(mu nu) + dash(psi) (i fey(partial) - m) psi - q dash(psi) gamma^mu A_mu psi
$

Dans le @scalaireele, on avais introduis une nouvelle dérivé : la dérivé covariante $D_mu = partial_mu + i q A_mu$, ici définis avec un $+$ ce qui ne change rien, ce signe peut être absorbé par la constante $q$, que l’on va pouvoir faire apparait dans notre lagrangien :
$
  lagr & = -1/4 F_(mu nu) F^(mu nu) + dash(psi) (i fey(partial) - m) psi - q dash(psi) gamma^mu A_mu psi \
       & = -1/4 F_(mu nu) F^(mu nu) + dash(psi) (i fey(partial) - m - q gamma^mu A_mu) psi \
       & = -1/4 F_(mu nu) F^(mu nu) + dash(psi) (i gamma^mu underbrace((partial + i q A_mu), = D_mu) - m) psi \
       & = -1/4 F_(mu nu) F^(mu nu) + dash(psi) (i fey(D) - m) psi \
$
Donc comme l’on avais démontré dans le @scalaireele, ce lagrangien est donc invariant pour le groupe $upright(U)(1)$ et par la transformation $A_mu --> A_mu - partial_mu chi$\
\
L’équation du mouvement s’écrit alors sous ce lagrangien :
$
  partial_mu F^(mu nu) = dash(psi) gamma^nu psi
$

\
\
*Définition :* On appelle #text(style: "italic")[matrice de charge conjugé] la matrice $C in M_4 (CC)$ tel que
$
  C^dagger C = 1
$
$
  C^dagger gamma^mu C = - (gamma^mu)^star
$\
\
*Définition :* On appelle spineur de #text(style: "italic")[charge conjugé], le spineur $psi^((c)) = C psi^star$\
\
*Propriété :* le spineur de charge conjugé se transforme comme il faut, par une transformation de Lorentz.\
\
*Preuve :*
$
  psi'^((c)) = C (psi')^star = C S[Lambda]^star psi^star = S[Lambda] C psi^star = S[Lambda] psi^((c))
$
#QED
\
Il est évidant que l’équation du mouvement pour $psi$ reste l’équation de Dirac, écrit avec la dérivé covariante, car le termes $F_(mu nu)F^(mu nu)$ est indépendantes de $psi$, on peut regardé ce que deviens cette équation quand on passe au conjugé :
$
  (i gamma^mu partial_mu - q gamma^mu A_mu - m) psi = 0 &==> ((i gamma^mu partial_mu - q gamma^mu A_mu - m) psi)^star = 0\
  &==> (- i (gamma^mu)^star partial_mu - q (gamma^mu)^star A_mu - m) psi^star = 0\
$
Ainsi en utilisant la matrice de charge conjugé définis plus ci-dessus, on obtient (ce qui donne tout le sens au nom de $C$) :
$
  (i C^dagger gamma^mu C partial_mu + q C^dagger gamma^mu C A_mu - m) psi^star &= C^dagger (i gamma^mu partial_mu + q gamma^mu A_mu - m) underbrace(C psi^star, = psi^((c))) = 0
$
Donc en multipliant à gauche des deux cotés de l’équation par $C$, et comme $C C^dagger = 1$, alors :
$
  (i gamma^mu partial_mu + q gamma^mu A_mu - m) psi^((c)) = 0
$
On remarque que $psi^((c))$ respecte l’équation de Dirac, mais avec une charge $+ q$ au lieu de $- q$.

=== Couplage avec un champs scalaire (spin $0$) <couplagespin0>

Ce couplage à déjà été traité en grande partie dans le @scalaireele, on nous avions démontré que que dans ce cas le lagrangien, juste les champs scalaire et l’interaction sans pour autant décrire les photons, on avais le lagrangien suivant :
$
  lagr = D_mu phi.alt D^mu phi.alt^star - m phi.alt phi.alt^star
$
Donc ici il ne manque plus que la déscription du photon luis même, il suffie de rajouter le lagrangien du photon libre, i.e. rajouter le terme $-1/4 F_(mu nu)F^(mu nu)$, ainsi le lagrangien deviens :
$
  lagr = - 1/4 F_(mu nu)F^(mu nu) + D_mu phi.alt D^mu phi.alt^star - m phi.alt phi.alt^star
$
Où les équations du mouvement reste les même pour $phi.alt$, avec juste la dérivé covariante à la place de la dérivé usuel. Pour $A^mu$, on a toujours que
$
  partial_mu ((partial lagr)/(partial (partial_mu A_mu))) = - partial_mu F^(mu nu)
$
Mais la dérivé par rapport à $A_mu$ n’est plus nul, en effet :
$
  (partial lagr)/(partial A_nu) &= (partial (D_mu phi.alt))/(partial A_nu) D^mu phi.alt^star + D_mu phi.alt (partial (D^mu phi.alt^star))/(partial A_nu)\
  &= - i q underbrace((partial A_mu)/(partial A_nu), = delta^nu""_mu) phi.alt D^mu phi.alt^star - i q D_mu phi.alt eta^(mu alpha) underbrace((partial A_alpha)/(partial A_nu), = delta^nu""_alpha) phi.alt^star\
  &= - i q (delta^nu""_mu phi.alt D^mu phi.alt^star + D_mu phi.alt eta^(mu alpha) delta^nu""_alpha phi.alt^star)\
  &= - i q ( phi.alt D^nu phi.alt^star + phi.alt^star D^nu phi.alt)\
  &= - i q (phi.alt partial^nu phi.alt^star + phi.alt^star partial^nu phi.alt - i q A^nu phi.alt phi.alt^star - i q A^nu phi.alt phi.alt^star)\
  &= - i q (phi.alt partial^nu phi.alt^star + phi.alt^star partial^nu phi.alt) - 2 q^2 A^nu phi.alt phi.alt^star\
$
ainsi on obtient l’équation du mouvement suivante pour $A_mu$ :
$
  partial_mu F^(mu nu) = i q ( phi.alt D^nu phi.alt^star + phi.alt^star D^nu phi.alt)
$

*N.B. :* On aurais put retrouvé ce résulta plus rapidement en utilisant l’expression du courant trouvé dans le @scalaireele : $J^mu = - i q ( phi.alt D^nu phi.alt^star + phi.alt^star D^nu phi.alt)$, réécrit ici avec les dérivé covariante pour respecté la symétrie locale $upright(U)(1)$, et @eqsourceele : $- partial_mu F^(mu nu) = j^nu$

=== « Je vous prendrais bien $1$ photons, $3$ fermion et $1$ champs scalaire. s’il vous plaît »

Le but de cette section est d’écrire un lagrangien qui dériras, comme le titre l’indique si bien :\
#set list(indent: 1cm, spacing: 5mm)
\
- $1$ photon $==> lagr_p = -1/4 F_(mu nu)F^(mu nu)$
- $3$ fermion nomé $psi_i$ pour $i in [|1;3|] ==> lagr_i = dash(psi_i) (i fey(partial) -m_i) psi_i$
- $1$ champs scalaire $==> lagr_s = partial_mu phi.alt partial^mu phi.alt^star - m_s^2 phi.alt phi.alt^star$
\
\
Ainsi pour pour écrire le lagrangien qui correspond au modèle voulus, il suffie d’ajouté le lagrangien pour chaqu’une des particules, en les considérant libre (sans intéraction), voulus, en ajoutant les termes d’intération. Ici on ne décrira pas l’intéraction entre les fermions et le champs scalaire, on dérira seulement les intéraction éléctromagnétique, i.e. entre le photons et les fermions et entre le photon et le champs scalaire, et aucune interaction entre les fermions. Dans ce cadre, nos termes de couplage s’écrivent :
\
\
- Interaction photon - fermion : $forall i in [|1;3|], q_i dash(psi)_i gamma^mu A_mu psi_i$ où $q_i$ est la charge de chaqu’un de nos fermions
- interaction photon - champs scalaire : $- i q_s (phi.alt A_mu partial^mu phi.alt^star + phi.alt^star A_mu partial^mu phi.alt) - phi.alt phi.alt^star q_s^2 A^mu A_mu$ où $q_s$ est la charge de la particule décrit par le champs scalaire
\
*N.B. :* pour rajouter les couplages entre fermion il faudrais rajouter les termes $forall i,j in [|1;3|], i != j => dash(psi)_i (i fey(D) - m) psi_j$, et pour les couplages entre fermion et champs scalaire, il faudrais ajouté des termes du genre $forall i in [|1;3|], dash(psi)_i phi.alt psi_i$
\
\
Pour savoir quel termes, on a le droit de mettre ou non dans le lagrangien, on peut regarder ce que l’on appelle #text(style: "italic")[la dimension massique]. En effet l’action est, ici, sans dimmension, dût au faits que l’on s’est placé dans le système d’unité naturelle, en effet $[S] = [h] = 1$. Ainsi comme l’on intègre notre densité lagrangienne sur une longueure, autrement dit sur l’inverse d’une masse, alors notre densité lagrangienne doit avoir la dimension suivante : $[cal(L)] = upright(M)^4$, ainsi chaqu’un de nos termes doivent avoir cette même dimension. Attention on peut tout de même ajouter des termes de dimension différentes à condition d’avoir un coefficient dont la dimension compense, e.g. : le termes $partial_mu phi.alt partial^mu phi.alt^star$ doit être de dimension $4$, or une dérivé est de dimension $[partial_mu] = upright(L)^(-1) = upright(M)$, donc $[partial_mu phi.alt partial^mu phi.alt^star] = [phi.alt]^2 upright(M)^2 = upright(M)^4$, donc $[phi.alt] = upright(M)^1$. Ainsi le second termes $m_s^2 phi.alt phi.alt^star$ nous donne : $[m_s]^2 upright(M)^2 = upright(M)^4$, soit $[m_s] = upright(M)$, on a donc, en effet, que le coefficient $m_s$ à bien la dimension d’une masse (ce qui pour cette exemple étais relativement évident).\
Pour plus de practicité, on travaille en réalité directement sur les exposants, i.e. que au lieu de $[phi.alt]^2 upright(M)^2 = upright(M)^4$, on écrirat directement $2 times [phi.alt] + 2 = 4$. Ce qui reviens à faire le calcul sur logarithme des grandeurs au lieu des grandeurs elle même (en effet $ln([phi.alt]^2 upright(M)^2) = ln(upright(M)^4) <=> 2 ln([phi.alt]) + 2 = 4$, en posant $ln(upright(M)) = 1$). C’est ce nombre (le logarithme de la grandeur dans les unités naturelle) que l’on nomme #text(style: "italic")[dimension massique]. \
En petite règle pour le calcul mentale, on pourra noté que le produit deviens une somme, et que la puissance un produit, pour la somme il faut que celà respecte la même condition que en analyse dimensionelle, i.e. que les deux termes de la somme doivent avoir la même dimension massique.
\
\
Revenons à la construiction de notre lagrangien.\
Comme nous l’avons montré dans les différents chapitres correspondant (@scalaireele et @spineurele), celà reviens en réalité à réécrire les différents lagrangien à l’aide de la dérivé covariantes. On feras attention, au faits que la dérivé covariante dépend du champs quelle dérive, en effet ici nous avons 4 charge $q$ différentes alors on auras de manière générale : $D_mu B_i = partial_mu B_i - i q_i A_mu B_i$ (on ferra gaffe à l’indice $i$ sur $q$). En combinant tout ce que nous venons de dire, on peut enfin écrire notre lagrangien dans la forme suivante :
$
  lagr = - 1/4 F_(mu nu)F^(mu nu) + D_(mu) phi.alt D^(mu) phi.alt^star - m_s^2 phi.alt phi.alt^star + sum_(i = 1)^3 dash(psi)_i (i fey(D) - m_i) psi_i
$
Comme à l’acoutumé, on pourras déduire les équations de mouvement pour chaque champs. Pour tout les champs fermionique et scalaire, leur équations du mouvement sont inchangé (à la dérivé covariante près) car $F_(mu nu)F^(mu nu)$ ne dépende pas de ces champs et qu’il n’y a pas de termes de couplage entre les différents champs. Cependant, l’équation du mouvement pour le photon, va changé, en effet on va rajouter des termes de source :
$
  (partial lagr)/(partial A_mu) &= underbrace((partial (D_nu phi.alt D^nu phi.alt^star))/(partial A_mu), = - i q_s ( phi.alt D^mu phi.alt^star + phi.alt^star D^mu phi.alt)\ #[voir @couplagespin0]) + sum_(i = 1)^3 (partial (dash(psi)_i (i fey(D) - m_i)psi_i))/(partial A_mu)\
  &= - i q_s ( phi.alt D^mu phi.alt^star + phi.alt^star D^mu phi.alt) + sum_(i = 1)^3 q_i dash(psi)_i gamma^nu underbrace((partial A_nu )/(partial A_mu), = delta^mu""_nu) psi_i\
  &= - i q_s ( phi.alt D^mu phi.alt^star + phi.alt^star D^mu phi.alt) + sum_(i = 1)^3 q_i dash(psi)_i gamma^mu psi_i\
$
On à déjà calculer plusieur fois $partial_mu ((partial lagr)/(partial (partial_mu A_nu)))= - partial_mu F^(mu nu)$ (voir @dF).\
Ainsi par l’équation d’Euler-Lagrange :
$
  partial_mu F^(mu nu) = i q_s ( phi.alt D^nu phi.alt^star + phi.alt^star D^nu phi.alt) - sum_(i = 1)^3 q_i dash(psi)_i gamma^nu psi_i\
$\

Pour résumé, on présente le tableau ci-dessous, qui donne pour chaque champs (particules) sont équation du mouvement :
#set table.cell(inset: 4mm)
#align(
  center,
  figure(
    table(
      columns: 2,
      align: center + horizon,
      stroke: (x, y) => (
        left: if x > 0 { 0.8pt },
        top: if y > 0 { 0.8pt },
      ),
      table.header([Champs / particules], [Équation du\ mouvement]),
      [champs scalaire], $D_mu D^mu phi.alt + m^2 phi.alt = 0$,
      [fermions], $forall i in [|1, 3|]\ (i fey(D) - m_i) psi_i = 0$,
      [photons],
      $partial_mu F^(mu nu) &= i q_s ( phi.alt D^nu phi.alt^star + phi.alt^star D^nu phi.alt)\ &- sum_(i = 1)^3 q_i dash(psi)_i gamma^nu psi_i$,
    ),
    caption: [Résumé des équations de mouvement\ pour les différentes particules décrite],
  ),
)

*N.B. :* On pourrais réécrire l’équation de mouvement pour le photon avec les courant de Noether, en effet nous avons $j^nu_(V, i) = q_i dash(psi)_i gamma^mu psi_i$ et $J^mu_s = i q_s ( phi.alt D^nu phi.alt^star + phi.alt^star D^nu phi.alt)$, et donc on aurais : $partial_mu F^mu nu = J^nu_s - sum_(i = 1)^3 j^nu_(V,i)$. De plus on a volontairement omis les équations pour $phi.alt^star$ et $dash(psi)$, car il seraits simple de les retrouvé à partir des lagrangiens sans couplage (i.e. remplacer la dérivé par une dérivé covariante).
\
\
On va également s’intéréser à l’energie de notre système, pour celà, comme décrit au @TenseurEP, l’energie vaut la composante $0 0$ du tenseur energie-impulsion, alors :
$
  cal(E) &= T^0""_(0) = (partial lagr)/(partial dot(A)_mu) dot(A)_mu + (partial lagr)/(partial dot(phi.alt)) dot(phi.alt) + (partial lagr)/(partial dot(phi.alt^star)) dot(phi.alt^star) + sum_(i = 1)^3 (partial lagr)/(partial dot(psi_i)) dot(psi_i) - lagr\
  &= - partial_t underbrace(F^(0 mu), = cases(-E^i &"si" mu != 0, 0 &"sinon")) partial_t A_mu + (partial_t dot(phi.alt) + partial_t dot(phi.alt)^star) dot(phi.alt) + (partial_t dot(phi.alt) + partial_t dot(phi.alt^star)) dot(phi.alt)^star + i sum_(i = 1)^3 dash(psi)_i gamma^0 - lagr\
  &= partial_t E^i partial_t A_i + (partial_t dot(phi.alt) + partial_t dot(phi.alt^star))(dot(phi.alt) + dot(phi.alt)^star) + i sum_(i = 1)^3 dash(psi)_i gamma^0 - lagr\
$
Donc en posant $Phi = phi.alt + phi.alt^star$, on trouve :
$
  cal(E) & = partial_t E^i partial_t A_i + Phi partial_t Phi + i sum_(i = 1)^3 dash(psi)_i gamma^0 - lagr \
         & = partial_t E^i partial_t A_i +1/2 partial_t (Phi^2) + i sum_(i = 1)^3 dash(psi)_i gamma^0 - lagr \
$

#pagebreak()

#align(center, text(weight: "bold", 30pt)[
  Chapitre II\
  #text(25pt)[
    Théorie Quantique \
    des champs
  ]
])

On va maintenant décrire toute la théorie précédente (classique) mais dans un cadre quantique, i.e. que l’on va #text(style: "italic")[quantifié] certaine grandeurs.\
On va donc pour celà réécrire la mécanique Hamiltonienne dans le cas des champs, pour enfin retraité les différents champs du chapitre I.

= Théorie Hamiltonienne des champs

Ce chapitre, bien que relativement court, a tout de même sont lot d’importance, car nous allons généralisé la théorie lagrangienne des champs (cf. @lagrchamps) à la théorie hamiltonienne des champs.\
Dans la version classique de ces théorie, l’on passe de l’une à l’autre, en définisant un moment conjugé $p_i = partial L\/ partial dot(q_i)$, on va donc chercher un équivalent pour nos champs, un #text(style: "italic")[champs conjugé]. Dans la théorie lagrangien que l’on a dévelopé, on peut prendre $dot(phi.alt_i)$ comme équivalent à $dot(q_i)$, ainsi :
$
  p &= (partial L)/(partial dot(phi.alt)) = partial/(partial dot(phi.alt)) integral dif y^3 cal(L)(phi.alt(y), dot(phi.alt)(y))\
  &= integral dif y^3 (partial lagr)/(partial dot(phi.alt))
$
Ainsi comme pour le lagrangien on définis la densité de moment conjugé par :
$
  p = integral dx^3 pi(x)
$
Et donc en identifiant, on trouve :
$
  pi = (partial lagr)/(partial dot(phi.alt))
$
On peut maintenant généralisé notre hamiltonien aux champs. Classiquement on à :
$
  H = sum_i p_i dot(q)_i - L
$
Or dans notre cas $dot(q)_i = dot(phi.alt)_i$, donc en remplacant $p_i$ et $L$ par leur densité éponyme.
$
  H & = sum_i (integral dx^3 pi_i (x)) dot(phi.alt)_i - integral dx^3 lagr \
    & = integral dx^3 (sum_i pi_i dot(phi.alt)_i - lagr)
$
Ainsi on peut, encore une fois, définir une densité hamiltonienne $cal(H)$ par :
$
  H = integral dx^3 ham
$
Donc finalement :
$
  ham = sum_i pi_i dot(phi.alt)_i - lagr
$

== Équation d’Hamilton

= Quantification du champs scalaire

Pour décrire la théorie dévelopé au @spin0, dans une théorie quantique, il nous faut la #text(style: "italic")[quantifier], pour celà on repart de notre théorie classique que l’on (spoileur alert) #text(style: "italic")[quantifie], i.e. que l’on réeinterprette les variables comme des opérateur qui respecte des relation de commutation. Enfin on étudie les vecteurs et valeurs propre de l’Hamiltonien.\
Dans un système discret, on peut écrire les relation de commutation entre les variables comme :
$
  [p_i, q_j] = i delta_(i j)\
  [p_i, p_j] = [q_i, q_j] = 0
$
Ainsi pour un sytème continue, on généralise le delta de Kronecker par un delta de Dirac, donc pour $phi.alt et pi$ on obtient la relation suivante :
$
  [phi.alt (arrow(x)), pi(arrow(y))] = i delta(arrow(x) - arrow(y))
$ <commutateurphipi>
$
  [phi.alt (arrow(x)), phi.alt (arrow(y))] = [pi (arrow(x)), pi(arrow(y))] = 0
$
\
Comme en mécanique quantique classique, on décomposer $phi.alt$ en une base de Fourier. En analogie à la mécanique classique, où $phi.alt_"c" = 1/sqrt(2 E) (a + a^dagger)$, on décompose $phi.alt$ en deux modes de Fourier indépendants
$
  phi.alt = integral (dif^3 arrow(p))/((2 pi)^3) 1/sqrt(2 E_arrow(p)) (a_arrow(p) e^(i arrow(p) dot.c arrow(x)) + a^dagger_arrow(p) e^(- i arrow(p) dot.c arrow(x)))
$
En partant de l’écriture du lagrangien pour le champs scalaire que l’on considérons comme réél pour cette partie (i.e. : $lagr = 1/2 partial_mu phi.alt partial^mu phi.alt - 1/2 m^2 phi.alt^2$). On peut en déduire la forme de $pi$ :
$
  pi = (partial lagr)/(partial dot(phi.alt)) = 1/2 (partial (partial_mu phi.alt partial^mu phi.alt))/(partial dot(phi.alt)) = dot(phi.alt)
$
Donc en utilisant la décomposition de $phi.alt$, on peut trouver celle de $pi$ :
$
  pi = integral (dif^3 arrow(p))/((2 pi)^3) 1/sqrt(2 E_arrow(p)) (a_arrow(p) (partial e^(i arrow(p) dot.c arrow(x)))/(partial t) + a^dagger_arrow(p) (partial e^(-i arrow(p) dot.c arrow(x)))/(partial t))
$
Or comme $arrow(p) = (E_arrow(p), p^1, p^2, p^3) = (E_arrow(p), p^i)$ et $arrow(x) = (t, x^i)$, alors\
\
$
  partial_alpha e^(i arrow(p) dot.c arrow(x)) = i partial_alpha eta_(mu nu) p^mu x^nu e^(i arrow(p) dot.c arrow(x)) = i eta_(mu nu) p^mu underbrace(partial_alpha x^nu, = delta^alpha""_nu) e^(i arrow(p) dot.c arrow(x)) = i eta_(mu alpha) p^mu = i p_alpha e^(i arrow(p) dot.c arrow(x))
$
Donc $partial_0 e^(i arrow(p) dot.c arrow(p)) = (partial e^(i arrow(p) dot.c arrow(x)))/(partial t) = i p_0 e^(i arrow(p) dot.c arrow(x)) = i E_arrow(p) e^(i arrow(p) dot.c arrow(x))$, de même $partial_0 e^(- i arrow(p) dot.c arrow(p)) = - i E_arrow(p) e^(-i arrow(p) dot.c arrow(x))$, ainsi :
$
  pi &= integral (dif^3 arrow(p))/((2 pi)^3) 1/sqrt(2 E_arrow(p)) (i a_arrow(p) E_arrow(p) e^(i arrow(p) dot.c arrow(x)) - i E_arrow(p) a^dagger_arrow(p) e^(-i arrow(p) dot.c arrow(x)) )\
  &= integral (dif^3 arrow(p))/((2 pi)^3) i sqrt(E_arrow(p)/2) (a_arrow(p) e^(i arrow(p) dot.c arrow(x)) - a^dagger_arrow(p) e^(-i arrow(p) dot.c arrow(x)) )\
$
Il sera plus simple pour le calcule que $phi.alt et pi$ soit vue comme une onde plane, i.e. avec juste un seul facteur $e^(i arrow(p) dot.c arrow(x))$, on peut donc forcé cette forme en réécrivant le coefficient $a^dagger_arrow(p)$. On obtient donc les formes suivantes :
$
  phi.alt = integral (dif^3 arrow(p))/((2 pi)^3) 1/sqrt(2 E_arrow(p)) (a_arrow(p) + a^dagger_(- arrow(p))) e^(i arrow(p) dot.c arrow(x))
$
$
  pi = integral (dif^3 arrow(p))/((2 pi)^3) i sqrt(E_arrow(p)/2) (a_arrow(p) - a^dagger_(- arrow(p))) e^(i arrow(p) dot.c arrow(x))
$
À partire de ces formes et de la condition sur leur comuntateur (@commutateurphipi), on peut prouvé la propriété suivantes :\
*Propriété :*
#{
  set math.equation(numbering: none)
  align(center, grid(
    columns: 3,
    column-gutter: 1cm,
    row-gutter: 1mm,
    $
      [phi.alt(arrow(x)); pi(arrow(y))] = i delta(arrow(x) - arrow(y))
    $,
    [],
    $
      [a_arrow(p); a^dagger_arrow(q)] = (2 pi)^3 delta(arrow(p) - arrow(q))
    $,

    [],
    $
      <==>
    $,
    [],

    $
      [phi.alt(arrow(x)); phi.alt (arrow(y))] = [pi (arrow(x)); pi(arrow(y))] = 0
    $,
    [],
    $ [a_(arrow(p)); a_(arrow(q))] = [a^dagger_(arrow(p)); a^dagger_(arrow(q))] = 0 $,
  ))
}
*Preuve :*
On ne prouveras ici que l’implication dans le sens $<==$, l’autre sens étant trop long et complexe pour être détaillé ici.\
On suposse donc :
$
  [a_arrow(p); a^dagger_arrow(q)] = (2pi)^3 delta(arrow(p) - arrow(q))\
  [a_arrow(p); a_arrow(q)] = [a^dagger_arrow(p); a^dagger_arrow(q)] = 0\
$
alors

$
  [phi.alt(arrow(x)); pi (arrow(arrow(y)))] &= integral (dif^3 arrow(p) dif^3 arrow(q))/(2 pi)^6 ((-i))/2 sqrt(E_arrow(q)/E_arrow(p)) e^(i (arrow(p) dot.c arrow(x) + arrow(q) dot.c arrow(y))) [a_arrow(p) + a^dagger_(- arrow(p)) ; a_arrow(q) - a^dagger_(-arrow(q))]\
  &= integral (dif^3 arrow(p) dif^3 arrow(q))/(2 pi)^6 ((-i))/2 sqrt(E_arrow(q)/E_arrow(p)) e^(i (arrow(p) dot.c arrow(x) + arrow(q) dot.c arrow(y))) (underbrace([a_arrow(p); a_arrow(q)], = 0) - underbrace([a_arrow(p); a^dagger_(-arrow(q))], = (2pi)^3 delta(arrow(p) - arrow(q))) + underbrace([a^dagger_(-arrow(p)); a_arrow(q)], = - (2pi)^3 delta(arrow(q) - arrow(p))) - underbrace([a^dagger_(-arrow(p)); a^dagger_(- arrow(q))], = 0))\
  &= integral (dif^3 arrow(p) dif^3 arrow(q))/(2 pi)^6 ((-i))/2 sqrt(E_arrow(q)/E_arrow(p)) e^(i (arrow(p) dot.c arrow(x) + arrow(q) dot.c arrow(y))) ( (2pi)^3 delta(arrow(p) - arrow(q)) +(2pi)^3 delta(arrow(q) - arrow(p)))\
  &= i integral (dif^3 arrow(p) dif^3 arrow(q))/(2 pi)^3 1/2 sqrt(E_arrow(q)/E_arrow(p)) e^(i (arrow(p) dot.c arrow(x) + arrow(q) dot.c arrow(y))) ( delta(arrow(p) - arrow(q)) + delta(arrow(p) - arrow(q)))\
  &= i integral (dif^3 arrow(p) dif^3 arrow(q))/(2 pi)^3 sqrt(E_arrow(q)/E_arrow(p)) e^(i (arrow(p) dot.c arrow(x) + arrow(q) dot.c arrow(y))) delta(arrow(p) - arrow(q))\
  #box($arrow(p) = arrow(q)\ donc E_arrow(p) = E_arrow(q)$) &= i integral (dif^3 arrow(p))/(2 pi)^3 e^(i arrow(p) dot.c (arrow(x) + arrow(y)))\
  &= i delta(arrow(x) - arrow(y))\
$
#QED\
\
Avant d’écrire l’Hamiltonien, on peut réécrire le lagrangien avec comme variable $phi.alt et pi$ :
$
  lagr & = 1/2 partial_mu phi.alt partial^mu phi.alt - 1/2 m^2 phi.alt^2 \
  lagr & = 1/2 partial_0 phi.alt partial^0 phi.alt + partial_i phi.alt partial^i phi.alt - 1/2 m^2 phi.alt^2 \
  lagr & = 1/2 dot(phi.alt)^2 - (nabla phi.alt)^2 - 1/2 m^2 phi.alt^2 \
  lagr & = 1/2 pi^2 - (nabla phi.alt)^2 - 1/2 m^2 phi.alt^2 \
$
On va maintenant pouvoir calculer l’Hamiltonien pour les champs scalaire, calculons d’abord la densité hamiltonienne :
$
  ham & = pi dot(phi.alt) - lagr \
  & = pi^2 - 1/2(pi^2 - (nabla phi.alt)^2 - m^2 phi.alt^2) \
  & = 1/2 pi^2 + 1/2 (nabla phi.alt)^2 + 1/2 m^2 phi.alt^2 \
  & = 1/2 pi(arrow(x)) pi(arrow(x)) + 1/2 nabla phi.alt(arrow(x)) nabla phi.alt(arrow(x)) + 1/2 m^2 phi.alt(x) phi.alt(x) \
  & = 1/2 integral (dif^3 arrow(p) dif^3 arrow(q))/(2pi)^6 { - sqrt(E_arrow(p) E_arrow(q))/2 (a_arrow(p) - a^dagger_(- arrow(p))) (a_arrow(q) - a^dagger_(- arrow(q))) e^(i (arrow(p) + arrow(q)) dot.c arrow(x)) - (arrow(p) dot.c arrow(q))/(2 sqrt(E_arrow(p) E_arrow(q))) (a_arrow(p) + a^dagger_(- arrow(p))) (a_arrow(q) + a^dagger_(- arrow(q))) e^(i (arrow(p) + arrow(q)) dot.c arrow(x))\
    &#h(9.47cm)+ m^2/(2 sqrt(E_arrow(p) E_arrow(q)))(a_arrow(p) + a^dagger_(- arrow(p))) (a_arrow(q) + a^dagger_(- arrow(q))) e^(i (arrow(p) + arrow(q)) dot.c arrow(x))} \
  & = 1/4 integral (dif^3 arrow(p) dif^3 arrow(q))/(2pi)^6 e^(i (arrow(p) + arrow(q)) dot.c arrow(x)) { - sqrt(E_arrow(p) E_arrow(q)) (a_arrow(p) - a^dagger_(- arrow(p))) (a_arrow(q) - a^dagger_(- arrow(q)))\
    &#h(7cm) + ( - arrow(p) dot.c arrow(q) + m^2)/(sqrt(E_arrow(p) E_arrow(q))) (a_arrow(p) + a^dagger_(- arrow(p))) (a_arrow(q) + a^dagger_(- arrow(q)))} \
$
Ainsi on peut calculer l’Hamiltonien :
$
  H & = integral dif^3 arrow(x) cal(H) \
  & = 1/4 integral dif^3 arrow(x) integral (dif^3 arrow(p) dif^3 arrow(q))/(2pi)^6 e^(i (arrow(p) + arrow(q)) dot.c arrow(x)) lr({dots.c}, size: #220%) \
  & = 1/4 integral (dif^3 arrow(p) dif^3 arrow(q))/(2pi)^3 underbrace(integral (dif^3 arrow(x))/(2pi)^3 e^(i (arrow(p) + arrow(q)) dot.c arrow(x)), = delta(arrow(p) + arrow(q))) lr({dots.c}, size: #220%) \
  & = 1/4 integral (dif^3 arrow(p) dif^3 arrow(q))/(2pi)^3 delta(arrow(p) + arrow(q)) lr({dots.c}, size: #220%) \
  #box([$arrow(q) -> - arrow(p)$\ comme $E_arrow(p)^2 prop arrow(p)^2$\ donc $E_(- arrow(p)) = E_arrow(p)$]) #h(1cm)& = 1/4 integral (dif^3 arrow(p))/(2pi)^3 {- E_arrow(p) (a_arrow(p) - a^dagger_(- arrow(p))) (a_( - arrow(p)) - a^dagger_(arrow(p))) + ( overparen(arrow(p)^2 + m^2, = E^2_arrow(p)))/(E_arrow(p)) (a_arrow(p) + a^dagger_(- arrow(p))) (a_( - arrow(p)) + a^dagger_(arrow(p)))} \
  & = 1/4 integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) { - (a_arrow(p) - a^dagger_(- arrow(p))) (a_( - arrow(p)) - a^dagger_(arrow(p))) + (a_arrow(p) + a^dagger_(- arrow(p))) (a_( - arrow(p)) + a^dagger_(arrow(p)))} \
  & = 1/4 integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) { - cancel(a_arrow(p) a_(- arrow(p))) + a_arrow(p) a^dagger_(arrow(p)) + a^dagger_(- arrow(p)) a_(- arrow(p)) - cancel(stroke: #blue, a^dagger_(-arrow(p)) a^dagger_arrow(p)) + cancel(a_arrow(p) a_(- arrow(p))) + a_arrow(p) a^dagger_arrow(p) + a^dagger_(-arrow(p)) a_(-arrow(p)) + cancel(stroke: #blue, a^dagger_(-arrow(p)) a^dagger_arrow(p))} \
  & = 1/4 integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) { 2 a_arrow(p) a^dagger_(arrow(p)) + 2 a^dagger_(- arrow(p)) a_(- arrow(p))} \
  & = 1/2 integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) a_arrow(p) a^dagger_(arrow(p)) + underbrace(1/2 integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) a^dagger_(- arrow(p)) a_(- arrow(p)), #[on opère le changement de variable\ $arrow(p) -> - arrow(p)$, un signe proviens de $dif^3 arrow(p)$\ un autre proviens de l’interversion\ des bornes de l’intégrale.]) \
  & = 1/2 integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) a_arrow(p) a^dagger_(arrow(p)) + 1/2 integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) a^dagger_(arrow(p)) a_(arrow(p)) \
  & = 1/4 integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) { 2 a_arrow(p) a^dagger_(arrow(p)) + 2 a^dagger_(arrow(p)) a_(arrow(p))} \
  & = 1/2 integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) {a_arrow(p) ; a^dagger_(arrow(p))} \
$
Or
$
  {A; B} & = A B + B A = B A + underbrace(A B - B A, = [A; B]) + B A \
         & = 2 B A + [A; B]
$
Ainsi l’Hamiltonien prend la forme suivante :
$
  H & = 1/2 integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) (2 a^dagger_arrow(p) a_arrow(p) + [a_arrow(p); a^dagger_(arrow(p))]) \
  & = integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) (a^dagger_arrow(p) a_arrow(p) + 1/2 [a_arrow(p); a^dagger_(arrow(p))]) \
$<offsetinf>
On noteras que le second termes est proportionelle à $delta(0)$, en effet $[a_arrow(p); a^dagger_(arrow(p))] = (2 pi)^3 delta(0)$, ainsi l’intégrale sur ce terme diverge. Ce qui physiquement « peut » poser problème. En faites, on peut faire disparaitre ce termes à l’aide d’argumement physique, bien que mathématiquements celà reste un immense point noir dans la théorie. Dans l’experience, on ne mesure toujours que en comparant avec le vide, que l’on pose à 0, pour des soucis de practicité. Ainsi on peut interprété ce terme infini comme un « #text(style: "italic")[offset] », un peut comme l’énergie potentielle qui elle aussi est définis à un offset près. Alors comme pour l’énergie potentielle, on peut décidé de retirer cette « #text(style: "italic")[offset] » infini. On peut donc réécrire l’Hamiltonien par :
$
  H = integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) a^dagger_arrow(p) a_arrow(p)
$
On peut regarder comment cette Hamiltonienne commute avec $a_arrow(p)$ & $a^dagger_arrow(p)$\
*Propriété :*
#grid(
  columns: 2,
  $
    [H, a_arrow(p)] = - E_arrow(p) a_arrow(p)
  $,
  $
    [H, a^dagger_arrow(p)] = E_arrow(p) a^dagger_arrow(p)
  $,
)
*Preuve :*
#grid(
  columns: 2,
  $
    [H, a_arrow(q)] &= integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) (a_arrow(q) a^dagger_arrow(p) a_arrow(p) - a^dagger_arrow(p) a_arrow(p) a_arrow(q))\
    &= integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) (a_arrow(q) a^dagger_arrow(p) a_arrow(p) - a^dagger_arrow(p) a_arrow(q) a_arrow(p))\
    &= integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) underbrace((a_arrow(q) a^dagger_arrow(p) - a^dagger_arrow(p) a_arrow(q)), = - (2pi)^3 delta(arrow(p) - arrow(q))) a_arrow(p)\
    &= - integral dif^3 arrow(p) E_arrow(p) delta(arrow(p) - arrow(q)) a_arrow(p)\
    &= - E_arrow(q) a_arrow(q)
  $,
  $
    [H, a^dagger_arrow(q)] &= integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) (a^dagger_arrow(q) a^dagger_arrow(p) a_arrow(p) - a^dagger_arrow(p) a_arrow(p) a^dagger_arrow(q))\
    &= integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) (a^dagger_arrow(p) a^dagger_arrow(q) a_arrow(p) - a^dagger_arrow(p) a_arrow(p) a^dagger_arrow(q))\
    &= integral (dif^3 arrow(p))/(2pi)^3 E_arrow(p) a^dagger_arrow(p) underbrace((a^dagger_arrow(q) a_arrow(p) - a_arrow(p) a^dagger_arrow(q)), = (2pi)^3 delta(arrow(p) - arrow(q)))\
    &= integral dif^3 arrow(p) E_arrow(p) delta(arrow(p) - arrow(q)) a^dagger_arrow(p)\
    &= E_arrow(q) a^dagger_arrow(q)
  $,
)
#QED

On peut opéré le même calcul que l’Hamiltonien, pour l’impulsion :\
*Propriété :*
$
  arrow(P) = integral (dif^3 p)/(2 pi)^3 arrow(p) a^dagger_arrow(p) a_arrow(p)
$

*Preuve :*\
En repartant de la définition donnée à @impulsion, nous avons d’abord que le tenseur énérgie impulsion s’écrit :
$
  T^i""_0 &= (partial lagr)/(partial (partial_i phi.alt)) underbrace(dot(phi.alt), = pi) - underbrace(delta^i""_0 lagr, = 0)\
  &= pi partial^i phi.alt = - pi partial_i phi.alt
$
Donc réécrit sous forme vectorielle, avec $arrow(T) = (T^i""_0)$  :
$
  arrow(P) = integral dx^3 arrow(T) = - integral dx^3 pi(arrow(x)) nabla phi.alt
$
En utilisant la décomposition en transformé de Fourier, on peut éxprimé l’impulsion en les $a_arrow(p) \& a^dagger_arrow(p)$ :
$
  arrow(P) &= - 1/2 integral dx^3 integral (dif^3 arrow(p) dif^3 arrow(q))/((2pi)^6) sqrt(E_arrow(p) / E_arrow(q)) (-i) times i arrow(q) (a_arrow(p) - a^dagger_(-arrow(p))) (a_arrow(q) + a^dagger_(-arrow(q))) e^(i (arrow(p) + arrow(q))dot.c arrow(x))\
  &= - 1/2 integral (dif^3 arrow(p) dif^3 arrow(q))/((2pi)^3) sqrt(E_arrow(p) / E_arrow(q))
  arrow(q) (a_arrow(p) - a^dagger_(-arrow(p))) (a_arrow(q) + a^dagger_(-arrow(q))) underbrace(integral (dx^3)/((2pi)^3) e^(i (arrow(p) + arrow(q))dot.c arrow(x)), = delta(arrow(p) + arrow(q)))\
  &= - 1/2 integral (dif^3 arrow(p) dif^3 arrow(q))/((2pi)^3) sqrt(E_arrow(p) / E_arrow(q)) arrow(q) (a_arrow(p) - a^dagger_(-arrow(p))) (a_arrow(q) + a^dagger_(-arrow(q))) delta(arrow(p) + arrow(q))\
  &= 1/2 integral (dif^3 arrow(p))/((2pi)^3) arrow(p) (a_(arrow(p)) - a^dagger_(-arrow(p))) (a_(- arrow(p)) + a^dagger_(arrow(p)))\
  &= 1/2 integral (dif^3 arrow(p))/((2pi)^3) arrow(p) (a_arrow(p) a_(- arrow(p)) + a_arrow(p) a^dagger_arrow(p) - a^dagger_(- arrow(p)) a_(- arrow(p)) - a^dagger_(-arrow(p)) a^dagger_arrow(p) )\
$
On peut montré aisément que $a_arrow(p) a_(-arrow(p))$ & $a^dagger_(-arrow(p)) a^dagger_arrow(p)$ sont des fonctions impaire sur $arrow(p)$, donc leurs intégrale est null, ainsi :
$
  arrow(P) &= 1/2 integral (dif^3 arrow(p))/((2 pi)^3) arrow(p) (a_arrow(p) a^dagger_arrow(p) - a^dagger_(- arrow(p)) a_(- arrow(p)))\
  arrow(P) &= 1/2 integral (dif^3 arrow(p))/((2 pi)^3) arrow(p) a_arrow(p) a^dagger_arrow(p) - underbrace(integral (dif^3 arrow(p))/((2 pi)^3) arrow(p) a^dagger_(- arrow(p)) a_(- arrow(p)), #[On opère le chamgement\ de variable $arrow(p) -> - arrow(p)$])\
  arrow(P) &= 1/2 integral (dif^3 arrow(p))/((2 pi)^3) arrow(p) a_arrow(p) a^dagger_arrow(p) + integral (dif^3 arrow(p))/((2 pi)^3) arrow(p) a^dagger_(arrow(p)) a_(arrow(p))\
  arrow(P) &= 1/2 integral (dif^3 arrow(p))/((2 pi)^3) arrow(p) (a_arrow(p) a^dagger_arrow(p) + a^dagger_(arrow(p)) a_(arrow(p)))\
  arrow(P) &= 1/2 integral (dif^3 arrow(p))/((2 pi)^3) arrow(p) {a_arrow(p); a^dagger_arrow(p)}\
  arrow(P) &= 1/2 integral (dif^3 arrow(p))/((2 pi)^3) arrow(p) (2 a^dagger_arrow(p) a_arrow(p) + [a_arrow(p); a^dagger_arrow(p)])\
  arrow(P) &= integral (dif^3 arrow(p))/((2 pi)^3) arrow(p) (a^dagger_arrow(p) a_arrow(p) + 1/2 [a_arrow(p); a^dagger_arrow(p)])\
$
Comme pour l’Hamiltonien, on retrouve « #text(style: "italic")[l’offset] » infini dû au commutateur de $a_arrow(p)$ et $a^dagger_arrow(p)$, donc par les même arguments que pour l’Hamiltonien, on peut omettre ce termes (cf. @offsetinf).#QED\
Similairement à l’Hamiltonien, on peut montré les deux relations suivantes :\
*Propriété :*\
\
#align(center, grid(
  columns: 2,
  $
    [arrow(P), a_arrow(q)] = - arrow(q) a_arrow(q)
  $,
  $
    [arrow(P), a^dagger_arrow(q)] = arrow(q) a^dagger_arrow(q)
  $,
))\
*Preuve :* Voir la preuve des pour les même relation que l’Hamiltonien (cf. #context { link(query(math.equation).at(679).location())[les équations (6.21) & (6.22)] })
\
Pour étudier la théorie que l’on viens d’écrire, on va définir l’état de référence, à savoir l’état du vide, d’énérgie $E = 0$ (quand l’on faits tombé $delta$ dans l’exprésion de l’Hamiltonien), ainsi on définis l’état du vide par :
\
*Définition :*\
#let vide = $ket(0)$
On appelle état du vide, et on le note $#ket(0)$, l’état tel que :
$
  forall arrow(p), a_arrow(p) vide = 0 et braket(0, 0) = 1
$\
\
Alors nous avons les deux importantes propriété suivantes :\
*Propriété :*
les états $a^dagger_arrow(p) vide$ sont des états propre (au sens de vecteur propre) de l’Hamiltonien $H$, de valeur propre $E_arrow(p)$, i.e. :
$
  H a^dagger_arrow(p) vide = E_arrow(p) a^dagger_arrow(p) vide
$
Et sont également états propre de l’impulsion $arrow(P)$, de valeurs propre $arrow(p)$, i.e :
$
  arrow(P) a^dagger_arrow(p) vide = arrow(p) a^dagger_arrow(p) vide
$
\
*Preuve :*\
Dans un permier tant, en partant de la relation #context { link(query(math.equation).at(678).location())[des équations (6.19) & (6.20)] }, on a :
$
  E_arrow(p) a^dagger_arrow(p) vide & = [H; a^dagger_arrow(p)] vide \
  & = H a^dagger_arrow(p) vide - a^dagger_arrow(p) H vide\
  &= H a^dagger_arrow(p) vide - cancel(a^dagger_arrow(p) integral (dif^3 arrow(p))/((2pi)^3) E_arrow(p) a^dagger_arrow(p) underbrace(a_arrow(p) vide, = 0))\
  &= H a^dagger_arrow(p) vide
$
Étant donnée que $arrow(P)$ vérifie exactement les même équations que $H$, alors il est simple de prouver la relation voulus.
#QED

#pagebreak()

#set heading(numbering: none)

= Conclusions
@Tong @Schwartz @Peskin

#pagebreak()

#bibliography("bibli.bib", title: [Bibliographie])

#pagebreak()

#set heading(supplement: [Annexe], numbering: (..nums) => {
  if nums.pos().len() == 2 {
    nums.pos().at(1)
  }
})

#align(center + horizon)[= Annexe]
