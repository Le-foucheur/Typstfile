#import "../../template.typ": *
#import "../../transposition.typ": *

#show: template.with(ancienne_lig: true)

#align(center)[= Rappel]

$
  dif E = T dif S - p dif V + mu dif N\
  C_V = diff_T E|_V "  " \& "  " C_P = diff_T E|_P\
  chi_T = - 1/V diff_p V|_T
$

Dans le cas d'une distribution gaussienne avec $x_1, ..., x_n in RR$ variables et $alpha_1, ..., alpha_n in RR$ coefficients:
$
  e^(-1/2 sum_(i= 1)^n alpha_i x_i^2)
$
alors on a:
$
  forall i,j in [|1, n|], <x_i> = 0 " & " <x_i x_j> = 1 /alpha_i delta_j^i
$

Pour une grandeur $A$, dépendante de $x_1, ..., x_n in RR$, alors:
$
  delta A = sum_(i = 1)^n diff_x_i A delta x_i
$
*N.B.*: c'est juste la règle de la chaine

#align(center)[= Formalisme d’#[E]instein]


Postulat d'#[E]instein:
$
  #rect(stroke: 0pt, width: 4cm)[distrib de la proba d'être dans l'état d'hors équilibre] = w = e^((diff S_c)/(k_B T))
$

pour toute la suite $i in [|1,r|] = I$; $r in NN^*$ et on pose $X_(i in [|1,r|])$ les coords thérmodynamique

On dèf $F_i = diff_X_i S$ et $Y_i = - T F_i = diff_X_i E$

On peut montrer alors:
$
  w = e^(-1/(2 kb T) (delta S delta T - sum_(i in I) delta X_i delta Y_i))
$

Relation de #[G]ibbs-#[D]uhem
$
  S dif T + sum_(i in I) X_i dif Y_i = 0
$

#align(center)[= Formalisme de la physique statistique]

#sym.star distribution de proba, #underline(stroke: black)[sans] échange de chaleur et de travaille :
$
  p_e = 1/Z e^(-beta E_l)
$
où :
- $beta = 1/(kb T)$
- $Z = sum_("les états" l) e^(-beta E_l)$

energie libre :
$
  F = <E> - T S = -kb T ln(Z)  
$

$
  dif F = -S dif T - <p> dif V + <mu> dif N
$

Fluctuation d’energie :
$
  V_E = <E^2> - <E>^2 = (diff^2 ln(Z))/(diff beta^2)
$

#sym.star distribution de proba, #underline(stroke: black)[avec] échange de chaleur et de travaille :
$
  p_l = 1/Z e^(-beta(E_l + p V_l))
$
où :
- $Z = sum_("les états "l) e^(-beta(E_l + p V_l))$

Entalpie libre :
$
  G = <E> - T S + p <V>\
  dif G = <mu> dif N - S dif T + <V> dif p = - kb T ln(Z)
$

Les fluctuation :
$
  V_V = 1/beta^2 (diff^2 ln(Z))/(diff beta^2) = - 1/beta diff_p <V> = kb T <V> chi_T\
  V_H = (diff^2 ln(Z))/(diff beta^2) = kb T^2 C_P\
  V_E = kb T^2 C_P + p^2 <V> kb T chi_T - 2p kb T^2 diff_T <V>
$

#align(center)[= Théorème de la réponse linéaire]

Soit un système à l'équilibre dépendent des paramètres $p, q$ et du hamiltonien $Ham_0(p, q)$.\
On vient perturber ce système par une force exterieur de norme $f$, couplé à une grandeur $A(p,q)$,\
Ainsi pour une grandeur quelconque $B(p,q)$:
$
  <B> = <B>_0 + beta f cov(A_0, B_0)
$
avec:
- $A_0$ = valeur de $A$ à l'équilibre
- $B_0$ = valeur de $B$ à l'équilibre
- $<B>_0$ = moyenne statistique à l'équilibre
- $beta = 1/(k_B T)$
- $cov(A_0, B_0) = <A B>_0 - <A>_0<B>_0$

On définis également la sucéptibilité généralisée entre $A$ et $B$:
$ chi_(A B) = diff_f <B> $

On peut ainsi réécrire la réponse linéaire:
$
  <B(t)> = <B>_0 + underbrace(integral_(-oo)^t chi_(A B) (t-t') f(t') dt', "produis de convolution")
$
*Attetion, Achtung*:
- La fonction de réponse doit être causale: $chi_(A B)(t-t') = 0$ pour $t < t'$

On peut écrire la réponse linéaire dans l'espace de #[F]ourier:
$ <tilde(B)(omega)> = tilde(chi)_(A B)(omega) tilde(f)(omega) $

avec:
- $tilde(chi)_(A B)(omega) = integral_(-oo)^(+oo) chi_(A B)(t) e^(i omega t) dt = integral_0^(+oo) chi_(A B) (t) e^(i omega t) dt$

- $tilde(B)(omega) = integral_(-oo)^(+oo) <B(t)> e^(i omega t) dt$
- $tilde(f)(omega) = integral_(-oo)^(+oo) f(t) e^(i omega t) dt$

On a également:
$
  <E_"energie dissipee" (t)> = 1/2 omega^2 f^2 tilde(chi)''_"A A" (omega)
$

avec: $tilde(chi)_"AA" = tilde(chi)'_"AA" - i tilde(chi)''_"AA"$

#align(center)[= Relation de #[K]ramer-#[K]ronig]

Les parties réelle et imaginaire de la fonction de réponse sont liées par les relations de #[K]ramer-#[K]ronig:
$
  tilde(chi)'_(A B)(omega) = 1/pi upright(V P) (integral_(-oo)^(+oo) (tilde(chi)''_(A B)(omega')) / (omega' - omega) d omega')\
  tilde(chi)''_(A B)(omega) = 1/pi upright(V P)( integral_(-oo)^(+oo) (tilde(chi)'_(A B)(omega')) / (omega' - omega) d omega')
$

#align(center)[= Théorème de la réponse linéaire: version classique]

A partir de l'équation de Liouville, on peut montrer que la fonction de réponse s'écrit:
$
  (dif C_"A B" (t)) / (dif t) = -1/(k_B T) chi_(A B)(t) "espace réel"\
  <=>\
  tilde(chi)''_(A B)(omega) = - omega / (2 k_B T) tilde(C)_(A B)(omega) "espace de "#[F]"ourier"
$
