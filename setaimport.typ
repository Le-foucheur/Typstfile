#set heading(
  numbering: (..numbers) => {
    let n = numbers.pos().len();
    if n == 1 { question.update(0); } else if n == 2 { [Partie ]; numbering("I", numbers.pos().at(1)) ;"." } else if n == 3 { [N=°];question.step(); question.display();"." } else if n == 4 { numbering("a.", numbers.pos().at(3) + 1) } else if n == 5 { numbering("i.", numbers.pos().at(4)) }
  },
)
#set underline(stroke: red + 1pt)
#set par(leading: 10pt)