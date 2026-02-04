#import "../../../template.typ": *
#import "../../../transposition.typ": *

#show: template

#align(center)[= Équation des géodésiques]

Soit le lagrangiens suivant :
$
  cal(L)(x^alpha, dot(x)^alpha) = [g_(mu nu)(x) dot(x)^mu dot(x)^nu]^(1/2)
$
avec $dot(x)^alpha = (dif x^alpha)/(dif s)$\
Ainsi on n’a :
$
  (partial cal(L))/(partial x^alpha) & = 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) diff/(diff x^alpha) (g_(mu nu) dot(x)^mu dot(x)^nu)\
  #box(width: 2.5cm)[car $dot(x)^mu$ et $dot(x)^nu$ sont constant face à $x^alpha ->$];
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) (partial g_(mu nu))/(diff x^alpha) dot(x)^mu dot(x)^nu\
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu, alpha) dot(x)^mu dot(x)^nu
$
où on note : $g_(mu nu, alpha) = (partial g_(mu nu))/(diff x^alpha)$\
Et
$
  (partial cal(L))/(partial dot(x)^alpha) &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) diff/(diff dot(x)^alpha) (g_(mu nu) dot(x)^mu dot(x)^nu) = 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) diff/(diff dot(x)^alpha) ( dot(x)^mu dot(x)^nu)\
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) ( dot(x)^nu underbrace(partial/(diff dot(x)^alpha) ( dot(x)^mu), = delta_alpha^mu) + dot(x)^mu underbrace(partial/(diff dot(x)^alpha) ( dot(x)^nu), = delta_alpha^nu))\
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) ( dot(x)^nu delta_alpha^mu + underbrace(dot(x)^mu delta_alpha^nu, = dot(x)^nu delta_alpha^mu "car" mu "et" nu "sont muet"))\
  &= cancel(1/2) [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) dot.c cancel(2) dot(x)^nu delta_alpha^mu\
  &= [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(alpha nu) dot(x)^nu
$
Ainsi par les équation d’Euleur-La Grange, on obtient l’équation suivante :
$
  dif/(dif s) ( [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(alpha nu) dot(x)^nu) = 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu, alpha) dot(x)^mu dot(x)^nu
$
\
En posant :
$
             dif lambda & = [g_(mu nu)dot(x)^mu dot(x)^nu]^(1/2) dif s \
  Donc dif/(dif lambda) & = [g_(mu nu)dot(x)^mu dot(x)^nu]^(-1/2) dif/(dif s)
$
Ainsi, en réécrivant l’équation précédente :
$
  dif/(dif s) ( [g_(mu nu) dot(x)^mu dot(x)^nu]^(- 1/2) g_(alpha nu) dif/(dif s) x^nu) &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu, alpha) dif/(dif s) x^mu dif/(dif s) x^nu\
  donc [g_(mu nu) dot(x)^mu dot(x)^nu]^(1/2) dif /(dif lambda) (cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(- 1/2)) g_(alpha nu) cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(1/2)) dif/(dif lambda) x^nu ) &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) [g_(mu nu) dot(x^mu) dot(x)^nu] g_(mu nu, alpha) dif/(dif lambda) x^mu dif/(dif lambda) x^nu\
  donc cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(1/2)) dif /(dif lambda) (g_(alpha nu) dif/(dif lambda) x^nu ) &= 1/2 cancel([g_(mu nu)dot(x)^mu dot(x)^nu]^(1/2)) g_(mu nu, alpha) dif/(dif lambda) x^mu dif/(dif lambda) x^nu\
  donc dif / (dif lambda) (g_(alpha nu) dif/(dif lambda) x^nu) &= 1/2 g_(mu nu, alpha) dif/(dif lambda) x^mu dif/(dif lambda) x^nu
$
\
Si on écrit l’action par rapport à $s$, on a :
$
  S_1 = integral [g_(mu nu) dif/(dif s) x^mu dif/(dif s) x^nu]^(1/2) dif s
$
Alors en oprérant le changement de variable $S_1$ devient :
$
  S_1 & = integral cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(1/2)) [g_(mu nu) dif/(dif lambda) x^mu dif/(dif lambda) x^nu]^(1/2) cancel([g_(mu nu) dot(x)^mu dot(x)^nu]^(-1/2)) dif lambda\
  &= integral [g_(mu nu) dif/(dif lambda) x^mu dif/(dif lambda) x^nu]^(1/2) dif lambda
$
Donc comme $S_1$ est invariante par la transformation $s --> lambda$ et que celle-ci est un diféomorphisme, on a alors :
$
  dif/(dif s)(g_(alpha nu) dot(x)^nu) = 1/2 g_(mu nu, alpha) dot(x)^mu dot(x)^nu
$
Donc en calculant le terme de gauche :
$
  d/(dif s)(g_(alpha nu)dot(x)^nu) &= dot(x)^nu dif/(dif s) g_(alpha nu) + g_(alpha nu) dot.double(x)^nu\
  &= g_(alpha nu) dot.double(x)^nu + dot(x)^nu underbrace((partial g_(alpha nu))/(partial mu), = g_(alpha nu, mu)) underbrace((dif x^mu)/(dif s), = dot(x)^mu)\
  &= g_(alpha nu) dot.double(x)^nu + g_(alpha nu, mu) dot(x)^nu dot(x)^mu
$
Ainsi :
$
  underbrace(g^(alpha beta) g_(alpha nu), = delta_nu^beta) dot.double(x)^nu &= 1/2 g_(mu nu, alpha) dot(x)^mu dot(x)^nu - g_(alpha nu, mu) dot(x)^nu dot(x)^mu\
  Donc dot.double(x)^beta &= 1/2 g^(alpha beta) (g_(mu nu, alpha) - 2g_(alpha nu, mu)) dot(x)^nu dot(x)^mu\
  Donc dot.double(x)^beta &= 1/2 g^(alpha beta) (g_(mu nu, alpha) - g_(alpha nu, mu) - g_(alpha mu, nu)) dot(x)^nu dot(x)^mu
$
En introduisant les symboles de Cristoffel $Gamma^beta_(mu nu) = 1/2 g^(beta alpha) (g_(mu alpha, nu) + g_(nu alpha, mu) - g_(mu nu, alpha) )$ on a :
$
  dot.double(x)^beta = - Gamma^beta_(mu nu) dot(x)^mu dot(x)^nu\
  "Soit" dot.double(x)^beta + Gamma^(beta)_(mu nu) dot(x)^mu dot(x)^nu = 0
$
