#set page(
  paper: "presentation-4-3",
  header: context [
    #set text(15pt, fill: white)
    #place(
      dx: -20mm,
      box(fill: rgb("#171568"), height: 15mm, width: 110%)[
        #place(dx: -5mm, right + horizon, [#h(18mm) Gaspar Daguet])
        #place(left + horizon, [test])
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
    if n == 1 {} else if n == 2 {} else if n == 3 {} else if n == 4 {} else if n == 5 {}
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
#import "@preview/cetz:0.3.2"

#let code(file, step: 30, langue: none, siz: 11pt, title: "code") = {
  let content = read(file)
  let size = content.split("\n").len()

  if langue == none {
    langue = file.split(".").at(-1)
  }

  for i in range(0, size, step: step) {
    let end = if i + step > size { size } else { i + step }
    let code = content.split("\n").slice(i, end).join("\n")
    [
      #pagebreak()
      == Annexe - #title
      #place(
        center + horizon,
        box(height: 200%, width: 90%)[
          #set align(left)
          #set text(size: siz)
          #raw(code, lang: langue)
        ],
      )
    ]
  }
}


#pagebreak()
