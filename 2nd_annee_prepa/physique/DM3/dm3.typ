#import "../../../template.typ": *
#import "../../../transposition.typ": *
#import "@preview/drafting:0.2.0": *

#show: template

Gaspar Daguet
#align(center, text(20pt)[Physique : DM5])

#set-page-properties()

= Une atmosphère électrique

#question.update(13)

=== \

$
norm((ar(v)_- and ar(B))/ ar(E)) = norm(ar(v)_- and ((ar(k) and ar(E))/omega))/E = (v_- k/omega E)/E = v_- k/omega approx v_-/c <<1 "car non relativiste"
$

#undermath[donc la compossante magnétique est négliqeable face à la compossante éléctrique]

=== \

Dans le plasma on a : $ar(dotless.j) = q_+ n' ar(v)_+ - e n ar(v)_-$\
avec $q_+$ la charge des ions, $n'$ la distribution des ions et $ar(v)_+$ leur vitesse 

Par #l2LN appliquée aux éléctrons dans le système du plasma supossé galiléen :
$
  m_e (dif ar(v)_-) / dt = ar(F)_"lorentz" = -e underline(ar(E))\
  "Donc par intégration" \
  ar(v)_- = -(e underline(ar(E)))/(i omega m_e)
$

De même on trouve que : $ar(v)_+ = (e underline(ar(E)))/(i omega M)$\
Donc
$
  norm(ar(v)_+/ar(v)_-) = ((e E)/(i omega M))/((e E)/(i omega m_e)) = m_e/M approx 1.10^(-3) << 1
$

Donc $ar(v)_+$ est négliqeable devant $ar(v)_-$, ainsi 
$
  ar(dotless.j) approx -n e ar(v)_- = underbrace((n e^2)/(i omega m_e), = underline(gamma)_p) underline(ar(E))
$

#underline(stroke: black)[Analyse energétique :]\
$
  <underline(ar(dotless.j)) . underline(ar(E))> = 1/2 Re(underline(ar(dotless.j)) underline(ar(E))^*) = 1/2 Re((n e^2)/(i omega m_e) underline(ar(E)) underline(ar(E))^*) = 1/2 Re underbrace(((n e^2)/(i omega m_e) norm(ar(E))), "imaginaire pure") = 0
$

Donc aucune énérgie est transphérée dans le plasma, donc soit l'onde le traverse sans l'influancer, soit elle rebondit dessus.

#pagebreak()

=== \

d'après les équations de Maxwell,
$
  underbrace(ar(nabla)(ar(nabla).ar(E)), = 0 "car" rho_0 = 0) - ar(laplace) ar(E) = ar(nabla) and (arrow(nabla) and arrow(E)) = - arrow(nabla) and (diff arrow(B))/(ddt) = -mu_0 (diff arrow(dotless.j))/ddt - 1/c^2 (diff^2 arrow(E))/ddt^2\
  Donc undermath(square arrow(E) = - mu_0 (diff arrow(dotless.j))/ddt)\
$\
avec $square$ l'oprérateur d'alembertien\

\
Or $(diff arrow(dotless.j))/(ddt) = gamma_p (diff arrow(E))/ddt$ \

$
  Donc arrow(laplace) arrow(E) &= (mu_0/(i omega)gamma_p + 1/c^2)(diff^2 arrow(E))/ddt^2\
  Donc -k^2 arrow(E) &= - (omega^2/c^2 - (mu_0 n e^2)/(m_e))arrow(E)\
  Donc k^2 &= omega^2/c^2 - underbrace((n e^2)/(m_e epsilon_o), = omega_p^2) 1/c^2\
  &= undermath((omega^2 - omega_p^2)/c^2)
$

=== \

Le cas limite arrive lorsque $omega_p = omega$, ainsi :
$
  k^2 = (omega^2 - omega_p^2)/c^2 = 0\
  Donc omega^2_p = (n e^2)/(m_e epsilon_o)\
  Donc 2 pi f_p = e sqrt(n/(m_e epsilon_o))\
  \
  Donc undermath(f_p = e / (2 pi) sqrt(n/(m_e epsilon_0)))
$
#underline[AN :]
$
  f_p = (1,6.10^(-19))/(2 times 3,14) sqrt(10^(-11)/(9.10^(-31) times 8,8.10^(-12))) approx 2,8 "MHz"
$