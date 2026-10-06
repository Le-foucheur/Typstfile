// =============================================================================
// TEMPLATE TYPST POUR RAPPORTS DE PHYSIQUE SUBATOMIQUE
// Réplique exacte du template LaTeX Template_26_27.tex
// =============================================================================

#set page(
  paper: "a4",
  margin: 0.5in, // Marges réduites 0.5 in (identique à \geometry{margin=0.5in})
  header: align(right)[
    #text(8pt, fill: luma(120))[Subatomic Physics Lab Report]
  ],
  footer: context [
    #align(center)[
      #text(8pt)[#counter(page).display("1")]
    ]
  ]
)

// Police principale et taille fixe à 9pt (\fontsize{9}{11})
#set text(
  font: "Linux Libertine",
  size: 9pt,
  lang: "fr",
  historical-ligatures: true
)

// Interligne et justification du texte
#set par(justify: true, leading: 0.55em)
#set list(spacing: 0.65em)
#set enum(spacing: 0.65em)

// Liens hypertexte en bleu (hyperref colorlinks)
#show link: set text(fill: rgb("#0000ff"))

// Style des titres
#set heading(numbering: "1.1")
#show heading: it => [
  #v(0.5em)
  #it
  #v(0.3em)
]

// Style des légendes de figures (font=footnotesize, labelfont=bf, textfont=it)
#show figure.caption: it => [
  #text(size: 8pt)[
    *#it.supplement #it.counter.display(it.numbering)*: #text(it.body, style: "italic")
  ]
]

// Numérotation automatique des équations
#set math.equation(numbering: "(1)")

// Raccourci pour i.e.
#let ie = [_i.e._]

// ==========================================
// EN-TÊTE ET TITRE (Sur 1 colonne)
// ==========================================

#align(center)[
  #v(5pt)
  #text(size: 13pt, weight: "bold")[Template for subatomic reports] \
  #v(2pt)
  #text(size: 11pt, weight: "bold", fill: rgb("#ff0000"))[DO NOT CHANGE the document setup.] \
  #v(4pt)
  #text(size: 8.5pt)[
    You can use this template for other experiments but please verify with the corresponding instructor the number of pages, style etc...
  ] \
  #v(2pt)
  #text(size: 8.5pt)[
    *When you upload to moodle :* \
    Please name your file EXP\#-SESSION1or2-GROUPETAG#footnote[The group TAG will be assigned on the moodle planning by the instructor.], \
    #ie for experiment "alpha", session 1 and group A3 \
    *File Name : alpha-S1-A3.pdf*
  ]
  #v(8pt)
  #text(size: 9pt, weight: "medium")[Author1 Name, Author 2 Name, Author 3 Name] \
  #v(2pt)
  #text(size: 8.5pt, fill: luma(80))[#datetime.today().display("[month repr:long] [day], [year]")]
  #v(8pt)
]

// RÉSUMÉ (ABSTRACT)
#align(center)[
  #block(width: 90%, inset: 6pt)[
    #align(center)[*Abstract*]
    #set align(left)
    #set text(size: 8pt)
    Here you should write a brief summary of the article. It provides an overview of the main findings and the purpose of the research. It also contains the main measurement value, _for example : \(theta = 3.4^\circ \pm 0.2^\circ\)_ which can be in agreement or not with the tabulated/theoretical values. The abstract is designed to give readers a quick understanding of the content and results of the paper.
  ]
]

#v(8pt)

// ==========================================
// CORPS DU DOCUMENT (Sur 2 colonnes)
// ==========================================

#show: rest => columns(2, gutter: 12pt, rest)

= Introduction 

The introduction provides background information on the topic of the research. It outlines the problem, the significance of the study, and the objectives. This section sets the stage for the detailed experiment and results that follow.

#text(fill: rgb("#ff0000"))[
  The main article SHOULD NOT go beyound 4-5 pages maximum (#ie with figures/tables etc...), this is ONLY required for subatomic, other colleagues might have their own requirement please ask. The exercice is also to select the relevant information and not swarm the reader with repetitive or non-relevant information.
]

If more information (tables, figures, graphs, codes) need to be included (example : figures for similar cases of measurements, etc...) use the appendix. The appendices will not be read systematically only if needed.

#text(fill: rgb("#ff0000"))[
  Please start writing and filling the template on Monday, you can include the "raw" measurements, some bullet points, discussions with colleagues or instructor, reflections etc... The best way is to use #link("https://www.overleaf.com")[Overleaf] for collaborative writing.
]

= Experiment Description

== Material

This subsection describes the materials used in the experiment. It includes details on the type and specifications of the materials, such as:

- (Always use the compact format to win space)
- Material 1: Description
- Material 2: Description
- Material 3: Description

Below is a photo (or two if needed) of the experimental setup.

#figure(
  grid(
    columns: 2,
    gutter: 6pt,
    rect(width: 100%, height: 45pt, fill: rgb("#f0f0f5"), stroke: 0.5pt + luma(150))[
      #align(center + horizon)[#text(size: 7pt, fill: luma(100))[example-image-a]]
    ],
    rect(width: 100%, height: 45pt, fill: rgb("#f0f0f5"), stroke: 0.5pt + luma(150))[
      #align(center + horizon)[#text(size: 7pt, fill: luma(100))[example-image-b]]
    ],
  ),
  caption: [Experimental setup, caption must be more informative this is an example.],
) 

#text(fill: rgb("#ff0000"))[
  It is a requirement to precise where the High Voltages and the Low voltages are connected on the setup.
]

= Calibration

Calibration is an essential part of the experiment to ensure accuracy and repeatability. This section describes the calibration procedure. Below is a photo of the calibration function.

=== Discussion

In this paragraph, the results of the calibration are discussed. It includes analysis of the calibration data, any issues encountered, and how they were resolved. The discussion can also be written in a subsection. See for example the next section. Normally a paragraph is better for a short discussions.

#figure(
  grid(
    columns: 2,
    gutter: 6pt,
    rect(width: 100%, height: 45pt, fill: rgb("#f0f0f5"), stroke: 0.5pt + luma(150))[
      #align(center + horizon)[#text(size: 7pt, fill: luma(100))[example-image-a]]
    ],
    rect(width: 100%, height: 45pt, fill: rgb("#f0f0f5"), stroke: 0.5pt + luma(150))[
      #align(center + horizon)[#text(size: 7pt, fill: luma(100))[example-image-b]]
    ],
  ),
  caption: [Energy and efficiency if needed, see above for caption indications.],
) 

#text(fill: rgb("#ff0000"))[
  Notice that every block/section (here it is the calibration) has an explanatory paragraph followed, if need be, by a discussion, you can add it as a subsection like it was done here. The discussions concerns any point that need to be raised, such as an outlier measurement, large errors etc...

  Normally the graphs, figures, tables, graphs related to a given section are "packed" in this section. The reader #underline[SHOULD NOT] look around for the pictures ideally they are on the same or neighbouring page.
]

= Measurement

This section details the raw measurement made in the experiment (in contrast with deduced or calculated measurements).

Raw measurements are typically what you read on a #link("https://en.wikipedia.org/wiki/Vernier_scale")[vernier scale] with no further treatment. Every measurement should have an associated uncertainty. If there's many measurements use the appendix and refer to it. See example below.

It also describes the procedures, mention the equipments, and techniques used to obtain the data. Example : If there is supplementary data that are important for the discussion they can be found here in \@tab:raw_measurements; *NB :* in some cases appendices could be indispensable to judge the accuracy of the work. You should provide enough data for the reader to be able to reproduce your calculated measurements.

== Discussion

In this subsection, the results of the measurement are discussed. It includes critique of the measured data, any issues encountered, and how they were resolved.

= Main findings : Results And Discussion

The results of the experiment are presented in this section, it mainly includes the final *calculated* data and measurements, graphs, and tables that summarize the findings.

== Discussion of result 1

In this subsection, the final result/conclusion are discussed in detail. It includes analysis of the calculated data, it should answer the following questions at minimum :

- Are the results in agreement with the expected value?
- If not then why? Is there a clear reason? An estimate? A reasonable guess?...
- What measured parameter or analysis method is at the origin of the anomalies? etc...

#figure(
  grid(
    columns: 2,
    gutter: 4pt,
    rect(width: 100%, height: 35pt, fill: rgb("#f0f0f5"), stroke: 0.5pt + luma(150))[
      #align(center + horizon)[#text(size: 7pt, fill: luma(100))[example-image-a]]
    ],
    rect(width: 100%, height: 35pt, fill: rgb("#f0f0f5"), stroke: 0.5pt + luma(150))[
      #align(center + horizon)[#text(size: 7pt, fill: luma(100))[example-image-b]]
    ],
    rect(width: 100%, height: 35pt, fill: rgb("#f0f0f5"), stroke: 0.5pt + luma(150))[
      #align(center + horizon)[#text(size: 7pt, fill: luma(100))[example-image-a]]
    ],
    rect(width: 100%, height: 35pt, fill: rgb("#f0f0f5"), stroke: 0.5pt + luma(150))[
      #align(center + horizon)[#text(size: 7pt, fill: luma(100))[example-image-b]]
    ],
  ),
  caption: [Graph showing the results, analysis, diagrams etc... take out figures as needed.],
) 

#text(fill: rgb("#ff0000"))[If you have several results you can create several subsections.]

= Conclusion

The conclusion summarizes the key findings of the experiment, discusses their implications, and suggests possible areas for future research.

== Referencing

You can reference sections with internal hyperlinks, like this: #link("8.8.8.8")[#text(fill: rgb("#0000ff"))[Introduction]] to send the reader to the introduction section.

Some referencing notes:
- Here's a direct link to #link("https://www.feynmanlectures.caltech.edu/")[Feynman lectures].
- The #link("https://www.nndc.bnl.gov/")[National Nuclear Data Center], NNDC, collects, evaluates, and disseminates nuclear physics data for basic nuclear research and applied nuclear technologies.
- Library for gamma and alpha emissions #link("http://www.lnhb.fr/Laraweb/index.php")[Nucléide - Lara], useful for inspecting decay data of radioactive nuclei.
- An example to cite a reference in the bibliography; Here's an article by Al-Khalili about Alhazen \@alkhalili2015.
- An example to reference a website in the bibliography, IAEA Live shart can be found in this reference \@websiteiaea.

= Bibliography

#block[
  #set text(size: 8.5pt)
  +  Author Name, _Title_. Publisher or Journal, year.
  +  Isaac Newton, _Opticks: or, a treatise of the reflexions, refractions, inflexions and colours of light. First edition, 1704._ #link("http://cudl.lib.cam.ac.uk/view/MS-ADD-03970/")
  +  Jim Al-Khalili, _In retrospect: Book of Optics_. Nature, Vol. 518, 2015. #link("https://doi.org/10.1038/518164a")
  +  International Atomic Energy Agency (IAEA) _Live Chart of Nuclides_. Apr 2023 - Nov 2023. #link("https://www-nds.iaea.org/relnsd/vcharthtml/VChartHTML.html")
  +  _Wikipedia page : History of the scientific method_. #link("https://en.wikipedia.org/wiki/History_of_scientific_method")
]

// ==========================================
// SECTION ANNEXES (APPENDIX)
// ==========================================

#counter(heading).update(0)
#set heading(numbering: "A.1")

= Appendix : purpose or use 

#text(fill: rgb("#ff0000"))[*The appendix are not counted in the 4-5 pages of the report.*] \

In case you use an appendix it should be referenced in the text such as Appendix \@app:A produced with this syntax `#link()[Appendix A]`.

It gives the authors a space to put more explanation (see Appendix \@app:B for more details), for non fundamental data or explanation it is optional. \

#text(fill: rgb("#ff0000"))[
  *However if some measurements are presented "out of the blue" (i.e. parachutés) in the main text, with no data to support it, the use of referenced appendix is #underline[indispensable] in order to provide the information without going beyond the allowed number of pages.*
]

= Appendix Contents 

This Appendix contains what supplementary data and results that goes in an appendix in general.

1. *Raw Data or Detailed Tables*
   - Large sets of raw data or results that are referenced but not included in the main text.
   - Complex tables or figures that would disrupt the flow of the main document if placed within the core sections.

2. *Supplementary Figures or Charts*
   - Additional graphs, charts, diagrams, or images that support the analysis but are not critical to the main discussion.
   - Alternative or repetitive visualizations or versions of figures already present in the document.

3. *Supplementary Calculations*
   - Detailed mathematical derivations, calculations, or proofs that support claims made in the main document but are too lengthy to include in the text.

4. *Technical or Methodological Details*
   - Detailed descriptions of methodologies, procedures, or technical specifications that are essential but too extensive for the main text.
   - Software code, algorithms, or scripts used for analyses or simulations. For code sharing in general it is better to use #link("https://github.com")[github] or #link("https://about.gitlab.com/")[gitlab]. However this is not necessary in general.

5. *Extended Literature Review or Theoretical Explanations*
   - Additional background information that is important but too detailed to be included in the main literature review.
   - Extended explanations of theories or models referenced in the paper.

6. *Abbreviations or Glossaries*
   - A glossary of terms or a list of abbreviations and acronyms used in the document, especially if extensive.

= Appendix example 

== Raw Measurements Example

This part includes the raw data collected during the experiment. It presents the measurements in tabular form for detailed analysis, see \@tab:raw_measurements.

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: center,
    stroke: 0.5pt + luma(120),
    [\(P_1\)], [\(\delta P_1\)], [\(P_2\)], [\(\delta P_2\)], [\(P_3\)], [\(\delta P_3\)], [\(C_1\)], [\(\delta C_1\)],
    [Data 1], [Data 2], [Data 3], [Data 4], [Data 5], [Data 6], [Data 7], [Data 8],
    [Data 9], [Data 10], [Data 11], [Data 12], [Data 13], [Data 14], [Data 15], [Data 16],
    [Data 17], [Data 18], [Data 19], [Data 20], [Data 21], [Data 22], [Data 23], [Data 24],
    [Data 25], [Data 26], [Data 27], [Data 28], [Data 29], [Data 30], [Data 31], [Data 32],
  ),
  caption: [Raw measurements collected during the experiment, \(P_1\) for parameter 1 or measured quantity 1 \(\delta P_1\) for its uncertainty, \(C\) for calculated etc..],
) 

== Formula Development

A similar section could be used to provide a detailed development of the formulas used in the analysis. It includes derivations, explanations, and any relevant mathematical steps.

=== Example : Error propagation formula

The general error propagation formula for a function \(f(x, y, z)\) with three variables and including covariances is given by:

$
sigma_f^2 = & ((partial f) / (partial x))^2 sigma_x^2 + ((partial f) / (partial y))^2 sigma_y^2 + ((partial f) / (partial z))^2 sigma_z^2 \
            & + 2 ((partial f) / (partial x)) ((partial f) / (partial y)) "Cov"(x, y) \
            & + 2 ((partial f) / (partial x)) ((partial f) / (partial z)) "Cov"(x, z) \
            & + 2 ((partial f) / (partial y)) ((partial f) / (partial z)) "Cov"(y, z)
$ 

where:
- \(sigma_f^2\): The variance of the function \(f(x, y, z)\).
- \((partial f) / (partial x)\), \((partial f) / (partial y)\), \((partial f) / (partial z)\): The partial derivatives of the function \(f\) with respect to variables \(x\), \(y\), and \(z\), respectively. These represent the sensitivity of the function \(f\) to changes in each variable.
- \(sigma_x^2\), \(sigma_y^2\), \(sigma_z^2\): The variances of the individual variables \(x\), \(y\), and \(z\). These describe the uncertainties in the measurements or values of the variables.
- "Cov"(x, y), "Cov"(x, z), "Cov"(y, z): The covariances between pairs of variables. Covariance measures how two variables change together. If the covariance is positive, an increase in one variable tends to be associated with an increase in the other.
- The terms \
  \(2 ((partial f) / (partial x)) ((partial f) / (partial y)) "Cov"(x, y)\), \(2 ((partial f) / (partial x)) ((partial f) / (partial z)) "Cov"(x, z)\), and \(2 ((partial f) / (partial y)) ((partial f) / (partial z)) "Cov"(y, z)\) \
  account for the covariances between the variables \(x\), \(y\), and \(z\).

And here's a numbered equation with respect to the one above:

$ E = m c^2 $ 

or the _unnumbered_ equation if needed:

$ E = m c^2 $

The above formula represents the mass-energy equivalence where \(E\) is the energy in joules, \(m\) is the mass in kilogrammes, and \(c\) is the speed of light m/s.