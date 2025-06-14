#import "transposition.typ": *
#import "@preview/drafting:0.2.2": *

#let cal(body, _font: "LT Perfume") = $text(font: #_font, body)$ + h(5pt)
#let question = counter("questions")
#let nonumeq = math.equation.with(block: true, numbering: none)
#let dm(x) = box[#nonumeq[#x]]
#let dfrac(x, y) = math.frac(dm(x), dm(y))
#let ubar(body, col: red) = rect(
  inset: 0pt,
  outset: (bottom: 3pt, rest: 0pt),
  stroke: (bottom: (0.5pt + col), rest: 0pt),
)[#body]
#let donc = "donc" + h(3pt)
#let Donc = "Donc" + h(3pt)
#let onA = "On a" + h(3pt)
#let tq = "tel que" + h(3pt)
#let et = "et" + h(3pt)
#let dt = math.dif + "t"
#let ddt = math.diff + $t$
#let Id(n) = math.mat(..for x in range(n) {
  let l = ()
  for y in range(n) {
    if y == x {
      l.push(1)
    } else { l.push(0) }
  }
  (l,)
})
#let M0(n) = math.mat(..for x in range(n) {
  let l = ()
  for y in range(n) {
    l.push(0)
  }
  (l,)
})
#let tend(n, val) = $limits(-->)_(#n -> #val)$
#let th = math.op([th])
#let cv = "converge" + h(3pt)
#let soitn(body, ens) = [soit $#body in #ens$]
#let soietn(body, ens) = [soient $#body in #ens$]
#let Soitn(body, ens) = [Soit $#body in #ens$]
#let Soietn(body, ens) = [Soient $#body in #ens$]
#let ssi = "si et seulement si" + h(1pt)
#let ateb = math.beta.alt
#let Ker = math.class("unary", [#cal("K") #h(-01mm) er])
#let ImE = math.class("unary", [#cal("I")#h(-0.5mm)m])
#let Vect = math.class("unary", "Vect")
#let ou = "ou" + h(3pt)
#let ar(body) = $arrow(#body)$
#let vec(..body) = math.cases(delim: "|", ..body)
#let equi(n: $n$, k: $+oo$) = $ tilde_(#n -> #k) $
#let po(ele: $x$, vers: $0$) = $ =_(#ele -> #vers) $
#let QED = align(right, text[*Q.E.D.*]) // Quod erat demonstratum
#let AFL = align(center, text(17pt, fill: red)[*A.F.L.*]) //ad facio labor
#let a = text[#h(-16pt) a.]
#let card = math.class("unary", "Card")
#let ux = $u_x$
#let uy = $u_y$
#let uz = $u_z$
#let Ur = $u_r$
#let ut = $u_theta$
#let up = $u_phi$
#let dx = $dif x$
#let ddx = $diff x$
#let l2LN = "la seconde loi de Newton"
#let ab(body, attache) = math.attach(body, br: attache)
#let dS = $d"S"$
#let scal(x, y) = math.op($< #x | #y >$)



//tout les set rule :
#let template(doc) = [
  #set heading(
    numbering: (..numbers) => {
      let n = numbers.pos().len()
      if n == 1 {
        question.update(1)
      } else if n == 2 {
        [Partie ]
        numbering("I.", numbers.pos().at(1))
      } else if n == 3 {
        question.step()
        if question.get().last() < 10 {
          margin-note(side: left, dy: -16.4pt, stroke: none)[#h(14pt)N=° #question.display().]
        } else {
          margin-note(side: left, dy: -16.4pt, stroke: none)[#h(8pt)N=° #question.display().]
        }
      } else if n == 4 {
        margin-note(side: left, dy: -16.5pt, stroke: none)[#h(34pt)#numbering("a.", numbers.pos().at(3) + 1) ]
      } else if n == 5 {
        numbering("i.", numbers.pos().at(4))
      }
    },
  )
  #set underline(stroke: red + 1pt)
  #set par(leading: 0.8em)
  #set page(numbering: (..nums) => nums.pos().map(na).join("/"), number-align: right)
  #set math.cancel(stroke: red)
  #set text(font: "Linux Libertine", lang: "fr")
  #show math.equation: set block(breakable: true)
  #doc
]
