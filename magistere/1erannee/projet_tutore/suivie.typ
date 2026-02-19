x#import "../../../template.typ": *
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
  &= 1/2 [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) ( dot(x)^nu delta_alpha^mu + underbrace(dot(x)^mu delta_alpha^nu, = dot(x)^nu delta_alpha^mu "car" mu "et" nu "sont muets"))\
  &= cancel(1/2) [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(mu nu) dot.c cancel(2) dot(x)^nu delta_alpha^mu\
  &= [g_(mu nu)dot(x)^mu dot(x)^nu]^(- 1/2) g_(alpha nu) dot(x)^nu
$
Ainsi par les équations d’Euleur-La Grange, on obtient l’équation suivante :
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
En introduisant les symboles de Christoffel $Gamma^beta_(mu nu) = 1/2 g^(beta alpha) (g_(mu alpha, nu) + g_(nu alpha, mu) - g_(mu nu, alpha) )$ on a :
$
  dot.double(x)^beta = - Gamma^beta_(mu nu) dot(x)^mu dot(x)^nu\
  "Soit" dot.double(x)^beta + Gamma^(beta)_(mu nu) dot(x)^mu dot(x)^nu = 0
$

#align(center)[= Commuteur des Co-dérivés covariante]

On définit les dérivés covariantes par :
$
  nabla_mu v^nu = partial_mu v^nu + Gamma^nu_(mu rho) v^rho
$
Ainsi, soit $v^rho$ un vecteur :
$
  [nabla_mu; nabla_nu]v^rho &= nabla_mu (nabla_nu v^rho) - nabla_nu (nabla_mu v^rho) \
  &= nabla_mu (partial_nu v^rho + Gamma_(nu alpha)^rho v^alpha) -nabla_nu (partial_mu v^rho + Gamma_(mu alpha)^rho v^alpha) \
  &= partial_mu (partial_nu v^rho + Gamma_(nu alpha)^rho v^alpha) + Gamma_(mu beta)^rho (partial_nu v^beta + Gamma_(nu alpha)^beta v^alpha)
  -
  partial_nu (partial_mu v^rho + Gamma_(mu alpha)^rho v^alpha) - Gamma_(nu beta)^rho (partial_mu v^beta + Gamma_(mu alpha)^beta v^alpha)\
  &= cancel(diff_(nu mu) v^rho) + diff_mu Gamma_(nu alpha)^rho v^alpha + Gamma_(mu beta)^rho diff_nu v^beta + Gamma_(mu beta)^rho Gamma_(nu alpha)^beta v^alpha
  -
  cancel(diff_(mu nu) v^rho) - diff_nu Gamma_(mu alpha)^rho v^alpha - Gamma_(nu beta)^rho diff_mu v^beta - Gamma_(nu beta)^rho Gamma_(mu alpha)^beta v^alpha\
  &= (Gamma_(mu beta)^rho Gamma_(nu alpha)^beta-Gamma_(nu beta)^rho Gamma_(mu alpha)^beta
    +
    diff_mu Gamma_(nu alpha)^rho - diff_nu Gamma_(mu alpha)^rho) v^alpha + underbrace(Gamma_(mu beta)^rho diff_nu v^beta - Gamma_(nu beta)^rho diff_mu v^beta, =0)
$
Ainsi, on reconnait le tenseur de Riemann définis par :$R^sigma_(mu nu kappa) = diff_nu Gamma^sigma_(mu kappa) - diff_kappa Gamma^sigma_(mu nu) + Gamma^sigma_(nu lambda) Gamma^lambda_(mu kappa) - Gamma^sigma_(kappa lambda) Gamma^lambda_(mu nu)$\
Donc on obtient la relation suivante :
$
  [nabla_mu; nabla_nu]v^rho = R^rho_(alpha mu nu) v^alpha
$

#align(center)[= Dérivé covariante]

On se place dans un système de coordonnée $xi^alpha$, et on s’intérèse à un changement de coordonée vers $x^alpha$\
Tout d’abord :
$
  0 = (dif^2 xi^alpha)/(dif tau^2) &= dif/(dif tau) ((dif xi^alpha)/(dif tau))\
  &= dif/(dif tau) ((diff xi^alpha)/(diff x^mu) (dif x^mu)/(dif tau))\
  &= (diff xi^alpha)/(diff x^rho) (dif^2 x^rho)/(dif tau^2) + (dif x^mu)/(dif tau) dif/(dif tau) (diff xi^alpha)/(diff x^mu)
$
Ainsi comme $(diff xi^alpha)/(diff x^mu) times (diff x^mu)/(diff xi^beta) = delta_beta^alpha$, en multipliant des deux cotés :
$
  0 &= (dif^2 x^rho)/(dif tau^2) + (diff x^rho)/(diff xi^alpha) dif/(dif tau) (diff xi^alpha)/(diff x^mu) (dif x^mu)/(dif tau) \
  &= (dif^2 x^rho)/(dif tau^2) + (diff x^rho)/(diff xi^alpha) (diff^2 xi^alpha)/(diff x^mu diff x^nu) (dif x^mu)/(dif tau) (dif x^nu)/(dif tau)
$
En posant : ${""_mu ""^lambda ""_(nu)} = (diff x^lambda)/(diff xi^beta) (diff^2 xi^beta)/(diff x^mu diff x^nu)$, on obtient finalement :
#let croh(m: sym.mu, l: sym.lambda, n: sym.nu) = ${""_#m ""^#l ""_(#n)}$
$
  0 & = (dif^2 x^rho)/(dif tau^2) + croh(l: rho) (dif x^mu)/(dif tau) (dif x^nu)/(dif tau)
$
\
\
En réécrivant le produit scalaire dans les coordonnées $x^alpha$ à:
$
  eta_(mu nu) dif xi^mu dif xi^nu = underbrace(eta_(mu nu) (diff xi^mu)/(diff x^alpha) (diff xi^nu)/(diff x^beta), = g_(alpha beta)) dif x^alpha dif x^beta
$
Donc :
$
  g_(alpha beta) = eta_(mu nu) (diff xi^mu)/(diff x^alpha) (diff xi^nu)/(diff x^beta)
$
alors en dérivant :
$
  g_(alpha beta, lambda) = diff_lambda g_(alpha beta) &= eta_(mu nu) diff/(diff x^lambda) ((diff xi^mu)/(diff x^alpha) (diff xi^nu)/(diff x^beta))\
  &= underbrace(eta_(mu nu) (diff xi^mu)/(diff x^alpha), = g_(alpha mu) (diff x^mu)/(diff xi^nu)) (diff^2 xi^nu)/(diff x^beta diff x^lambda) + underbrace(eta_(mu nu) (diff xi^nu)/(diff x^beta), = g_(beta nu) (diff x^nu)/(diff xi^mu)) (diff^2 xi^mu)/(diff x^alpha diff x^lambda)\
  &= g_(alpha mu) underbrace((diff x^mu)/(diff xi^nu) (diff^2 xi^nu)/(diff x^beta diff x^lambda), = croh(l: mu, m: beta, n: lambda))
  +
  g_(beta nu) underbrace((diff x^nu)/(diff xi^mu) (diff^2 xi^mu)/(diff x^alpha diff x^lambda), = croh(l: nu, m: alpha, n: lambda))\
  &= croh(m: beta, n: lambda, l: mu) g_(mu alpha) + croh(m: alpha, n: lambda, l: nu) g_(nu beta)\
$
Donc en sommant pour difféante dérivé :
$
  g_(alpha beta, lambda) + g_(lambda beta, alpha) - g_(alpha lambda, beta) &= croh(l: mu, m: alpha, n: lambda) g_(mu beta) + cancel(croh(m: beta, n: lambda, l: nu) g_(nu alpha))\
  &+ cancel(croh(l: mu, m: beta, n: alpha) g_(mu lambda)) + croh(m: lambda, n: alpha, l: nu) g_(nu beta)\
  &- cancel(croh(l: mu, m: alpha, n: beta) g_(mu lambda)) cancel(- croh(m: lambda, n: beta, l: nu) g_(nu alpha))\
  &= croh(l: mu, m: alpha, n: lambda) g_(mu beta) + croh(m: lambda, n: alpha, l: nu) g_(nu beta) = 2 croh(l: mu, n: lambda, m: alpha)g_(mu beta)
$
Ainsi :
$
  Gamma^(gamma)_(alpha lambda) &= 1/2 g^(gamma beta) (g_(alpha beta, lambda) + g_(lambda beta, alpha) - g_(alpha lambda, beta)) = 1/2 g^(gamma beta) times 2 croh(l: mu, n: lambda, m: alpha) g_(mu beta)\
  &= croh(l: mu, n: lambda, m: alpha) delta^gamma_(mu) = croh(l: gamma, n: lambda, m: alpha)
$
On trouve que : $Gamma^(mu)_(alpha beta) = croh(l: mu, m: alpha, n: beta)$, et pas concéquant : $Gamma_(alpha beta)^mu = (diff x^mu)/(diff xi^nu) (diff^2 xi^nu)/(diff x^alpha diff x^beta)$

==== Transformation de $Gamma_(mu nu)^lambda$

$
  Gamma_(mu nu)^lambda ' &= croh()' = (diff x'^lambda)/(diff xi^beta) (diff^2 xi^beta)/(diff x'^mu diff x'^nu)\
  &= (diff x^k)/(diff xi^beta) (diff x'^lambda)/(diff x^k) (diff^2 xi^beta)/(diff x^gamma diff x^alpha) (diff x^gamma)/(diff x'^mu) (diff x^alpha)/(diff x'^nu)\
  &= (diff x'^lambda)/(diff x^k) (diff x^gamma)/(diff x'^mu) (diff x^alpha)/(diff x'^nu) underbrace((diff x^k)/(diff xi^beta) (diff^2 xi^beta)/(diff x^gamma diff x^alpha), = croh(l: k, m: gamma, n: alpha))\
  &= (diff x'^lambda)/(diff x^k) (diff x^gamma)/(diff x'^mu) (diff x^alpha)/(diff x'^nu) croh(l: k, m: gamma, n: alpha) ?\
$

#AFL

#align(center)[= Solution de Schwwarzschild]


== Équation sur $R_(mu nu)$

On se place dans un espace de dimension $n$\
D’après l’équation de Einstein :
$
  R_(mu nu) - 1/2 g_(mu nu) R = kappa T_(mu nu)
$
On recherche une solution pour un espace vide, statique et à symétrie sphérique\
donc $T_(mu nu) = 0$, ainsi l’équation devient :
$
                                                                        R_(mu nu) - 1/2 g_(mu nu) R & = 0 \
                                                       donc g^(mu nu) (R_(mu nu) - 1/2 g_(mu nu) R) & = 0 \
  donc underbrace(g^(mu nu) R_(mu nu), = R) - 1/2 underbrace(g^(mu nu)g_(mu nu), = delta_mu^mu = n) & = 0 \
                                                                                   donc R(1 - 1/2n) & = 0 \
                                                                                      donc R(2 - n) & = 0
$

Ainsi on a deux cas particulier :
- Soit $n = 2$, dans ce cas la gravité est topologique
- Soit $R = 0$

Or on recherche une solution pour un espace à 4 dimension (espace-temps), ainsi $R = 0$\
En injectant dans l’équation d’Einstein :
$
  R_(mu nu) - 1/2 g_(mu nu) underbrace(R, = 0) = 0\
  Donc R_(mu nu) = 0
$

== Écriture de la métrique

On sait que dans un espace isotropique, la métrique doit ressemblé à :
$
  dif s^2 = A(r,t)dif t^2 - B(r, t) dif t (arrow(x) dot.c dif arrow(x)) - C(r, t) (arrow(x) dot.c dif arrow(x))^2 - D(r, t) dif arrow(x)^2
$
En opérant le changement de variables en coordonnées sphérique :
$
  x^1 & = r sin(theta) cos(phi) \
  x^2 & = r sin(theta) sin(phi) \
  x^3 & = r cos(theta)
$
Dans ce cas on a :
$
  arrow(x) dot.c arrow(x) = r^2, "    " arrow(x) dot.c arrow(x) = r dr, "    "dif arrow(x) dot.c dif arrow(x) = dr^2 + r^2 dif theta^2 + r^2 sin(theta)^2 dif phi^2
$
Ainsi la métrique devient :
$
  ds^2 & = A(t,r)dt^2 - B(t, r) r dt dr - C(t,r) r^2 dr^2 - D(t, r) dr^2 - D(t,r) r^2 dif^2 Omega \
       & = A(t,r)dt^2 - B'(t,r) dt dr - C'(r,t) dr^2 - D' dif^2 Omega
$
avec $dif^2 Omega = dif theta^2 + sin(theta)^2 dif phi^2$ l’angle solide et $B' = B r;" " C' = C r^2 + D et D' = D$\
On pose $dash(r)^2 = D'$, alors :
$
  ds^2 = A(t, dash(r)) dt^2 - B'(t, dash(r)) dt dif dash(r) - C'(t, dash(r)) dif dash(r)^2 - dash(r)^2 dif^2 Omega
$
On pose également $dif dash(t) = Phi(t, dash(r))[A(t, dash(r)) dt - 1/2 B'(t, dash(r)) dif dash(r)]$, donc
$
  dif dash(r)^2 = Phi(t, dash(r)) [A^2 dt^2 + 1/4 B'^2 dif dash(r)^2 - A B' dt dif dash(r) ]\
  Donc A dt^2 - B' dt dif dash(r) = 1/(A Phi) dif dash(t)^2 - B/(4 A) dif dash(r)^2
$
