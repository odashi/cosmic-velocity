% calculate and plot CV1/CV2
function [min1, max1, min2, max2] = plotcv(n)
    [min2, max2] = numcv2(n, 1.0, 100.0);
    [min1, max1] = numcv1(n, 1.0, min2(n+1));
    i = 0:n;

    cv1 = sqrt(Env.G * Env.Me / Env.Re);
    cv2 = sqrt(2.0 * Env.G * Env.Me / Env.Re);

    figure;
    plot(i, min1, i, max1, i, cv1*ones(1,n+1));
    legend('Minimum', 'Maximum', 'CV1');
    xlabel('Step [times]');
    ylabel('Velocity [km/s]');

    figure;
    plot(i, min2, i, max2, i, cv2*ones(1,n+1));
    legend('Minimum', 'Maximum', 'CV2');
    xlabel('Step [times]');
    ylabel('Velocity [km/s]');
end