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
#let Id(n) = math.mat(..for x in range(n){
  let l = ()
  for y in range(n){
    if y == x {
      l.push(1)
    }
    else {l.push(0)}
  }
  (l,)
})
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
#let cv = "converge" + h(5pt)

Gaspar Daguet
#align(center, text(20pt)[Maths : DM 10])

=== \
