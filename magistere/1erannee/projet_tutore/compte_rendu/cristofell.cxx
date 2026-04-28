X:=copy([t,r,theta,phi]);
d:=len(X);
g:=copy([[1-Rs/r,0,0,0],[0,-(1-Rs/r)^-1,0,0],[0,0,-r^2,0],[0,0,0,(-r^2)*sin(theta)^2]]);
ginv:=g^-1;
G:=(makemat(matrix(d),0,d))[0];
for (j:=0;j<d;j++) {for (k:=0;k<d;k++) {for (l:=0;l<d;l++) { 
        tmp:=0;  
        for (m:=0;m<d;m++) {tmp=(tmp+1/2*(ginv[j])[m]*(diff((g[k])[m],X[l])+diff((g[l])[m],X[k])-(diff((g[k])[l],X[m]))))};  
        ((G[j])[k])[l]:=simplify(tmp);  
      }}};
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
          for (b:=0;b<d;b++) {tmp2:=tmp2+((G[b])[a])[j]*((G[a])[b])[k]};  
        };  
      (Ri[j])[k]:=simplify(-(diff(diff(ln(sqrt(-dg)),X[k]),X[j]))+tmp1-tmp2+tmp3);  
    }};
R:=0;
for (j:=0;j<d;j++) {for (k:=0;k<d;k++) {R=(R+(ginv[j])[k]*(Ri[j])[k])}};
