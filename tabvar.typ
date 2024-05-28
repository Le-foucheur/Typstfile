#import "@preview/fletcher:0.4.5": *
#let bo(x) = table(columns: 2cm, stroke: 0pt)[#table.cell(align: center+horizon)[#x]]

#let tabvar(aligne: center, var : (), sign: (), init: ("x": [], "label": []), T: (), arrow : "->", couple: true, debug: false) = {
  context{
    if sign == none and var != none and couple{
      diagram(
        spacing: ((4/3)*1cm, 1.3pt),
        cell-size: 0pt,
        debug: debug,
        node((0,0), stroke: 1pt,enclose:  (//contour du tableau
          ..for i in range(T.len()+1){
              for j in range(init.at("label").len()*3+1){
                ((i,j),)
                }
            }
          ),
        ),
        node((-0.075,0), (init.at("x")), width: 2cm), for i in range(T.len()-1){
          node((i+2/3, 0), T.at(i), width: (2/3)*1cm)
        },
        edge((-0.65,0.6),(T.len()+0.1,0.6), stroke: 1pt), // ligne de séparation x du reste
        edge((0.36,-4),(0.36,init.at("label").len()*3+4), stroke: 1pt), // ligne de label ligne des varations
        node((T.len()-1/3,0), T.at(T.len()-1), width: (2/3)*1cm),
        ..for j in range(init.at("label").len()){ 
          (node((0,2+j*3), bo(init.at("label").at(j)), height: calc.max(measure(bo(init.at("label").at(j))).height, 45pt)),
          for i in range(var.at(j).len()-1){
            let proch= 0
            if var.at(j).at(i).first() == top{node((i+2/3, 1+j*3), var.at(j).at(i).last())
              proch = 1+j*3
            }
            else if var.at(j).at(i).first() == center{node((i+2/3, 2+j*3), var.at(j).at(i).last())
              proch = 2+j*3
            }
            else if var.at(j).at(i).first() == bottom{node((i+2/3, 3+j*3), var.at(j).at(i).last())
              proch = 3+j*3
            }
            if var.at(j).at(i+1).first() == top{edge((i+2/3,proch),(i+5/3,3*j+1), arrow)}
            else if var.at(j).at(i+1).first() == center{edge((i+2/3,proch),(i+5/3,3*j+2), arrow)}
            else if var.at(j).at(i+1).first() == bottom{edge((i+2/3,proch),(i+5/3,3*j+3), arrow)}
          },
          if var.at(j).last().first() == top{node((T.len()-1/3, 1+j*3), var.at(j).last().last())}
          else if var.at(j).last().first() == center{node((T.len()-1/3, 2+j*3), var.at(j).last().last())}
          else if var.at(j).last().first() == bottom{node((T.len()-1/3, 3+j*3), var.at(j).last().last())},
          if j != init.at("label").len() -1{edge((-0.539,3*j+3.5), (T.len()+0.19, 3*j+3.5), stroke: 1pt)},
          )
        }
      )
    }
    if var == none and sign != none and couple{
      diagram(
        debug: debug,
        spacing: ((4/3)*1cm, 1.3pt),
        cell-size: 0pt,
        edge((-0.65,0.5),(T.len()-0.03,0.5), stroke: 1pt), // ligne de séparation x du reste
        edge((0.5,-4),(0.5,init.at("label").len()*3-1.5), stroke: 1pt), // ligne de label ligne des varations
        node((0,0), stroke: 1pt,enclose:  (//contour du tableau
          ..for i in range(T.len()+1){
              for j in range(init.at("label").len()+1){
                ((i,j),)
                }
            }
          ),
        ),
        node((-0.075,0), (init.at("x")), width: 2cm), for i in range(T.len()-1){
          node((i+2/3, 0), T.at(i), width: (2/3)*1cm)
        },
        ..for j in range(init.at("label").len()){(
          node((0, j+1), bo(init.at("label").at(j)), height: calc.max(measure(bo(init.at("label").at(j))).height, 45pt)),
          for i in range(1,sign.at(j).len()){
            node((i+1.2, j+1),sign.at(j).at(i))
          },
          node((1.05, j+1),sign.at(j).first()),
          if j != init.at("label").len()-1{edge((-0.59,j+1.5), (T.len()-0.03, j+1.5), stroke: 1pt)},
        )},
        for i in range(1,T.len()-1){
          edge((i+0.67, 0.5), (i+0.67,init.at("label").len()+4.5), stroke: 1pt)
        },
        node((T.len()-1/3,0), T.at(T.len()-1), width: (2/3)*1cm),
      )
    }
  }
}

#tabvar(
  init: ("x":$x$,"label":([varation de $f$], [var de $c$], [var de $c$])),
  sign: none,
  var: (((top,$t 101$),(center,$c 111$),(bottom,$b 121$),(bottom,$b 231$),(center,$c 241$), (bottom, $b 251$)),((top,$t 1 02$),(center,$c 112$),(bottom,$b 122$),(top,$t 232$),(center,$c 242$), (bottom, $b 252$)), ((top,$t 1 02$),(center,$c 112$),(bottom,$b 122$),(top,$t 232$),(center,$c 242$), (bottom, $b 252$))),
  T: ($0$, $2$, $3$, $4$, $5$, $6$),
  arrow: "->",
  debug: false,
)

#tabvar(
  init: ("x":$x$,"label":([varation de $f$], [var de $c$], [var de $c$])),
  sign: (($+$, $-$, "+","+","+"),("-","-","+", "3", "5",), ("-","-","+", "3", "5",)),
  var: none,
  T: ($0$, $2$, $3$, $4$, $5$, $6$),
  arrow: "->",
  debug:false,
)

#tabvar(
  init: ("x":$x$,"label":([varation de $f$], [var de $c$], [var de $c$])),
  sign: (($+$, $-$, "+","+","+"),("-","-","+", "3", "5",)),
  var: (((top,$t 101$),(center,$c 111$),(bottom,$b 121$),(bottom,$b 231$),(center,$c 241$), (bottom, $b 251$)),((top,$t 1 02$),(center,$c 112$),(bottom,$b 122$),(top,$t 232$),(center,$c 242$), (bottom, $b 252$)), ((top,$t 1 02$),(center,$c 112$),(bottom,$b 122$),(top,$t 232$),(center,$c 242$), (bottom, $b 252$))),
  T: ($0$, $2$, $3$, $4$, $5$, $6$),
  arrow: "->",
  debug: false,
)
