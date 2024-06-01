#import "@preview/fletcher:0.4.5": *
#let bo(x) = table(columns: 2cm, stroke: 0pt)[#table.cell(align: center + horizon)[#x]]
#let signe = "Signe"
#let variation = "Variation"

#let lastele(x, interval, j, stroke) = {
  // pour gérer le dernier élément
  if x.first() == top {
    node((interval.len() - 1 / 3, 1 + (j) * 3 + 0.25), x.last())
  } else if x.first() == center {
    node((interval.len() - 1 / 3, 2 + (j) * 3), x.last())
  } else if x.first() == bottom {
    node((interval.len() - 1 / 3, 3 + (j) * 3 - 0.25), x.last())
  }
  if x.at(1) == "u" {
    edge(
      (
        interval.len() + 0.06,
        j * 3 + if j == 0 {
          0.85
        },
      ),
      (
        interval.len() + 0.06,
        j * 3 + 4,
      ),
      stroke: stroke.thickness / 2 + stroke.paint,
    )
  }
}

#let tabvar(
  //parameter
  content: (), //the content
  init: (
   "variable": [],  //the variable of the table
   "label": [] //the labels on the right collum
  ),
  interval: (), //the ensemble where the varable is defined
  arrow : "->", //what kind of arrow
  debug: false, //just for development
  stroke: 1pt + black, //stroke of the entier table exept arrows
  stroke-arrow: 0.6pt+black //stroke of arrows

  ) = {

  //start of function
  context {
    //tableau de varation + signe + naïf
    diagram(
        spacing: ((4/3)*1cm, 1.3pt),
        cell-size: 0pt,
        debug: debug,
        node((0,0), stroke: stroke,enclose:  (//contour du tableau
          ..for i in range(interval.len()+1){
              for j in range(init.at("label").len()*3+1){
                ((i,j),)
              }
            }
          ),
        ),
        edge((-0.86,0.87),(interval.len()+0.12,0.87), stroke: stroke), // ligne de séparation x du reste
        edge((0.36,-4),(0.36,init.at("label").len()*3+0.9 + if init.at("label").last().last() == signe{3.5}), stroke: stroke), // ligne de séparation des label, des varations
        node((-0.19,0), (init.at("variable")), width: 2cm), for i in range(interval.len()-1){
          node((i+2/3, 0), interval.at(i), width: (2/3)*1cm)
        },
        node((interval.len()-1/3,0), interval.at(interval.len()-1), width: (2/3)*1cm),

        ..for j in range(init.at("label").len()){(
          node((-0.19,2+j*3), bo(init.at("label").at(j).first()), height: calc.max(measure(bo(init.at("label").at(j).first())).height, 45pt)),)
        },
        ..for j in range(init.at("label").len()){(
          if init.at("label").at(j).last() == signe{( //tableau de signe
            for i in range(1,content.at(j).len()){
              node((i+1.2, 2+(j)*3),content.at(j).at(i))
            },
            node((1.05, 2+(j)*3),content.at(j).at(1)),
            for i in range(1,interval.len()-1){ // ligne de séparation
              edge((i+2/3, 1+(j)*3), (i+2/3,3+(j)*3 + if j == init.at("label").len()-1{4.5}), stroke: stroke.thickness/2 + stroke.paint)
            },
            if j != init.at("label").len()-1{edge((-0.74,3+(j)*3), (interval.len()+0.1, 3+(j)*3), stroke: stroke)} // ligne sous les tableaux de contente
          )},

          if init.at("label").at(j).last() == variation{( // tableau de variation
            for i in range(content.at(j).len()-1){
              let proch= 0
              let decalindef = if content.at(j).at(i).len() >= 3 and i != 0 and content.at(j).at(i).at(2) == "u"{0.255} else{0}
              let edgeprochindef = if content.at(j).at(i+1).len() >= 3 and content.at(j).at(i+1).at(2) == "u"{0.3} else{0}
              let prochainIndef = if content.at(j).at(i).len() >= 3 and i != 0 and content.at(j).at(i).at(2) == "u"{
                if content.at(j).at(i).first() == top{1}
                else if content.at(j).at(i).first() == center{1.75}
                else if content.at(j).at(i).first() == bottom{2.5}
              }

              if content.at(j).at(i).len()>2 and i != 0 and content.at(j).at(i).at(2) == "u"{ // cas de l'ajout d'une ligne indéfine

                node((i +2/3 - decalindef, prochainIndef +(j)*3+0.25), content.at(j).at(i).at(3))

                //la double ligne de l'indéfine
                edge((i +2/3 -0.015 ,3*j + if j == 0{0.9} ),(i +2/3 - 0.015 ,3*j+4), stroke: stroke.thickness/2 + stroke.paint)
                edge((i +2/3 + 0.015,3*j + if j == 0{0.9} ),(i +2/3 + 0.015,3*j+4), stroke: stroke.thickness/2 + stroke.paint)
              }
              else if content.at(j).at(i).len()>2 and content.at(j).at(i).at(1) == "u"{ //traite le premier cas s'il est non défine

                //le node qui contient l'élément
                if content.at(j).at(i).first() == top{
                  node((2/3, 1+(j)*3+0.25), content.at(j).first().last())
                  proch = 1+(j)*3+0.25
                }
                else if content.at(j).at(i).first() == center{
                  node((2/3, 2+(j)*3), content.at(j).first().last())
                  proch = 2+(j)*3
                }
                else if content.at(j).at(i).first() == bottom{
                  node((2/3, 3+(j)*3-0.25), content.at(j).first().last())
                  proch = 3+(j)*3-0.25
                }

                // la ligne de l'indéfine
                edge((0.4 ,3*j + if j == 0{0.9} ),(0.4 ,3*j+4), stroke: stroke.thickness/2 + stroke.paint)
              }

              // les nodes contenants les éléments
              if content.at(j).at(i).at(if content.at(j).at(i).len()>2{1} else{0}) == top{
                node((i +2/3 + decalindef, 1+(j)*3+0.25), content.at(j).at(i).last())
                proch = 1+(j)*3+0.25
              }
              else if content.at(j).at(i).at(if content.at(j).at(i).len()>2{1} else{0}) == center{
                node((i +2/3 + decalindef, 2+(j)*3), content.at(j).at(i).last())
                proch = 2+(j)*3
              }
              else if content.at(j).at(i).at(if content.at(j).at(i).len()>2{1} else{0}) == bottom{
                node((i +2/3 + decalindef, 3+(j)*3-0.25), content.at(j).at(i).last())
                proch = 3+(j)*3-0.25
              }

              // les flèches entre les éléments
              if content.at(j).at(i+1).first() == top{
                edge((i +2/3 + decalindef ,proch),(i+5/3 - edgeprochindef ,3*(j)+1+0.25), arrow, stroke: stroke-arrow)
              }
              else if content.at(j).at(i+1).first() == bottom{
                edge((i +2/3 + decalindef ,proch),(i+5/3 - edgeprochindef,3*(j)+3-0.25), arrow, stroke: stroke-arrow)
              }
              else if content.at(j).at(i+1).first() == center{
                edge((i +2/3 + decalindef ,proch),(i+5/3 - edgeprochindef ,3*(j)+2), arrow, stroke: stroke-arrow)
              }
            },
            lastele(content.at(j).last(), interval, j, stroke), // pour gérer le dernier élément

            if j  != init.at("label").len()-1{edge((-0.74,3*(j)+4), (interval.len()+0.11, 3*(j)+4), stroke: stroke)} // ligne sous les tableaux de variation
          )}
        )}
      )
  }
}

#tabvar(
  init: (
    "variable": $x$,
    "label": (
      ([varation de $f$], variation),
      ([signe de $c$], signe),
      ([var de $c$], variation),
      ([signe de s], signe),
    ),
  ),
  interval: ($0$, $2$, $3$, $4$, $5$, $6$),
  content: (
    (
      (top, "u", $t 101$),
      (center, bottom, "u", $c 1111$, $c 1112$),
      (top, top, "u", "oui", $b 121$),
      (bottom, $b 231$),
      (center, $c 241$),
      (bottom, "u", $b 251$),
    ),
    ($-$, $-$, $+$, $-$, $-$),
    (
      (center, "u", $t 1 02$),
      (center, center, "u", $c 33$, $c 112$),
      (bottom, $b 122$),
      (top, $t 232$),
      (bottom, $b 242$),
      (bottom, "u", $b 252$),
    ),
    ($+$, $-$, $+$, $-$, $+$),
  ),
  arrow: "->",
  debug: false,
)

#scale(x: 90%, y: 80%)[
  #tabvar(
    init: (
      "variable": $x$,
      "label": (
        ([varation de $f$], variation),
        ([signe de $c$], signe),
        ([var de $c$], variation),
        ([signe de s], signe),
      ),
    ),
    interval: ($0$, $2$, $3$, $4$, $5$, $6$),
    content: (
      (
        (top, $t 101$),
        (center, $c 111$),
        (bottom, $b 121$),
        (bottom, $b 231$),
        (center, $c 241$),
        (bottom, "u", $b 251$),
      ),
      ($-$, $-$, $+$, $-$, $-$),
      (
        (top, "u", $t 1 02$),
        (bottom, top, "u", $h$, $c 112$),
        (bottom, $b 122$),
        (top, $t 232$),
        (center, $c 242$),
        (bottom, $b 252$),
      ),
      ($+$, $-$, $+$, $-$, $+$),
    ),
    arrow: "<>--|>",
    stroke-arrow: blue,
    debug: false,
    stroke: red + 3pt,
  )]