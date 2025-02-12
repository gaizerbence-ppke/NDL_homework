function cycle = check_for_limit_cycle(dFun, origin, T)
    [solT, X] = ode45(dFun, [0 T], origin);
    samples = 1000;
    
    T_full = 0:(T / samples):T;
    T_half = 0:(T / 2 / samples):(T / 2);
    fullSample = interp1(solT, X, T_full);
    halfSample = interp1(solT, X, T_half);

    % subplot(3, 1, 1)
    % plot(T_half, halfSample)
    % subplot(3, 1, 2)
    % plot(T_full, fullSample)
    % 
    % subplot(3, 1, 3)
    autoRegDiff = fullSample - halfSample;
    autoDist = sqrt(sum(autoRegDiff'.^2));
    %plot(T_half, autoDist)
    autoCorr = xcorr(autoDist, autoDist, "normalized");
    autoCorr = autoCorr((samples + 1):end);
    [allPeaks, peakLocs, ~] = findpeaks(autoCorr);
    cycle = [];
    if (length(allPeaks) < 2)
        return;
    end
    period = peakLocs(2);

    cycle = halfSample((end - period):end, :);
end