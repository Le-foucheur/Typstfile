//chiffre
#let fe = text(font: "FreeMono")[#str.from-unicode(0x16A0)] + h(0.5pt)
#let ur = text(font: "FreeMono")[#str.from-unicode(0x16A2)] + h(0.5pt)
#let tur = text(font: "FreeMono")[#str.from-unicode(0x16A6)]+ h(0.5pt)
#let an = text(font: "FreeMono")[#str.from-unicode(0x16A8)]+ h(0.5pt)
#let rai = text(font: "FreeMono")[#str.from-unicode(0x16B1)]+ h(0.5pt)
#let kau = text(font: "FreeMono")[#str.from-unicode(0x16B2)]+ h(0.5pt)
#let geb = text(font: "FreeMono")[#str.from-unicode(0x16B7)]+ h(0.5pt)
#let wun = text(font: "FreeMono")[#str.from-unicode(0x16B9)]+ h(0.5pt)
#let hag = text(font: "FreeMono")[#str.from-unicode(0x16BA)]+ h(0.5pt)
#let nau = text(font: "FreeMono")[#str.from-unicode(0x16BE)]+ h(0.5pt)
#let je = text(font: "FreeMono")[#str.from-unicode(0x16C3)]+ h(0.5pt)
#let ei = text(font: "FreeMono")[#str.from-unicode(0x16C7)]+ h(0.5pt)
//symbole math
#let ing = h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16DD)] + h(2pt)
#let ti = h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16CF)] + h(2pt)
#let al = h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16C9)] + h(2pt)
#let dag = h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16DE)] + h(2pt)
#let lag = h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16DA)] + h(2pt)
#let so = h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16CA)] + h(2pt)
#let man = h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16D7)] + h(2pt)
#let eh = h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16D6)] + h(2pt)
#let per = h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16C8)] + h(2pt)
#let ber = h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16D2)] + h(2pt)
#let uber = h(2pt) + "!" + text(font: "FreeMono")[#str.from-unicode(0x16D2)] + h(2pt)
#let naing = h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16DC)] + h(2pt)
#let ehwing =  h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16D6)] + text(font: "FreeMono")[#str.from-unicode(0x16DD)] + h(2pt)
#let maning =  h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16D7)] + text(font: "FreeMono")[#str.from-unicode(0x16DD)] + h(2pt)
#let suz = h(2pt) + text(font: "FreeMono")[#str.from-unicode(0x16AD)] + h(2pt)
#let zus =h(2pt) + rotate(180deg)[#text(font: "FreeMono")[#str.from-unicode(0x16AD)]]+ h(2pt)
//variable
#let inc = text(font: "Noto Sans Phoenician")[#str.from-unicode(0x10901) #h(0.5pt)]
#let v1 = text(font: "Noto Sans Phoenician")[#str.from-unicode(0x10907) #h(0.5pt)]
#let com = text(font: "Noto Sans Phoenician")[#str.from-unicode(0x10900) #h(0.5pt)]
#let ens = text(font: "Noto Sans Phoenician")[#str.from-unicode(0x10988) #h(0.5pt)]
#let v2 = text(font: "Noto Sans Phoenician")[#str.from-unicode(0x1090C) #h(0.5pt)]
#let v3 = text(font: "Noto Sans Phoenician")[#str.from-unicode(0x10919) #h(0.5pt)]
#let pol1 = text(font: "Noto Sans Phoenician")[#str.from-unicode(0x178D) #h(0.5pt)]
#let pol2 = text(font: "Noto Sans Phoenician")[#str.from-unicode(0x1788) #h(0.5pt)]
#let v4 = text(font: "Noto Sans Phoenician")[#str.from-unicode(0x1090E) #h(0.5pt)]

#let nonumeq = math.equation.with(block: true, numbering: none)
#let dm(x) = box[#nonumeq[#x]]

#let rac(body) = context {
  let taille = measure(dm(body))
  line(start: (-1pt,5.6pt), end: (-1pt, -taille.height)) 
  body
  line(start: (1pt,5.6pt), end: (1pt, -taille.height)) 
  line(start: (-taille.width -2pt,-taille.height+2pt), end: (0pt, -taille.height -2.34pt)) 
  line(start: (-taille.width -2pt,-taille.height -2.34pt), end: (0pt, -taille.height +2pt)) 
}
#let nrac(body, n) = context {
  let taille = measure(dm(body))
  let taillen = measure(dm(n))
  line(start: (-1pt,5.6pt), end: (-1pt, -taille.height)) 
  body
  line(start: (1pt,5.6pt), end: (1pt, -taille.height)) 
  line(start: (-taille.width -2pt,-taille.height+2pt), end: (0pt, -taille.height -2.34pt)) 
  line(start: (-taille.width -2pt,-taille.height -2.34pt), end: (0pt, -taille.height +2pt)) 
  move(text(taille.height/1.4)[#n], dx: -(taille.width + taillen.width -3pt)/2, dy: -taille.height -3.5pt)
  h(-taillen.width + 1.5pt)
}

#table(
  columns: 3,
  align: center,
  //chiffre
  [symbole usuel],[symbole du DM],[prononciation],
  [0],$fe$,[fé],
  [1],$ur$,[ur],
  [2],$tur$,[tur],
  [3],$an$,[an],
  [4],$rai$,[rai],
  [5],$kau$,[kau],
  [6],$geb$,[gèb],
  [7],$wun$,[wun],
  [8],$hag$,[hag],
  [9],$nau$,[nau],
  [10],$je$,[je],
  [11],$ei$,[ei],
  //symbole math
  $=$,$ing$,[ing/i ng],
  $+$,$ti$,[ti],
  $-$,$al$,[al],
  $times$,$dag$,[dag],
  $div$,$lag$,[lag],
  $sqrt(a)$,$rac(a)$,[naz],
  $root(n,a)$,$nrac(a,n)$,[$n$-naz],
  $in$,$so$,[so],
  $forall$,$per$,[per],
  $exists$,$ber$,[ber],
  $>$,$man$,[man],
  $<$,$eh$,[e],
  $>=$,$man ing$,[maning],
  $<=$,$eh ing$,[ehwing],
  $!=$,$naing$, [naing/na i ng],
  $subset$,$suz$, [suz],
  $supset$,$zus$, [zus],
)

#let b12(n) ={ let rep = ""
let tmp = 0
  if n == 1 {"1"}
  else if n == 0 {"0"}
  else{
    for i in range(calc.ceil(calc.log(n,base :10))){
    tmp = calc.rem(n,12)
    if tmp == 11 {
      rep = rep + "b"
    } 
    else if tmp == 10 {
      rep = rep + "a"
    }
    else{
      rep = rep + str(tmp)
    }
    n = calc.quo(n,12)
  }
  rep = str.rev(rep)
  let i = 0
  while rep.first() == "0"{
    rep = rep.slice(1, rep.len())
  }
  rep
  }
}

#let na(n) ={ let rep = b12(n)
  let r = ""
  for i in range(rep.len()){
    if rep.at(i) == "b" {
      r = r + ei
    } 
    else if rep.at(i) == "a" {
      r = r + je
    }
    else if rep.at(i) == "9" {
      r = r + nau
    }
    else if rep.at(i) == "8" {
      r = r + hag
    }
    else if rep.at(i) == "7" {
      r = r + wun
    }
    else if rep.at(i) == "6" {
      r = r +geb
    }
    else if rep.at(i) == "5" {
      r = r + kau
    }
    else if rep.at(i) == "4" {
      r = r + rai
    }
    else if rep.at(i) == "3" {
      r = r + an
    }
    else if rep.at(i) == "2" {
      r = r + tur
    }
    else if rep.at(i) == "1" {
      r = r + ur
    }
    else if rep.at(i) == "0" {
      r = r + fe
    }
  }
  r
}


#pagebreak()
#set par(leading: -3pt)

#let oui(s,n) = for i in range(s,n+1){
  ($#i _10 = #b12(i)_(12) ing #nrac(na(i), na(i))$,)
}

#grid(
  columns: 1,
  gutter: 5pt,
  ..oui(0,300)
)
