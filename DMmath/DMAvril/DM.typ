#import "/template.typ": *
#import "./transposition.typ" : *

#set heading(
  numbering: (..numbers) => {
    let n = numbers.pos().len();
    if n == 1 { question.update(0); } 
    else if n == 2 { [Partie ]; numbering("I", numbers.pos().at(1)) ;"." } 
    else if n == 3 { [N=°];numbering((..nums) => nums.pos().map(na).join(),numbers.pos().at(2));"." } 
    else if n == 4 { numbering("a.", numbers.pos().at(3) + 1) } 
    else if n == 5 { numbering("i.", numbers.pos().at(4)) }
  },
)
#set underline(stroke: red + 1pt)
#set par(leading: 0.7em)
#set page(numbering: (..nums) => nums.pos().map(na).join("/"), number-align: right)

Gaspar Daguet
#align(center, text(20pt)[Maths : DM #na(18)])

#t(1) Il est important avant de commencer lire ce DM\
#t(1) d'avoir bien compris le tableau et les exemples suivants

#grid(
  columns: 2,
  gutter: 5em,
  table(
    columns: 3,
    align: center,
    //chiffre
    [symbole usuel],[symbole du DM],[prononciation],
    [0],$fe$,[fé],
    [1],$ur$,[ur],
    [2],$tur$,[tur],
    [3],$an$,[an],
    [4],$rai$,[rai],
    [5],$kau$,[kau],
    [6],$geb$,[gèb],
    [7],$wun$,[wun],
    [8],$hag$,[hag],
    [9],$nau$,[nau],
    [10],$je$,[je],
    [11],$ei$,[ei],
    //symbole math
    $=$,$ing$,[ing/i ng],
    $+$,$ti$,[ti],
    $-$,$al$,[al],
    $times$,$dag$,[dag],
    $div$,$lag$,[lag],
    $in$,$so$,[so],
    $forall$,$per$,[per],
    $exists$,$ber$,[ber],
    $>$,$man$,[man],
    $<$,$eh$,[e],
    $>=$,$maning$,[maning],
    $<=$,$ehwing$,[ehwing],
    $!=$,$naing$, [naing],
    $subset$,$suz$, [suz],
    $supset$,$zus$, [zus],
  ),
  v(16em)+
  $ #na(79) ti #na(65) ing #na(144) " ce qui est équivalant à" 79+65=144 $ + 
  v(6em) + 
  $ e^inc limits(ing)_(x -> fe) ur ti inc ti inc^tur /tur! ti dots.c ti inc^v1 / v1! + o(inc^v1) $ + 
  align(center)[est équivalant à] +
  $ e^x limits(=)_(x -> 0) 1 + x + x^2/2 + dots.c + x^n/x! + o(x^n) $
)

#pagebreak()

= Problème #tur : nombres algébrique et extensions de corps \

== extensions de corps\

=== Premiers exemples a.\
#t(1) il est évidant que $RR$ est stable un sous-corps de $CC$ et de plus $CC$ est de dimension finis,\
#t(1) donc $CC$ est une extention finie de $RR$\
\
#t(1) de plus soit $com so CC$ alors
$ per inc, v1 so RR, com ing inc ti i v1 <=> com so Vect((ur,fe),(fe,i)) $
#t(1) Ainsi comme $(ur,fe)$ et $(fe,i)$ ne sont pas colinéaire, $Vect((ur,fe),(fe,i))$ forme une base de $CC$\
#t(1) #undermath[Ainsi $[CC : RR] ing  tur$]\
\
#t(1) soit $ens$ un sous-corps qui contient $RR$\
#t(1) comme $[RR : RR] ing ur$ et que l'on vient de prouver que $[CC : RR] ing  tur$\
#t(1) il apparait donc comme condition que, $ur ehwing [ens : RR] ehwing tur $\
#t(1) Ainsi $[ens : RR] ing ur$ ou $[ens : RR] ing tur$\
#t(1) #undermath[Et ansi $ens ing RR$ ou $ens ing CC$]

// #pagebreak()

// #let oui(s,n) = for i in range(s,n+1){
//   (text(font: "Noto Sans Phoenician")[#str.from-unicode(i)],)
// }

// #grid(
//   columns: 20,
//   gutter: 5pt,
//   ..oui(0,10000)
// )