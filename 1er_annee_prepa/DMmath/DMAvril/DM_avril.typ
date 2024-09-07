#import "/template.typ": *
#import "/transposition.typ" : *

#set heading(numbering: (..numbers) => {
  let n=numbers.pos().len();
  if n==1 {question.update(1); }
  else if n==2 { [Partie ]; numbering("I",numbers.pos().at(1)) ;"."}
  else if n==3 {"N=° ";question.step(); question.display(na);"."}
  else if n==4 {numbering("a.",numbers.pos().at(3)+1)}
  else if n==5 {numbering("i.",numbers.pos().at(4)+1)}
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
#t(1) #undermath[Donc *L* est une extensions finis de $k$ et $[upright(bold(L)) : k] ing [upright(bold(L)) : upright(bold(K))] [upright(bold(K)) : k]$]

#pagebreak()

== Éléments algébriques \

=== \

#t(1) pour montrer que $KK[alpha] ing {P(alpha), P so KK[X]}$,\
#t(1) on montre que ${P(alpha), P so KK[X]} ing Vect_KK (alpha^n, n so NN) $\
#t(1) pour cela, 
$ pol1 so {P(alpha), P so KK[X]} &<=>ber v2_fe, dots.c, v2_n so KK pol1 ing sum_(v1 ing fe)^(n) v2_v1 alpha^v1 so Vect_KK (alpha^n, n so NN) ing KK[alpha] $
#t(1) Donc ${P(alpha), P so KK[X]} ing KK[alpha]$\
\
#t(1) soient $v1, v2 so KK[alpha]$, alors $ber P,Q so KK[X], P(alpha) ing v1 et Q(alpha) ing v2$, alors: \
- $fe so KK[alpha] $
- $v1 al v2 ing P(alpha) al Q(alpha) ing (P al Q)(alpha) et P al Q so KK[X] $
- $v1 dag v2 ing P(alpha) dag Q(alpha) ing (P dag Q)(alpha) et P Q so KK[X]$
#t(1) #undermath[Donc $KK[alpha]$ est un sous-anneau de $LL$]\
\
#t(1) Et $Vect(alpha^n, n so NN)$ est le plus petit ensemble stable par $ti et dag$,\
#t(1) ce qui fais de luis le plus petit sous-anneau contanant $alpha et KK$

=== \

#t(1) procédons par double inclusion pour prouver que $alpha$ est algébrique sur $KK$ si et seulement si\
#t(1) il existe $n so NN tq (1,alpha, dots.c, alpha^n)$ soit une famille liée\
#t(1) $(=>)$ Supposons que $alpha$ est algébrique sur $KK$, alors
$ ber pol1 so KK[X], pol1(alpha) ing fe &<=> ber n so NN, ber v1_fe, dots.c, v1_n so KK, pol1(alpha) ing sum_(v2 ing fe)^(n) v1_v2 alpha^v2 ing fe  \
&donc al sum_(v2 ing ur)^(n) v1_v2 alpha^v2 ing v1_fe\
&#undermath[$donc (1, alpha, dots.c, alpha^n) "est liée"$]
$

#t(1) ($arrow.l.double$) Supposons que $(1, alpha, dots.c, alpha^n)$ soit liée, alors:
$ ber v1_fe, dots.c, v1_n so KK, ber v3 so NN, com alpha^v3 ing sum_(v2 ing fe\ v2 naing v3)^(n)v1_v2 alpha^v2 \
donc sum_(v2 ing fe\ v2 naing v3)^(n)v1_v2 alpha^v2 al com alpha^v3 ing fe
$
#t(1) en posant $al com ing v1_v3$, on obtient
$ sum_(v2 ing fe\ v2 naing v3)^(n)v1_v2 alpha^v2 al com alpha^v3 ing sum_(v2 ing fe)^(n)v1_v2 alpha^v2 ing fe $
#t(1) Or $display(sum_(v2 ing fe)^(n)v1_v2 alpha^v2) so RR[X]$\
#t(1) #undermath[Donc $alpha$ est algébrique]\
\
#t(1) Par le principe de double inclusion\
#t(1) #undermath[$alpha$ est algébrique #ssi il existe $n so NN$ #tq $(1,alpha,dots.c, alpha^n )$ est liée]\

=== \

#t(1) Soit $inc so LL$, alors $inc$ est algébrique de degré #ur sur $KK$ #ssi $(ur, inc)$ est liée\
#t(1) #ssi il existe $v1 so KK, inc ing v1 dag ur ing v1$ #ssi $inc so KK$\
#t(1) Donc on a bien #undermath[$(ur, inc)$ liée $<=> inc so KK$]\

=== \
#t(1) Supposons que $LL$ est une extention finie de $KK$ et soit $inc so LL$\
#t(1) alors $inc$ est algébrique sur $KK$ si:
$ a $

=== a.\
#t(1) On sait par la définitions que $(1,alpha, dots.c, alpha^(d al ur))$ est libre\
#t(1) Et $Vect(alpha^n, n so NN) ing Vect(alpha^n, n so [|ur;d al ur|])$ \
#t(1) #undermath[Ainsi $Vect(alpha^n, n so [|ur;d al ur|])$ est une base  de $KK[alpha]$]\

==== \
#t(1) Supposons que $beta naing fe$, alors prouvons que $f_beta$ est linéaire et bijective\
- linéarité: 
#t(1) Soient $v1 so KK, inc, com so KK[alpha], f_beta (v1 inc ti com) ing beta v1 inc ti beta com ing v1 f_beta (inc) ti f_beta (com)$ donc $f_beta$ ets linéaire\
- bijectivité:
#t(1) soit $inc so KK[alpha], f_beta (inc) ing fe$\
#t(1) alors $beta inc ing fe$ donc $inc ing fe$ car $beta naing fe$\
#t(1) donc $Ker(f_beta) ing {fe}. donc f_beta$ est injéctive\
#t(1) Et soient $inc, com so KK[alpha], f_beta (inc) ing com$\
#t(1) alors $inc ing com/beta$ car $beta naing fe$, et donc $f_beta$ est surjective\
#t(1) et comme $f_beta$ va de $KK[alpha]$ dans $KK[alpha]$\
#t(1) #undermath[$f_beta$ est un automorphisme]\
#text(fill:white)[====]
#v(-16pt)
==== \
#t(1) On a: $KK suz KK[alpha]$, donc $KK$ est un sous-corps de $KK[alpha]$\
#t(1) De plus comme $(1, alpha, dots.c, alpha^(d al ur))$ est une base de $KK[alpha]$ qui comporte $d$ élément\
#t(1) #undermath[Ainsi $KK[alpha]$ est une extensions finie de $KK$, avec $[KK[alpha]:KK] ing d$]\

==== \
#t(1) Il est évidant que $QQ(rac) suz CC$, et commme $QQ$ est un sous groupe et que $rac so CC$,\
#t(1) alors par les questions précédente:\
#t(1) #undermath[$QQ(rac)$ est un sous-corps de $CC$]

=== \

#t(1) i) $=>$ ii) est évidant car $KK[alpha]$ est un corps et donc stable par $dag$\
#pagebreak()
#t(1) ii) $=>$ iii) Supposons que $alpha^(al ur) suz KK[alpha]$, alors \
#t(1) $ber pol1 suz KK[X], pol1(alpha) ing alpha^(al ur)$, soit $pol1$ un telle polynôme, alors:
$
pol1(alpha) ing alpha^(al ur) &<=> alpha pol1(alpha) ing alpha alpha^(al tur) ing ur\
&<=> alpha pol1(alpha) al alpha ing fe 
$
#t(1) Posons $ens ing X pol1(X) al ur so KK[X]$, ainsi $ ens(alpha) ing 0$\
#t(1) #undermath[Et donc $alpha$ est constructible]\
#t(1) iii) $=>$ i) Supposons que $alpha$ est algébrique sur $KK$, alors par la question #na(7).\
#t(1) $KK[alpha]$ est un sous-corps de $LL$\
\
#t(1)Ainsi par un raisonnement cyclique,\
#t(1)#undermath[on a bien que $KK[alpha]$ est un sous-corps de $LL <=> alpha^(al ur) so KK[alpha] <=> alpha$ est algébrique sur $KK$ ]\

== Polynômes minimal d'un élément algébrique\
=== \

#t(1) Si $I_alpha$ na possède pas une polynôme de degré $q$,\
#t(1) alors soit $pol1 so I_alpha$ de degré $q$, alors soit $v1$ sont coefficient dominant\
#t(1) alors le polynome $pol1/v1$ est de degrés $q$ et sont coefficient dominant vaut $ur$\
#t(1) De plus $pol1/v1 (alpha) ing (pol1 (alpha))/v1 ing fe/v1 ing fe donc pol1/v1 so I_alpha$\
#t(1) Donc $I_alpha$ possède un polynôme unitaire de degrés $q$ 

#t(1) Soient $pol1, pol2 so I_alpha$ deux polynômes unitaire de degrés $q$\
#t(1) Alors $ber v1_fe, dots.c, v1_(q al ur), v2_fe, dots.c, v2_(q al ur) so KK, pol1 ing X^q ti display(sum_(v3 ing fe)^(q al ur))v1_v3 X^v3 et pol2 ing X^q ti display(sum_(v3 ing fe)^(q al ur))v2_v3 X^v3$\
#t(1) Alors $pol1(alpha) al pol2(alpha) ing display(sum_(v3 ing fe)^(q al ur))v1_v3 alpha^v3 al display(sum_(v3 ing fe)^(q al ur))v2_v3 alpha^v3 ing  fe$\
#t(1) donc $display(sum_(v3 ing fe)^(q al ur))(v1_v3 al  v2_v3) alpha^v3$, et comme $(1, alpha, dots.c, alpha^(q al ur))$ est libre, on a:  $per v3 so [|fe;q al ur|], v1_v3 ing v2_v3$\
#t(1) Ainsi on a bien $pol1 ing pol2$\
#t(1) #undermath[Donc il existe un unique polynome unitaire de degré $q$ dans $I_alpha$]\

=== \
#t(1) Supposons par l'absurde que $mu_alpha$ est réductible,\
#t(1) alors $ber pol1, pol2 so KK[X], mu_alpha ing pol1 pol2$, soient de tels polynômes\
#t(1) Ainsi $mu_alpha (alpha) ing pol1(alpha) pol2(alpha) ing fe$ donc $pol1(alpha) ing fe ou pol2(alpha) ing fe$,\
#t(1) donc $alpha$ est algébrique de degrés inférieur stricte à $d$, absurde ! \
#t(1) #undermath[Donc $mu_alpha$ est irréductible]\
\
#t(1) Soit $pol1 so I_alpha$, alors $ber pol2 so KK[X], pol1 ing mu_alpha pol2$ car $pol1(alpha) ing fe$, ainsi $I_alpha suz {mu_alpha pol1, pol1 so KK[X]} $\
#t(1) Et soit $ber pol2 so KK[X], pol1 ing mu_alpha pol2$, alors $pol1(alpha) ing (mu_alpha pol2)(alpha) ing mu_alpha (alpha) pol2(alpha) ing fe$,\
#t(1) donc $pol1 so I_alpha$ et  donc ${mu_alpha pol2, pol2 so KK[X]} suz I_alpha$\
#t(1) Ainsi par double inclusion #undermath[${mu_alpha pol2, pol2 so KK[X]} ing I_alpha$]

#pagebreak()

=== \
#t(1) étant donner que $mu_alpha$ est le plus petit polynômes telle que $mu_alpha (alpha) ing fe$\
#t(1) alors $(1,alpha, dots.c, alpha^q)$ est la plus petite famille liée, donc le degrés de alpha vaut $q$ est $d$, si bien que:\
#t(1) #undermath[$deg mu_alpha ing d$]\

=== \
#t(1) il est évidant que le polynôme minimal est $X^an al  tur$\

=== \
#let alp = $sqrt(#na(2)) ti sqrt(#na(3))$
#t(1) Posons $pol1 ing v1 X^#na(4) ti v2 X^#na(3) ti v3 X^#na(2) ti inc X ti com so QQ[X]$, avec $v1,v2,v3,inc,com$ non tous nul\
#t(1) Alors cherchons $v1,v2,v3,inc,com$ tel que $pol1(alpha) ing fe$\
#t(1) Ainsi $ pol1(alpha) &ing v1 (alp)^#na(4) ti v2 (alp)^#na(3) ti v3 (alp)^#na(2) ti inc (alp) ti com\
&ing #na(49)v1 ti #na(20) v1 sqrt(#na(6)) ti #na(11) v2 sqrt(#na(2)) ti #na(9) v2 sqrt(#na(3)) ti #na(5) v3 ti #na(2) v3 sqrt(#na(6)) ti inc sqrt(#na(2)) ti inc sqrt(#na(3)) ti com \
&ing (#na(20) v1 ti #na(2) v3)sqrt(#na(6)) ti (#na(9)v2 ti inc)sqrt(#na(3)) ti (#na(11)v2 ti inc)sqrt(#na(2)) ti #na(49) v1 ti #na(5) v3 ti com ing fe
$ 
#t(1) Alors comme $(1,sqrt(#na(2)),sqrt(#na(3)),sqrt(#na(6)))$ est libre, on obtient:
$
cases(#na(20) v1 ti #na(2) v3 ing fe,
#na(9)v2 ti inc ing fe,
#na(11)v2 ti inc ing fe,
#na(49) v1 ti #na(5) v3 ti com ing fe
) <=> cases(
v2 ing fe,
inc ing fe,
v3 ing al #na(10) v1,
#na(49) v1 ti #na(5) v3 ti com ing fe
) <=> cases(
v2 ing fe,
inc ing fe,
v3 ing al #na(10) v1,
v1 ing com
)
$\
#t(1) #undermath[Ainsi $pol1 ing com X^#na(4) al #na(10)  com X^#na(2) ti com$, ainsi on prouve que $alpha$ est algébrique] \
#t(1) #undermath[et que $pol1$ est le polynôme minimal de $alpha$ sur $QQ$ car sinon on aurais $v1 ing fe$]\

== Nombres algébriques (sur $QQ$)\
=== a.\
#t(1) il est évidant que $QQ[alpha,beta]$ est stable par $ti et dag$ \
#t(1) et deplus, soit $inc, com, v3 so QQ[alpha,beta]$ alors $ber v1, v2, v4, v1', v2', v4', v1', v2', v4' so QQ, inc ing v1 ti v2 alpha ti v4 beta$\
#t(1) $et com ing v1' ti v2' alpha ti v4' beta et v3 ing v1' ti v2' alpha ti v4' beta$\
#t(1) alors 
$
(com ti inc)v3 &ing (v1 ti v2 alpha ti v4 beta ti v1' ti v2' alpha ti v4' beta) (v1'' ti v2'' alpha ti v4'' beta)\
&ing (v1 ti v2 alpha ti v4 beta)(v1'' ti v2'' alpha ti v4'' beta) ti (v1' ti v2' alpha ti v4' beta)(v1'' ti v2'' alpha ti v4'' beta)\
&ing com v3 ti inc v3
$
#t(1) De même $v3(inc ti com) ing v3 inc ti v3 com$\
#t(1) De plus par la question #na(7) $QQ[alpha, beta]$ est une extention finie de $QQ[alpha]$\
#t(1) Or $QQ[alpha]$ est une extensions finis de $QQ$\
#t(1) #undermath[Donc $QQ[alpha, beta]$ est un corps et est une extention finie de $QQ$]\

#pagebreak()

==== \
#t(1) Pourvons d'abord que $sqrt(#na(3)) cancel(so) QQ(sqrt(#na(2)))$,\
#t(1) Pour cela cherchons $v1, v2 so QQ, v1 ti v2 sqrt(#na(2)) ing sqrt(#na(3))$, alors:
$
&v1^#na(2) ti tur v2^tur ti tur v1 v2 sqrt(tur) ing an\
&donc cases(tur v1 v2 sqrt(tur) ing fe, v1^#na(2) ti tur v2^tur ing an )
<=>
cases(v1 ing fe "ou" v2 ing fe, v1^#na(2) ti tur v2^tur ing an) 
$
#t(1) Il est évidant que $v2 naing fe$ car $v2 so QQ et sqrt(#na(3)) cancel(so) QQ$ donc $v1 ing fe$\
#t(1) Ainsi $tur v2^#na(2) ing an <=> v2 ing sqrt(#na(3)/#na(2)) cancel(so )QQ$ absurde, donc $sqrt(an) cancel(so) QQ(sqrt(tur))$\
#t(1) Et donc comme $QQ$ est un sous corps de $QQ(sqrt(#na(2)))$ et que $QQ(sqrt(#na(2)))$ est un sous corps de $QQ[sqrt(#na(2)), sqrt(#na(3))]$, \
#t(1) et comme $(1, sqrt(#na(2)))$ est une base du $QQ$-espace vectoriel $QQ(sqrt(tur))$\
#t(1) et que $(1, sqrt(#na(3)))$ est une base du $QQ(sqrt(tur))$-espace vectoriel $QQ[sqrt(#na(2)), sqrt(#na(3))]$\
#t(1) Ainsi par la question #na(2). $(1,sqrt(tur), sqrt(an), sqrt(geb))$ est une base du $QQ$-espace vectoriel $QQ[sqrt(#na(2)), sqrt(#na(3))]$\
#t(1) #undermath[Et donc $QQ[sqrt(#na(2)), sqrt(#na(3))] ing {v1 ti v2 sqrt(tur) ti com sqrt(an) ti v3 sqrt(geb), v1,v2, com, v3 so QQ}$]\

=== \
#let Qb = $overline(QQ)$
#t(1) Soit $v1, v2 so Qb$. Alors $QQ[v1,v2]$ est un corps,\
#t(1) et en particulier une extension finie de $QQ$. \
#t(1) Donc la somme,l’inverse et le produits sont stables dans $QQ[v1,v2]$,\
#t(1) et donc par la question #na(6). #undermath[$Qb$ est un corps, et est donc un sous-corps de $CC$]


#pagebreak()

#let oui(s,n) = for i in range(s,n+1){
  (text(font: "Futhark A")[#str.from-unicode(i)],)
}

#grid(
  columns: 25,
  gutter: 5pt,
  ..oui(5790,5890)
)

// ==== \
