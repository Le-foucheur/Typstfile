#import "/template.typ": *
#import "/transposition.typ": *
#import "@preview/drafting:0.2.0":*

#set heading(
  numbering: (..numbers) => {
    let n = numbers.pos().len();
    if n == 1 { question.update(1); } 
    else if n == 2 { [Partie ]; numbering("I", numbers.pos().at(0)) ;"." }
    else if n == 3 { question.step(); margin-note(side:left, dy: -16.4pt, stroke: none)[#h(14pt)N=° #question.display().] } 
    else if n == 4 { margin-note(side:left, dy: -16.5pt, stroke: none)[#h(34pt)#numbering("a.", numbers.pos().at(3)+1) ]} 
    else if n == 5 { numbering("i.", numbers.pos().at(4)) }
  },
)
#set underline(stroke: red + 1pt)
#set par(leading: 0.7em)
#set page(numbering: (..nums) => nums.pos().map(na).join("/"), number-align: right)

Gaspar Daguet
#align(center, text(20pt)[Maths : DM 21])
#set-page-properties()

= Problème 2 : une construction rigoureuse des fonctions trigonométriques

=== \
Soit $z in CC$, alors 
$
sum abs(z^n/n!) = sum abs(z)^n/n! = e^abs(z)
$
Donc $sum z^n/n!$ converge absolument 

== \

=== \
Soit $z in ZZ$, alors
$
abs(a_n z^n) = o(r^n abs(z)^n)
$