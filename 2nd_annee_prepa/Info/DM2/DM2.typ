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
- *Lemme Minimaliste*
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
        $Gamma, phi_1 tack bot$,
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
      name: $ab(->, "ax")$,
      $Gamma, phi -> psi, phi tack psi$,
    )
  ),
  
  "preuve : " + 
  proof-tree(
    rule(
      name:$ab(->, e)$,
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

- *Lemme Classique*

#grid(
  columns: 2,
  align: center+horizon,
  column-gutter: 50mm,
  row-gutter: 10mm,
  [*Lemme 1*] + 
  proof-tree(
    rule(
      $Gamma tack phi$,
      name: $not not_e$,
      $Gamma tack not not phi$
    )
  ),
  [preuve :]+
  proof-tree(
    rule(
      $Gamma tack phi$,
      name: "raa",
      rule(
        $Gamma, not phi tack bot$,
        name: $not_e$,
        rule(
          $Gamma, not phi tack not phi$,
          name:"ax"
        ),
        rule(
          $Gamma, not phi tack not not  phi$,
          name: "aff",
          rule(
            $Gamma tack not not phi$,
            "hypp"
          )
        )
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
        name: $ab(->, e)$,
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
    name: $ab(->, i)$,
    undermath[$p -> (q or r), q -> s, r -> s tack p ->s$],
    rule(
      name: $or_e$,
      $Gamma, p tack s$,
      rule(
        name: $ab(->, e)$, 
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
        name: $ab(->, "ax")$, 
        $Gamma, p, q tack s$,
      ),
      rule(
        name: $ab(->, "ax")$,
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
      name: $ab(->, e)$,
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
      name: $ab(->, e)$,
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
        name: $ab(->, "ax")$
      )
    ),
    rule(
      $Gamma, r tack q or s$,
      name: $or_i$,
      rule(
        $Gamma, r tack s$,
        name: $ab(->, "ax")$
      )
    )
  )
)
Avec $Gamma = {p -> q, r -> s, p or r}$

===
#proof-tree(
  rule(
    undermath[$(p or q) -> r tack (p->r) and (q -> r)$],
    name: $and_i + ab(->, i)$,
    rule(
      $Gamma_1 tack r$,
      name:$ab(->, e)$,
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
      name:$ab(->, e)$,
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
      $not p and not q, p or q tack bot$,
      name: $or_e$,
      rule(
        $Gamma, q tack bot$,
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
        $Gamma, p tack bot$,
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
      $not p or not q, p and q tack bot$,
      name: $or_e$,
      rule(
        $Gamma, not q tack bot$,
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
        $Gamma, not p tack bot$,
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

===
#proof-tree(
  rule(
    undermath[$not (p and q) tack not p or not q$],
    name: "raa",
    rule(
      $Gamma tack bot$,
      name: $not_e$,
      rule(
        $Gamma tack not(p and q)$,
        name: "ax"
      ),
      rule(
        $Gamma tack p and q$,
        name: $and_i$,
        rule(
          $Gamma tack p$,
          name: $not not_e$,
          rule(
            $Gamma tack not not p$,
            name: $and_e^g$,
            rule(
              $Gamma tack not not p and not not q$,
              name: "q.7"
            )
          )
        ),
        rule(
          $Gamma tack q$,
          name: $not not_e$,
          rule(
            $Gamma tack not not q$,
            name: $and_e^d$,
            rule(
              $Gamma tack not not p and not not q$,
              name: "q.7"
            )
          )
        )
      )
    )
  )
)
Avec $Gamma = {not (p and q), not (not p or not q)}$

== Logique intuitionniste
\
===
#proof-tree(
  rule(
    undermath[$not p tack p -> q$],
    name: $ab(->, i)$,
    rule(
      $not p, p tack q$,
      name:$ab(bot, e)$,
      rule(
        $not p, p tack bot$,
        name: $not_e$,
        rule(
          $not p ,p tack p$,
          name: "ax"
        ),
        rule(
          $not p, p tack not p$,
          name: "ax"
        )
      )
    )
  )
)

===
#proof-tree(
  rule(
    undermath[$p or q, not q tack p$],
    name: $or_e$,
    rule(
      $Gamma tack p or q$,
      name: "ax"
    ),
    rule(
      $Gamma , p tack p$,
      name: "ax"
    ),
    rule(
      $Gamma, q tack p$, 
      name: $ab(bot, e)$,
      rule(
        $Gamma, q tack bot$, 
        name: $not_e$, 
        rule(
          $Gamma, q tack q$, 
          name: "ax"
        ), 
        rule(
          $Gamma, q tack not q$, 
          name: "ax"
        )
      )
    )
  )
)
Avec $Gamma = {p or q, not q}$

===
#proof-tree(
  rule(
    $not (p -> q) tack q -> p$, 
    name: $ab(->, i)$,
    rule(
      $Gamma tack p$,
      name: $ab(bot, e)$,
      rule(
        $Gamma tack bot$,
        name: $not_e$,
        rule(
          $Gamma tack not (p -> q)$
        ),
        rule(
          $Gamma tack p -> q$,
          name: $ab(->, i)$,
          rule(
            $Gamma , p tack q$, 
            name: "ax"
          )
        )
      )
    )
  )
)
Avec $Gamma = {not (p -> q), q}$

== logique classique

===
#proof-tree(
  rule(
    undermath[$p -> (q or r) tack (p -> q) or ( p -> r)$],
    name: $or_e$,
    rule(
      $Gamma tack q or not q$,
      name: "t.e."
    ),
    rule(
      $Gamma, q tack (p -> q) or (p -> r)$,
      name: $or_i^g + ab(->, i)$,
      rule(
        $Gamma, q,p tack q$,
        name: "ax"
      )
    ),
    rule(
      $Gamma, not q tack (p -> q) or (p -> r)$, 
      name: $or_i^d + ab(->, i)$,
      rule(
        $Gamma, not q, p tack r$,
        name: "ax",
        "Voir ci-dessous"
      )
    )
  )
)


Le ci-dessous en question :
#proof-tree(
rule(
  $Gamma, not q, p tack r$,
  name: $or_e$,
  rule(
      $Gamma_2 tack q or r$,
      name: $ab(->, e)$, 
      rule(
        $Gamma_2 tack p -> (q or r)$, 
        name: "ax"
      ),
      rule(
        $Gamma_2 tack p$, 
        name: "ax"
      )
    ), 
    rule(
      $Gamma, r tack r$, 
      name: "ax"
  ),
    rule(
      $Gamma_2, q tack r$, 
      name:$not_e$,
      rule(
        $Gamma_2, q tack q$,
        name: "ax"
      ),
      rule(
        $Gamma_2, q tack not q$,
        name: "ax"
      )
    )
  )
)
Avec $Gamma = {p -> (q or r)} et Gamma_2 = Gamma union {not q, p}$

===
#proof-tree(
  rule(
    undermath[$q -> r, not q -> not p tack p -> r$],
    name: $ab(->, i)$,
    rule(
      $Gamma tack r$,
      name: $ab(->, e)$, 
      rule(
        $Gamma tack q -> r$, 
        name: "ax"
      ),
      rule(
        $Gamma tack q $,
        name:"raa", 
        rule(
          $Gamma, not q tack bot$,
          name: $not_e$,
          rule(
            $Gamma, not q tack p$, 
            name: "ax"
          ),
          rule(
            $Gamma, not q tack not p$,
            name: $ab(->, e)$,
            rule(
              $Gamma, not q tack not q -> not p$,
              name: "ax"
            ),
            rule(
              $Gamma, not q tack not q$,
              name: "ax"
            )
          )
        )
      )
    )
  )
)