//chiffre
#let fe = str.from-unicode(0x16A0)
#let ur = str.from-unicode(0x16A2)
#let tur = str.from-unicode(0x16A6)
#let an = str.from-unicode(0x16A8)
#let rai = str.from-unicode(0x16B1)
#let kau = str.from-unicode(0x16B2)
#let geb = str.from-unicode(0x16B7)
#let wun = str.from-unicode(0x16B9)
#let hag = str.from-unicode(0x16BA)
#let nau = str.from-unicode(0x16BE)
#let je = str.from-unicode(0x16C3)
#let ei = str.from-unicode(0x16C7)
//symbole math
#let ing = str.from-unicode(0x16DD)
#let ti = str.from-unicode(0x16CF)
#let al = str.from-unicode(0x16C9)
#let dag = str.from-unicode(0x16DE)
#let lag = str.from-unicode(0x16DA)
#let so = str.from-unicode(0x16CA)
#let man = str.from-unicode(0x16D7)
#let eh = str.from-unicode(0x16D6)
#let per = str.from-unicode(0x16C8)
#let ber = str.from-unicode(0x16D2)
#let naing = str.from-unicode(0x16DC)
#let suz = str.from-unicode(0x16AD)
#let zus = rotate(180deg)[#str.from-unicode(0x16AD)]

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

#let oui(s,n) = for i in range(s,n+1){
  ($#i _10 = #b12(i)_12 = #na(i)_(ur tur)$,)
}
#grid(
  columns:1,
  gutter: 5pt,
  ..oui(0,calc.pow(12,1))
)