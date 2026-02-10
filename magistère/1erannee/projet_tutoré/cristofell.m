n = 2;

x = sym("x", [1 n])


%Rentre la métrique ici
g = [1, 0;0, x(1)^2]

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
            Gamma(gamma, alpha, beta) = simplify(tmp0);
        end
    end
end


Gamma

gd = det(g);

Ri = g;

for mu = 1:n
    for nu = 1:n
        tmp1 = 0;
        tmp2 = 0;
        tmp3 = 0;
        for alpha = 1:n
            tmp1 = tmp1 + diff(Gamma(alpha, mu, nu), x(alpha));
            tmp3 = tmp3 + Gamma(alpha, mu, nu) * diff(log(sqrt(-gd)), x(alpha));
            for beta = 1:n
                tmp2 = tmp2 + Gamma(beta, alpha, mu) * Gamma(alpha, beta, nu);
            end
        end
        Ri(mu,nu) = simplify(- diff(diff(log(sqrt(-gd)),x(nu)), (mu)) + tmp1 - tmp2);
    end
end

Ri

