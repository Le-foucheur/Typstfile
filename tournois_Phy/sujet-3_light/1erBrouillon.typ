#import "@preview/cetz:0.5.2" 
#import "@preview/mechanical-system-cetz-34j:1.1.5": spring, wall
#import "../../template.typ": *

#show: it => template(ancienne_lig: true, it)

Pour l’instant je ne considère que un système proche d’un haut parleur classique, en suposant que seul la pression radiative bouge la feuille et que le reste de la feuille, non toucher par le laser, sert de ressort, d’une constante de raideur $k$ :

#align(center, 
  cetz.canvas({
    import cetz.draw: *


    wall((0, -1), b: (0, 1), name: "wall", inverse: true)

    spring((0.5,0), b: (3.5,0), name: "spring", width: 10%, n: 20)
    line("spring", "wall")

    line((4, 1), (4, -4), name: "feuille")
    line("spring", "feuille.20%")

    circle((0, -2.5), radius: (0.25, 0.5), name: "laser", stroke: red)
    line("laser.0", "feuille.60%", stroke: red)
    line("laser.50%", "feuille.80%", stroke: red)
    content("laser", anchor: "west", padding: 0.5, [Laser])

    content("feuille.start", anchor: "south", padding: 0.2, [Feuille d’or])

    content((2, 0.5), anchor: "south", [« ressort »])

    content("laser", $S$)

    line((-0.2,-4.5), (5, -4.5), mark: (end: "straight"), name: "axe")

    content("axe.end", anchor: "south-west", $x$)
    content((4, -5), $x(t)$, name: "pos")
    line("feuille.end", "pos", stroke: (dash: "dashed"))
  })
)

== Lien entre constante de raideur et module de Young

En physique des millieux continues, on a la relation suivante :
$
  sigma = E epsilon
$
avec : $sigma = F/S$ la contraite, $E$ le module de Young\
et $epsilon = (Delta l)/l_0$ l’écart relatif
et où $F$ est la force appliqué, $S$ la surface\
Ici je pose $l_0 = upright(e) ou upright(e)/2$ avec $upright(e)$ l’aipesseur de la feuille\
Ainsi, j’obtiens :
$
  F = underbrace((S E)/upright(e), = k) Delta l
$
Donc
$
  k = (S E)/upright(e)
$

== Équation du mouvement de la feuille

En fouillant sur le net, j’ai trouvé que la pression radiative étais proportionelle à l’intensité du laser, donc, la force éxercé sur la feuille est :
$
  F = S/c I(t)
$
avec $I$ l’intensité du laser et $c$ la célérité de la lumière \
\
Ainsi en supposant des frottement fluide à faible vitesse, j’obtiens, via la seconde loi de Newton :
$
  m dot.double(x) &= S/c I(t) - k x - alpha dot(x)\
  donc dot.double(x) &+ alpha dot(x) + (S E)/(m e) x = (S)/(m c) I(t) 
$
Je pose $omega_0^2 = (S E)/(m e)$, on peut le réecrire, car la masse de feuille d’or poussé vaut: $m = rho S upright(e)$, avec $rho$ la masse volumique, douc :
$
  omega_0 = 1/upright(e) sqrt(E/rho)
$

j’obtiens finalement, l’équation suivante :
$
  dot.double(x) + alpha dot(x) + omega_0^2 x = 1/(rho c upright(e)) I(t)
$ 

- Quelque ordre de grandeur de $omega_0$ :
 - Or : $upright(e) = 0.001 "mm"$ donc $omega_"or" approx 2 dot.c 10^9 "s"^(-1)$
 - Aluminium : $upright(e) = 0.02 "mm"$ donc $omega_"alu" approx 2,5 dot.c 10^8 "s"^(-1)$

== Solution pour un signal crénaux sans frottement
Pour l’instant je considère le cas sans frottement ($alpha = 0$), et ou l’intensité suit un signal crénaux d’intensité $I_0$ et de pulsation $Omega$, donc :
$
  I(t) = I_0/2 + (2 I_0)/pi sum_(n = 0)^(+oo) sin((2n+1) Omega t)/(2n + 1) = I_0/2 + (2 I_0)/pi sum_(n = 0\ n "impaire")^(+oo) sin(n Omega t)/n
$
Je recherche donc une solution particulière sous forme de série de fourier impaire de pulsation $Omega$, donc :
$
  x_p = a_0 + sum_(n = 0)^(+oo) a_n sin(n Omega t)
$
ainsi :
$
  dot.double(x)_p = - sum_(n = 0)^(+oo) n^2 Omega^2 a_n sin(n Omega t)
$
En y injéctant dans l’équa diff :
$
  - sum_(n = 0)^(+oo) n^2 Omega^2 sin(n Omega t) + a_0 omega_0^2 + omega_0^2 sum_(n = 0)^(+oo) a_n sin(n Omega t) &= I_0/(2 rho c upright(e)) + (2 I_0)/(pi rho c upright(e)) sum_(n = 0\ n "impaire")^(+oo) sin(n Omega t)/n\
  a_0 omega_0^2 + sum_(n = 0)^(+oo) a_n (omega_0^2 - n^2 Omega^2) sin(n Omega t) &= I_0/(2 rho c upright(e)) + (2 I_0)/(pi rho c upright(e)) sum_(n = 0\ n "impaire")^(+oo) sin(n Omega t)/n
$
Or tout la décompositon en série de fourier est unique, donc :
$
  a_o = I_0 / (2 omega^2_0 rho c upright(e))
$
pour $n > 0$ et paire :
$
  a_n (omega_0^2 - n^2 Omega^2) = 0 => a_n = 0
$
pour $n > 0$ et impaire :
$
  a_n (omega_0^2 - n^2 Omega^2) = (2 I_0)/(n pi rho c upright(e)) => a_n = (2 I_0)/(pi rho c upright(e)) 1/(n (omega_0^2 - n^2 Omega^2))
$
donc on a, la solution suivante :
$
  x_p (t) &= I_0 / (2 omega^2_0 rho c upright(e)) + (2 I_0)/(pi rho c upright(e)) sum_(n = 0\ n "impaire")^(+oo) sin(n Omega t)/(n (omega_0^2 - n^2 Omega^2))\
  &= I_0 / (2 rho c upright(e)) (1/omega_0^2 + 4/pi sum_(n = 0)^(+oo) sin((2n+1) Omega t)/((2n+1)(omega^2_0 - (2n+1)^2 Omega^2)))
$

Ainsi les solution de l’équation sont :
$
  x(t) = A cos(omega_0 t) + B sin(omega_0 t) + x_p (t)
$
je prend en condition initiale : $x(0) = dot(x)(0) = 0$, la feuille bouge pas quoi, donc :
$
  A = - I_0/(2 omega_0^2 rho c upright(e))
$
et 
$
  omega_0 B + (2 I_0)/(pi rho c upright(e)) sum_(n = 0)^(+oo) Omega/(omega^2_0 - (2n+1)^2 Omega^2) = 0
$
Donc
$
  B &= - (2 I_0)/(pi rho Omega omega_0 c upright(e)) sum_(n = 0)^(+oo) 1/(underbrace(omega^2_0/Omega^2, = lambda^2) - (2n+1)^2)\
  &= - (2 I_0)/(pi rho Omega omega_0 c upright(e)) sum_(n = 0)^(+oo) 1/(lambda^2 - (2n+1)^2)
$
Calculon la série:
$
  sum_(n = 0)^(+oo) 1/(lambda^2 - (2n+1)^2) = - pi/(4 lambda) underbrace({sum_(n = 0)^(+oo) (- 8 (lambda pi)/2)/(4((pi lambda)/2)^2 - (2n+1)^2 pi^2) }, = tan((pi lambda)/2)) = - pi/(4 lambda) tan((pi lambda)/2) = - (pi Omega)/(4 omega_0) tan((pi omega_0)/(2 Omega))
$
*N.B. :* Oui, j’apprend en même temps que vous que $tan$ peut s’écrire sous la forme :
$
  tan(z) = sum_(n = 0)^(+oo) (- 8 z)/(4z^2 - (2n +1)^2 pi^2)
$
\
Ainsi :
$
  B = - (2 I_0)/(cancel(pi) rho cancel(Omega) omega_0 c upright(e)) times - (cancel(pi) cancel(Omega))/(4 omega_0) tan((pi omega_0)/(2 Omega)) = I_0/(2 rho omega_0^2 c upright(e)) tan((pi omega_0)/(2 Omega))
$
La solution s’écrit finalement :
$
  x(t) &= I_0/(2 rho omega_0^2 c upright(e)) tan((pi omega_0)/(2 Omega)) sin(omega_0 t) - I_0/(2 omega_0^2 rho c upright(e)) cos(omega_0 t) + I_0 / (2 rho omega_0^2 c upright(e)) (1 + (4 omega_0^2)/pi sum_(n = 0)^(+oo) sin((2n+1) Omega t)/((2n+1)(omega^2_0 - (2n+1)^2 Omega^2)))\
  &= I_0/(2 rho omega_0^2 c upright(e)) (tan((pi omega_0)/(2 Omega)) sin(omega_0 t) - cos(omega_0 t) + 1  + (4 omega_0^2)/pi sum_(n = 0)^(+oo) sin((2n+1) Omega t)/((2n+1)(omega^2_0 - (2n+1)^2 Omega^2)))
$