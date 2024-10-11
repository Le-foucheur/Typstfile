#import "/template.typ": *
#import "/transposition.typ": *
#import "@preview/drafting:0.2.0": *
#import "@preview/vartable:0.1.0": *
#import "@preview/cetz:0.2.2": *
#import "@preview/curryst:0.3.0": rule, proof-tree

#show: template

Gaspar Daguet
#align(center, text(20pt)[Info : DM2])

#set-page-properties()

= En logique minimale : \
\

== Lemme : \
#grid(
  columns: 2,
  align: center+horizon,
  column-gutter: 50mm,
  row-gutter: 10mm,
  [*Lemme 1*] + 
  proof-tree(
    rule(
      name: $not_(e i)$,
      $Gamma tack not phi_1$,
      $Gamma, phi_1 tack phi_2$,
      $Gamma, phi_1 tack not phi_2$
    )
  ),

  "preuve : " + 
  proof-tree(
    rule(
      name:$not_"i"$,
        $Gamma tack not phi_1$,
      rule(
        name: $not_"e"$, 
        $Gamma, phi_1 tack tack.t$,
        rule(
          $Gamma, phi_1 tack phi_2$,
          "hypp"
        ),
        rule(
          $Gamma, phi_1 tack not phi_2$,
          "hypp"
        )
      )
    )
  ),

  [*Lemme 2*] + 
  proof-tree(
    rule(
      name: $->_"ax"$,
      $Gamma, phi -> psi, phi tack psi$,
    )
  ),
  
  "preuve : " + 
  proof-tree(
    rule(
      name:$->_e$,
      $Gamma, phi -> psi, phi tack psi$,
      rule(
        name: "ax",
        $Gamma, phi -> psi, phi tack phi -> psi$,
      ),
      rule(
        name: "ax",
        $Gamma, phi -> psi, phi tack phi$,
      )
    )
  ) 
)

== Logique minimale :
\
=== \

#grid(
  columns: 2,
  align: center+horizon,
  column-gutter: 10mm,
  proof-tree(
    rule(
      name: $or_e$,
      undermath[$p or (p and q) tack p $],
      rule(
        name: "ax", 
        $Gamma tack p or (p and q)$
      ),
      rule(
        name: "ax",
        $Gamma, p tack p$
      ),
      rule(
        name: $and_e^g$,
        $Gamma, p and q tack p$,
        rule(
          name:"ax", 
          $Gamma, p and q tack p and q$,
        )
      )
    )
  ), 
  [Avec $Gamma = {p or (p and q)}$]
)

===
#grid(
  columns: 2,
  align: center+horizon,
  column-gutter: 10mm,
  proof-tree(
    rule(
      name: $not_"ei"$,
      undermath[$p -> not p tack not p$],
      rule(
        name: "ax",
        $Gamma tack p$
      ),
      rule(
        name: $->_e$,
        $Gamma tack not p$,
        rule(
          name: "ax", 
          $Gamma tack p -> not p$
        ),
        rule(
          name: "ax",
          $Gamma tack p$
        )
      )
    )
  ), 
  [Avec $Gamma = {p -> not p, p}$]
)


===

#proof-tree(
  rule(
    name: $->_i$,
    undermath[$p -> (q or r), q -> s, r -> s tack p ->s$],
    rule(
      name: $or_e$,
      $Gamma, p tack s$,
      rule(
        name: $->_e$, 
        $Gamma, p tack q or r$,
        rule( 
          name:"ax", 
          $Gamma, p tack p -> q or r$
        ),
        rule(
          name: "ax",
          $Gamma, p tack p$
        )
      ),
      rule(
        name: $->_"ax"$, 
        $Gamma, p, q tack s$,
      ),
      rule(
        name: $->_"ax"$,
        $Gamma, p, r tack s$
      )
    )
  )
)

Avec $Gamma = {p -> (q or r), q -> s, r -> s}$

===

#proof-tree(
  rule(
    name: $and_i$,
    undermath[$Gamma tack q and s$],
    rule(
      name: $->_e$,
      $Gamma tack q$,
      rule(
        name: "ax",
        $Gamma tack p -> q$
      ), 
      rule(
        name: $and_e^g$,
        $Gamma tack p$,
        rule(
          name: "ax",
          $Gamma tack p and r$
        )
      )
    ),
    rule(
      name: $->_e$,
      $Gamma tack s$,
      rule(
        name: "ax",
        $Gamma tack r -> s$
      ), 
      rule(
        name: $and_e^d$,
        $Gamma tack r$,
        rule(
          name: "ax",
          $Gamma tack p and r$
        )
      )
    )
  )
)
Avec $Gamma = {p->q,r-> s, p and r}$

=== 
#proof-tree(
  rule(
    name: $or_e$,
    undermath[$Gamma tack q or s$],
    rule(
      name:"ax", 
      $Gamma tack p or r$
    ),
    rule(
      $Gamma, p tack q or s$,
      name: $or_i^g$,
      rule(
        $Gamma, p tack q$,
        name: $->_"ax"$
      )
    ),
    rule(
      $Gamma, r tack q or s$,
      name: $or_i$,
      rule(
        $Gamma, r tack s$,
        name: $->_"ax"$
      )
    )
  )
)
Avec $Gamma = {p -> q, r -> s, p or r}$

===
#proof-tree(
  rule(
    undermath[$(p or q) -> r tack (p->r) and (q -> r)$],
    name: $and_i + ->_i$,
    rule(
      $Gamma_1 tack r$,
      name:$->_e$,
      rule(
        $Gamma_1 tack (p or q) -> r$,
        name: "ax"
      ),
      rule(
        $Gamma_1 tack p or q$,
        name: $or_e^g$,
        rule(
          $Gamma_1 tack p$,
          name: "ax"
        )
      )
    ),
    rule(
      $Gamma_2 tack r$,
      name:$->_e$,
      rule(
        $Gamma_2 tack (p or q) -> r$,
        name: "ax"
      ),
      rule(
        $Gamma_2 tack p or q$,
        name: $or_e^d$,
        rule(
          $Gamma_2 tack q$,
          name: "ax"
        )
      )
    )
  )
)
Avec $Gamma_1 = {(p or q) -> r, p} et Gamma_2 = {(p or q) -> r, q}$

== Lois de De Morgan

===
#proof-tree(
  rule(
    undermath[$not (p or q) tack not p and not q$],
    name: $and_i$,
    rule(
      $not(p or q) tack not p$,
      name: $not_(e i)$,
      rule(
        $Gamma_1 tack not (p or q)$,
        name: "ax"
      ),
      rule(
        $Gamma_1 tack p or q$,
        name: $or_i^g$,
        rule(
          $Gamma_1 tack p$,
          name: "ax"
        )
      )
    ),
    rule(
      $not(p or q) tack not q$,
      name: $not_(e i)$,
      rule(
        $Gamma_2 tack not (p or q)$,
        name: "ax"
      ),
      rule(
        $Gamma_2 tack p or q$,
        name: $or_i^d$,
        rule(
          $Gamma_2 tack q$,
          name: "ax"
        )
      )
    )
  )
)
Avec $Gamma_1 = {not(p or q), p} et Gamma_2 = {not(p or q), q}$

===
#proof-tree(
  rule(
    undermath[$not p and not q tack (p or q)$],
    name: $not_i$,
    rule(
      $not p and not q, p or q tack tack.t$,
      name: $or_e$,
      rule(
        $Gamma, q tack tack.t$,
        name: $not_e$, 
        rule(
          $Gamma, q tack not q$,
          name: $and_e^d$,
          rule(
            $Gamma, q tack not p and not q$,
            name: "ax"
          )
        ),
        rule(
          $Gamma, q tack q$, 
          name: "ax"
        ),
      ),
      rule(
        $Gamma tack p or q$,
        name: "ax"
      ),
      rule(
        $Gamma, p tack tack.t$,
        name: $not_e$, 
        rule(
          $Gamma, p tack p$, 
          name: "ax"
        ),
        rule(
          $Gamma, p tack not p$,
          name: $and_e^g$,
          rule(
            $Gamma, p tack not p and not q$,
            name: "ax"
          )
        )
      )
    )
  )
)
Avec $Gamma = {not p and not q, p or q}$

===
#proof-tree(
  rule(
    undermath[$not p or not q tack not(p and q)$],
    name: $not_i$,
    rule(
      $not p or not q, p and q tack tack.t$,
      name: $or_e$,
      rule(
        $Gamma, not q tack tack.t$,
        name: $not_e$, 
        rule(
          $Gamma, not q tack q$,
          name: $and_e^d$,
          rule(
            $Gamma, not q tack  p and  q$,
            name: "ax"
          )
        ),
        rule(
          $Gamma, not q tack not q$, 
          name: "ax"
        ),
      ),
      rule(
        $Gamma tack not p or not q$,
        name: "ax"
      ),
      rule(
        $Gamma, not p tack tack.t$,
        name: $not_e$, 
        rule(
          $Gamma, not p tack not p$, 
          name: "ax"
        ),
        rule(
          $Gamma, not p tack p$,
          name: $and_e^g$,
          rule(
            $Gamma, not p tack p and q$,
            name: "ax"
          )
        )
      )
    )
  )
)
Avec $Gamma = {not p or not q, p and q}$