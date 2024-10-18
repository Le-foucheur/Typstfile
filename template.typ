#import "transposition.typ": *
#import "@preview/drafting:0.2.0": *

#let question = counter("questions")
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
#let donc = "donc" + h(3pt)
#let Donc = "Donc" + h(3pt)
#let onA = "On a" + h(3pt)
#let tq = "tel que" + h(3pt)
#let et = "et" + h(3pt)
#let dt = math.dif + "t"
#let Id(n) = math.mat(..for x in range(n){
  let l = ()
  for y in range(n){
    if y == x {
      l.push(1)
    } else { l.push(0) }
  }
  (l,)
})
#let M0(n) = math.mat(..for x in range(n){
  let l = ()
  for y in range(n){
    l.push(0)
  }
  (l,)
})
#let tend(n, val) = $limits(-->)_(#n -> #val)$
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
#let cv = "converge" + h(3pt)
#let bi = math.beta.alt
#let soitn(body, ens) = [soit $#body in #ens$]
#let soietn(body, ens) = [soient $#body in #ens$]
#let Soitn(body, ens) = [Soit $#body in #ens$]
#let Soietn(body, ens) = [Soient $#body in #ens$]
#let ssi = "si et seulement si" + h(1pt)
#let vect(body) = "Vect("+ body + ")"
#let ateb = math.beta.alt
#let Ker(body) = if (body.fields().keys() == ("text",)) {[Ker #body]} else {[Ker(#body) ]}
#let Im(body) = if (body.fields().keys() == ("text",)) {[Im #body]} else {[Im(#body) ]}
#let Vect = "Vect"
#let ou = "ou" + h(3pt)
#let G = $#text(font: "LT Perfume")[G]$+ h(4pt)
#let C = $#text(font: "LT Perfume")[C]$+ h(4pt)
#let ar(body) = $arrow(#body)$
#let ve(..body) = context{
  let max = 0mm
  for i in (body.pos()){
    let tmp = measure(i).height
    if tmp >= max {
      max = tmp
    }
  }
  grid(columns: 1,row-gutter: max+0.7mm ,grid.vline(), ..for i in range(body.pos().len()){
    (h(3pt)+body.pos().at(i),)
  })
}
#let equi(n : $n$, k : $+oo$) = $ tilde_(#n -> #k) $
#let po(ele : $x$ , vers : $0$ ) = $ =_(#ele -> #vers) $
#let QED = align(right, text[*Q.E.D.*]) // Quod erat demonstratum
#let AFL = align(center, text(17pt,fill: red)[*A.F.L.*]) //ad facio labor
#let a = text[#h(-16pt) a.]
#let card = "Card"
#let ux = $u_x$
#let uy = $u_y$
#let uz = $u_z$
#let Ur = $u_r$
#let ut = $u_theta$
#let up = $u_phi$
#let l2LN = "la seconde loi de Newton"
#let ab(body, attache) = math.attach(body, br:attache)
#let dS = $d"S"$







//tout les set rule :
#let template(doc) = [
  #set heading(numbering: (..numbers) => {
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
  })
  #set underline(stroke: red + 1pt)
  #set par(leading: 0.8em)
  #set page(numbering: (..nums) => nums.pos().map(na).join("/"),  number-align: right)
  #set math.cancel(stroke: red)
  #set text(font:"Linux Libertine")
  #doc
]