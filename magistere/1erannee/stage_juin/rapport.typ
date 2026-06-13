#import "../../../template.typ": *
#import "../../../transposition.typ": *
#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.3": plot
#import "@preview/zebraw:0.6.3": *
#import "@preview/mitex:0.2.7": *
#show: zebraw

#show: template

#set page(paper: "a4")
#set text(lang: "la") // Modifié pour la gestion typographique latine

#let equa = counter("equa")
#equa.step()

#show math.equation: set block(breakable: true)

#set math.equation(
  supplement: [aequatio],
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

// Ad LaTeX simulandum

#set page(number-align: right, numbering: (it, ..) => {
  if it != 1 { if it != 2 { text[#na(it) / #na(counter(page).final().first())] } }
})

#set par(leading: 0.55em, spacing: 0.55em, justify: true)
#set text(font: "Linux Libertine", historical-ligatures: true)
#show raw: set text(font: "Linux Libertine")
#show heading: set block(above: 1.4em, below: 1em)
#set document(title: text(20pt)[Theoria classica (et quantica?)\ camporum])
#set text(size: 11pt)
#set math.cancel(stroke: red)

#align(center, title())
#v(1.5cm)
#align(center, text(
  16pt,
  weight: "bold",
)[Gaspar Daguet\ #v(5pt) #text(11pt, weight: "thin")[gaspar.daguet\@etu.unistra.fr]])

#align(bottom + center)[
  Facultas Physicae et Artis Machinalis\
  \
  Universitas Argentinensis\
  \
  Annus academicus MMXXV-MMXXVI
]

#pagebreak()

#align(center)[*Summarium*]\
#v(1mm)

#let pagenub = context {
  let nbpage = counter(page)
  if nbpage != 1 or nbpage != 2 { counter(page).display("1") } else {}
}

#pagebreak()

#heading(outlined: false, numbering: none)[
  Index Capitum
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

#show heading.where(body: [Introductio]): set heading(numbering: none)
= Introductio

Hoc opus scriptum est ut relatio tirocinii initio de theoria classica camporum agentis. Hoc tirocinium magna ex parte in libro #text(style: "italic")[Quantum Field Theory] a Doctore David Tong scripto fundatum est, ergo non mirum est structuram similem passim invenire, vel etiam paraphrasim operis eius (quam plagiariam vocare possimus...). Tamen, cum finis tirocinii nostri esset theoriam classicam camporum discere et ei assuescere, hic invenies fere omnes demonstrationes et definitiones cuiusque obiecti praesentati, exceptis obiectis plerumque communibus et eis quorum demonstratio vel rigorosa definitio vires nostras superabant.

#pagebreak()


= Conventiones

Hic enumeratur summa conventionum quibus magis minusve implicite in reliquo opere utimur. Hae conventiones in tabula praesentabuntur, causa electionis data ubi haec utilis esse potest.

#align(
  center + horizon,
  figure(
    table(
      columns: 2,
      inset: 5mm,
      table.header([conventio], [causa]),
      $eta^(mu nu) = mat(+, -, -, -)$, [Haec est conventio magis usitata\ in contrarium ad $mat(-, +, +, +)$],
    ),
    caption: [Summa conventionum usitatarum],
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

= Theoria lagrangiana camporum

== Aequatio Euleri-Lagrange <1.1>

*Definitio:*\
Definimus novum genus lagrangiani $cal(L) (phi.alt, partial_mu phi.alt)$ in campis, quod vocamus: densitatem lagrangianam, per:
$
  S = integral upright(L) dt = integral integral cal(L) dx^3 dt = integral cal(L) dx^4
$
Per abusionem linguae simpliciter lagrangianum vocatur, loco #text(style: "italic")[densitatis] lagrangianae.
\
\
*Aequatio Euleri-Lagrange:*\
Sit $phi.alt_a$ campus, indice $a$ notatus, talis ut $delta phi.alt (arrow(x), t_1) = delta phi.alt (arrow(x), t_1) = 0$, tunc eius lagrangianum hanc aequationem respectat:
$
  forall a, partial_mu ( (partial lagr) / (partial(partial_mu phi.alt_a))) - (partial lagr) / (partial phi.alt_a) = 0
$<equlagr>

*Demonstratio:*\
Per principium actionis minimae, quaerimus $delta S = 0$, atqui:
$
  delta lagr &= (partial lagr)/(partial phi.alt_a) delta phi.alt_a + (partial lagr)/(partial(partial_mu phi.alt_a)) delta (partial_mu phi.alt_a)\
  &= (partial lagr)/(partial phi.alt_a) delta phi.alt_a + partial_mu ((partial lagr)/(partial(partial_mu phi.alt_a)) delta phi.alt_a) - partial_mu ((partial lagr)/(partial(partial_mu phi.alt_a))) delta phi.alt_a\
  &= ((partial lagr)/(partial phi.alt_a) - partial_mu ( (partial lagr)/(partial(partial_mu phi.alt_a)))) delta phi.alt_a + partial_mu ((partial lagr)/(partial(partial_mu phi.alt_a)) delta phi.alt_a)
$
Ergo, variatio actionis scribitur:
$
  delta S = integral dx^4 ((partial lagr)/(partial phi.alt_a) - partial_mu ( (partial lagr)/(partial(partial_mu phi.alt_a)))) delta phi.alt_a + integral dx^4 partial_mu ((partial lagr)/(partial(partial_mu phi.alt_a)) delta phi.alt_a)
$
Quoniam $phi.alt_a$ respectat factum quod $delta phi.alt_a (arrow(x), t_1) = delta phi.alt_a (arrow(x), t_2) = 0$, et quod $partial_mu ((partial lagr)/(partial(partial_mu phi.alt_a)) delta phi.alt_a)$ est derivatio totalis, tunc eius integrale nullum est, ergo:
$
  delta S = integral dx^4 ((partial lagr)/(partial phi.alt_a) - partial_mu ( (partial lagr)/(partial(partial_mu phi.alt_a)))) delta phi.alt_a
$
et per principium actionis minimae $delta S = 0$, ex quo sequitur:
$
  (partial lagr)/(partial phi.alt_a) - partial_mu ( (partial lagr)/(partial(partial_mu phi.alt_a))) = 0
$
#QED

=== Exemplum I: Aequatio Klein-Gordon

Ponantur in spatio Minkowskiano, cuius metrica est $eta_(mu nu) = eta^(mu nu) = "diag"(+, -, -, -)$, et consideretur hoc lagrangianum:
$
  lagr = 1/2 eta^(mu nu) partial_mu phi.alt partial_nu phi.alt - 1/2 m^2 phi.alt^2
$
Tunc, habemus:
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
Ergo secundum @equlagr:
$
  partial_mu partial^mu phi.alt + m^2 phi.alt = 0
$

=== Exemplum II: Aequationes Maxwell
In hoc exemplo proponitur aequationes Maxwell in vacuo recuperare.\
Ad hoc, consideretur sequens lagrangianum:
$
  lagr = - 1/2 (partial_mu A_nu) (partial^mu A^nu) + 1/2 (partial_mu A^mu)^2
$

Tunc:
$
  (partial lagr)/(partial (partial_mu A_nu)) &= -1/2 (underbrace((partial(partial_rho A_sigma))/(partial(partial_mu A_nu)), = delta_(rho)^mu delta_(sigma)^nu) partial^(rho) A^(sigma) + eta^(rho alpha) eta^(sigma beta) underbrace((partial(partial_alpha A_beta))/(partial(partial_mu A_nu)), = delta_(alpha)^mu delta_(beta)^nu) partial_(rho) A_(sigma)) + 1/2 (eta^(rho sigma))^2 underbrace((partial (partial_rho A_sigma )^2)/(partial(partial_mu A_nu)), = 2 delta^mu_rho delta^nu_sigma partial_rho A_sigma)\
  & = - partial^mu A^nu + (partial_rho A^rho) eta^(mu nu)
$
Ergo
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
Ergo secundum aequationes Euleri-Lagrange, invenimus:
$
  partial_mu F^(mu nu) = 0
$
Demonstrabimus hanc aequationem permittere aequationes Maxwell recuperare (@). Lagrangianum etiam in forma compactiore rescribi potest auxilio tensoris $F^(mu nu)$.
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

== Invariabilitas Lorentziana
Una ex primis causis cur theoria camporum excogitata sit, fuit reconciliatio mechanicae quanticae cum theoria relativitatis. Ergo, theoriam construere quaerimus quae invariabilis maneat sub transformationibus Lorentzianis:
$
  x^mu --> (x^mu)' = Lambda^mu""_nu x^nu
$
ubi $Lambda^mu""_nu$ satisfacit:
$
  eta^(mu nu) = Lambda^mu""_rho Lambda^nu_sigma eta^(rho sigma)
$
Hic $Lambda$ est matrix transformationum inter duo systemata referentiae,\
\
\
#align(center, grid(
  column-gutter: 3cm,
  row-gutter: 0.5cm,
  columns: 2,
  $Lambda^nu""_mu = mat(1, 0, 0, 0; 0, cos(theta), sin(theta), 0; 0, -sin(theta), cos(theta), 0; 0, 0, 0, 1)$,
  $Lambda^nu""_mu = mat(gamma, -gamma v, 0, 0; -gamma v, gamma, 0, 0; 0, 0, 1, 0; 0, 0, 0, 1)$,

  [Rotatio per $theta$, circa $x^3$], [Impulsus Lorentzianus secundum $x^1$\ ubi $gamma = sqrt(1 - v^2)$],
))

Itaque, volumus campum scalarem sub his transformationibus invariabilem esse, id est, si $phi.alt(x)$ est solutio aequationum motus, tunc et $phi.alt'(x) = phi.alt(Lambda^(-1)x)$ sit.\
Notandum est indicem exponentis $-1$ adhiberi quia transformationem activam consideramus.

=== Exemplum I: Aequatio Klein-Gordon
Videamus quomodo lagrangianum primi nostri exempli se habeat sub transformatione:
$
  phi.alt(x) --> phi.alt'(x) = phi.alt(Lambda^(-1)x)
$
tunc:
$
  partial_mu phi.alt(x) --> (Lambda^(-1))^nu""_mu partial_nu phi.alt(y)
$
ubi $y = Lambda^(-1) x$, ita lagrangianum sub hac transformatione fit:
$
  lagr'(x) & = partial_mu phi.alt'(x) partial_nu phi.alt'(x) eta^(mu nu) \
  & = (Lambda^(-1))^sigma_mu partial_sigma phi.alt(y) times (Lambda^(-1))^rho_nu partial_rho phi.alt(y) eta^(mu nu)\
  & = partial_sigma phi.alt(y) partial_rho phi.alt(y) underbrace((Lambda^(-1))^sigma""_mu (Lambda^(-1))^rho""_nu eta^(mu nu), = eta^(sigma rho))\
  &= partial_sigma phi.alt(y) partial_rho phi.alt(y) eta^(sigma rho) = lagr(y)
$
Consequitur ergo actionem invariabilem esse sub hac transformatione:
$
  S' = integral dif y^4 lagr'(y) = integral dif y^4 lagr(x) = integral dx^4 lagr(x) = S
$
Notari potest nos terminum Jacobianum in mutatione $dif y -> dx$ omisisse, quia hic habemus $det(Lambda) = 1$.

== Symmetria

=== Theorema Noether

*Theorema Noether:*\
Si lagrangianum habet symmetriam continuam ex parametro $alpha$ dependentem, tunc exsistit flumen (currens) $J_mu = display(sum_a (partial lagr)/(partial (partial_mu phi.alt_a)) (delta phi.alt_a)/(delta alpha)) - F^mu$, flumen Noetherianum vocatum, symmetriae associatum, quod conservatur,\
i.e. $partial_mu J_mu = 0$\
\
*Demonstratio:*\
Cum lagrangianum invariabile est sub quadam variatione speciei $phi.alt -> phi.alt + delta phi.alt$, tunc haec transformatio vocatur #text(style: "italic")[symmetria].\
Tunc lagrangianum nostrum rescribi potest:
$
  delta lagr &= sum_a { (partial lagr)/(partial phi.alt_a) delta phi.alt_a + (partial lagr)/(partial (partial_mu phi.alt_a))delta(partial_mu phi.alt_a)}\
  &= sum_a { (partial lagr)/(partial phi.alt_a) delta phi.alt_a + partial_mu ((partial lagr)/(partial (partial_mu phi.alt_a))delta phi.alt_a) - partial_mu ((partial lagr) / (partial(partial_mu phi.alt_a)))delta phi.alt_a}\
  &= sum_a {[(partial lagr)/(partial phi.alt_a) - partial_mu ((partial lagr)/(partial (partial_mu phi.alt_a)))] delta phi.alt_a + partial_mu ((partial lagr)/(partial (partial_mu phi.alt_a)) delta phi.alt_a)}
$
Cum autem aequationes motus satisfiunt, terminus inter uncos evanescit, et ita relinquitur:
$
  delta lagr = sum_a partial_mu ((partial lagr)/(partial (partial_mu phi.alt_a))delta phi.alt_a)
$
In casu autem symmetriae, variatio lagrangiani secundum parametrum est derivatio totalis quantitatis scalaris:
$
  (delta lagr)/(delta alpha) = partial_mu F^mu
$
Ergo:
$
  partial_mu (sum_a (partial lagr)/(partial (partial_mu phi.alt_a)) (delta phi.alt_a)/(delta alpha) - F^mu)
$
Ergo, flumen definire possumus per:
$
  J^mu = sum_a (partial lagr)/(partial (partial_mu phi.alt_a)) (delta phi.alt_a)/(delta alpha) - F^mu
$
Sic relinquitur:
$
  partial_mu J^mu = 0
$
Patet igitur flumen Noether conservari.
#QED


==== Exemplum I: Klein-Gordon
Si consideretur campus scalaris complexus $phi.alt$, cum lagrangiano sequenti:
$
  lagr = |partial^mu phi.alt|^2 - m^2 |phi.alt|^2
$
Quoniam duo sunt gradus libertatis in campo complexo: $phi.alt$ et $phi.alt^star$, tunc lagrangianum rescribitur:
$
  lagr = partial^mu phi.alt partial_mu phi.alt^star - m^2 phi.alt phi.alt^star
$
Animadverti potest hoc lagrangianum invariabile esse sub transformatione: $phi.alt -> e^(-i alpha) phi.alt$, cum $alpha in RR$.\
Haec transformatio est ergo symmetria lagrangiani, ita habemus:
$
  (delta phi.alt)/(delta alpha) = -i phi.alt " " et " " (delta phi.alt^star)/(delta alpha) = i phi.alt^star
$
Praeterea lagrangianum immutatum manet, ergo:
$
  (delta lagr)/(delta alpha) = 0
$
ergo $F^mu = "const"$, et eligere possumus $F^mu = 0$ sine amissione generalitatis.\
Invenitur tunc:
$
  J^mu &= -i phi.alt (partial lagr)/(partial(partial_mu phi.alt)) + i phi.alt^star (partial lagr)/(partial (partial_mu phi.alt^star))\
  &= -i (phi.alt partial^mu phi.alt^star - phi.alt^star partial^mu phi.alt)
$ <courantKleinGordon>
Et ergo secundum theorema Noether, habemus:
$
  partial_mu J^mu = -i( phi.alt partial_mu partial^mu phi.alt^star - phi.alt^star partial_mu partial^mu phi.alt) = 0
$
Quod etiam per aequationem motus inventam in exemplo I capitis @1.1 verificari potest.\
Etenim inveneramus aequationes motus ita scribi:
$
  partial_mu partial^mu phi.alt = - m^2 phi.alt
$
Ergo @courantKleinGordon reducitur ad:
$
  J^mu = i m^2 ( cancel(phi.alt phi.alt^star) - cancel(phi.alt^star phi.alt)) = 0
$

==== Exemplum II: Tensor Energiae-Impulsionis <TenseurEP>
Si consideretur symmetria translationis per quadrivectorem $xi$ constantem et valde parvum, scilicet $x^nu -> x^nu + xi^nu$, tunc campus rescribi potest:
$
  phi.alt(x + xi) = phi.alt(x) + xi^nu partial_nu phi.alt(x) + o (xi)
$
tunc lex transformationis est:
$
  (delta phi.alt)/(delta xi^nu) = partial_nu phi.alt(x)
$
Idem valet pro lagrangiano, etenim:
$
  lagr(x + xi) = lagr(x) + xi^nu partial_nu lagr(x)
$
ergo
$
  (delta lagr)/(delta xi^nu) = partial_nu lagr(x)
$
Habemus ergo flumen Noetherianum pro singulis $nu = 0, 1, 2, 3$:
$
  (J^mu)_nu = (partial lagr)/(partial (partial_mu phi.alt)) partial_nu phi.alt - delta^mu""_nu lagr
$
Definimus tunc novum tensorem, tensorem energiae-impulsionis, per:
$
  T^mu""_nu = (J^mu)_nu = (partial lagr)/(partial (partial_mu phi.alt)) partial_nu phi.alt - delta^mu""_nu lagr
$
qui verificat, per theorema Noether, hanc proprietatem:
$
  partial_mu T^mu""_nu = 0
$

Hic tensor duas magnitudines magnas in se continet:
- Energiam:
$
  cal(E) = T^0""_0 = (partial lagr)/(partial dot(phi.alt)) dot(phi.alt) - lagr
$
Agnoscitur expressio energiae in mechanica lagrangiana classica, cum:
$
  E = integral dx^3 T^0""_0 = integral dx^3 cal(E)
$

- Impulsionem:
$
  cal(P)^i = T^i""_0
$
cum hic quoque
$
  P^i = integral dx^3 cal(P)^i
$

= Particulae spinus nullius

== Copulatio cum electromagnetismo <scalaireele>

Primum demonstrabimus lagrangianum $lagr = partial_mu phi.alt partial^mu phi.alt^star - m^2 phi.alt phi.alt^star$ invariabile esse sub grupo $upright(U)(1)$ quamdiu haec symmetria globalis est. Deinde, cum ad symmetriam localem transibimus, lagrangianum nostrum non iam invariabile erit, ergo quaeremus id denuo invariabile reddere sub hac symmetria $upright(U)(1)$ locali.

=== Praenotanda de grupo $upright(U)(1)$

In casu nostro, $upright(U)(1)$ isomorpheus est, ergo coincidit cum grupo $(UU, dot.c)$, circulo complexo unitatis multiplicatione praedito, i.e. $UU = {|z| = 1, z in CC} = {e^(i alpha), alpha in RR}$. Hic ergo demonstrabimus $(UU, dot.c)$, et per consequens $upright(U)(1)$, vere grupum esse.\
Ad hoc, habemus hanc definitionem grupi:\
\
Sit copia $G$ et $dot.c$ lex compositionis internae, tunc $(G, dot.c)$ grupus est, si et solum si:\
\

#set enum(indent: 1cm, spacing: 4mm)
+ $exists e in G, forall z in G, e z = z e = z$
+ $forall z in G, exists u in G, z u = u z = e$
+ $forall x, y, z in G, (x y) z = x (y z)$
\
Videamus quomodo se res habeat in grupo nostro,\
sit $z in UU$, tunc:\

- $1$ vere est elementum neutrum, etenim
$
  |1| = 1 "ergo" 1 in UU
$
et
$
  1 dot.c z = z = z dot.c 1
$

- $z^star$ vere est inversum ipsius $z$, etenim:
$
  |z^star| = |z|^star = 1^star = 1 "ergo" z^star in UU
$
et
$
  z z^star = z^star z = |z|^2 = 1
$

- Denique pro $u, v in UU$, habetur associativitas:
$
  (z u) v = z u v = z (u v)
$
Ergo $UU$ vere grupus est, et consequenter etiam $upright(U)(1)$.\

=== Symmetria globalis

Hinc porro operabimur cum $upright(U)(1) = {e^(i q alpha), alpha, q in RR}$ sicut definitione pro $upright(U)(1)$ globali.\
Ostendi potest lagrangianum nostrum invariabile esse per elementa huius grupi, id est procedimus ad hanc transformationem:
$
  forall alpha in RR, phi.alt -> phi.alt' = e^(i q alpha) phi.alt
$
ergo pro $alpha in RR$,
$
  lagr' & = partial_mu phi.alt' partial^mu phi.alt'^star - m phi.alt' phi.alt'^star \
  & = e^(i q alpha) e^(- i q alpha) partial_mu phi.alt partial^mu phi.alt^star - m e^(i q alpha) e^(- i q alpha) phi.alt phi.alt^star\
  & = partial_mu phi.alt partial^mu phi.alt^star - m phi.alt phi.alt^star = lagr\
$
Ergo lagrangianum nostrum vere invariabile est per symmetriam globalem inductam a $upright(U)(1)$.

Iam demonstravimus (@courantKleinGordon) sub hac symmetria, flumen Noetherianum inductum fuisse:
$
  J^mu = - i q ( phi.alt partial^mu phi.alt^star - phi.alt^star partial^mu phi.alt)
$

=== Symmetria localis

Nunc quaeremus symmetriam per $upright(U)(1)$ localem reddere, ad hoc, parametrum nostrum $alpha$ a positione dependere faciemus, i.e.:
$
  alpha in RR --> alpha in CC^(RR^4)
$
aliter dictu, $alpha$ fit functio positionis.\
Ita transformatio fit:
$
  forall x in RR^4, phi.alt --> phi.alt' = e^(i q alpha(x)) phi.alt
$
Proh dolor, derivatio non iam se habet ut oportet:
$
  partial_mu phi.alt' &= partial_mu (e^(i q alpha) phi.alt) = partial_mu (e^(i q alpha)) phi.alt + e^(i q alpha) partial_mu phi.alt\
  &= i q (partial_mu alpha) e^(i q alpha) phi.alt + e^(i q alpha) partial_mu phi.alt
$
Propter hoc, lagrangianum nostrum non iam invariabile est, etenim:
$
  lagr' &= partial_mu phi.alt' partial^mu phi.alt'^star - m phi.alt' phi.alt'^star\
  &= (i q (partial_mu alpha) e^(i q alpha) phi.alt + e^(i q alpha) partial_mu phi.alt) ( - i q (partial^mu alpha) e^( - i q alpha) phi.alt^star + e^( -i q alpha) partial^mu phi.alt^star) - m phi.alt phi.alt^star\
  &= q^2 partial_mu alpha partial^mu alpha phi.alt phi.alt^star + underbrace(partial_mu phi.alt partial^mu phi.alt^star - m phi.alt phi.alt^star, lagr)\
  &= lagr + q^2 partial_mu alpha partial^mu alpha phi.alt phi.alt^star
$

Ad symmetriam restituendam, oportebit novam derivationem inducere, vocatam #text(style: "italic")[derivationem covariantem], quam definimus per:
$
  D_mu = partial_mu - i q A_mu
$
ita ut:
$
  D_mu phi.alt --> (D_mu phi.alt)' = e^(i q alpha) D_mu phi.alt
$
Ubi $A_mu$ est potentiale vectoriale electromagnetismi, quod hic photonem codificat. Usitate aequationes Maxwell, quas redemonstrabimus in @, invariabiles sunt per transformationem mensurae $A_mu -> A_mu - partial_mu chi$ ubi $chi$ functio arbitraria est. In hac compage, invenire possumus relationem inter $chi$ et $alpha$.\
*Proprietas:*
$
  chi = - alpha + C
$
ubi $c$ est constans\
\
*Demonstratio:*\
Hic ponimur in casu transformationum sequentium:
$
  phi.alt' = e^(i q alpha) phi.alt
  D_mu phi.alt --> (D_mu phi.alt)' = e^(i q alpha) D_mu phi.alt\
  A_mu --> A'_mu = A_mu - partial_mu chi
$
Idea demonstrationis est scribere $(D_mu phi.alt)'$ duobus modis, ut deinde ambas expressiones aequemus, sic habemus ex una parte:
$
  (D_mu phi.alt)' & = e^(i q alpha) D_mu phi.alt \
                  & = e^(i q alpha) (partial_mu phi.alt - i q A_mu phi.alt)
$
Et ex altera parte:
$
  (D_mu phi.alt)' & = D'_mu phi.alt' = partial_mu phi.alt' - i q A'_mu phi.alt' \
  & = i q (partial_mu alpha) e^(i q alpha) phi.alt + e^(i q alpha) partial_mu phi.alt - i q e^(i q alpha) A_mu phi.alt + i q e^(i q alpha) partial_mu chi phi.alt\
  &= e^(i q alpha) (i q (partial_mu alpha) phi.alt + partial_mu phi.alt - i q A_mu phi.alt + i q partial_mu chi phi.alt)
$
Invenimus ergo
$
  cancel(partial_mu phi.alt) - cancel(i q A_mu phi.alt) = i q (partial_mu alpha) phi.alt + cancel(partial_mu phi.alt) - cancel(i q A_mu phi.alt) + i q partial_mu chi phi.alt
$
Ergo
$
  partial_mu chi = - partial_mu alpha
$
ita bene recuperamus
$
  chi = - alpha + c
$
#QED

=== Aequationes motus cum symmetria locali

Possumus tunc inspicere quid fiat de nostro lagrangiano cum hac nova derivatione, et pro certo habere id vere invariabile esse per $upright(U)(1)$ localem.\
Ergo lagrangianum nostrum fit:
$
  lagr &= D_mu phi.alt D^mu phi.alt^star - m^2 phi.alt phi.alt^star\
  &= (partial_mu - i q A_mu) phi.alt (partial^mu - i q A^mu) phi.alt^star - m^2 phi.alt phi.alt^star\
  &= partial_mu phi.alt partial^mu phi.alt^star - i q partial_mu phi.alt A^mu phi.alt^star - i q A_mu phi.alt partial^mu phi.alt^star - q^2 A_mu A^mu phi.alt phi.alt^star - m^2 phi.alt phi.alt^star\
  &= partial_mu phi.alt partial^mu phi.alt^star - i q (phi.alt A_mu partial^mu phi.alt^star + phi.alt^star A_mu partial^mu phi.alt) - phi.alt phi.alt^star (q^2 A^mu A_mu + m^2)
$
Facile est, auxilio primae formae lagrangiani, demonstrare illud invariabile esse per grupum $upright(U)(1)$ localem.\
Denique, poterimus inde deducere $3$ aequationes motus pro $phi.alt$, $phi.alt^star$ et $A_mu$\
\
+ Pro $phi.alt$:
Habemus ex una parte:
$
  partial_mu ((partial lagr)/(partial (partial_mu phi.alt))) = partial_mu (partial^mu phi.alt^star - i q phi.alt^star A^mu) = square phi.alt^star - i q partial_mu phi.alt^star A^mu
$
Et ex altera parte:
$
  (partial lagr)/(partial phi.alt) = - i q A_mu partial^mu phi.alt^star - phi.alt^star (q^2 A^mu A_mu + m^2)
$
Ergo secundum aequationes Euleri-Lagrange:
$
  square phi.alt^star + i q (A_mu partial^mu phi.alt^star - partial^mu phi.alt^star A_mu) + phi.alt^star (q^2 A^mu A mu + m^2) = 0
$\
\

#h(1cm) 2.~~ Pro $phi.alt^star$:
Habemus ex una parte:
$
  partial_mu ((partial lagr)/(partial (partial_mu phi.alt^star))) = partial_mu (partial^mu phi.alt - i q phi.alt A^mu) = square phi.alt - i q partial_mu phi.alt A^mu
$
Et ex altera parte:
$
  (partial lagr)/(partial phi.alt^star) = - i q A^mu partial_mu phi.alt - phi.alt (q^2 A^mu A_mu + m^2)
$
Ergo secundum aequationes Euleri-Lagrange:
$
  square phi.alt + i q (A^mu partial_mu phi.alt - partial_mu phi.alt A^mu) + phi.alt (q^2 A^mu A mu + m^2) = 0
$

#h(1cm) 3.~~ Pro $A_mu$:
Habemus ex una parte:
$
  partial_mu ((partial lagr)/(partial (partial_mu A_nu))) = 0
$
Et ex altera parte:
$
  (partial lagr)/(partial A_mu) &= - i q (phi.alt partial^mu phi.alt^star + phi.alt^star partial^mu phi.alt) - q^2 phi.alt phi.alt^star (partial (A^nu A_nu))/(partial A_mu)\
  &= - i q (phi.alt partial^mu phi.alt^star + phi.alt^star partial^mu phi.alt) - q^2 phi.alt phi.alt^star (A^mu + A^mu)\
  &= - i q (phi.alt partial^mu phi.alt^star + phi.alt^star partial^mu phi.alt) - 2 q^2 phi.alt phi.alt^star A^mu\
$
Ergo secundum aequationes Euleri-Lagrange:
$
  i q (phi.alt partial^mu phi.alt^star + phi.alt^star partial^mu phi.alt) + 2 q^2 phi.alt phi.alt^star A^mu = 0
$

Tunc possumus eas $3$ aequationes summatim in sequenti tabula exponere:
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
    caption: [Aequationes motus pro campo scalari\ cum electromagnetismo copulato],
  ),
)

= Particulae spinus $1 \/2$

In paragrapho praecedenti, theoriam pro campis scalaribus explicavimus, quae nobis permisit particulas spinus 0 describere. In hoc capite proponimus explicationem pro particulis spinus semi-integri.\
Ad hoc, oportebit novum genus obiectorum inducere: spinores.

== Spinores

Huc usque, solum de campis scalaribus egimus, sed pleraeque particulae plures gradus libertatis internae habent. Quod nos cogit considerare campos qui non trivialiter in grupo Lorentziano transformantur. Itaque ad particulas spinus $1/2$ describendas, debemus repraesentationem grupi Lorentziani explicare et studere.\
In genere, campi transformantur per:
$
  phi.alt^a (x) --> D[Lambda]^a""_b phi.alt^b (x)
$
ubi matrices $D[Lambda]$ sunt repraesentatio grupi Lorentziani.\
Cum $D$ sit repraesentatio, illa est morphismus, id est, has proprietates respectat:
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

Ad hanc repraesentationem inveniendam, inspicere possumus quid eveniat pro transformationibus Lorentzianis infinitesimalibus et studere algebrae Lieanae inde resultanti.
$
  Lambda^mu""_nu = delta^mu""_nu + omega^mu""_nu
$
ubi $omega$ infinitesimalis est.\
Utendo facto quod $Lambda^mu""_rho Lambda^nu""_sigma eta^(rho sigma) = eta^(mu nu)$, tunc sequitur:
$
  eta^(mu nu) & = (delta^mu""_rho + omega^mu""_rho) (delta^nu""_sigma + omega^nu""_sigma) eta^(rho sigma) \
              & = eta^(mu nu) + omega^(mu nu) + omega^(nu mu) + underbrace(omega^(mu nu) omega^(nu mu), = 0)
$
Ita habemus ut condicionem quod $omega$ antisymmetricus est:
$
  omega^(mu nu) = - omega^(nu mu)
$
\
Notari potest matrices $4 times 4$ habere $(4 times (4 - 1)) /2 = 6$ componentia, sicut pro transformationibus Lorentzianis quae 3 rotationes et 3 impulsus habent, id est 6 transformationes in toto. Ergo transformationes Lorentzianae per matrices $4 times 4$ describi poterunt.\
Inducimus ergo matrices $(cal(M)^(rho sigma))^(mu nu)$ ubi $mu, nu in [|0; 3|]$ indicem matricis repraesentant, $rho, sigma in [|0; 3|]$ indicem axium circum quos vel secundum quos transformatio fit repraesentant:\
\
#align(
  center,
  math.equation(numbering: none)[$
    forall i in [|1, 3|], (cal(M)^(0 i))^(mu nu) --> "Impulsus Lorentzianus secundum axem" x^i\
    forall i,j in [|1, 3|], (cal(M)^(i j))^(mu nu) --> "Rotatio in plano" (x^i, x^j)\
  $],
)
Atqui cum $rho$ et $sigma$ sine restrictione, habemus $4 times 4 = 16$ componentia, quamobrem imponimus ipsi $cal(M)$ ut sit antisymmetrica in $rho$ et $sigma$, i.e. $cal(M)^(rho sigma) = - cal(M)^(sigma rho)$, sic remanent solummodo $(4 times (4 - 1))/2 = 6$ componentia.\
Ponimus ergo hanc basim:
$
  (cal(M)^(rho sigma))^(mu nu) = eta^(rho mu)eta^(sigma nu) - eta^(sigma mu) eta^(rho nu)
$
Cave, si hanc expressionem per metricam multiplicamus, ut unum ex indicibus deorsum obtineamus, quod in quibusdam calculis utile esse potest, obtinemus:
$
  (cal(M)^(rho sigma))^(mu)""_nu = eta^(rho mu)delta^sigma""_nu - eta^(sigma mu)delta^rho""_nu
$
Hae matrices non iam necessario antisymmetrices sunt!\
\
Nunc ergo scribere possumus $omega$ in hac basi:
$
  omega^mu""_nu = 1/2 Omega_(rho sigma) (cal(M)^(rho sigma))^mu""_nu
$
ubi coefficiens $1/2$ adest ad compensandum factum quod terminos bis sumimus, propter antisymmetriam matricis $cal(M)$, et $Omega_(rho sigma)$ repraesentat id quod transformatio Lorentziana facit.\
Tales matrices $cal(M)^(rho sigma)$ generatrices transformationum Lorentzianarum vocantur, verificatque relationem algebrae Lieanae Lorentzianae:
$
  [cal(M)^(rho sigma); cal(M)^(tau nu)] = eta^(sigma tau) cal(M)^(rho nu) - eta^(rho tau) cal(M)^(sigma nu) + eta^(rho nu) cal(M)^(sigma tau) - eta^(sigma nu) cal(M)^(rho tau)
$
Exemptis indicibus matricum\
*Demonstratio:*\
Quaerimus ergo rescribere:
$
  [cal(M)^(rho sigma); cal(M)^(tau nu)]^alpha""_beta = (cal(M)^(rho sigma))^alpha""_ateb (cal(M)^(tau nu))^ateb""_beta - (cal(M)^(tau nu))^alpha""_ateb (cal(M)^(rho sigma))^ateb""_beta
$
Ad hoc, primum unum tantum e duobus terminis calculemus:
$
  (cal(M)^(rho sigma))^alpha""_ateb (cal(M)^(tau nu))^ateb""_beta &= (eta^(rho alpha) delta^sigma""_ateb - eta^(sigma alpha) delta^rho""_ateb)
  (eta^(tau ateb) delta^nu""_beta - eta^(nu ateb) delta^tau""_beta)\
  &= eta^(rho alpha) eta^(tau sigma) delta^nu""_beta - eta^(rho alpha) eta^(nu sigma) delta^tau""_beta\
  &""+ eta^(sigma alpha) eta^(nu rho) delta^(tau)""_beta - eta^(sigma alpha) eta^(tau rho) delta^(nu)""_beta
$
Faciendo eundem calculum pro $(cal(M)^(tau nu))^alpha""_ateb (cal(M)^(rho sigma))^ateb""_beta$ (quod aequiparatur permutationi $rho <-> tau$ et $sigma <-> nu$), obtinemus:
$
  (cal(M)^(tau nu))^alpha""_ateb (cal(M)^(rho sigma))^ateb""_beta &= eta^(tau alpha) eta^(rho nu) delta^sigma""_beta - eta^(tau alpha) eta^(nu sigma) delta^rho""_beta\
  &""+ eta^(nu alpha) eta^(sigma tau) delta^(rho)""_beta - eta^(nu alpha) eta^(rho tau) delta^(sigma)""_beta
$<commutateurM>
Sic subtrahendo (inter X et XIII annos maximum) duas quantitates, obtinemus:
$
  [cal(M)^(rho sigma); cal(M)^(tau nu)]^alpha""_beta &= (cal(M)^(rho sigma))^alpha""_ateb (cal(M)^(tau nu))^ateb""_beta - (cal(M)^(tau nu))^alpha""_ateb (cal(M)^(rho sigma))^ateb""_beta\
  &= eta^(tau sigma) underbrace((eta^(rho alpha) delta^nu""_beta - eta^(nu alpha) delta^alpha""_beta), = (cal(M)^(rho nu))^alpha""_beta) - eta^(rho tau) underbrace((eta^(sigma alpha) delta^nu""_beta - eta^(nu alpha) delta^sigma""_beta), = (cal(M)^(sigma nu))^alpha""_beta)\
  &+ eta^(rho nu) underbrace((eta^(sigma alpha) delta^tau""_beta - eta^(tau alpha) delta^sigma""_beta), (cal(M)^(sigma tau))^alpha""_beta) - eta^(sigma nu) underbrace((eta^(rho alpha) delta^tau""_beta - eta^(tau alpha) delta^rho""_beta), (cal(M)^(rho tau))^alpha""_beta)\
  &= eta^(sigma tau) (cal(M)^(rho nu))^alpha""_beta - eta^(rho tau) (cal(M)^(sigma nu))^alpha""_beta + eta^(rho nu) (cal(M)^(sigma tau))^alpha""_beta - eta^(sigma nu) (cal(M)^(rho tau))^alpha""_beta
$
#QED

Denique rescribere possumus $Lambda$ sub forma exponentiali:
$
  Lambda &= underparen(1, = delta^(mu nu)\ "sine indicibus"\ "matricialibus") + omega = 1 + 1/2 Omega_(rho sigma) cal(M)^(rho sigma)\
  \
  \
  &= e^(1/2 Omega_(rho sigma) cal(M)^(rho sigma))
$

=== Algebra Cliffordiana

Ad definiendam repraesentationem spinorum, oportet definire algebram Cliffordianam:
$
  {gamma^mu; gamma^nu} = gamma^mu gamma^nu + gamma^nu gamma^mu = 2 eta^(mu nu) upright(I)_4
$
ubi $gamma^mu$ matrices sunt et $upright(I)_n$ matrix identitatis dimensionis $4$.\
aliter dicta $gamma^mu$ has proprietates respicit:
- pro $alpha != beta$
$
  gamma^alpha gamma^beta + gamma^beta gamma^alpha = 0\
  ==> gamma^alpha gamma^beta = - gamma^beta gamma^alpha
$
et
$
                         2 (gamma^0)^2 = 2 upright(I)_4 & ==> (gamma^0)^2 = upright(I)_4 \
  forall i in [|1; 3|], 2 (gamma^i)^2 = -2 upright(I)_4 & ==> (gamma^i)^2 = - upright(I)_4 \
$
Hae matrices necessario dimensionis $4$ sunt, etenim in dimensione $2$ solum $i upright(I)_2$ valet $-upright(I)_2$ sed adhuc nobis duabus aliis matricibus opus est ad hanc repraesentationem describendam. Similiter in dimensione 3, non difficile est persuadere sibi non satis matricum esse quae $A^2 = -upright(I)_3$ verificant.\
In nostro casu, possumus, exempli gratia, has matrices per bloccos considerare:
$
  gamma^0 = mat(upright(0)_2, upright(I)_2; upright(I)_2, upright(0)_2), forall i in [|1,3|], gamma^i = mat(upright(0)_2, sigma^i; -sigma^i, upright(0)_2)
$
ubi $sigma^i$ matrices $2 times 2$ sunt, dictae matrices Paulianae, quae sic definiuntur:
$
  sigma^1 = mat(0, 1; 1, 0); sigma^2 = mat(0, -i; i, 0); sigma^3 = mat(1, 0; 0, -1)
$
*Proprietas:*
$
  forall i,j in [|1; 3|], {sigma^i; sigma^j} = 2 delta^(i j)
$
Ad comprehendendum quod sit vinculum inter hanc algebram et coetus Lorentzii, demonstrabimus quandam magnitudinem relationem commutationis a @commutateurM definitam respicere, ad hoc plures proprietates huius rei demonstrabimus, donec eandem relationem commutationis assequamur.\
Definiamus igitur $S^(mu nu)$ per:\
*Definitio & proprietas:*
$
  S^(rho sigma) = 1/4[gamma^rho; gamma^sigma] = vec(0 &"si " rho = sigma, 1/2 gamma^rho gamma^sigma &"aliter", delim: "{") = 1/2 gamma^rho gamma^sigma - 1/2 eta^(rho sigma)
$<defS>
*Demonstratio:*\
- Pro $mu = nu$:
$
  1/4 [gamma^mu; gamma^mu] = 1/4 ((gamma^mu)^2 - (gamma^mu)^2) = 0 = 1/2 (gamma^mu)^2 - 1/2 eta^(mu mu)
$
- Pro $rho != sigma$:
$
  1/4 [gamma^rho; gamma^sigma] = 1/4 (gamma^rho gamma^sigma - underbrace(gamma^sigma gamma^rho, = - gamma^rho gamma^sigma)) = 1/2 gamma^rho gamma^sigma = 1/2 gamma^rho gamma^sigma - underbrace(1/2eta^(rho sigma), = 0)
$
#QED

*Proprietas:*
$
  [S^(mu nu), gamma^rho] = gamma^mu eta^(nu rho) - gamma^nu eta^(mu rho)
$

*Demonstratio:*
$
  [S^(mu nu), gamma^rho] &= 1/2((gamma^mu gamma^nu - eta^(mu nu))gamma^rho - gamma^rho (gamma^mu gamma^nu - eta^(mu nu)))\
  &= 1/2 (gamma^mu gamma^nu gamma^rho - gamma^rho gamma^mu gamma^nu + cancel(eta^(mu nu)gamma^rho) - cancel(gamma^rho eta^(mu nu)))\
  &= 1/2 (gamma^mu underbrace((gamma^nu gamma^rho + gamma^rho gamma^nu), = {gamma^nu; gamma^rho}) - underbrace((gamma^mu gamma^rho + gamma^rho gamma^mu), = {gamma^mu; gamma^rho}) gamma^nu )\
  &= gamma^mu eta^(nu rho) - gamma^nu eta^(mu rho)
$
#QED

*Proprietas:*
$
  [S^(mu nu); S^(rho sigma)] = S^(mu sigma) eta^(nu rho) - S^(nu sigma) eta^(rho mu) + S^(rho mu) eta^(nu sigma) - S^(rho nu) eta^(sigma mu)
$
*Demonstratio:*
$
  [S^(mu nu); S^(rho sigma)] & = 1/2[S^(mu nu); (gamma^rho gamma^sigma) - eta^(rho sigma)]\
  &= 1/2 [S^(mu nu); gamma^rho gamma^sigma] - 1/2 underbrace([S^(mu nu); eta^(rho sigma)], = 0)\
  &= 1/2 gamma^rho [S^(mu nu); gamma^sigma] + 1/2 [S^(mu nu); gamma^rho] gamma^sigma\
  &= 1/2 (gamma^rho gamma^mu eta^(nu sigma) - gamma^rho gamma^nu eta^(mu sigma) + gamma^mu gamma^sigma eta^(nu rho) - gamma^nu gamma^sigma eta^(mu rho))
$<commutS>
Autem secundum @defS: $gamma^mu gamma^nu = 2 S^(mu nu) + eta^(mu nu)$, sic:
$
  [S^(mu nu); S^(rho sigma)] &= S^(rho mu) eta^(nu sigma) + cancel(1/2 eta^(rho mu) eta^(nu sigma)) - S^(rho nu) eta^(mu sigma) - cancel(1/2 eta^(rho nu) eta^(mu sigma)) + S^(mu sigma) eta^(nu rho) + cancel(1/2 eta^(mu sigma) eta^(nu rho)) - S^(nu sigma) eta^(mu rho) - cancel(1/2 eta^(nu sigma) eta^(mu rho))\
  &= S^(rho mu) eta^(nu sigma) - S^(rho nu) eta^(mu sigma) + S^(mu sigma) eta^(nu rho) - S^(nu sigma) eta^(mu rho)
$
#QED

Sic regredimur ad relationem commutationis pro $cal(M)$ pro $S$, ergo hae duae repraesentationes bene eundem coetum repraesentant, scilicet illum Lorentzii.

=== Spinores Diraci

Spinores Diraci definiuntur per campum spinorialem, qui res quattuor componentium complexarum est et qui ut sequitur per transformationem Lorentzii transformatur:
$
  forall alpha in [|1; 4|], psi^alpha --> S[Lambda]^alpha""_beta psi^beta (Lambda^(-1) x)
$
ubi
$
  Lambda = exp(1/2 Omega_(rho sigma) cal(M)^(rho sigma))\
  S[Lambda] = exp(1/2 Omega_(rho sigma) S^(rho sigma))
$
hic $S[Lambda]$ repraesentat $Lambda$ in repraesentatione basis $S$ scriptum. Notandum quoque est nos isdem $Omega$ pro utraque repraesentatione uti, quod in tuto collocat nos eandem transformationem Lorentzii facere.\

Ad confirmandum $Lambda$ et $S[Lambda]$ revera diversa esse, hoc exemplum consideramus:\
\
_Exemplum:_ Rotatio\
Consideremus rotationem in plano $forall i,j in [|1,3|], (x^i, x^j)$, tum, pro $i != j$:
$
  S^(i j) &= 1/2 gamma^i gamma^j = 1/2 mat(0, sigma^i; -sigma^i, 0) mat(0, sigma^j; -sigma^j, 0) = 1/2 mat(-sigma^i sigma^j, 0; 0, - sigma^i sigma^j)\
  &= -i/2 epsilon^(i j k) mat(sigma^k, 0; 0, sigma^k)
$
Praeterea parameter $Omega$ in casu rotationis in plano $(x^i, x^j)$ scribi potest:
$
  Omega_(i j) = - epsilon_(i j k)phi^k
$
ubi $arrow(phi) = (phi^1, phi^2, phi^3)$ et $arrow(sigma) = (sigma^1, sigma^2, sigma^3)$, ubi unaquaeque pars rotationem $phi^i$ circum axem $x^i$ repraesentat\
Tum, matrix rotationis fit:
$
  S[Lambda] & = exp(1/2 Omega_(rho sigma) S^(rho sigma)) \
            & = exp(1/4 i epsilon^(i j k) epsilon_(i j l) phi^l mat(sigma^k, 0; 0, sigma^k)) \
            & = exp(1/2 i delta^k_l phi^l mat(sigma^k, 0; 0, sigma^k)) \
            & = exp(1/2 i phi^k mat(sigma^k, 0; 0, sigma^k)) \
            & = mat(exp(i/2 phi^k sigma^k), 0; 0, exp(i/2 phi^k sigma^k)) \
            & = mat(e^(i (arrow(phi) dot.c arrow(sigma))/2), 0; 0, e^(i (arrow(phi) dot.c arrow(sigma))/2)) \
$
Sic in casu rotationis $theta$ circum axem $x^3$, $arrow(phi) = (0, 0, theta)$, tum:
$
  S[Lambda] = mat(e^(i (theta sigma^3)/2), 0; 0, e^(i (theta sigma^3)/2))
$
sic in casu rotationis $theta$, spinor solum dimidium huius rotationis efficiet, exempli gratia in casu rotationis integrae ($theta = 2pi$), habemus:
$
  S[Lambda] = - upright(I)_4
$
et ergo spinor hanc transformationem sequetur:
$
  psi^alpha (x) --> - psi^alpha (x)
$\
\
Ad hoc ut res rotationem integram faciat, oportet igitur eam rotationem $4 pi$ facere.\
Hae res sunt comparative contra-intuitivae, sed plura exempla accessibilia exstant, sicut rotatio manus sicut in saltatione Tari Piring, aut cum circum taeniam Moebii is (quod nihil ad vaccinia pertinet !), quo in casu cum gyrum perfeceris, in altera parte folii te reperis!\
\
*Cave !*\
Repraesentatio coetus Lorentzii non est unitaria, etenim ut sit, oportet $S^(rho sigma)$ anti-hermitianam esse, i.e. $(S^(rho sigma))^dagger = - S^(rho sigma)$, sed habemus:
$
  (S^(rho sigma))^dagger = 1/4 [(gamma^rho)^dagger; (gamma^sigma)^dagger]
$
Nisi quod $(gamma^0)^dagger = gamma^0$ et $(gamma^i)^dagger = -gamma^i$, ergo repraesentatio nostra unitaria esse non potest. Revera, hunc eventum generalizare possumus monstrando nullam repraesentationem unitariam dimensionis finitae coetuum Lorentzii exstare.

== Actio Diraci <actiondedirac>

Nunc propositum est actionem construere quae invarians sit per transformatas Lorentzii, super novis campis quos modo construximus: spinores Diraci. Ad hoc quaeritur actio quae scalaris sit per transformatas Lorentzii.\
\
Simpliciter, spectare poterimus quomodo $psi^dagger (x) psi(x)$ transformetur, ubi $psi^dagger$ definitur per:
$
  psi^dagger (x) = (psi^star)^t (x)
$
Spectemus igitur, quomodo hoc productum sub hac transformatione transformetur:
$
  psi --> S[Lambda] psi(Lambda^(-1) x)\
  psi^dagger --> psi^dagger (Lambda^(-1) x) S[Lambda]^dagger
$
Tum productum fit:
$
  (psi')^dagger (x) psi' (x) & = psi^dagger (Lambda^(-1) x) S[Lambda]^dagger S[Lambda] psi (Lambda^(-1) x)
$
Sed monstravimus (disputavimus) repraesentationem coetus Lorentzii non esse unitariam ergo $S[Lambda]^dagger S[Lambda] != 1$, sic hoc productum non ut scalaris transformatur, et non habet bonam transformationem in coetu Lorentzii. Nunc cum viderimus cur hoc non procedat. Ad elementum construendum quod procedit, consideremus algebram Cliffordianam, talem ut: $(gamma^0)^dagger = gamma^0$ et $forall i in [|1, 3|], (gamma^i)^dagger = - gamma^i$, sic, primum notare poterimus:
$
                        & gamma^0 gamma^0 gamma^0 = gamma^0 = (gamma^0)^dagger \
  forall i in [|1, 3|], & gamma^0 gamma^i gamma^0 = - gamma^i = (gamma^i)^dagger
$
Sic, has formulas in unam multo commodiorem rescribere possumus:
$
  forall mu in [|0, 3|], (gamma^mu)^dagger = gamma^0 gamma^mu gamma^0
$
Praeterea, habemus:\
*Proprietas:*
$
  (S^(rho sigma))^dagger = - gamma^0 S^(rho sigma) gamma^0
$
*Demonstratio:*
$
  (S^(rho sigma))^dagger & = 1/4 [(gamma^sigma)^dagger; (gamma^rho)^dagger] \
                         & = 1/4 [gamma^0 gamma^sigma gamma^0; gamma^0 gamma^rho gamma^0] \
                         & = - 1/4 gamma^0 [gamma^rho; gamma^sigma] gamma^0 \
                         & = - gamma^0 S^(rho sigma) gamma^0
$
#QED

Tum, videre possumus quomodo $S[Lambda]$ sub adiuncto (pugione) se gerat:\
*Proprietas:*
$
  (S[Lambda])^dagger = gamma^0 S[Lambda]^(-1) gamma^0
$
*Demonstratio:*
$
  (S[Lambda])^dagger & = exp(1/2 Omega_(rho sigma) (S^(rho sigma))^dagger) \
                     & = exp(- 1/2 Omega_(rho sigma) gamma^0 S^(rho sigma) gamma^0) \
                     & = underbrace(1, = gamma^0 gamma^0) - 1/2 Omega_(rho sigma) gamma^0 S^(rho sigma) gamma^0 \
                     & = gamma^0 (1 - 1/2 Omega_(rho sigma) S^(rho sigma)) \
                     & = gamma^0 exp(-1/2 Omega_(rho sigma)S^(rho sigma)) gamma^0 = gamma^0 S[Lambda]^(-1) gamma^0
$
#QED
\
Sic, adiunctum Diraci definire possumus per:
$
  dash(psi) = (psi)^dagger gamma^0
$
Videamus igitur quomodo hic per coetum Lorentzii transformetur:

*Proprietas:*
$
  dash(psi) (x) psi(x) "scalaris Lorentzii est"
$\

*Demonstratio:*
$
  dash(psi') (x) psi'(x) &= (psi')^dagger (x) gamma^0 psi'(x)\
  &= psi^dagger (Lambda^(-1) x) S[Lambda]^dagger gamma^0 S[Lambda] psi(Lambda^(-1) x)\
  &= psi^dagger (Lambda^(-1) x) gamma^0 cancel(S[Lambda]^(-1) gamma^0 gamma^0 S[Lambda]) psi(Lambda^(-1) x)\
  &= psi^dagger (Lambda^(-1) x) gamma^0 psi(Lambda^(-1) x)\
  &= dash(psi) (Lambda^(-1) x) psi(Lambda^(-1) x)\
$\
\
Hac eadem methodo, duo alia invariantia per transformatas Lorentzii construere possumus, vectores et tensores, etenim:\
\
*Proprietas:*
$
  dash(psi) gamma^mu psi "vector Lorentzii est, i.e.:"\
  dash(psi) (x) gamma^mu psi (x) --> Lambda^mu""_nu dash(psi) (Lambda^(-1) x) gamma^nu psi (Lambda^(-1) x)
$\

*Demonstratio:*
Vide Tong\
\
\
*Proprietas:*
$
  dash(psi) gamma^mu gamma^nu psi "tensor Lorentzii est"\
  dash(psi) (x) gamma^mu gamma^nu psi (x) --> Lambda^mu""_rho Lambda^nu""_sigma dash(psi) (Lambda^(-1) x) gamma^rho gamma^sigma psi (Lambda^(-1) x)
$\

*Demonstratio:*
Vide Tong
\
\
\
Nunc igitur actionem invariantem per coetum Lorentzii construere possumus, gratia III formarum bilinearium quas modo construximus: $dash(psi) psi, dash(psi) gamma^mu psi$ et $dash(psi) gamma^mu gamma^nu psi$, revera solum primae duae utiles erunt, tum actionem Diraci definimus per:
$
  S = integral dx^4 dash(psi) (x) (i gamma^mu partial_mu - m) psi (x)
$ <ActionDirac>

== Aequatio Diraci

Ab actione Diraci, supra definita, hoc Lagrangianum deducere possumus:
$
  cal(L) = dash(psi) (i gamma^mu partial_mu - m) psi
$
\
Sic habemus:
$
        partial_mu ((partial lagr)/(partial (partial_mu psi))) & = i partial_mu dash(psi) gamma^mu \
                                                          "et" \
  partial_mu ((partial lagr)/(partial (partial_mu dash(psi)))) & = 0
$
Sed
$
        (partial lagr)/(partial psi) & = -m dash(psi) \
                                "et" \
  (partial lagr)/(partial dash(psi)) & = i gamma^mu partial_mu psi - m psi
$
Ergo per aequationes Euler-Lagrange, has duas aequationes invenimus:
$
  (i gamma^mu partial_mu - m) psi = 0
$<eqDirac>
$
  i partial_mu dash(psi) gamma^mu + m dash(psi) = 0
$
Hae aequationes interdum quoque vocantur "radices quadratae" solutionis aequationis Klein-Gordon, etenim hae aequationes aequationi Klein-Gordon solutiones sunt:
$
  (i gamma^nu partial_nu - m)(i gamma^mu partial_mu + m) psi = - (gamma^mu gamma^nu partial_nu partial_mu + m^2) psi = 0
$
Sed ostendere possumus in nostro casu: $gamma^mu gamma^nu = eta^(mu nu)$, sic invenimus:
$
  - (eta^(mu nu) partial_mu partial_nu + m^2) psi = -(partial^mu partial_mu + m^2)psi = 0\
$
haec aequatio non iam de $gamma^mu$ dependet, sic eodem modo omnibus componentibus $psi$ applicatur\
\
*Notatio Slash*\
In multis libris aequatio Diraci ut sequitur scripta invenitur:
$
  (i fey(partial) - m)psi = 0
$
ubi hanc notationem, comparative commode, definimus:
$
  fey(A) = gamma^mu A_mu
$

== Spinores Chirales

In exemplo vidimus $S[Lambda]$ in casu rotationis scribi ut:
$
  S[Lambda_"rot"] = mat(e^(i (arrow(phi) dot.c arrow(sigma))/2), 0; 0, e^(i (arrow(phi) dot.c arrow(sigma))/2))
$
Ostendi potest in casu Impulsus (Boost) $S[Lambda]$ scribi posse:
$
  S[Lambda_"boost"] = mat(e^(arrow(chi) dot.c arrow(sigma) \/ 2), 0; 0, e^(- arrow(chi) dot.c arrow(sigma) \/ 2))
$
ubi $arrow(chi)$ parameter impulsus est ($forall i in [|1;3|], Omega_(i 0) = chi_i$)\
\
Notamus has matrices per bloccos diagonales esse, quod significat repraesentationem spinorum Diraci coetus Lorentzii reductibilem esse, i.e. duo (quoniam duo blocci in diagonali) subcoetus irreductibiles exstare, nostrae repraesentationi supplementares. Sic spinorem Diraci $psi$ in duas componentes $u_plus.minus$ decomponere possumus, quas sic definimus:
$
  psi = vec(u_+, u_-)
$
Duae componentes $u_plus.minus$ vocantur spinores Weyl vel spinores chirales, quia uni blocco nostrae transformationis respondent, transformantur ut:
- pro rotationibus:
$
  u_plus.minus --> e^(i arrow(phi) dot.c arrow(sigma) \/2) u_plus.minus
$
- pro impulsibus:
$
  u_plus.minus --> e^(plus.minus i arrow(chi) dot.c arrow(sigma) \/2) u_plus.minus\
$\
\
Spectare possumus quid aequatio #link(<eqDirac>)[Diraci] fiat, ad hoc in antecessum magnitudines calculemus: $psi^dagger$ & $gamma^0 gamma^mu$\
\
*Proprietas:*
$
  psi^dagger = ((u_plus)^dagger " " (u_minus)^dagger )
$\
*Demonstratio:*
$
  psi^dagger & = vec(u_+, u_-)^dagger = (vec(u_+, u_-)^star)^t \
             & = ((u_+^star)^t " " (u_-^star)^t) = (u_+^dagger " " u_-^dagger)
$
#QED\
\
*Proprietas:*
$
  gamma^0 gamma^mu = mat(dash(sigma)^mu, 0; 0, sigma^mu)
$
ubi $sigma = (1, sigma^i)$ et $dash(sigma) = (1, - sigma^i)$ redefinimus, per indicem $mu$ denotatum, quod non est confundendum cum $sigma^i$ quod semper ad originales $sigma$ refertur\
\
*Demonstratio:*
$
  gamma^0 gamma^mu &= cases(gap: #5mm, gamma^0 gamma^0 = upright(I)_4 &"si" mu = 0, mat(0, 1; 1, 0) mat(0, sigma^i; - sigma^i, 0) = mat(- sigma^i, 0; 0, sigma^i) &"aliter")\
  &= mat(dash(sigma)^mu, 0; 0, sigma^mu)
$
#QED\
\
Nunc, parati sumus ad rescribendum Lagrangianum Diraci, pro spinoribus Weyl
$
  lagr &= dash(psi) (i gamma^mu partial_mu -m) psi\
  &= i psi^dagger gamma^0 gamma^mu partial_mu psi - m psi^dagger gamma^0 psi\
  &= i mat(u_+^dagger, u_-^dagger) mat(dash(sigma)^mu, 0; 0, sigma^mu) vec(partial_mu u_+, partial_mu u_-) - m mat(u_+^dagger, u_-^dagger) mat(0, 1; 1, 0) vec(u_+, u_-)\
  &= i mat(u_+^dagger, u_-^dagger) vec(dash(sigma)^mu partial_mu u_+, sigma^mu partial_mu u_-) - m mat(u_+^dagger, u_-^dagger) vec(u_-, u_+)\
  &= i u_+^dagger dash(sigma)^mu partial_mu u_+ + i u_-^dagger sigma^mu partial_mu u_- - m (u_+^dagger u_- + u_-^dagger u_+)
$
Sed habemus si aequationes motus respiciuntur $lagr = 0$, ergo:
$
  i u_+^dagger dash(sigma)^mu partial_mu u_+ + i u_-^dagger sigma^mu partial_mu u_- - m (u_+^dagger u_- + u_-^dagger u_+) = 0
$
Sic, notamus in casu fermionis massivi, opus esse $u_+$ vel $u_-$ describere, quia hi duo termini in termino massae copulantur, tamen, in casu fermionis non massivi hic terminus evanescit, sufficit solum $u_+$ vel $u_-$ ad tale fermion describendum, quod igitur hanc aequationem motus respicere debet:
$
  i dash(sigma)^mu partial_mu u_+ = 0 "descriptus a" u_+\
  i sigma^mu partial_mu u_- = 0 "descriptus a" u_-\
$

*Demonstratio:*\
Cum fermion non massivum sit, tum lagrangianum rescribitur:
$
  lagr = i u_+^dagger dash(sigma)^mu partial_mu u_+ + i u_-^dagger sigma^mu partial_mu u_-
$
Habemus igitur, ex una parte:
$
  partial_mu ((partial lagr)/ (partial (partial_mu u_+^dagger))) = 0
$
et ex altera parte:
$
  (partial lagr)/(partial u_+^dagger) = i dash(sigma)^mu partial_mu u_+
$
Ergo secundum aequationes Euler-Lagrange, invenimus:
$
  i dash(sigma)^mu partial_mu u_+ = 0
$
Secundam aequationem invenimus per eundem calculum per parametrum $u_-^dagger$
#QED

== Proiectio in alias repraesentationes <projection>
In nostra repraesentatione $S[Lambda]$ nobis per bloccos diagonalis apparet, ideo enim haec repraesentatio etiam repraesentatio chiralis vocatur, quia hanc decompositionem in spinores chirales explicat. Spectemus quid aliis repraesentationibus $gamma^mu$ algebrae Cliffordianae fieret:
$
  gamma^mu --> U gamma^mu U^(-1) et psi --> U psi
$
Sic $S[Lambda]$ nullam causam habet ut diagonalis per bloccos sit, nunc inveniendum est nobis invarians ad spinores chirales definiendos.\
Ad hoc hanc rem definire possumus:\
*Definitio:*
$
  gamma^5 = - i gamma^0 gamma^1 gamma^2 gamma^3
$\
\
*Proprietas:*
$
  {gamma^5, gamma^mu} = 0 et (gamma^5)^2 = upright(I)_4
$\
\
*Demonstratio:*\
sit $mu in [|0; 3|]$
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
*Proprietas:*\
$
  [S_(mu nu); gamma^5] = 0
$\
*Demonstratio:*
$
  S_(mu nu) gamma^5 &= 1/2 (eta_(mu rho) eta_(nu sigma) gamma^rho gamma^sigma - eta_(mu nu)) gamma^5 = 1/2 (eta_(mu rho) eta_(nu sigma) gamma^rho gamma^sigma gamma^5 - gamma^5 eta_(mu nu))\
  &= 1/2 ( - eta_(mu rho) eta_(nu sigma) gamma^rho gamma^5 gamma^sigma - gamma^5 eta_(mu nu))\
  &= 1/2 ( eta_(mu rho) eta_(nu sigma) gamma^5 gamma^rho gamma^sigma - gamma^5 eta_(mu nu))\
  &= 1/2 gamma^5 ( eta_(mu rho) eta_(nu sigma) gamma^rho gamma^sigma - eta_(mu nu))\
  &= gamma^5 S_(mu nu)\
$
Ergo habemus bene:
$
  [S_(mu nu); gamma^5] = S_(mu nu) gamma^5 - gamma^5 S_(mu nu) = 0
$
#QED

Haec ultima proprietas, nobis indicat $gamma^5$ scalarem sub rotationibus et impulsibus esse et quoniam $(gamma^5)^2 = upright(I)_4$, has proiectiones definire possumus, quae igitur per coetum Lorentzii invariantes sunt:
$
  P_plus.minus = 1/2 (upright(I)_4 plus.minus gamma^5)
$
*Proprietas:*
$
  P_plus.minus "est proiectio" et P_+ P_- = 0
$\
*Demonstratio:*
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
In nostra repraesentatione $gamma^5$ scribitur:
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
Notamus igitur in nostra repraesentatione $P_plus.minus$ spinorem Diraci $psi$ in eius componentes chirales proicere. Componentes chirales igitur pro qualibet repraesentatione definire possumus per:
$
  psi_plus.minus = P_plus.minus psi
$
quae igitur repraesentationes irreductibiles coetus Lorentzii sunt.

=== Paritas
In mechanica quantica, duae symetriae discretae comparative graves sunt:
$
  "Reversio temporis:" & (x^0, x^i) --> (-x^0, x^i) \
                 "Paritas:" & (x^0, x^i) --> (x^0, -x^i)
$
Nos tantum de symetria paritatis curabimus. Spectemus quomodo igitur spinores chirales transformentur, ad hoc spectabimus quid fiat pro elementis coetus $(1/2, 0)$, haec elementa igitur definiuntur sicut ita transformantia:
- Rotatio:
$
  S[Lambda_"Rot"] u = e^(i/2 arrow(phi) dot.c arrow(sigma)) u
$
- Impulsus:
$
  S[Lambda_"Boost"] u = e^(1/2 arrow(chi) dot.c arrow(sigma)) u
$
Sed cum proiectionem his transformationibus applicamus obtinemus:
- Rotatio:
$
  P(S[Lambda_"Rot"] u) = e^(i/2 arrow(phi) dot.c arrow(sigma)) u
$
- Impulsus:
$
  P(S[Lambda_"Boost"] u) = e^( - 1/2 arrow(chi) dot.c arrow(sigma)) u
$
Quod exacte definitio elementi coetus $(0, 1/2)$ est, eadem methodo ostendere possemus elementum coetus $(0, 1/2)$ fieri elementum coetus $(1/2, 0)$, sic $P$ bijectionem inter $(0, 1/2)$ et $(1/2, 0)$ efficit, aliter dictum, habemus:
$
  P(u_plus.minus) = u_minus.plus
$

Sic spinor Diraci transformatur per:\
*Proprietas:*
$
  P (psi) = gamma^0 psi
$\
*Demonstratio:*
$
  gamma^0 psi & = mat(0, 1; 1, 0) vec(psi_+, psi_-) = vec(psi_-, psi_+) \
              & = vec(P(psi_+), P(psi_-)) = P(vec(psi_+, psi_-)) = P(psi)
$
#QED

Spectare possumus quid fiat aequatio Diraci per hanc symetriam:
$
  (i gamma^mu partial_mu - m) psi' = (i gamma^0 partial_t + i gamma^i partial_i - m) gamma^0 psi = gamma^0 (i gamma^0 partial_t - gamma^i partial_i - m) psi = 0
$
ubi signum per transitum $gamma^5$ adeptum compensatur per derivatam super $- arrow(x)$\
\
==== Interactivitas chiralis
Spectare quoque possumus quomodo termini copulationis sub symetria paritatis transformentur, sic pro quaque forma bilineari ad @actiondedirac inventa calculabimus.\
Pro scalaribus, habemus:
$
  P (dash(psi) psi) = dash(P(psi)) P(psi) = dash(gamma^0 psi) gamma^0 psi = dash(psi) gamma^0 gamma^0 psi = dash(psi) psi
$
Quod transformatio scalarium est.\
Pro vectore, casum temporalem a casu spatiali distinguemus:
$
  P(dash(psi) gamma^0 psi) = dash(P(psi)) gamma^0 P(psi) = dash(psi) gamma^0 gamma^0 gamma^0 psi = dash(psi) gamma^0 psi\
  P(dash(psi) gamma^i psi) = dash(P(psi)) gamma^0 P(psi) = dash(psi) gamma^0 gamma^i gamma^0 psi = - dash(psi) gamma^i psi\
$
Observamus, ut exspectatum, inversionem signi super componentibus spatialibus vectorum, et quod haec bene sicut vectores transformantur.\
Ostendere possemus tensorem $S^(mu nu)$ quoque sicut decet transformari, tamen, magis curabimus de duabus formis bilinearibus quas in @projection ope $gamma^5$ construere potuimus: $dash(psi) gamma^5 psi$ & $dash(psi) gamma^5 gamma^mu psi$
$
  P(dash(psi) gamma^5 psi) = dash(P(psi)) gamma^5 P(psi) = dash(psi) gamma^0 gamma^5 gamma^0 psi = - dash(psi) gamma^5 psi\
  P(dash(psi) gamma^5 gamma^mu psi) = dash(P(psi)) gamma^5 gamma^mu P(psi) = dash(psi) gamma^0 gamma^5 gamma^mu gamma^0 psi = cases(- dash(psi) gamma^5 gamma^0 psi &"si" mu = 0, + dash(psi) gamma^5 gamma^mu psi &"si" mu != 0)
$
Habemus igitur $dash(psi) gamma^5 psi$ sicut pseudo-scalarem transformari et $dash(psi) gamma^5 gamma^mu psi$ sicut pseudo-vectorem transformari\
\
Typum diversarum formarum bilinearium quas hucusque construximus in tabula sequenti comprehendere possumus:
#figure(
  grid(
    columns: 2,
    column-gutter: 1cm,
    row-gutter: 0.5cm,
    align: center + horizon,
    $dash(psi) psi$, [scalaris],
    $dash(psi) gamma^mu psi$, [vector],
    $dash(psi) S^(mu nu) psi$, [Tensor],
    $dash(psi) gamma^5 psi$, [pseudo-scalaris],
    $dash(psi) gamma^5 gamma^mu psi$, [pseudo-vector],
  ),
  gap: 7mm,
  caption: [Typus formarum bilinearium],
)\

Invenimus igitur $1 + 4 + (4 times 3\/2) + 1 + 4 = 16$ formas bilineares, qui igitur numerus maximus est quem invenire sperare possumus.\

== Symetria & Fluxio conservata

Lagrangianum Diraci 4 symetrias codificat: \
\
#set enum(indent: 1cm, spacing: 4mm)
+ Translatio spatio-temporalis

+ transformatio Lorentzii
+ symetria interna vectorum
+ symetria axialis

In hoc capite proponimus fluxionem Noetherianam unicuique symetriae associatam calculare.\
Primum habemus:
$
  (partial lagr)/(partial(partial psi)) = i dash(psi) gamma^mu
$
et
$
  (partial lagr)/(partial(partial dash(psi))) = 0
$
Ergo habemus:
$
  J^mu = i dash(psi) gamma^mu (delta psi)/(delta alpha) - F^mu
$

=== Translatio spatio-temporalis
Iam vidimus in casu translationis spatio-temporalis $x --> x + epsilon$, nos habere:
$
  delta psi = epsilon^nu partial_nu psi
$
Et quod
$
  delta lagr = epsilon^nu partial_nu lagr
$
Sic, fluxio nostra fit:
$
  T^mu""_nu = (J^mu)_nu = i dash(psi) gamma^mu partial_nu psi - delta^mu""_nu lagr
$
Sed si aequationes motus respiciuntur, habemus $lagr = 0$, unde:
$
  T^(mu nu) = i dash(psi) gamma^mu partial^nu psi
$

=== Transformatio Lorentzii

Sub transformatione Lorentzii infinitesimali, $psi$ sic transformatur:
$
  psi'^alpha (x) & = S[Lambda] psi^alpha (Lambda^(-1) x) \
  & = e^(1/2 Omega_(rho sigma) (S^(rho sigma))^alpha""_beta) psi^beta ((delta^mu""_nu - omega^mu""_nu) x^nu) \
  & = (delta^alpha + 1/2 Omega_(rho sigma) (S^(rho sigma))^alpha""_beta) psi^beta (x^mu - omega^mu""_nu x^nu)\
  & = (delta^alpha""_beta + 1/2 Omega_(rho sigma) (S^(rho sigma))^alpha""_beta) (psi^beta - omega^mu""_nu x^nu partial_mu psi^beta)\
  & = psi^alpha - omega^mu""_nu x^nu partial_mu psi^alpha + 1/2 Omega_(rho sigma) (S^(rho sigma))^alpha""_beta psi^beta - 1/2 Omega_(rho sigma) omega^mu""_nu (S^(rho sigma))^alpha""_beta psi^beta \
$ <2.6.2.1>
Sed habemus $omega^mu""_nu = 1/2 Omega_(rho sigma) (cal(M)^(rho sigma))^mu""_nu$ et $(cal(M)^(rho sigma))^mu""_nu = eta^(rho mu) delta^(sigma)""_nu - eta^(sigma mu) delta^rho""_nu$, ergo:
$
  omega^mu""_nu &= 1/2 Omega_(rho sigma) (cal(M)^(rho sigma))^mu""_nu = omega^mu""_nu = 1/2 Omega_(rho sigma) (eta^(rho mu) delta^(sigma)""_nu - eta^(sigma mu) delta^rho""_nu)\
  &= 1/2 (Omega^mu""_nu - Omega_nu""^mu) = 1/2 times 2 Omega^mu""_nu = Omega^mu""_nu
$
Ergo substituendo $Omega^(mu nu)$ per $omega^(mu nu)$ in @2.6.2.1 obtinemus:
$
  psi'^alpha (x) &= psi^alpha - omega^mu""_nu x^nu partial_mu psi^alpha + 1/2 omega_(rho sigma) (S^(rho sigma))^alpha""_beta psi^beta - underbrace(1/2 omega_(rho sigma) omega^mu""_nu (S^(rho sigma))^alpha""_beta psi^beta, = o(omega^(mu nu)))\
  &= psi^alpha underbrace(- omega_(mu nu) (x^nu partial^mu psi^alpha - 1/2 (S^(mu nu))^alpha""_beta psi^beta), = delta psi^alpha)
$
Ergo
$
  delta psi^alpha & = - omega_(mu nu) (x^nu partial^mu psi^alpha - 1/2 (S^(mu nu))^alpha""_beta psi^beta)
$
Sed per anti-symmetricam primus terminus rescribitur:
$
  -omega_(mu nu) x^nu partial^mu psi^alpha &= -1/2 (omega_(mu nu) - omega_(nu mu)) x^nu partial^mu psi^alpha\
  &= -1/2(omega_(mu nu)x^nu partial^mu psi^alpha - omega_(nu mu)x^mu partial^nu psi^alpha)
$
Et ergo habemus tandem:
$
  delta psi^alpha = -1/2(omega_(mu nu)x^nu partial^mu psi^alpha - omega_(nu mu)x^mu partial^nu psi^alpha) + 1/2 omega_(mu nu)(S^(mu nu))^alpha""_beta psi^beta
$
Sicut in casu translationis spatio-temporalis habemus $F^mu = 0$, ergo:
$
  (J^(mu))^(rho sigma) &= i dash(psi) gamma^mu (-1/2(x^sigma partial^rho psi - x^rho partial^sigma psi) + 1/2 (S^(rho sigma)) psi)\
  &= -1/2 x^sigma underbrace(i dash(psi)gamma^mu partial^rho psi, = T^(mu rho)) + 1/2 x^rho underbrace(i dash(psi)gamma^mu partial^sigma psi, = T^(mu sigma)) + 1/2 dash(psi) gamma^mu S^(rho sigma) psi\
  &= 1/2 (x^rho T^(mu sigma) - x^sigma T^(mu rho) + dash(psi) gamma^mu S^(rho sigma) psi)
$
Quoniam fluxiones ad factorem definitae sunt, hanc fluxionem definimus:
$
  (cal(J)^mu)^(rho sigma) = 2 (J^mu)^(rho sigma) = x^rho T^(mu sigma) - x^sigma T^(mu rho) + dash(psi) gamma^mu S^(rho sigma) psi
$

=== Symetria interna vectorum

Facile est verificare lagrangianum invarians esse per mutationem phasis: $psi -> e^(i alpha) psi$, sic hoc naturaliter symetriam constituit, sic, habemus:
$
  delta psi = i alpha
$
et quoniam lagrangianum invarians est $F^mu = 0$\
Obtinemus igitur hanc fluxionem:
$
  j^mu & = i dash(psi) gamma^mu times i psi \
       & = - dash(psi) gamma^mu psi
$
Secundam fluxionem positivam, comparate ad eam a theoremate Noetheriano directe datam, iterum definimus per:
$
  j^mu_V = - j^mu = dash(psi) gamma^mu psi
$
Agnovimus hic expressionem vectoris

=== Symetria axialis

Cum massa nulla est ($m = 0$) lagrangianum symetriam additam admittit quae fermiones laevos et dextros in sensu opposito rotare facit:
$
  psi -> e^(i alpha gamma^5) psi
$
Ergo
$
  delta psi = i alpha gamma^5
$
Sic eodem ratiocinio quo