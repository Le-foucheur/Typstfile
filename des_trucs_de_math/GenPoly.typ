#set text(historical-ligatures:true, font: "Linux Libertine")
#let mag = $class("unary","mag")$
#let card = $class("unary","card")$

*Def* : Pour un corps $KK$ commutatif où l’exponentiation est définis et pour $LL$ un sous corps de $KK$, on définis pour n in $NN$ :
$
  (KK, LL)_n [X] = {sum_(k = 0)^n alpha_k X^( beta_k ), forall i > n, alpha_i = 0, (alpha_n) in KK^NN, (beta_n) in LL^NN}
$

*Def* : Pour $P, Q in (KK,LL)_n [X]$, avec $P = sum_(i = 0)^n alpha_i X^(beta_i)$ et $Q = sum_(i = 0)^n a_i X^(beta_i)$
 - Si $LL$ possède un ordre totale, alors on appelle $deg P = limits(max)_(k in NN) {beta_k, alpha_k != 0}$

 - on appelle magnitude, et note $mag P$ = $limits(card)_(k in KK) {alpha_k, alpha_k != 0}$
 - $P = Q$ ssi ${(alpha_n, beta_n), n in NN} = {(a_n, beta_n), n in NN}$
 - $forall lambda in LL, lambda P = sum_n lambda alpha_n X^(beta_n)$
 - $P Q = sum_(i=0)^n alpha_i Q^n$
 - $((KK, LL), +, *)$ est un anneaux sans diviseur de zéro

*Def* : On dit qu’un polynôme $P in (KK,LL)_n [X]$, de magnitude m, est condensé ssi $forall i in [|0;m|], alpha_i != 0$

*Théorème 1 :* 
Pour tout polynôme $P = sum_(i = 0)^n alpha_i X^(beta_i)$ de magnitude $m$, il existe un unique polynôme condensé $tilde(P)$, tel que $P = tilde(P)$

Preuve :\
Soit $phi in frak(S)$ tq $forall i in [|0;m|], alpha_(phi(i)) != 0$, \
Posons $tilde(P) = sum_(i= 0)^n alpha_(phi(i)) X^(beta_(phi(i)))$\
Alors nous avons bien ${(alpha_n, beta_n), n in NN} = {(alpha_phi(i), beta_phi(i)), i in NN}$ car un ensemble est invariant par permutation, donc $P = tilde(P)$\
De plus $tilde(P)$ est bien condensé par définition de $phi$ *Q.E.D.*\
\

*Def :* On définis la dérivé d’un polynôme $P in (KK, LL)_n [X]$ par :
$
  P’ = sum_(i = 0)^n alpha_i beta_i X^(beta_i - 1)
$
\
*Prop :* Soit $P, Q in (KK, LL)_n [X]$, alors pour $k in [|0, n|]$ :
- $deg P’ = deg P - 1$

- $deg P Q = deg P times deg Q$
- $forall lambda in KK, deg lambda P = deg P$
- $deg (P + Q) = max(deg P, deg Q)$
- $mag P’ = mag P - card {beta_k = 0} + card({alpha_k = 0} inter {beta_k = 0})$, de plus si $P$ est condensé : $mag P’ = mag P - limits(card)_(i in [|0, mag P|]) {beta_i = 0}$