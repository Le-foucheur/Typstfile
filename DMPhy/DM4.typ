#let question = counter("questions")

#set heading(
  numbering: (..numbers) => {
    let n = numbers.pos().len();
    if n == 1 { question.update(0); } else if n == 2 { [Partie ]; numbering("I", numbers.pos().at(1)) ;"." } else if n == 3 { [N=°];question.step(); question.display();"." } else if n == 4 { numbering("a.", numbers.pos().at(3) + 1) } else if n == 5 { numbering("i.", numbers.pos().at(4)) }
  },
)
#show heading : it => {
  if it.body == [] or it.level >= 3 [#parbreak() #linebreak() #counter(heading).display() #it.body] else [#parbreak() #linebreak() #counter(heading).display() #it.body]
}

#let nonumeq = math.equation.with(block: true, numbering: none)
#let dm(x) = box[#nonumeq[#x]]
#let dfrac(x, y) = math.frac(dm(x), dm(y))
#let lbar(..args) = math.display(math.cases(delim: "|", ..args))
#let ubar(body, col: red) = rect(
  inset: 0pt,
  outset: (bottom: 3pt, rest: 0pt),
  stroke: (bottom: (0.5pt + col), rest: 0pt),
)[#body]

#let frame(x) = rect(stroke: 1pt + red, outset: (x: -2pt, y: 2pt))[#x]
#let dframe(x) = frame(dm(x))
#let donc = "Donc" + h(5pt)
#let onA = "On a" + h(5pt)
#let tq = "tel que" + h(5pt)
#let et = "et" + h(5pt)
#let dt = math.dif + "t"
#let tend(n, val) = $limits(-->)_(#n -> #val)$
#set underline(stroke: red + 1pt)
#let undermath(body, col: red)= {
  style(styles => {
    let size = measure(dm(body), styles);
    let size2 = measure(body, styles);
    let offshet = ((size.height) - (size2.height)) / 1.1 + 1.3pt;
    box(stroke: (bottom: col + 1pt), outset: (bottom: offshet), body);
  })
}
#let th = "th"
#let t(x) = for i in range(x) {
  h(1em)
}
#set par(leading: 10pt)
#let D(n, body) = {
  if n == 1 { math.accent(body, math.dot) } else if n == 2 { math.accent(body, math.dot.double) } else if n == 3 { math.accent(body, math.dot.triple) }
}
Gaspar Daguet
#align(
  center,
  text(20pt)[DM n°4\ Exercice 2: Particule dans une chambre à bulles],
)

Pour toute la suite de l'exercice, on sa place dans un référentiel terrestre
supposé galiléen

=== \
#t(1) On a: $ arrow(v) = lbar(#D(1)[x] \ #D(1)[y] \ #D(1)[z]) et arrow(B) = lbar(0\ 0\ B) $
#t(1) Ainsi: $ F_m = q arrow(v) and arrow(B) = q B lbar(#D(1)[y] \ -#D(1)[x]\ 0) $
#t(1) Alors par la seconde loi de Newton: $ m lbar(#D(2)[x] \ #D(2)[y] \ #D(2)[z]) = q B lbar(#D(1)[y] \ -#D(1)[x]\ 0) <=> lbar(#D(2)[x] \ #D(2)[y] \ #D(2)[z]) = (q B )/m lbar(#D(1)[y] \ -#D(1)[x]\ 0) = omega lbar(#D(1)[y] \ -#D(1)[x]\ 0) $
#t(1) #undermath[$ donc cases(#D(2)[x] = omega #D(1)[y] \ #D(2)[y] = -omega #D(1)[x]) $] \
#t(1)* N.B.* Le mouvement selon #D(2)[z] est nul donc on a $#D(1)[z] = 0$ (selon
les conditions initials)\ #t(1) donc le mouvement se fais dans un plan et donc
on ne le prend plus en compte\ #t(1) pour la suite des calcules

=== \
#t(1) Selon la question précédente:
$ cases(#D(2)[x] = omega #D(1)[y] \ #D(2)[y] = -omega #D(1)[x]) $
#t(1) Donc$ cases(
  integral_0^t #D(2)[x] dt= omega integral _0^t #D(1)[y] \ integral_0^t #D(2)[y] dt= -omega integral _0^t #D(1)[x]
) = cases(#D(1)[x] = omega y \ #D(1)[y] = -omega x + v_0) $
#t(1) Ainsi en remplaçant #D(1)[x] et #D(1)[y] dans la première équation on
trouve:
$ cases(#D(2)[x] = -omega^2 x + v_0/omega omega^2 \ #D(2)[y] = - omega ^2 y) $
#pagebreak()
#t(1) Ainsi $ cases(
  x(t) = A_x cos(omega t) + B_x sin(omega t) + v_0/omega \ y(t) = A_y cos(omega t) - B_y sin(omega t)
) $
#t(1) Grâce aux conditions initiales on trouve $A_x = -v_0/omega; B_x = 0; A_y = 0 et B_y = -v_0/omega $,
ainsi :
$ cases(
  x(t) = -v_0/omega cos(omega t) + v_0/omega \ y(t) = v_0/omega sin(omega t)
) $
#figure(
  image("elecprotonDM4.png"),
  caption: [trajectoire d'un proton (rouge) et d'un éléctron (bleu) dans la chambre à bulle
    en négligeant les frottement],
)

#pagebreak()

=== \
#t(1) Par la seconde loi de Newton, on a:
$ m lbar(#D(2)[x] \ #D(2)[y] \ #D(2)[z]) = q B lbar(#D(1)[y] \ -#D(1)[x]\ 0) - lambda lbar(#D(1)[x] \ #D(1)[y] \ #D(1)[z]) <=> lbar(#D(2)[x] \ #D(2)[y] \ #D(2)[z]) = (q B )/m lbar(#D(1)[y] \ -#D(1)[x]\ 0) - lambda/m lbar(#D(1)[x] \ #D(1)[y] \ #D(1)[z]) = omega lbar(#D(1)[y] \ -#D(1)[x]\ 0) - alpha lbar(#D(1)[x] \ #D(1)[y] \ #D(1)[z]) $
#t(1) On a donc $#D(2)[z] = -alpha #D(1)[z]$, donc en intégrant $#D(1)[z] = -alpha z$ Or $#D(1)[z] = 0$ alors $-alpha z = 0 <=> z = 0 $ car $alpha != 0$\
#t(1) Donc $z = 0$ et donc le mouvement se fais sur le plans $(x O y)$ \
#t(1) Deplus: $ cases(
  #D(2)[x] = omega #D(1)[y] - alpha #D(1)[x] \ #D(2)[y] = -omega #D(1)[x] - alpha #D(1)[y]
) $

=== \
#t(1) On a : $ #D(2)[u] = #D(2)[x] + i #D(2)[y] = omega#D(1)[y] - alpha #D(1)[x] - i omega #D(1)[x] - i alpha #D(1)[y] = #D(1)[x] (-alpha - i omega) + i #D(1)[y] (- alpha - i omega) = -(alpha + i omega)#D(1)[u] $
#t(1) Ainsi on retombe sur une équation différentiel du 1er ordre, on trouve
donc:
$ #D(1)[u] (t) = i v_0 e^(-(alpha + i omega)t) $
#t(1) Ainsi on trouve $ u(t) = -(i v_0)/(alpha + i omega) e^(-(alpha + i omega)t) + (i v_0)/(alpha^2 + omega^2 )= e^(-alpha t)(-(v_0 omega)/(alpha^2 + omega^2) - (alpha v_0)/(alpha^2 + omega^2)i)(cos(omega t) - i sin(omega t) +(v_0 omega)/(alpha^2 + omega^2) + (alpha v_0)/(alpha^2 + omega^2)i $
#t(1) On a donc:
$ cases(
  x(t) = Re(u(t)) = -v_0/(alpha^2 + omega^2)e^(-alpha t)(omega cos(omega t) + alpha sin(omega t)) + (v_0 omega)/(alpha^2 + omega^2) \ y(t) = Im(u(t)) = v_0/(alpha^2 + omega^2)e^(-alpha t)(omega sin(omega t) - alpha cos(omega t)) + (v_0 alpha)/(alpha^2 + omega^2)
) $

=== \
#t(1) Comme $e^(-alpha t) tend(t, +oo) 0$, alors on a:
$ P_(oo) = cases(
  x(oo) = (v_0 omega)/(alpha^2 + omega^2) \ y(oo) = (v_0 alpha)/(alpha^2 + omega^2)
) $

#figure(
  image("sansfrot.png", width: 29%),
  caption: [trajectoire d'un proton (rouge) et d'un éléctron (bleu) dans la chambre à bulle],
)