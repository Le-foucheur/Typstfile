#import "@preview/fletcher:0.4.5": *
#let bo(x) = table(columns: 2cm, stroke: 0pt)[#table.cell(align: center+horizon)[#x]]
#let signe = "Signe"
#let variation = "Variation"

#let tabvar(
  //parameter
  aligne: center, //alignement of the table
  content: (), //the content
  init: ( 
   "variable": [],  //the variable of the table
   "label": [] //the labels on the right collum
  ), 
  T: (), //the ensemble where the varable is defined
  arrow : "->", //what kind of arrow
  debug: false, //just for development
  stroke: 1pt + black, //stroke of the entier table exept arrows
  stroke-arrow: 0.6pt+black //stroke of arrows

  ) = {

    //start of function
  context{
     //tableau de varation + signe + naïf
      diagram(
        spacing: ((4/3)*1cm, 1.3pt),
        cell-size: 0pt,
        debug: debug,
        node((0,0), stroke: stroke,enclose:  (//contour du tableau
          ..for i in range(T.len()+1){
              for j in range(init.at("label").len()*3+1){
                ((i,j),)
              }
            }
          ),
        ),
        edge((-0.74,1),(T.len()+0.1,1), stroke: stroke), // ligne de séparation x du reste
        edge((0.36,-4),(0.36,init.at("label").len()*3+0.9 + if init.at("label").last().last() == signe{3.5}), stroke: stroke), // ligne de séparation des label, des varations
        node((-0.19,0), (init.at("variable")), width: 2cm), for i in range(T.len()-1){
          node((i+2/3, 0), T.at(i), width: (2/3)*1cm)
        },
        node((T.len()-1/3,0), T.at(T.len()-1), width: (2/3)*1cm),

        ..for j in range(init.at("label").len()){(
          node((-0.19,2+j*3), bo(init.at("label").at(j).first()), height: calc.max(measure(bo(init.at("label").at(j).first())).height, 45pt)),)
        },
        ..for j in range(init.at("label").len()){( 
          if init.at("label").at(j).last() == signe{( //tableau de signe
            for i in range(1,content.at(j).len()){
              node((i+1.2, 2+(j)*3),content.at(j).at(i))
            },
            node((1.05, 2+(j)*3),content.at(j).at(1)),
            for i in range(1,T.len()-1){
              edge((i+0.67, 1+(j)*3), (i+0.67,3+(j)*3 + if j == init.at("label").len()-1{4.5}), stroke: stroke.thickness/2 + stroke.paint)
            },
            if j != init.at("label").len()-1{edge((-0.74,3+(j)*3), (T.len()+0.1, 3+(j)*3), stroke: stroke)} // ligne sous les tableaux de contente
          )},

          if init.at("label").at(j).last() == variation{( // tableau de variation
            for i in range(content.at(j).len()-1){
              let proch= 0
              if content.at(j).at(i).first() == top{node((i +2/3, 1+(j)*3+0.25), content.at(j).at(i).last())
                proch = 1+(j)*3+0.25
              }
              else if content.at(j).at(i).first() == center{node((i +2/3, 2+(j)*3), content.at(j).at(i).last())
                proch = 2+(j)*3
              }
              else if content.at(j).at(i).first() == bottom{node((i +2/3, 3+(j)*3-0.25), content.at(j).at(i).last())
                proch = 3+(j)*3-0.25
              }
              if content.at(j).at(i+1).first() == top{edge((i +2/3,proch),(i+5/3,3*(j)+1+0.25), arrow, stroke: stroke-arrow)}
              else if content.at(j).at(i+1).first() == center{edge((i +2/3,proch),(i+5/3,3*(j)+2), arrow, stroke: stroke-arrow)}
              else if content.at(j).at(i+1).first() == bottom{edge((i +2/3,proch),(i+5/3,3*(j)+3-0.25), arrow, stroke: stroke-arrow)}
            },
            if content.at(j).last().first() == top{node((T.len()-1/3, 1+(j)*3+0.25), content.at(j).last().last())}
            else if content.at(j).last().first() == center{node((T.len()-1/3, 2+(j)*3), content.at(j).last().last())}
            else if content.at(j).last().first() == bottom{node((T.len()-1/3, 3+(j)*3-0.25), content.at(j).last().last())},
            if j  != init.at("label").len()-1{edge((-0.74,3*(j)+4), (T.len()+0.1, 3*(j)+4), stroke: stroke)} // ligne sous les tableaux de variation
          )}
        )}
      )
    }
}

#tabvar(
  init: (
    "variable":$x$,
    "label":(([varation de $f$], variation), ([signe de $c$], signe), ([var de $c$], variation), ([signe de s], signe))
  ),
  T: ($0$, $2$, $3$, $4$, $5$, $6$),
  content: (
    ((top,$t 101$),(center,$c 111$),(bottom,$b 121$),(bottom,$b 231$),(center,$c 241$), (bottom, $b 251$)),
    ($-$, $-$, $+$,$-$,$-$),
    ((top,$t 1 02$),(center,$c 112$),(bottom,$b 122$),(top,$t 232$),(center,$c 242$), (bottom, $b 252$)), 
    ($+$, $-$, $+$, $-$, $+$),
    ),
  arrow: "->",
  debug: false,
)

#scale(x: 90%, y: 80%)[
  #tabvar(
  init: (
    "variable":$x$,
    "label":(([varation de $f$], variation), ([signe de $c$], signe), ([var de $c$], variation), ([signe de s], signe))
  ),
  T: ($0$, $2$, $3$, $4$, $5$, $6$),
  content: (
    ((top,$t 101$),(center,$c 111$),(bottom,$b 121$),(bottom,$b 231$),(center,$c 241$), (bottom, $b 251$)),
    ($-$, $-$, $+$,$-$,$-$),
    ((top,$t 1 02$),(center,$c 112$),(bottom,$b 122$),(top,$t 232$),(center,$c 242$), (bottom, $b 252$)), 
    ($+$, $-$, $+$, $-$, $+$),
    ),
  arrow: "<>--|>",
  stroke-arrow: blue,
  debug: false,
  stroke: red + 10pt
)]