#import "../../../template.typ": *
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#import "@preview/drafting:0.2.2": *

#show: template

#set page(numbering: "1/1")

#set heading(numbering: "1.1.1.a")

UFR de Phisique et Ingénierie #h(1fr) Université de Strasbourg
#v(15mm)
#align(center)[
  LICENCE 3 DE PHYSIQUE — ANNÉE 2025/2026\
  *Analyse numérique et calcul scientifique :*\
  *Projet informatique*
]

#align(center)[
  #text(20pt)[*Introduction et explication du projet*]
  #v(-6mm)
  #repeat[─]
]

#align(center)[
  \
  #text(14pt)[6 : Double Pendules]\
  \
  #text(20pt)[*Gaspar Daguet*]\
  gaspar.daguet\@etu.unistra.fr\
  \
]
#repeat[─]

#pagebreak()

#outline()

= Arborescence du projet

Le projet se présente sous l’arborésance suivante :

#figure( 
  diagram(
    node-stroke: 1pt,
    node((1,0), [.], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#b4b4ff")),

    ..for i in range(-2, 3) {
      (edge((1,0), (i - if i <= 0 {0.5} else {0} + if i == 2 {1}, 1),"-|>"),)
    },

    node((-2.5,1), [Makefile], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#e6e6ff")),
    node((-1.5,1), [inputs], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#cdcdff")),

    edge("->"),

    node((-1.5,2), [
      A rajouter
      config.cfg
      pendule.cfg
    ], corner-radius: 2pt, shape: "rect", width: 2.5cm, fill: rgb("#e6e6ff")),

    node((-0.5,1), [includes], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#cdcdff")),

    edge("->"),

    node((-0.5,2), [
      maestro.h
      pendule.h
      tui.h
    ], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#e6e6ff")),

    node((1,1), [src], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#cdcdff")),

    edge("->"),

    node((1.5,2), [plotting], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#cdcdff")),

    edge((1.5, 2), (1.5, 3), "->"),
    node((1.5, 3), [
      plot_energie.typ
      plot_portrait_phase.typ
      plottraj.typ
    ], corner-radius: 2pt, shape: "rect", width: 4.2cm, fill: rgb("#e6e6ff")),

    edge((1,1), (0.5, 2),  "->"), 
    node((0.5,2), [
      maestro.cpp
      main.cpp
      pendule.cpp
      tui.cpp
    ], corner-radius: 2pt, shape: "rect", width: 2.5cm, fill: rgb("#e6e6ff")),



    node((3.5,1), [target], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#cdcdff")),

    edge((3.5, 1), (2.5, 2), "-|>"),
    edge((3.5, 1), (3.5, 2), "-|>"),
    edge((3.5, 1), (4.5, 2), "-|>"),

    node((3.5, 2), [data], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#cdcdff")),

    edge((3.5, 3), "->"),

    node((3.5, 3), [`*.csv`], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#e6e6ff")),

    node((4.5, 2), [plot], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#cdcdff")),
    
    edge((4.5, 3), "->"),

    node((4.5, 3), [`*.pdf`], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#e6e6ff")),

    node((2.5, 2), [main], corner-radius: 2pt, shape: "rect", width: 2cm, fill: rgb("#e6e6ff"))
  ), 
  caption: [Arborescence du projet depuis la racine]
)

== Racine du projet `./`

#set list(marker: ([#sym.bullet], [—]))
 - Makefile : le fichier pour compiler & éxécuter le projet :
  - `make build` : compile le projet
  - `make run` : compile et éxécute le projet
  - `make plot` : compile les datas contenue dans `./target/data/`, et les plots via typst
  - `make run_et_plot` : effectue `make run` puis `make plot`
- Les sous-dossiers décrit ci-dessous

== inputs

- `config.cfg` : les config générales du projet (voir @configgen)
- `pendule.cfg` : les différents pendules (voir @configpend)

== includes
- `maestro.h` : définition de la classe `Maestro`, de ses attributs et du prototype de ses méthodes
- `pendule.h` : définition de la classe `Pendule`, de ses attributs et du prototype de ses méthodes
- `tui.`h : définition de la classe `TUI`, de ses attributs et du prototype de ses méthodes — Ainsi que de la classe `TUI_Pendule` dérivé de la classe `TUI`, de ses attributs et du prototype de ses méthodes

== src
- `main.cpp` : Le programme principal 
- `maestro.cpp` : définition des méthode de la classe `Maestro`  
- `pendule.cpp` : définition des méthode de la classe `Pendule`  
- `TUI.cpp` : définition des méthode des classes `TUI` & `TUI_Pendule`
- `plotting/` : les sous-dossiers pour plot les données

=== plotting
- `plot_energie.typ`: permet de plot l’energie cinétique,  potentielle et mécanique dans le cas d’un double pendules
- `plot_portrait_phase.typ`: permet de plot le prortrait de phase du dernier pendule
- `plottraj.typ`: permet de plot la trajectoire du dernier pendule

== target 
- `polyekkreme` : le binaire du projet
- `data/` : les données produits par le projet, au format `.csv`
- `plot/` : les plots produis par le projet

= Utilisation

Pour éxécuter le programme, il faut d’abord le configuré, et luis renseigné les différents pendules, pour celà voir les deux sous-chapitres suivant.\
Ensuite, faites : 
#rect(width: 100%, radius: 2mm, stroke: none, fill: rgb(0,0,0, 10%), [```bash
$ make run
```]) 
Pour ploter les données, aller voir @plot



== les config générales <configgen>

== les pendules <configpend>

== plot <plot>

*Attention :* Pour plot les données il vous faut installer #link("https://typst.app/")[typst] (github : #link("https://github.com/typst/typst"))
sans celà le projet ne peut produire les différents plots

#rect(width: 100%, radius: 2mm, stroke: none, fill: rgb(0,0,0, 10%), [```bash
$ make plot
```]) 
De plus, vous pouvez éxécuter et plot directement avec :
#rect(width: 100%, radius: 2mm, stroke: none, fill: rgb(0,0,0, 10%), [```bash
$ make run_et_plot
```]) 