function plottest
    % generate earth's edge
    i = 0:0.01:2*pi+0.1;
    ex = Env.Re * cos(i);
    ey = Env.Re * sin(i);

    % simulation
    x0 = simu(7.0);
    x1 = simu(8.0);
    x2 = simu(9.0);
    x3 = simu(10.0);
    x4 = simu(11.0);
    x5 = simu(11.2);
    x6 = simu(11.5);
    x7 = simu(12.0);

    % plot
    plot(ex, ey, x0(1,:), x0(2,:), x1(1,:), x1(2,:), x2(1,:), x2(2,:), x3(1,:), x3(2,:), x4(1,:), x4(2,:), x5(1,:), x5(2,:), x6(1,:), x6(2,:), x7(1,:), x7(2,:));
    legend('Earth', 'vx0 = 7.0', 'vx0 = 8.0', 'vx0 = 9.0', 'vx0 = 9.0', 'vx0 = 10.0', 'vx0 = 11.2', 'vx0 = 11.5', 'vx0 = 12.0');
    axis([-15000, 25000, -25000, 15000], 'square');
    xlabel('x [km]');
    ylabel('y [km]');
end


function x = simu(vx0)
    x = Env.simu(vx0, 0, 100, 3000);
    x = [x(1,:); x(3,:)];