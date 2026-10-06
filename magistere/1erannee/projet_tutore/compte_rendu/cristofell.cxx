X:=copy([t,x,y,z]);
print("%les coordonnées");
print("x^\\mu = ");
print(latex(X));
print("\\newline");

d:=len(X);
print("%la dimension de l’espace");
print("\\text{la dimension de l’espace  } n = ");
print(latex(d));
print("\\newline");

g:=copy([
  [1+h_(0,0)(t), h_(0,1)(t),h_(0,2)(t),h_(0,3)(t)],
  [h_(1,0)(t), h_(1,1)(t) - 1,h_(1,2)(t),h_(1,3)(t)],
  [h_(2,0)(t), h_(2,1)(t),h_(2,2)(t) - 1,h_(2,3)(t)],
  [h_(3,0)(t), h_(3,1)(t),h_(3,2)(t),h_(3,3)(t) - 1],

]);
print("%la métrique");
print("g_{\\mu \\nu} = ");
print(latex(g));
print("\\newline");

ginv:=g^-1;
print("%la métrique inverse");
print("g^{\\mu \\nu} = ");
print(latex(ginv));
print("\\newline");

G:=(makemat(matrix(d),0,d))[0];
for (j:=0;j<d;j++) {
    for (k:=0;k<d;k++) {
        for (l:=0;l<d;l++) {
                tmp:=0;
                for (m:=0;m<d;m++) {
                    tmp=(tmp+1/2*(ginv[j])[m]*(diff((g[k])[m],X[l])+diff((g[l])[m],X[k])-(diff((g[k])[l],X[m]))))
                };
                ((G[j])[k])[l]:=simplify(tmp);
        }
    }
};
print("%les symboles de Christofell");
for (j := 0; j < d; j++){
    print("\\Gamma^" + j + "_{\\mu \\nu} = ");

    print(latex(G[j]));
    print("\\newline");
};
dg:=det(g);
Ri:=makemat(d);
for (j:=0;j<d;j++) {for (k:=0;k<d;k++) {
            tmp1:=0;
            tmp2:=0;
            tmp3:=0;
            tmp4:=0;
            for (a:=0;a<d;a++) {
                    tmp1:=tmp1+diff(((G[a])[j])[k],X[a]);
                    tmp3:=tmp3+((G[a])[j])[k]*diff(ln(sqrt(-dg)),X[a]);
                    for (b:=0;b<d;b++) {
                        tmp2:=tmp2+((G[b])[a])[j]*((G[a])[b])[k]
                    };
                };
            (Ri[j])[k]:=simplify(-(diff(diff(ln(sqrt(-dg)),X[k]),X[j]))+tmp1-tmp2+tmp3);
        }};
print("%Le tenseur de Ricci");
print("R_{\\mu \\nu} = ");
print(latex(Ri));
print("\\newline");

R:=0;
for (j:=0;j<d;j++) {
    for (k:=0;k<d;k++) {
        R=(R+(ginv[j])[k]*(Ri[j])[k])
      }
};
print("%la courbure scalaire");
print("R = ");
print(latex(R));