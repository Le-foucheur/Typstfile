#import "@preview/cetz:0.5.2" 
#import "@preview/cetz-plot:0.1.4" : plot
#import "@preview/mechanical-system-cetz-34j:1.1.5": spring, wall
#import "../../template.typ": *

#show math.equation: it => {
    show regex("\d+\.\d+"): it => {show ".": {","+h(0pt)}
        it}
    it
}

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
  donc dot.double(x) &+ alpha/m dot(x) + (S E)/(m e) x = (S)/(m c) I(t) 
$
Je pose $omega_0^2 = (S E)/(m e)$, on peut le réecrire, car la masse de feuille d’or poussé vaut: $m = rho S upright(e)$, avec $rho$ la masse volumique, douc :
$
  omega_0 = 1/upright(e) sqrt(E/rho)
$

j’obtiens finalement, l’équation suivante :
$
  dot.double(x) + alpha/(rho S e) dot(x) + omega_0^2 x = 1/(rho c upright(e)) I(t)
$ 

- Quelque ordre de grandeur de $omega_0$ :
 - Or : $upright(e) = 0.001 "mm"$ donc $omega_"or" approx 2 dot.c 10^9 "s"^(-1)$
 - Aluminium : $upright(e) = 0.02 "mm"$ donc $omega_"alu" approx 2.5 dot.c 10^8 "s"^(-1)$

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
  a_o = I_0 / (2 omega^2_0 rho c upright(e)) =I_0/(2 Aleph )
$
avec $Aleph = omega_0^2 rho c upright(e) = cancel(rho) c cancel(upright(e)) dot.c E/(e^cancel(2) cancel(rho)) = (c E)/upright(e)$\
- Pour l’or :
$Aleph_"or" = (3 dot.c 10^8 times 78)/0.001 approx 2.3 dot.c 10^(25) "Pa" dot.c "s"^(-1) = 2.3 dot.c 10^(25) "W" dot.c "m"^(-3)$
- Pour l’aluminium :
$Aleph_"alu" = 0.02/(3 dot.c 10^8 times 69) approx 1,0 dot.c 10^(24) "Pa" dot.c "s"^(-1) = 1,0 dot.c 10^(24) "W" dot.c "m"^(-3)$

Revenons au calcule :

pour $n > 0$ et paire :
$
  a_n (omega_0^2 - n^2 Omega^2) = 0 => a_n = 0
$
pour $n > 0$ et impaire :
$
  a_n (omega_0^2 - n^2 Omega^2) = (2 I_0 omega_0^2)/(n pi Aleph) => a_n = (2 I_0 omega_0^2)/(pi Aleph) 1/(n (omega_0^2 - n^2 Omega^2))
$
donc on a, la solution suivante :
$
  x_p (t) &= I_0 / (2 Aleph) + (2 I_0 omega_0^2)/(pi Aleph) sum_(n = 0\ n "impaire")^(+oo) sin(n Omega t)/(n (omega_0^2 - n^2 Omega^2))\
  &= I_0 / (2 Aleph) (1 + (4omega_0^2)/pi sum_(n = 0)^(+oo) sin((2n+1) Omega t)/((2n+1)(omega^2_0 - (2n+1)^2 Omega^2)))
$

Ainsi les solution de l’équation sont :
$
  x(t) = A cos(omega_0 t) + B sin(omega_0 t) + x_p (t)
$
je prend en condition initiale : $x(0) = dot(x)(0) = 0$, la feuille bouge pas quoi, donc :
$
  A = - I_0/(2 Aleph)
$
et 
$
  omega_0 B + (2 I_0 omega_0^2)/(pi Aleph) sum_(n = 0)^(+oo) Omega/(omega^2_0 - (2n+1)^2 Omega^2) = 0
$
Donc
$
  B &= - (2 I_0 omega_0)/(pi Omega Aleph) sum_(n = 0)^(+oo) 1/(underbrace(omega^2_0/Omega^2, = lambda^2) - (2n+1)^2)\
  &= - (2 I_0)/(pi Aleph) (omega_0)/Omega sum_(n = 0)^(+oo) 1/(lambda^2 - (2n+1)^2)
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
  B = - (2 I_0)/(cancel(pi) Aleph) (cancel(omega_0))/cancel(Omega) times - (cancel(pi) cancel(Omega))/(4 cancel(omega_0)) tan((pi omega_0)/(2 Omega)) = I_0/(2 Aleph) tan((pi omega_0)/(2 Omega))
$
La solution s’écrit finalement :
$
  x(t) &= I_0/(2 Aleph) tan((pi omega_0)/(2 Omega)) sin(omega_0 t) - I_0/(2 Aleph) cos(omega_0 t) + I_0 / (2 Aleph) (1 + (4 omega_0^2)/pi sum_(n = 0)^(+oo) sin((2n+1) Omega t)/((2n+1)(omega^2_0 - (2n+1)^2 Omega^2)))\
  &= I_0/(2 Aleph) (1 + tan((pi omega_0)/(2 Omega)) sin(omega_0 t) - cos(omega_0 t)  + (4 omega_0^2)/pi sum_(n = 0)^(+oo) sin((2n+1) Omega t)/((2n+1)(1 - (2n+1)^2 Omega^2/omega_0^2)))
$

On peut premièrement remarqué un phénomène de résonance pour $Omega = omega_0/(2 n + 1)$

Si vous voulez tester cette solution : #link("https://www.desmos.com/calculator/023hzq7f78?lang=fr")

== Avec Frottement 

=== Étude générale

Considéron une harmonique pure, i.e. que $underline(x)(t) = underline(A) e^(i omega t)$, alors :
$
  (- omega^2 + i alpha/(rho S upright(e)) omega + omega_0^2) underline(x) = 1/(rho c upright(e)) I(t) 
$
Ainsi, la fonction de transfère est :
$
  H &= underline(x)/I = (1/(rho c upright(e)))/(omega_0^2 - omega^2 + i alpha/(rho S upright(e)) omega) = (overbrace(1/(omega_0^2 rho c upright(e)), = 1/Aleph = H_0))/(1 - (omega/omega_0)^2 + i underbrace(alpha/(rho S upright(e) omega_0), = 1/Q) omega/omega_0)\
  &= H_0/(1 - omega^2/omega_0^2 + i/Q omega/omega_0)
$

On y reconnais un filtre passe-bas, de gain : $G = H_0/sqrt((1- X^2)^2 + X^2/Q^2)$\
\
et de phase $phi.alt = cases(arctan(X/(Q (1-X^2))) " " &Q (1-X^2) > 0, pi/2  " " &Q (1-X^2) = 0, pi + arctan(X/(Q (1-X^2))) " " & Q (1-X^2)< 0) $\
avec $X = omega_0/omega$

avec un laser de diamètre de $1,8$cm et $alpha approx 1.3$
- Pour l’or :
$Q = (omega_"or" rho S upright(e))/alpha approx 7595$
- Pour l’aluminium :
$Q = (omega_"alu" rho S upright(e))/alpha approx 2672$

De plus on à une résonance pour : $Omega_r = omega_0 sqrt(1-1/(2Q^2))$

#grid(
  columns: 2,
  column-gutter: 2cm,
  figure(
    cetz.canvas({
      import cetz.draw:*
      let f(q, x) = {
        20*calc.log(1/calc.sqrt(calc.pow(1-calc.pow(x,2), 2) + calc.pow(x/q,2)))
      }

      plot.plot(
        axis-style: "left",
        size: (7, 7),
        x-mode: "log",
        x-base: 10,
        x-tick-step: 1,
        x-minor-tick-step: 1,
        x-format: calc.log,
        y-tick-step: auto,
        y-max: 80,
        x-grid: "both",
        y-grid: "both",
        legend: "inner-south-west",
        x-label: $ "    "omega/omega_0 $,
        y-label: $ G $,
        {
          for q in ((7595, "or ", red),(2672, "alu", blue)) {
            plot.add(
              domain: (calc.pow(10,-0), calc.pow(10,0)),
              x => f(q.first(), x),
              style: (stroke: q.last()),
              sample-at: (
                0.3,
                0.4,
                0.5,
                0.6,
                0.7,
                0.8,
                0.9,
                0.95,
                0.99,
                0.995,
                0.999,
                1,
                1.005,
                1.001,
                1.01,
                1.05,
                1.125,
                1.25,
                1.5,
                2,
                3,
              ),
              label: $Q_#q.at(1) = #q.first()$
            )
          }
        }
      )
    }),
    caption: "Gain"
  ),
  figure(
    cetz.canvas({
    import cetz.draw: set-style
      set-style(legend: (fill: white))

      let format(v) = {$#{calc.round(v, digits: 3)}$}
      plot.plot(
        axis-style: "left",
        size: (7, 7),
        x-mode: "log",
        x-base: 10,
        x-tick-step: 0.001,
        x-minor-tick-step: 1,
        x-format: format,
        y-tick-step: 20, y-max: 180, y-min: 0,
        x-grid: "both",
        y-grid: "both",
        legend: "inner-south-west",
        x-label: $ "    "omega/omega_0 $,
        y-label: $ phi.alt $,
        {
          let g(q, x) = {
             -calc.atan(x/(q * (1-calc.pow(x,2)))).deg() + 180
          }
          let f(q, x) = {
            -calc.atan(x/(q * (1-calc.pow(x,2)))).deg()
          }
          for q in ((7595, "or ", red),(2672, "alu", blue)) {
            plot.add(
              domain: (calc.pow(10,0.0000001), calc.pow(10,0.001)),
              x => f(q.first(), x),
              style: (stroke: q.last()),
              label: $Q_#q.at(1) = #q.first()$,
            )
            plot.add(
              domain: (calc.pow(10,-0.001), calc.pow(10,-0.0000001)),
              x => g(q.first(), x),
              style: (stroke: q.last()),
            )
          }
        }
      )
  }),
    caption: "Phase"
  )
)


=== Étude avec un signal carré 

Je rappelle l’équation diff ($Q = (omega_0 rho S upright(e))/alpha$) :
$
  dot.double(x) + underbrace(alpha/(rho S e), = omega_0/Q) dot(x) + omega_0^2 x = omega_0^2/(Aleph) I(t)
$ 

Comme tout dans le chapitre précédent on a :
$
  I(t) = I_0/2 + (2 I_0)/pi sum_(n = 0)^(+oo) sin((2n+1) Omega t)/(2n + 1) = I_0/2 + (2 I_0)/pi sum_(n = 0\ n "impaire")^(+oo) sin(n Omega t)/n
$
Cette fois on cherche une solution particulière de la forme :
$
  x_p (t) = X_0 + sum_(n = 0\ n "impaire")^(+oo) X_n sin(n Omega t + phi.alt_n) = X_0 + sum_(n = 0\ n "impaire")^(+oo) x_n (t)
$
alors, on obtient :
$
  omega_0^2 X_0 + sum_(n = 0)^(+oo) [dot.double(x)_n + omega_0/Q dot(x)_n + omega_0^2 x_n] = (I_0 omega_0^2)/(2 Aleph) + (2 I_0 omega_0^2)/(pi Aleph) sum_(n = 0\ n "impaire")^(+oo) sin(n Omega t)/n
$
Donc, on a :
$
  cases(
    "coef constant :" X_0 = I_0/(2 Aleph),
    "pour" n "impaire :" dot.double(x)_n + omega_0/Q dot(x)_n + omega_0^2 x_n = (2 I_0 omega_0^2)/(pi Aleph)  sin(n Omega t)/n
  )
$
Pour résoudre le second cas on pose : $underline(x_n) = underline(X_n) e^(i n Omega t)$, ainsi $x_n = Im(underline(x_n))$, on obtient donc :
$
  underline(X_n)(- n^2 Omega^2 + i (omega_0 n Omega)/(Q)+ omega_0^2) = (2 I_0 omega_0^2/(pi n Aleph)
$ 
donc
$
  underline(X_n) = (2 I_0)/(pi Aleph) (omega_0^2)/(n (omega_0^2 - n^2 Omega^2 + i (omega_0 n Omega)/(Q))) = (2 I_0)/(pi Aleph) 1/(n (1 - n^2 Omega^2/omega_0^2 + i (n)/(Q) Omega/omega_0))
$
On peut récupérer $X_n et phi.alt_n$ :
$
  X_n = abs(underline(X_n)) = (2 I_0)/(pi Aleph) 1/(n sqrt((1 - n^2 Omega^2/omega_0^2)^2 + (n^2)/Q^2 Omega^2/omega_0^2))
$
et
$
  phi.alt_n &= - arg(1 - n^2 Omega^2/omega_0^2 + i ( n)/(Q) Omega/omega_0)\ 
  &= -atan2( n/Q Omega/(omega_0), 1 - n^2 Omega^2/omega_0^2)
$
avec $atan2(y ,x) = cases(arctan(y/(|x|)) " " &x > 0, pi/2  " " &x = 0, pi + arctan(y/(|x|)) " " &x < 0)$\
Ainsi :
$
  x_p (t) &= I_0/(2 Aleph) + (2 I_0)/(pi Aleph) sum_(n = 0)^(+oo) 1/(2n+1) sin{(2n+1) Omega t -atan2((2n+1)/Q ( Omega)/(omega_0), 1 - (2n+1)^2 Omega^2/omega_0^2) }/sqrt((1 - (2n+1)^2 Omega^2/omega_0^2)^2 + (2n+1)^2/Q^2 (Omega^2)/(omega_0^2))\
  &= I_0/(2 Aleph) [1 + (4)/pi sum_(n = 0)^(+oo) 1/(2n+1) sin{(2n+1) Omega t -atan2((2n+1)/Q ( Omega)/(omega_0), 1 - (2n+1)^2 Omega^2/omega_0^2) }/sqrt((1 - (2n+1)^2 Omega^2/omega_0^2)^2 + (2n+1)^2/Q^2 (Omega^2)/(omega_0^2))]
$
*N.B. :* C’est vraiment pas beau… Mais on ré-obtiens bien ce que l’on trouvais dans l’étude générale, i.e. que chaque fréquence est bien multiplié par le gain et est déphasé par la phase que l’on avais trouvé\
Ce qui voudrais dire que l’on a un signal carré dont on vire les hautes fréquence et on amplifie la fréquence proche de $omega_0$ ??\
\
Cherchons maintenants les solutions homogènes :
$
  dot.double(x) + omega_0/Q dot(x) + omega_0^2 x = 0
$

Donc de manière générale, on prendra $Q > 1/2$, donc les solutions de la forme :
$
  x_h (t) = e^(Im(r) t) (A sin(abs(Re(r)) t) + B cos(abs(Re(r))t))
$
avec $r$ une des solution du plynome $X^2 + omega_0/Q X + omega_0^2$,\ 
soit $r = - omega_0/(2Q) plus.minus i omega_0 sqrt(1 - 1/(4 Q^2)) = - underbrace(alpha/(2rho S upright(e)), = 1/tau) plus.minus sqrt(omega_0^2 - alpha^2/(4 rho^2 S^2 e^2)) = - 1/tau plus.minus sqrt(omega_0^2 - 1/tau^2)$\

Ordre de grandeur du $tau$ :\
- Pour l’or :
$tau_"or" = (2Q)/omega_"or" approx 7.6 dot.c 10^(-6) "s"$
- Pour l’aluminium :
$tau_"alu" = (2Q)/omega_"alu" approx 2.1 dot.c 10^(-5) "s"$

Donc :
$
  x_h (t) = e^(- t/tau) (A sin(sqrt(omega_0^2 - 1/tau^2)t) + B cos(sqrt(omega_0^2 - 1/tau^2)t) )
$

Ainsi les solutions sont :
$
  x(t) = e^(- t/tau) (A sin(sqrt(omega_0^2 - 1/tau^2)t) + B cos(sqrt(omega_0^2 - 1/tau^2)t) ) + x_p (t)
$
En posant comme condition initiale $x(0) = dot(x) (0) = 0$ :
$
  B = - x_p (0)
$
et
$
  A = - (dot(x)_p (0))/sqrt(omega_0^2 - 1/tau^2)
$
avec :
$
  x_p (0) = I_0/(2 Aleph) (1 - C(Q, Omega/omega_0))
$
et
$
  dot(x)_p (0) = (I_0 Omega)/(2 Aleph) C'(Q, Omega/omega_0)
$
où on définis :
$
  C(Q, x) &=  (4)/pi sum_(n = 0)^(+oo) 1/(2n+1) sin{atan2((2n+1)/Q x, 1 - (2n+1)^2 x^2) }/sqrt((1 - (2n+1)^2 x^2)^2 + (2n+1)^2/Q^2 x^2)\ 
    &= (4 x)/(pi Q) sum_(n = 0)^(+oo) abs(1 - (2n+1)^2 x^2)/(1 - (2n+1)^2 x^2) 1/((1 - (2n+1)^2 x^2)^2 + (2n+1)^2/Q^2 x^2) \
  "pour" x >= 1  &= (sh(pi/(2 Q x)) - 1/sqrt(4Q^2 - 1)sin((pi sqrt(4Q^2 - 1))/(2 Q x)))/(ch(pi/(2 Q x)) + cos((pi sqrt(4Q^2 - 1))/(2 Q x))) \
  C'(Q, x) &= (4)/pi sum_(n = 0)^(+oo)  cos{atan2((2n+1)/Q x, 1 - (2n+1)^2 x^2) }/sqrt((1 - (2n+1)^2 x^2)^2 + (2n+1)^2/Q^2 x^2)\
  &= (4)/pi sum_(n = 0)^(+oo)  ((2n+1)^2 x^2)/((1 - (2n+1)^2 x^2)^2 + (2n+1)^2/Q^2 x^2)\
  &= 1/(2Q x) (sh(pi/(2 Q x)) + 1/sqrt(4Q^2 - 1)sin((pi sqrt(4Q^2 - 1))/(2 Q x)))/(ch(pi/(2 Q x)) + cos((pi sqrt(4Q^2 - 1))/(2 Q x)))
$

*N.B. :* Les deux forme « closes » faudrait les démontré, car la elle sorte juste de mon cul (-> gémini) 

Revenons à nos moutons :\
La solution final est donc :
$
  x(t) &= - I_0/(2 Aleph) e^(- t/tau) [ (1 - C(Q, Omega/omega_0)) sin(sqrt(omega_0^2 - 1/tau^2)t)+Omega C'(Q, Omega/omega_0) cos(sqrt(omega_0^2 - 1/tau^2)t) ] + x_p (t)\
  &=  I_0/(2 Aleph) { 1 + (4)/pi sum_(n = 0)^(+oo) 1/(2n+1) sin{(2n+1) Omega t -atan2((2n+1)/Q ( Omega)/(omega_0), 1 - (2n+1)^2 Omega^2/omega_0^2) }/sqrt((1 - (2n+1)^2 Omega^2/omega_0^2)^2 + (2n+1)^2/Q^2 (Omega^2)/(omega_0^2))\ 
  &"                   "- e^(- t/tau) [ (1 - C(Q, Omega/omega_0)) sin(sqrt(omega_0^2 - 1/tau^2)t)+Omega C'(Q, Omega/omega_0) cos(sqrt(omega_0^2 - 1/tau^2)t) ]}
$

Comme vue, on a $tau << 1$, donc en vrais on peut simplifier avec juste la série ($e^(-t/tau) approx 0$) (oui j’aime me faire chier…)
$
  x(t) = I_0/(2 Aleph) { 1 + (4)/pi sum_(n = 0)^(+oo) 1/(2n+1) sin[(2n+1) Omega t -atan2((2n+1)/Q ( Omega)/(omega_0), 1 - (2n+1)^2 Omega^2/omega_0^2) ]/sqrt((1 - (2n+1)^2 Omega^2/omega_0^2)^2 + (2n+1)^2/Q^2 (Omega^2)/(omega_0^2)) }
$

=== Cas concret et sans résonance ($Omega != omega_0/(2 n + 1) sqrt(1 - 1/(2Q^2))$)

dans ce cas on a : $Omega << omega_0$ :
$
  x(t) &= I_0/(2 Aleph) { 1 + (4)/pi sum_(n = 0)^(+oo) 1/(2n+1) sin[(2n+1) Omega t -arctan((2n+1)/Q ( Omega)/(omega_0)) ] }\
  &= I_0/(2 Aleph) { 1 + (4)/pi sum_(n = 0)^(+oo) 1/(2n+1) sin((2n+1) Omega t -(2n+1)/Q ( Omega)/(omega_0)) }\
  &= I_0/(2 Aleph) { 1 + (4)/pi sum_(n = 0)^(+oo) 1/(2n+1) sin((2n+1) Omega (t - 1/(Q omega_0) )) }\
  &= 1/(Aleph) I(t - 1/(Q omega_0)) approx 1/Aleph I(t)
$
On retombe sur le signal crénaux départ mais retardé et réduis\
dans les faits on a $omega_0 >> 1$, donc il n’est même pas retardé


Sauf que je rappelle que $Aleph$ est de l’ordre $10^(-24 )$, donc ,heu, on devrais rien voir là… #str.from-unicode(0x1F480)

=== Cas concret et avec résonance 

On est dans un cas où une des fréquence du signal carré est en résonance, donc on posse :
$
  Omega = omega_0/(2 n' + 1) sqrt(1 - 1/(2Q^2)) approx omega_0/(2 n' + 1)
$
avec $n' >> 1$ et $Q >> 1$, donc pour la fréquance amplifiée ($n = n'$) :

premièrement : $1 - (2n'+1)^2 Omega^2/omega_0^2 = 1 - (2n'+1)^2/(2n'+1)^2 omega_0^2/omega_0^2 = 0$ et $(2n'+1)/Q ( Omega)/(omega_0) = 1/Q$ \
\

$
  &"   "1/(2n'+1) sin[(2n'+1) Omega t -atan2((2n'+1)/Q ( Omega)/(omega_0), 1 - (2n'+1)^2 Omega^2/omega_0^2) ]/sqrt((1 - (2n'+1)^2 Omega^2/omega_0^2)^2 + (2n'+1)^2/Q^2 (Omega^2)/(omega_0^2))\
  &= 1/(2n'+1) sin[omega_0 t -overbrace(atan2(1/Q, 0), = pi/2)]/sqrt(1/Q^2 ) = - Q/(2n'+1) cos(omega_0 t)
$
et les autres fréquance :
$
  &"    "1 + (4)/pi sum_(n = 0\ n= n')^(+oo) 1/(2n+1) sin[(2n+1) Omega t -atan2((2n+1)/Q ( Omega)/(omega_0), 1 - (2n+1)^2 Omega^2/omega_0^2) ]/sqrt((1 - (2n+1)^2 Omega^2/omega_0^2)^2 + (2n+1)^2/Q^2 (Omega^2)/(omega_0^2))\
  &approx 2/I_0 I(t)
$
J’ai le droit de faire ça car $n'>> 1$ et donc on retire juste une toute petite fréquance qui « n’apporte » pas grand chose, de plus on a $Omega << omega_0$ donc on peut faire la même approximation que dans le chapitre précédent.\
Ainsi le signal deviens :
$
  x(t) = 1/(Aleph) I(t) - (2 I_0)/(pi Aleph) Q/(2n'+1) cos(omega_0 t) 
$

Pour avoir une résonance dans l’audible on veut :
$
  20 <= omega_0/(2n'+1) <= 20 dot.c 10^3
$
on obtient que $n'$ doit être compris entre :
$
  omega_0/(40 dot.c 10^3) <= n' <= omega_0/(40)
$
- Pour l’or :
$
  50" "258 <= n' <= 50" "258" "400 
$
- Pour l’aluminium :
$
  6" "321 <= n' <= 6" "320" "351
$