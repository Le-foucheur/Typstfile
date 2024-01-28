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
    } else { l.push(0) }
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
#let vp = $v_p$
#let bi = math.beta.alt

Gaspar Daguet
#align(center, text(20pt)[Maths : DM 10])

=== \
#t(1) soit $n in NN^* $
#t(1) $ v_p (x^n - y^n) = v_p ((x-y)sum_(k=0)^(n-1)(x^(n-1-k) y^k)) = v_p (x-y) + v_p (sum_(k=0)^(n-1)(x^(n-1-k) y^k)) $
#t(1) Or par l'énoncé $p divides x-y$ donc $x equiv y [p]$\
#t(1) Ainsi $display(sum_(k=0)^(n-1))(x^(n-1-k) x^k) equiv display(sum_(k=0)^(n-1))(x^(n-1-k) y^k) equiv display(sum_(k=0)^(n-1))(x^(n-1)) equiv display(x^(n-1) sum_(k=0)^(n-1))1 equiv n x^(n-1) [p]$ \
#t(1) Donc comme p premier à $n$ et à $x$, il l'est aussi à $x^(n-1)$ alors $p divides.not n x^(n-1)$\
#t(1) Ainsi: $v_p (display(sum_(k=0)^(n-1)(x^(n-1-k) y^k))) = 0$
$ v_p (x^n - y^n) = v_p (x-y) + v_p (sum_(k=0)^(n-1)(x^(n-1-k) y^k)) = v_p (x-y) $
#t(1) #undermath[Donc $forall n in NN^*,n and p = 1 => v_p (x^n - y^n) = v_p (x-y)$]

=== a\
#t(1) On a $2$ premier à $x$ et à $y$, il sont donc tout les deux impair\
#t(1) Or la somme de deux impairs est pair donc $2 divides x+y$ \
#t(1) Supposons par l'absurde que $4 divides x+y$ \
#t(1) Donc comme $4 divides x-y$ alors $4 divides x+y+x-y = 2x$\
#t(1) Donc $2 divides x$, absurde !\
#t(1) Donc $4 = 2^2 divides.not x+y$ et $2 = 2^1 divides x+y$\
#t(1) Ainsi $v_p (x+y) = 1$\
#t(1) Donc:
$ v_2 (x^2 - y^2) = v_2 (x-y) + v_2 (x+y) = v_p (x-y)+1 $

==== \
#t(1) Soit la propriété $P(n): v_2 (x^n-y^n) = v_2 (x-y) + v_2 (n)$\
#t(1) On a, $v_2 (x-y) = v_2 (x-y) + v_p (1)$\
#t(1) Donc pour $n=1$ la propriété est vérifié\
#t(1) Soit $n in NN^* tq forall k in [|1;n|], P(k)$\
#pagebreak()
- Si $n+1$ est impair
#t(1) alors $n+1 and 2 = 1$ et donc $v_2 (n+1) = 0$ et par la question 1\
$ v_2 (x^(n+1)-y^(n+1)) = v_2 (x-y) = v_2 (x-y) + v_2 (n+1) $
- Si $n+1$ est pair alors, $exists k in NN^*, n+1 = 2k$\
#t(1) Soit un tel $k$ alors $v_2 (x^n - y^n) = v_2 ((x^k)^2-(y^k)^2)$\
#t(1) Donc par la question 2.a
$ v_2 ((x^k)^2-(y^k)^2) = v_2 (x^k-y^k)+1 $
#t(1) Or $k<n$, donc on peut appliquer l'hypothèse de récurrence, ainsi
$ v_2 (x^k-y^k)+1 = v_2 (x-y) + v_2 (k) +1 $
#t(1) Or $v_2 (2) = 1$, donc
$ v_2 (x-y) + v_2 (k) +1 = v_2 (x-y) + v_2 (k) + v_2 (2) = v_2 (x-y) + v_2 (2k)\ = v_2 (x-y) + v_2 (n+1) $
\
#t(1) Ainsi dans les deux cas on a bien: $v_2 (x^(n+1)-y^(n+1)) = v_2 (x-y) +v_2 (n+1)$\
#t(1) #undermath[Donc par le principe de récurrence forte $v_2 (x^n-y^(n)) = v_2 (x-y) +v_2 (n)$]

=== a.\
#t(1) Soit $k in [|1;p-1|]$ et $k$ impair
$ x^k = (y+(x-y))^k = sum_(i=0)^k binom(k,i) y^i (x-y)^(k-i) = y^k+k(x-y)y^(k-1) + sum_(i=0)^(k-2) binom(k,i) y^i (x-y)^(k-i) $\
#t(1)Or $0<=i<=k-2 <=> k-i>= 2$ et comme $p divides x-y$, donc $(x-y)^(k-i) equiv 0 [p^2]$\
#t(1) Donc $sum_(i=0)^(k-2) binom(k,i) y^i (x-y)^(k-i) equiv 0 [p^2]$\
#t(1) Ainsi
$ x^k equiv y^k+k(x-y)y^(k-1) + sum_(i=0)^(k-2) binom(k,i) y^i (x-y)^(k-i) equiv y^k+k(x-y)y^(k-1) [p^2] $
#t(1) #undermath[On a donc bien $x^k equiv y^k+k(x-y)y^(k-1) [p^2]$]

#pagebreak()
==== \
$ sum_(k=0)^(p-1) x^k y^(p-1-k) = y^(p-1)  + sum_(k=1)^(p-1) x^k y^(p-1-k) $\
#t(1) D'après la question précédente et comme $k in [|1; p-1|]$ $ y^(p-1) + sum_(k=1)^(p-1) x^k y^(p-1-k) equiv y^(p-1) + sum_(k=1)^(p-1) y^(p-1) + sum_(k=1)^(p-1)k(x-y)y^(p-2)\ equiv p y^(p-1) + (x-y)y^(p-2) p(p-1)/2  equiv p y^(p-1) [p^2] $\
#t(1) #undermath[Donc $display(sum_(k=0)^(p-1) x^k y^(p-1-k) equiv p y^(p-1) [p^2] ) equiv 0 [p]$]\
\
#t(1) Ainsi $display(v_p (sum_(k=0)^(p-1) x^k y^(p-1-k)) = 1)$ \
#t(1) Donc
#undermath[$ v_p (x^p-y^p) = v_p (x-y) + v_p (sum_(k=0)^(p-1) x^k y^(p-1-k)) = v_p (x-y) +1  $]

==== \
#t(1) Prouvons par récurrence forte que $forall n in NN^*, v_p (x^n-y^n) = v_p (x-y) + v_p (n)$\
#t(1) pour $n = 1$, $v_p (x^1-y^1) = v_p (x-y) + underbrace(v_p(1),=0)$\
\
#t(1) Soit $n in NN^* tq forall k in [|1; n|], v_p (x^k-y^k) = v_p (x-y) + v_p (KK)$
- Si $p divides.not n+1$ alors $p and n+1 = 1$
#t(1) Donc par la question 1:
$ vp(x^p - y^p) = vp(x-y) = vp(x-y) + underbrace(vp(n+1), =0) $

#pagebreak()
- Si $p divides n+1$ alors $exists k in NN, n+1 = k p$, ainsi
$ vp(x^(n+1)-y^(n+1)) = vp((x^k)^p-(y^k)^p) $
#t(1) Donc par la question précédente
$ vp((x^k)^p-(y^k)^p) = vp(x^k-y^k) +1 $
#t(1) Or $k<p$, donc par hypothèse de récurrence 
$ vp(x^k-y^k) +1 = vp(x-y) + vp(k) + underbrace(1, = vp(p)) = vp(x-y) + vp(p k) = vp(x-y) + vp(n+1) $

#t(1) Ainsi dans les deux cas on a $vp(x^(n+1)-y^(n+1)) = vp(x-y) + vp(n+1)$\
\
#t(1) #undermath[Donc par le principe de récurence forte $vp(x^n-y^n) = vp(x-y) +vp(n)$]

=== \
- Si n est impaire, alors $exists beta.alt in NN, n = 2beta.alt +1$ alors 
$ 2^n -1 = 2^(2beta.alt+1) -1 = 2(2^2)^beta.alt -1 $ 
#t(1) Or $2^2 equiv 1 [3]$ donc
$ 2(2^2)^beta.alt -1 equiv 2 -1 equiv 1 [3] $
#t(1) #undermath[Ainsi $3 divides.not 2^n-1$ donc $forall k in NN^*, 3^k divides.not 2^n-1$]

- Si n est pair, alors $exists beta.alt in NN, n = 2beta.alt$, donc on cherche $n tq v_3 (2^n -1) >= k$, alors
$ v_3 (2^n -1) = v_3 (4^bi - 1) $
#t(1) Or $3 divides 4-1$, donc par la question 3
$ v_3 (4^bi - 1^bi) = v_3 (3) + v_3 (bi) = 1 + V_3 (bi) >= k $ 
#t(1) donc $v_3 (bi) >= k-1$ \
#t(1) Ainsi $3^k divides 2^n-1 <=> 2 times 3^(k-1) divides n$\
\
#t(1) #undermath[Donc les $n$ telles que $3^k divides 2^n -1 $ sont les $n$ divisible par $2 times 3^(k-1)$]