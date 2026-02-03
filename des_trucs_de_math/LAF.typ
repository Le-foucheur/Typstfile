Mq :
$
  H_k (n) = sum_(i_1 =1)^n sum_(i_2 = 1)^(i_1) dots.c sum_(i_k = 1)^(i_(k-1)) 1
  <==>
  H_k (n) &= sum_(i = 1)^n H_(k-1) (i) \& H_0 (n) = 1 "ça c’est bon !" "    " (0)
  \
  H_k (n) &= 1/k! product_(i=0)^(k-1)(n+i) <=> H_(k+1) (n) = (n+k)/(k+1) H_k (n) "    " (1)\
  H_k (n) &= sum_(i=0)^k alpha_i^k n^i "avec " cases(delim: "{",alpha_0^k = delta_0^k,forall i>0\,  display(alpha_i^k = sum_(j = i)^k binom(j,i) alpha_(j-1)^(k-1)/j)B_(j-i)) "   " (2) "Fait"\
  H_k (1) &= 1 " & " underbrace(H_k (0) = delta_k^0, "facile")
$
avec $(B_i)$ les nombres de Bernoulli, avec la convention $B_1 = 1/2$

== Preuve de $(0) => (2)$ :\
 - Pour $k= 0 :$ \
Soit $n in NN$, $H_0 (n) = 1$ et $sum_(i = 0) ^(0) alpha_i^0 n^i = underbrace(alpha_0^0, = 1) n^0 = 1 $\
\
 - Pour $k in NN^*$ :
 montrons par récurance que $forall k in NN^*, forall n in NN, H_k (n) = display(sum_(i=0)^k alpha_i^k n^i)$

-- Initialisation : Soit $n in NN$\
$H_1 (n) = n$ et $display(sum_(i = 0)^1 alpha_i^1 n^i = underbrace(alpha_0^1, = 0) + alpha_1^1 n)$\
Or 
$
  alpha_1^1 = sum_(i = 1)^1 underbrace(binom(1,1) alpha_0^0 / 1 B_0, = 1) = 1
$
Donc $H_1 (n) = display(sum_(i= 0)^1 alpha_i^1 n^i)$

-- Hérédité :\
Soit $k in NN^*$ tq $H_k (n) = display(sum_(i= 0)^k alpha_i^k n^i)$\
$
  H_(k + 1) (n) = sum_(i= 1)^n H_k (i) &=sum_(i = 1)^n sum_(j = 0)^k alpha_j^k i^j = sum_(j = 0)^k alpha_j^k sum_(i=1)^n i^j\
  &= sum_(j = 0)^k alpha_j^k /(j+1) sum_(i = 0)^j binom(j+1,i) B_i n^(j - i +1) \
  &= sum_(j = 0)^k  sum_(i = 0)^j binom(j+1,i) alpha_j^k /(j+1) B_i n^(j - i +1) \
  &= sum_(j = 0)^k  sum_(i = 0)^j binom(j+1,j - i) alpha_j^k /(j+1) B_(j-i) n^(i +1) "avec" i’ = j - i\
  &= sum_(i = 0)^k  sum_(j = i)^k binom(j+1,j - i) alpha_j^k /(j+1) B_(j-i) n^(i +1)\
  &= sum_(i = 0)^k  sum_(j = i)^k binom(j+1, i + 1) alpha_j^k /(j+1) B_(j-i) n^(i +1)\
  &= sum_(i = 1)^(k+1)  sum_(j = i - 1)^k binom(j+1, i) alpha_j^k /(j+1) B_(j + 1-i) n^(i )\
  &= sum_(i = 1)^(k+1) underbrace( sum_(j = i)^(k+1) binom(j, i) alpha_(j - 1)^k /(j) B_(j-i), = alpha_i^(k+1)) n^i = sum_(i = 0)^(k+1) alpha_i^(k+1) n^i\ 
$

Par le principe de récurance simple et la petite disjonction de cas : $forall k,n in NN, display(H_k (n) = sum_(i = 0)^k alpha_i^k n^i)$

== Preuve de $(2) => (0)$ :

Il suffie de « remonter » la preuve précédente, sans faire de récurance et de calculer $H_0$

== Propriété sur $(alpha_i^k)$ :
- $forall k in NN^*, alpha_1 ^k = 1/k$ (1)
- $forall i in NN, alpha_i^i = 1/i!$ (2)

=== preuve :

$
"Comme pour" forall p in NN^*,forall k in NN, forall n in [|k p, (k+1)p|], F^((p))_n = P^(p)_k (n) \
 "avec" P_k^((p)) = sum_(i = 0)^(k-1) P_(k-1)^((p)) ((i+1)p) S_(k-1-i) (X-k p) + S_k (X-k p) \
 "Donc" \
 forall p in NN^*, forall n in NN, F_n^((p)) = P^((p))_floor(n/p) (n) \
 "alors"\
  forall n in NN, lim_(p --> 0^+) P_floor(n/p)^((p))(n) = lim_(p--> 0^+) F^((p))_n = F^((0))_n = 2^n "  ?"
$
