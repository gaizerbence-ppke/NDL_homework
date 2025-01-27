u = 1;
anonFun = @(t, x)[x(2);...
                  -x(1) + u * (1 - x(1) ^ 2) * x(2)];

%anonFun = @(t, x)[x(1) - x(2);...
%                  x(1) ^ 2 - 1];

check_for_limit_cycle(anonFun, [0.5, 0.5], 100);