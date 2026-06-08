#import "../../../template.typ": *
#import "../../../transposition.typ": *
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot
#import "@preview/zebraw:0.6.1": *
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
      [#h(1cm * chapter.level) #link(loc)[#num #chapter.body] #box(width: 1fr, repeat[.]) #nr #v(
          2.5mm,
        ) ]
    } else if (chapter.level < 2 and num == none) {
      [#h(1cm * chapter.level) #link(loc)[#num #chapter.body] #box(width: 1fr, repeat[.]) #nr #v(2.5mm) ]
    }
  }
}

#pagebreak()

#show heading.where(body: [Introduction]): set heading(numbering: none)
= Introduction

#pagebreak()

= Théorie lagrangienne des champs

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

=== Exemple 1 : L’équation de Klein-Gordon

On se place dans l’espace de Minkovski, de métrique $eta_(mu nu) = eta^(mu nu) = "diag"(+, -, -, -)$, et que l’on considére le lagrangien suivant :
$
  lagr = 1/2 eta^(mu nu) partial_mu phi.alt partial_nu phi.alt - 1/2 m^2 phi.alt^2
$
Alors, nous avons :
$
  partial_mu ((partial lagr)/(partial(partial_mu phi.alt))) &= partial_mu (1/2 eta^(sigma nu)( underbrace((partial(partial_sigma phi.alt)) / (partial (partial_mu phi.alt)), = delta_(sigma)^mu) partial_nu phi.alt + underbrace((partial(partial_nu phi.alt)) / (partial(partial_mu phi.alt)), = delta_(nu)^mu) partial_sigma phi.alt))\
  &= partial_mu (1/2(underbrace(eta^(sigma nu) delta_sigma^(mu), = eta^(mu nu)) partial_nu phi.alt + underbrace(eta^(sigma nu) delta_nu^(mu), = eta^(sigma mu) = eta^(mu sigma)) partial_sigma phi.alt))\
  &= partial_mu (1/2 times 2 underbrace(eta^(mu nu) partial_nu phi.alt, = partial^mu phi.alt))\
  &= partial_mu partial^mu phi.alt
$
Et
$
  (partial lagr)/(partial phi.alt) = - m^2 phi.alt
$
Donc d’après @equlagr :
$
  partial_mu partial^mu phi.alt + m^2 phi.alt = 0
$

=== Exemple 2 : Équations de Maxwel
On propose dans cette exemple de retrouvé les équations de Maxwel dans le vide.\
Pour celà, on considére le lagrangien suivant :
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
des équations du mouvement, alors $phi.alt'(x) = phi.alt(Lambda^(-1)x)$ le soit aussi.\
On remarquera que l’exposant $-1$ est du au faits que l’on considère une transformation active

=== Exemple 1 : L’équation de Klein-Gordon
Regardons comment se comporte le lagrangien de notre premier exemple sous la transformation :
$
  phi.alt(x) --> phi.alt'(x) = phi.alt(Lambda^(-1)x)
$
alors :
$
  partial_mu phi.alt(x) --> (Lambda^(-1))^nu""_mu partial_nu phi.alt(y)
$
où $y = Lambda^(-1) x$, ainsi, le lagrangien deviens sous cette transformation :
$
  lagr'(x) & = partial_mu phi.alt'(x) partial_nu phi.alt'(x) eta^(mu nu) \
  & = (Lambda^(-1))^sigma_mu partial_sigma phi.alt(y) times (Lambda^(-1))^rho_nu partial_rho phi.alt(y) eta^(mu nu)\
  & = partial_sigma phi.alt(y) partial_rho phi.alt(y) underbrace((Lambda^(-1))^sigma""_mu (Lambda^(-1))^rho""_nu eta^(mu nu), = eta^(sigma rho))\
  &= partial_sigma phi.alt(y) partial_rho phi.alt(y) eta^(sigma rho) = lagr(y)
$
On a par conséquant que l’action est invariante sous cette transformation :
$
  S' = integral dif y^4 lagr'(y) = integral dif y^4 lagr(x) = integral dx^4 lagr(x) = S
$
On pourra noté que l’on à omis le terme jacobien sur le changement de $dif y -> dx$, car
ici on à que $det(Lambda) = 1$

== Symétrie

=== Théorème de Noether

*Théorème de Noether :*\
Si le lagrangien possède une symétrie continue dépendante d’un paramètre $alpha$, alors
il existe un courant $J_mu = display(sum_a (partial lagr)/(partial (partial_mu phi.alt_a)) (delta phi.alt_a)/(delta alpha)) - F^mu$,
appelé courant de Noether, associé à la symétrie, qui est conservé,\
i.e. $partial_mu J_mu = 0$\
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


==== Exemple 1 : Klein-Gordon
Si l’on considère le champs scalaire complexe $phi.alt$, avec le lagrangien suivant :
$
  lagr = |partial^mu phi.alt|^2 - m^2 |phi.alt|^2
$
Comme il y a deux degrée de libérté dans un champs complexe : $phi.alt et phi.alt^star$, alors le lagrangien se réécrit :
$
  lagr = partial^mu phi.alt partial_mu phi.alt^star - m^2 phi.alt phi.alt^star
$
On peut remarquer que ce lagrangien est invariant sous la transformation : $phi.alt -> e^(-i alpha) phi.alt$, avec $alpha in RR$.\
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
Ce qui peut également ce vérifier par l’équation de mouvement trouvé dans l’exemple 1 du @1.1.\
En effet, nous avions trouvés que les équations de mouvement s’écrivait :
$
  partial_mu partial^mu phi.alt = - m^2 phi.alt
$
Donc @courantKleinGordon se réduit à :
$
  J^mu = i m^2 ( cancel(phi.alt phi.alt^star) - cancel(phi.alt^star phi.alt)) = 0
$

==== Exemple 2: Tenseur Energie-Impulsion
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
$

= Particules de spin demi-entier

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
Attention, si l’on multiplie cette exprésion par la métrique, pour obtenir un des indice en bas, ce qui peut être utile dans certain calcul, on obtient :
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
Dans notre cas, on peut, par exemple, considéré les matrices par block suivantes :
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
ici $S[Lambda]$ représente $Lambda$ écrit dans la représentation de la base $S$. On pourrat égalemnet noté que l’on utilise les même $Omega$ pour les deux représentation, cecis nous assure que l’on fasse la même transformation de Lorentz.\

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
où $arrow(phi) = (phi^1, phi^2, phi^3)$, où chaque composante représente une rotation de $phi^i$ autour de l’axe $x^i$\
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

== Action de Dirac

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
  overline(psi) = (psi)^dagger gamma^0
$
Voyons donc comment celui-ci se transforme par le groupe de Lorentz :

*Propriété :*
$
  overline(psi) (x) psi(x) "est un scalaire de Lorentz"
$\

*Preuve :*
$
  overline(psi') (x) psi'(x) &= (psi')^dagger (x) gamma^0 psi'(x)\
  &= psi^dagger (Lambda^(-1) x) S[Lambda]^dagger gamma^0 S[Lambda] psi(Lambda^(-1) x)\
  &= psi^dagger (Lambda^(-1) x) gamma^0 cancel(S[Lambda]^(-1) gamma^0 gamma^0 S[Lambda]) psi(Lambda^(-1) x)\
  &= psi^dagger (Lambda^(-1) x) gamma^0 psi(Lambda^(-1) x)\
  &= overline(psi) (Lambda^(-1) x) psi(Lambda^(-1) x)\
$\
\
Par cette même méthode, on peut construire deux autre invariant par transformé de Lorentz, des vecteurs et des tenseurs, en effet :\
\
*Propriété :*
$
  overline(psi) gamma^mu psi "est un vecteur de Lorentz, i.e. :"\
  overline(psi) (x) gamma^mu psi (x) --> Lambda^mu""_nu overline(psi) (Lambda^(-1) x) gamma^nu psi (Lambda^(-1) x)
$\

*Preuve :*
Voir Tong\
\
\
*Propriété :*
$
  overline(psi) gamma^mu gamma^nu psi "est un tenseur de Lorentz"\
  overline(psi) (x) gamma^mu gamma^nu psi (x) --> Lambda^mu""_rho Lambda^nu""_sigma overline(psi) (Lambda^(-1) x) gamma^rho gamma^sigma psi (Lambda^(-1) x)
$\

*Preuve :*
Voir Tong
\
\
\
Nous povons donc maintenant construire une action invariante pas groupe de Lorentz, grâce au 3 forme bilinéaire que l’on viens de construire : $overline(psi) psi, overline(psi) gamma^mu psi$ et $overline(psi) gamma^mu gamma^nu psi$, en réalité seul les deux première serons utile

#pagebreak()

#set heading(numbering: none)

= Conclusions

#pagebreak()

//#bibliography("biblio.bib", title: [Bibliographie])

#pagebreak()

#set heading(supplement: [Annexe], numbering: (..nums) => {
  if nums.pos().len() == 2 {
    nums.pos().at(1)
  }
})

#align(center + horizon)[= Annexe]
