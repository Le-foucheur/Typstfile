#let question = counter("questions")

#set heading(
  numbering: (..numbers) => {
    let n = numbers.pos().len();
    if n == 1 { question.update(0); } else if n == 2 { [Partie ]; numbering("I", numbers.pos().at(1)) ;"." } else if n == 3 { [N=°];question.step(); question.display();"." } else if n == 4 { numbering("a.", numbers.pos().at(3) + 1) } else if n == 5 { numbering("i.", numbers.pos().at(4)) }
  },
)
#show heading : it => {
  if it.body == [] or it.level >= 3 [#parbreak() #linebreak() #counter(heading).display() #it.body] else [#parbreak() #linebreak() #counter(heading).display() #it.body]
}

#let nonumeq = math.equation.with(block: true, numbering: none)
#let dm(x) = box[#nonumeq[#x]]
#let dfrac(x, y) = math.frac(dm(x), dm(y))
#let lbar(..args) = math.display(math.cases(delim: "|", ..args))
#let ubar(body, col: red) = rect(
  inset: 0pt,
  outset: (bottom: 3pt, rest: 0pt),
  stroke: (bottom: (0.5pt + col), rest: 0pt),
)[#body]

#let frame(x) = rect(stroke: 1pt + red, outset: (x: -2pt, y: 2pt))[#x]
#let dframe(x) = frame(dm(x))
#let donc = "Donc" + h(5pt)
#let onA = "On a" + h(5pt)
#let tq = "tel que" + h(5pt)
#let et = "et" + h(5pt)
#let dt = math.dif + "t"
#let Id(n) = math.mat(..for x in range(n){
  let l = ()
  for y in range(n){
    if y == x {
      l.push(1)
    }
    else {l.push(0)}
  }
  (l,)
})
#let tend(n, val) = $limits(-->)_(#n -> #val)$
#set underline(stroke: red + 1pt)
#let undermath(body, col: red)= {
  style(styles => {
    let size = measure(dm(body), styles);
    let size2 = measure(body, styles);
    let offshet = ((size.height) - (size2.height)) / 1.1 + 1.3pt;
    box(stroke: (bottom: col + 1pt), outset: (bottom: offshet), body);
  })
}
#let th = "th"
#let t(x) = for i in range(x) {
  h(1em)
}
#set par(leading: 10pt)
#let cv = "converge" + h(5pt)

Gaspar Daguet
#align(center, text(20pt)[Maths : DM 10])

== Le théorème de Cesàro
=== a.\
#t(1) Par la définition de limite:\
#t(1) #undermath[$ exists n_0 in NN^*, forall n >= n_0, abs(u_n) <= epsilon/2 $]

==== \
#t(1) Soient $n_0,n in NN^* tq n >= n_0$ alors\
#t(1) $ abs(sigma_n) = abs((sum_(k=1)^n u_k)/n) = abs((sum_(k=1)^(n_0 -1) u_k)/n +(sum_(k=n_0)^n u_k)/n) <=abs((sum_(k=1)^(n_0 -1) u_k)/n) + abs((sum_(k=n_0)^n u_k)/n) <= (sum_(k=1)^(n_0 -1) abs(u_k))/n + (sum_(k=n_0)^(n) abs(u_k))/n $\
#t(1) Ainsi on a bien:\
#t(1) #undermath[$ forall n >= n_0, abs(sigma_n) <= (abs(u_1) + abs(u_2) + dots + abs(u_(n_0 -1)))/n + (abs(u_(n_0)) + dots +abs(u_n) )/n $]

==== \
#t(1) Comme $1/n sum^(n_0 -1)_(k=1) u_k$ est une somme finis alors:
$ 1/n sum^(n_0 -1)_(k=1) abs(u_k) op(-->, limits: #true)_(n->+oo) 0 $
#t(1) Donc par la définition de limite: $ exists n_1 in NN^* , forall n >= n_1, 1/n sum^(n_0 -1)_(k=1) abs(u_k) <=epsilon/2 $ \
#t(1) De plus:\
$ 1/n sum^(n)_(k=n_0) abs(u_k) <= 1/n sum^(n)_(k =n_0) epsilon/2 = (n-n_0+1)/2 epsilon <=epsilon/2 $ \
#pagebreak()
#t(1) Poson $N = max(n_1, n_0)$ alors : $ forall n >=N, abs(sigma_n) <= 1/n sum^(n_0 -1)_(k=1) abs(u_k) + 1/n sum^(n)_(k=n_0) abs(u_k) <=epsilon/2 + epsilon/2 <= epsilon $\
#t(1) Donc #undermath[$ sigma_n op(-->, limits: #true)_(n -> +oo) 0 $]

=== \
#t(1) Soit $(u_n) in RR^NN tq u_n tend(n, +oo) l$ et $sigma_n$ la suite des
moyennes de Césàro associée à $(u_n)$ alors :\
#t(1) la suite $(u_n - l)$ tend vers $0$\
#t(1) Donc selon le résulta précédent: $sigma_n - l tend(n, +oo) 0$ \
#t(1) Donc :
#undermath[$ sigma_n tend(n, +oo) l $]

=== \
#t(1) Soit $(u_n)_(n>=1)$ la suite définie par $forall n in NN,u_n = (-1)^n$ \
#t(1) Cette suite n'admet pas de limite\
#t(1) Or la suite des moyennes de Césàro associé à $(u_n)$:
$ sigma_n = 1/n sum^n_(k=1)(-1)^k = ((-1)^n -1)/(2n) tend(n, +oo) 0 $
#t(1) Donc $sigma_n$ converge vers 0\
#t(1) #undermath[Ce qui contredit la réciproque]

=== \
#t(1) Soit $A in RR$ alors:\
#t(1) $exists n_0 in NN, forall n >= n_0, u_n >= 2A$ alors\
#t(1) Soit un tel $n_0$ et\
#t(1) Soit $(sigma_n)$ la suite des moyennes de Césàro de $(u_n)$, alors pour $n >= n_0$ :
$ sigma_n = 1/n sum^n_(k=1)u_k = 1/n sum^(n_0 -1)_(k=1)(u_k) +1/n sum^(n)_(k=n_0)(u_k) >= 1/n sum^(n_0 -1)_(k=1)(u_k) + 2A (n-n_0+1)/n $\
#t(1) Comme $1/n sum^(n_0 -1)_(k=1)(u_k)$ tend vers 0 (cf: première question)
alors à partir qu'un certain rang $n_1$:
$ 1/n sum^(n_0 -1)_(k=1)(u_k) >= -A/5 $ \
#t(1) Et $2(n-n_0 +1)/n$ tend vers $2$ donc à partir d'un certain rang $n_2$: $2(n-n_0 +1 )/n >= 9/5$\
#t(1) Poson $N = max(n_0, n_1, n_2)$\
#pagebreak()
#t(1) Alors pour tout $n >= N$:
$ sigma_n >= -A/5+9/5 A >= 8/5 A >= A $
#t(1) #undermath[Donc $sigma_n$ diverge vers $+oo$]

=== \
#t(1) Supposons que $(sigma_n)$ converge vers $l$ et \
#t(1) Supposons par l'absurde que $(u_n)$ est divergante \
#t(1) Donc puisque $u_n$ est croissante alors $u_n --> +oo$ \
#t(1) Ainsi par la question 4, $sigma_n --> +oo$ ce qui est absurde puisque $sigma_n cv$ \
#t(1) #undermath[Ainsi $u_n cv$]
== Quelques appliquations
=== *Le lemme de l'escalier* \
#t(1) Soit $n in NN$\
#t(1) Poson $forall n>=2, v_n = a_n - a_(n-1)$ \
#t(1) Selons le lemme de Césàro on a: 
$ 1/n sum^n_(k=2) v_n tend(n, +oo) a $ \
#t(1) Or $1/n sum^n_(k=2) v_k = 1/n sum^n_(k=2) a_(k)-a_(k-1) = (a_(n) - a_1)/n $ Or $-a_1/n tend(n, +oo) 0$ \
#t(1) Donc il existe un rang $n_0$ tel que:$ forall n>=n_0, abs((a_n)/n-(a_1)/n - a) <= abs(a_n /n -a) + abs(a_1 /n) <= abs(a_n/n - a) +abs(a_1) <= 2abs(a_1) + abs(a) $
#t(1) ce qui est équivalant à: $forall n>= n_0, abs(a_n/n - a) < abs(a_1) + abs(a)$ \
#t(1) Poson alors $epsilon = abs(a_1) + abs(a) >0$\
#t(1) Donc $forall n>=n_0, abs(a_n/n -a) < epsilon$\
#t(1) #undermath[Autrement dit $a_n/n tend(n, +oo) a$]

=== a.\
#t(1) Prouvons tout d'abord que $u_n cv$ \
#t(1) Comme $1+u_n^2 >0 et u_1 >0$ alors $forall n in NN^*, u_n > 0$\
#t(1) Donc la suite est strictement positve et minorée par 0 \
#pagebreak()
#t(1) Et on a $ u_(n+1) - u_n = u_n/(1+u_n^2) - u_n = -u_n^3/(1+u_n^2) $
#t(1) Or comme $u_n > 0 et 1 + u_n^2 > 0$ alors $-u_n^3 / (1+u_n^2) < 0$\
#t(1) Donc la suite est décroisante \
#t(1) Ainsi comme la suite est minorée et décroisante alors par le théorème de la limite monotone, \
#t(1) $(u_n)$ converges vers $l$\
\
#t(1) Par passage à la limite et par unicité de la limite dans la définition \
#t(1) $l = l/(1+l^2) $\
#t(1) donc $1+l^2 = 1$\
#t(1) donc $l^2 = 0$ \
#t(1) donc $l = 0$ \
#t(1) #undermath[Ainsi $display(op(lim, limits: #true)_(n->+oo) u_n = 0)$]

==== \
#t(1) $v_n$ est bien définis car $u_n > 0$ \
$ v_n+1 - v_n = 1/u_(n+1)^2 - 1/u_n^2 = (1+u_n^2)^2/u_n^2 - 1/u_n^2 = (1 + 2u_n^2 + u_n^4 - 1)/u_n^2 = 2 + underbracket(u_n^2, --> 0) tend(n,+oo) 2 $

#t(1) #undermath[Ainsi $display(lim_(n->+oo) (v_(n+1) - v_n) = 2) $]

==== \
#t(1) Par le lemme de l'escalier, on a: $v_n / n = 1/(n u_n^2) tend(n, +oo) 2$ \
#t(1) Donc $1/(2n u_n^2) tend(n,+oo) 1$ \
#t(1) Donc $2n u_n^2 tend(n,+oo) 1$ \
#t(1) #undermath[Donc $u_n sqrt(2n) tend(n,+oo) 2$] \

= Exercice 2 : calcul des puissances d'une matrice $3 times 3$

=== a. \
#t(1) Soit $X in cal(M)_(3,1)(RR)$ et soient $a,b,c in RR tq X = mat(a;b;c)$ \
#t(1) Ainsi le systeme se réécrit: $ cases(3a + b -c = a\ -a+b+c = b \ a = c) <=> cases(c= -b \ b= b \ a = -b) $ 

#t(1) Ainsi l'ensemble des solution du système est: ${mat(-b;b;-b), b in RR}$ \
#t(1) #undermath[Donc la matrice $C_1$ vaut: $mat(1;-1;1)$ ]

==== \
#t(1) Soit $X in cal(M)_(3,1)$ et soient $a,b,c in RR tq X = mat(a;b;c)$ \
#t(1) Ainsi le systeme se réécrit: $ cases(3a + b -c = 2a\ -a+b+c = 2b \ a = 2c) <=> cases(c= -2b \ b= b \ a = -b) $ 
#t(1) Ainsi l'ensemble des solution du système est: ${mat(-2b;b;-b), b in RR}$ \
#t(1) #undermath[Donc la matrice $C_3$ vaut: $mat(2;-1;1)$ ]

==== \
#let l = math.lambda
#t(1) Soit $X in cal(M)_(3,1)$ et soient $a,b,c in RR tq X = mat(a;b;c)$ \
#t(1) Ainsi le systeme se réécrit: $ cases(3a + b -c = lambda a\ -a+b+c = #l b \ a = #l c) <=> cases(3 #l c + b - c = #l^2 c \ -#l c + b +c = #l b \ a = #l c) <=> cases( c (-#l^2 + 3#l -2) =0 \ b = -c \ a = #l c) $ 
#t(1) la première ligne force $c=0$ car les racines du polynome $-x^2 + 3x -2$ sont $2 et 1$\
#t(1) or #l est différent de 2 et de 1\
#t(1) Donc la seul solution du système est $X = 0$\
#t(1) #undermath[Donc il n'y a pas de solution au système non nul]

==== \
#t(1) Soit $C_2 in cal(M)_(3,1)(RR)$ et soient $a,b,c in RR tq X = mat(a;b;c)$ \
#t(1) Ainsi le systeme se réécrit: $ cases(3a + b -c = 1+a\ -a+b+c = -1+b \ a = 1+c) <=> cases(c= -1-b \ b= b \ a = -b) $ 

#t(1) Ainsi l'ensemble des solution du système est: ${mat(-b;b;-1-b), b in RR}$ \
#t(1) #undermath[Donc la matrice $C_2$ vaut: $mat(0;0;-1)$ ]

=== \
#let A = $mat(3,1,-1;-1,1,1;1,0,0)$
#let P = $mat(1,0,2;-1,0,-1;1,-1,1)$
#let T = $mat(1,1,0;0,1,0;0,0,2)$
#t(1) On a donc $P = #P$

*a.* \
#t(1) $T = mat(1,1,0;0,1,0;0,0,2)$ est une telle matrice \
#t(1) En effet:
$ A P = #A #P  = mat(1,1,4;-1,-1,-2;1,0,2) = #P #T = P T $ 

==== \
#let P-1 = $mat(-1,-2,0;0,-1,-1;1,1,0)$
#t(1) $ mat(1,0,2,1,0,0;-1,0,-1,0,1,0;1,-1,1,0,0,1;augment: #3) <==>_(cases(L_2 <- L_2 + L_1 \ L_3 <- L_1 - L_3 ,delim: "|")) mat(1,0,2,1,0,0;0,0,1,1,1,0;0,1,1,1,0,-1;augment: #3) <==>_(cases(delim: "|", L_2 <-> L_3)) mat(1,0,2,1,0,0;0,1,1,1,0,-1;0,0,1,1,1,0;augment: #3) $ \
#t(1)  #undermath[Donc $P$ est inversible car tous les coefficients diagonaux sont non nul], alors: \
$  mat(1,0,2,1,0,0;0,1,1,1,0,-1;0,0,1,1,1,0;augment: #3) <==>_(cases(delim: "|", L_1 <- L_1 - 2 L_3 \ L_2 <- L_2 - L_3)) mat(1,0,0,-1,-2,0;0,1,0,0,-1,-1;0,0,1,1,1,0;augment: #3) $
#t(1) Ainsi $P^(-1) = #P-1$ \
#t(1) Deplus, on a $A = P T P^(-1)$

==== \
#let Tn = $mat(1,n,0;0,1,0;0,0,2^n)$
#t(1) On cherche à monter par récurance simple que $T^n = #Tn$

- *Initialisation:*
#t(1) Pour n = 0:
$ T^0 = "Id"_3 = #Id(3) = mat(1,0,0;0,1,0;0,0,2^0) $
#t(1) #undermath[Donc l'initialisation est vérifiée] 
- *Hérédité:*
#t(1) Soit $n in NN$ tel que $forall n in NN, T^n = #Tn$, alors:
$ T^(n+1) = T^n T = #Tn #T = mat(1,n+1,0;0,1,0;0,0,2^(n+1)) $
#t(1) #undermath[Donc l'hérédité est vérifiée] \
\
#t(1) #undermath[Ainsi par la principe de récurance simple $forall n in NN; T^n = #Tn$]
#pagebreak()
=== \
#let An = $mat(2^(n+1)-1, 2^(n+1)-2-n, -n; 1-2^n, 2-2^n +n, n; 2^n -1, 2^n -n -1, 1-n)$
#t(1) On va prouver par récurance simple la proposition suivante  $P(n): A^n = P T^n P^(-1)$\
- *Initialisation:*
#t(1) $A^0 = "Id"_3$ et $P T^0 P^(-1) = P P^(-1) = "Id"_3$ \
#t(1) #undermath[Donc l'initialisation est vérifiée] 
- *Hérédité:* \
#t(1) Soit $n in NN tq P(n)$ est vraie \
#t(1) On rappelle que $A = P T P^(-1)$
#t(1) $A^(n+1) = A^n A = P T^n P^(-1) P T P^(-1) = P T^n T P^(-1) = P T^(n+1) P ^(-1)$ \
#t(1) #undermath[Donc l'hérédité est vérifiée] \
#t(1) Ainsi par principe de récurance $P(n)$ est vraie \ 
#t(1) Donc on a: $ forall n in NN, A^n = P T^n P^(-1) = #P #Tn #P-1 = #An $\
\
#t(1) #undermath[Ainsi $forall n in NN, A^n = #An$]