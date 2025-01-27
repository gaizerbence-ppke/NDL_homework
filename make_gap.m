function [minval, maxval] = make_gap(minvalin, maxvalin)
    minval = minvalin;
    maxval = maxvalin;
    if minvalin == maxval
        if (minval == 0)
            minval = -1;
            maxval = 10;
        else
            minval = min(0, minval);
            maxval = max(0, maxval);
            dist = maxval - minval;
            minval = minval - dist / 2;
            maxval = maxval + dist / 2;
        end
    end
    dist = maxval - minval;
    minval = minval - dist / 2;
    maxval = maxval + dist / 2;
end