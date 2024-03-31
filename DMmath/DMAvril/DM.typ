#import "/template.typ": *
#import "./transposition.typ" : *

#let question = counter("questions")
#set heading(numbering: (..numbers) => {
  let n=numbers.pos().len();
  if n==1 {question.update(1); }
  else if n==2 { [Partie ]; numbering("I",numbers.pos().at(1)) ;"."}
  else if n==3 {"N=° ";question.step(); question.display(na);"."}
  else if n==4 {numbering("a.",numbers.pos().at(3)+1)}
  else if n==5 {numbering("i.",numbers.pos().at(4))}
  })
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
    $exists !$,$uber$,[\\],
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
  $ e^inc limits(ing)_(inc -> fe) ur ti inc ti inc^tur /tur! ti dots.c ti inc^v1 / v1! ti o(inc^v1) $ + 
  align(center)[est équivalant à] +
  $ e^x limits(=)_(x -> 0) 1 + x + x^2/2 + dots.c + x^n/x! + o(x^n) $
)

#pagebreak()

= Problème #tur : nombres algébrique et extensions de corps \

== extensions de corps\

=== Premiers exemples a.\
#t(1) il est évidant que $RR$ est un sous-corps de $CC$ et de plus $CC$ est de dimension finis,\
#t(1) donc $CC$ est une extention finie de $RR$\
\
#t(1) de plus soit $com so CC$ alors
$ per inc, v1 so RR, com ing inc ti i v1 <=> com so Vect(ur,i) $
#t(1) Ainsi comme $ur$ et $i$ ne sont pas colinéaire dans $RR$, $Vect(ur,i)$ forme une base de $CC$\
#t(1) #undermath[Ainsi $[CC : RR] ing  tur$]\
\
#t(1) soit $ens$ un sous-corps qui contient $RR$\
#t(1) comme $[RR : RR] ing ur$ et que l'on vient de prouver que $[CC : RR] ing  tur$\
#t(1) il apparait donc comme condition que, $ur ehwing [ens : RR] ehwing tur $\
#t(1) Ainsi $[ens : RR] ing ur$ ou $[ens : RR] ing tur$\
#t(1) #undermath[Et ansi $ens ing RR$ ou $ens ing CC$]

==== \

#t(1) Soit $inc so QQ(sqrt(tur))$, alors $ber v1, com so QQ, inc ing v1 ti com sqrt(tur)$, alors prenons $com ing fe$\
#t(1) ainsi $inc ing v1 so QQ$, donc $QQ suz QQ(sqrt(tur))$ et comme $QQ$ est un corps \
 de $QQ(sqrt(tur))$\
#t(1) de plus, soit $inc so QQ(sqrt(tur))$ alors $ber v1, com so QQ, inc ing ber ti v1 sqrt(tur)$, soit un telle $com, v1$\
#t(1) donc $inc ing com ti v1 sqrt(tur) so Vect(ur, sqrt(tur))$\
#t(1) et supposons par l'absurde $ber inc, v1 so QQ dag QQ^*, inc ti v1 sqrt(tur) ing fe$ \
#t(1) alors $inc/v1 ing al sqrt(tur)$ ce qui est absurde car $inc/v1 so QQ$, donc $inc ing v1 ing fe$ \
#t(1) Ainsi $(ur, sqrt(tur))$ est une base de $QQ(sqrt(tur))$\
#t(1) #undermath[Donc $[QQ(sqrt(tur)):QQ] ing tur$]\

==== i.\

#t(1) Soit $upright(P) so QQ[X] tq P(root(an,tur)) ing fe$\
#t(1) prenons la divisions euclidienne de $X^an al tur$ par $upright(P)$\
#t(1) ce qui nous donne $X^an al tur ing upright(P Q) ti R$ avec $upright(Q) so QQ_ur [X] et upright(R) so QQ[X] tq deg upright(R) eh tur$ \
#t(1) En évaluant notre expression précédente en $root(an,tur)$ on obtient :
$ (root(an,tur))^an al tur ing fe ing underbrace(upright(P(root(an,tur))),ing fe) ti upright(R) $
#t(1) donc $upright(R) ing fe$ et donc $deg upright(R) ing fe$\
#t(1) #undermath[ainsi $upright(P)$ divise $upright(X^an al tur)$]\
\
#t(1) Ainsi Comme $upright(P)$ divise $X^an al tur$ et que $deg upright(P) ing tur$,\
#t(1) alors $upright(P)$ et $X^an al tur$ possède deux racines en commun dont $root(an,tur)$\
#t(1) et comme $X^an al tur ing (X al root(an,tur))(X al root(an,tur)e^( i pi /an))(X al root(an,tur)e^( i (tur pi )/an))$ donc $upright(P)$ à en plus une racine complexe\
#t(1) or un polynôme dans $RR$ qui possède une racine complexe possède sont conjugée\
#t(1) ce qui n'est pas le cas pour $upright(P)$ donc $upright(P) cancel(so) QQ[X]$ ce qui est absurde \
#t(1) #undermath[Donc $cancel(ber) P so QQ[X], P(root(an,tur))ing fe$]\

#let rac = $root(an,tur)$
===== \
#t(1) Par un résonnement annaloge à la question #ur .b on montre que $QQ suz QQ(root(an,tur))$,\
#t(1) De plus soit $inc so QQ(root(an,tur))$ alors soient $v1,com,v2 so QQ, inc ing v1 ti com root(an,tur) ti v2 (rac)^tur$ \
#t(1) donc $inc so Vect(ur, rac, rac^tur)$ \
#t(1) donc $QQ(root(an,tur))$ est une extensions finis et $[Q(rac) : QQ] ing an$\

==== \

#t(1) Soient $v1_ur, dots.c, v1_n so QQ$ tels que $display(sum_(v2 ing ur)^(n) v1_v2 ln(p_v2) ing fe ) $,\
#t(1) alors $ ln(product_(v2 ing ur)^(n) p_v2^v1_v2 ) ing fe " "donc product_(v2 ing ur)^(n) p_v2^v1_v2 ing ur $
#t(1) Or comme $per v2 so [|ur; n|], v1_v2 so QQ$ donc $ber v3, com_ur, dots.c, com _n so NN,per v2 so [|ur; n|], v1_v2 ing com_v2/v3$. Ainsi
$ (product_(v2 ing ur)^(n) p_v2^com_v2)^(1/v3) ing ur <=> product_(v2 ing ur)^(n) p_v2^com_v2 ing ur $\
#t(1) Or comme $per v2 so [|ur;n|], p_v2^com_v2 so NN donc p_ur^v2_ur ing dots.c ing p_n^v2_n ing ur " "donc v2_ur ing dots.c ing v2_n ing fe $\
#t(1) Et donc $v1_ur ing dots.c ing v1_n ing fe$\
#t(1) #undermath[Ainsi $(ln(p_ur), dots.c, ln(p_n))$ est libre]\
#t(1) Et donc la dimmension de $RR$ n'est pas finis, donc $RR$ n'est pas une extention finis de $QQ$


=== \

#t(1) soit $inc so upright(bold(L))$, alors $uber v1_ur, dots.c, v1_n so upright(bold(K))$ tel que, $display(inc ing sum_(com ing ur)^(n))alpha_com v1_com$\
\
#t(1) Or on a $display(per com so [|ur, n|]\,uber v2_ur\, dots.c \, v2_p so k \, v1_com ing sum_(v3 ing ur)^(p) beta_v3 v2_v3 )$\
\
#t(1) Ainsi $uber v1_ur, dots.c, v1_n so upright(bold(K)) so k,uber v2_ur\, dots.c \, v2_p so k, inc ing display(sum_(ur ehwing com ehwing n \ ur ehwing v3 ehwing p) alpha_com beta_v3 v1_com v2_v3)$\
#t(1) Donc $inc$ s'écrit d'une manière unique comme des élément de $k$,\
#t(1) donc la famille $(alpha_i beta_j)_(ur ehwing i ehwing n \ ur ehwing j ehwing p)$ est une base de du $k$-espace vectoriel *L*\
#t(1) De plus la famille $(alpha_i beta_j)_(ur ehwing i ehwing n \ ur ehwing j ehwing p)$ comporte exactement $n p$ éléments\
#t(1) #undermath[Donc $[upright(bold(L)) : k] ing [upright(bold(L)) : upright(bold(K))] [upright(bold(K)) : k]$]

#pagebreak()

== Éléments algébriques \

=== \

#t(1) pour montrer que $KK[alpha] ing {P(alpha), P so KK[X]}$,\
#t(1) on montre que ${P(alpha), P so KK[X]} ing Vect_KK (alpha^n, n so NN) $\
#t(1) pour cela, 
$ pol so {P(alpha), P so KK[X]} &<=>ber v2_fe, dots.c, v2_n so KK pol ing sum_(v1 ing fe)^(n) v2_v1 alpha^v1 so Vect_KK (alpha^n, n so NN) ing KK[alpha] $
#t(1) Donc ${P(alpha), P so KK[X]} ing KK[alpha]$\
#t(1)\

=== \



// #pagebreak()

// #let oui(s,n) = for i in range(s,n+1){
//   (text(font: "arial")[#str.from-unicode(i)],)
// }

// #grid(
//   columns: 20,
//   gutter: 5pt,
//   ..oui(0,10000)
// )

// ==== \
