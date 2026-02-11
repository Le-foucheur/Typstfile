%Met la dimention ici 
n = 4;

x = sym("x", [1 n])

%les constantes/variables
G = sym("G");
M = sym("M");
c = sym("c");
Rs = sym("Rs");

%Rentre la métrique ici
g = [
    -(1-Rs/x(2)), 0, 0, 0;
    0, 1/(1-Rs/x(2)), 0, 0;
    0, 0, x(2)^2, 0;
    0, 0, 0, x(2)^2 * sin(x(3))^2;
]

ig = inv(g)

Gamma = g;

for i = 1:n
    Gamma(:,:,i) = zeros(n,n);
end

for gamma = 1:n
    for alpha = 1:n
        for beta = 1:n
            tmp0 = 0;
            for m = 1:n
                tmp0 = tmp0 + 0.5 * ig(gamma, m) * (diff(g(m,alpha), x(beta)) + diff(g(m, beta), x(alpha)) - diff(g(alpha, beta), x(m)));
            end
            Gamma(alpha, beta, gamma) = simplify(tmp0);
        end
    end
end

Gamma


gd = det(g)



Ri = g;

for mu = 1:n
    for nu = 1:n
        tmp1 = 0;
        tmp2 = 0;
        tmp3 = 0;
        tmp4 = 0;
        for alpha = 1:n
            tmp1 = tmp1 + diff(Gamma(mu, nu, alpha), x(alpha));
            tmp3 = tmp3 + Gamma(mu, nu, alpha) * diff(log(sqrt(-gd)), x(alpha));
            for beta = 1:n
                tmp2 = tmp2 + Gamma(alpha, mu, beta) * Gamma(beta, nu, alpha);
            end
        end
        Ri(mu,nu) = simplify(- diff(diff(log(sqrt(-gd)),x(nu)), x(mu)) + tmp1 - tmp2 + tmp3);
    end
end

Ri

courbureScalaire = 0;
for mu = 1:n
    for nu = 1:n
        courbureScalaire = courbureScalaire + ig(mu, nu) * Ri(mu, nu);
    end
end

courbureScalaire