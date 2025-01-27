syms x y u
eq1 = x * y * (1 - x);
eq2 = -1 / u * x * (1 - y);
equilibria = find_equilibria(eq1, eq2, .1)