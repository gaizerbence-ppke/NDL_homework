function equilibria = find_equilibria(eq1, eq2, u_val)
    syms x y u
    E = solve([eq1 == 0, eq2 == 0, u == u_val], [x, y, u]);

    J = jacobian([eq1, eq2], [x, y]);

    clear equilibria
    numInvalid = 0;
    for iter = 1:numel(E.x)
        if (imag(E.x(iter)) ~= 0) || (imag(E.y(iter)) ~= 0)
            numInvalid = numInvalid + 1;
            continue
        end
        currEq.x = double(E.x(iter));
        currEq.y = double(E.y(iter));

        currEq.J = double(subs(J, [x, y, u], [currEq.x, currEq.y, u_val]));
        [currEq.eigenvectors, currEq.eigenvalues] = eig(currEq.J);
        currEq.eigenvalues = currEq.eigenvalues * ones(2, 1);
        
        currEq.stability = "unknown";
        currEq.rotation = "unknown";

        if all(real(currEq.eigenvalues) > 0)
            currEq.stability = "unstable";
        elseif any(real(currEq.eigenvalues) > 0) && any(real(currEq.eigenvalues) < 0)
            currEq.stability = "saddle";
        else
            currEq.stability = "stable";
        end

        if any(imag(currEq.eigenvalues) ~= 0)
            currEq.rotation = "focus";
        else
            currEq.rotation = "node";
        end
        
        equilibria(iter - numInvalid) = currEq;
    end
    if exist("equilibria") == 0
        equilibria = [];
    end
end