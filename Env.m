classdef Env
    
    % environmental constants
    properties (Constant)
        G = 6.674e-20; % gravitational constant
        Me = 5.972e24; % Earth's weight
        Re = 6.378e3; % Earth's radius (Equator)
        x0 = 0; % initial X of a satellite
        y0 = 6.378e3 + 0.001; % initial Y of a satellite
        
        % differential coefficient
        A = [0,1,0,0; 0,0,0,0; 0,0,0,1; 0,0,0,0];
    end
    
    methods (Static = true)
        
        % simulation by constant steps
        function x = simu(vx0, vy0, h, n)
            fprintf('abs(v) = %f\n', sqrt(vx0*vx0 + vy0*vy0));
            xx = [Env.x0; vx0; Env.y0; vy0];
            x = [xx,zeros(4,n-1)];

            for i = 2:n
                xx = xx + Env.rungekutta(xx, h);
                x(:,i) = xx;
            end
        end
        
        % judgement of 1st cosmic velocity
        function judge = cv1(vx0, h)
            fprintf('EV1: vx0 = %f ... ', vx0);
            xx = [Env.x0; vx0; Env.y0; 0.0];
            judge = true;
            while xx(1) >= 0.0
                xx = xx + Env.rungekutta(xx, h);
                if (xx(1)^2+xx(3)^2 < Env.Re^2)
                    judge = false;
                    break;
                end
            end
            if judge
                fprintf('true\n');
            else
                fprintf('false\n');
            end
        end
        
        % judgement of 2nd cosmic velocity
        function judge = cv2(vx0, h)
            limit = 1000*Env.Re;
            fprintf('EV2: vx0 = %f ... ', vx0);
            xx = [Env.x0; vx0; Env.y0; 0.0];
            judge = true;
            while xx(1)^2+xx(3)^2 < limit^2
                xx = xx + Env.rungekutta(xx, h);
                if (xx(2) < 0.0)
                    judge = false;
                    break;
                end
            end
            if judge
                fprintf('true\n');
            else
                fprintf('false\n');
            end
        end
        
        % Runge-Kutta coefficient
        function k = rungekutta(x, h)
            k1 = h*Env.euler(x);
            k2 = h*Env.euler(x + 0.5*k1);
            k3 = h*Env.euler(x + 0.5*k2);
            k4 = h*Env.euler(x + k3);
            k = (k1 + 2*k2 + 2*k3 + k4) / 6;
        end
        
        % Euler coefficient (divided by h)
        function k = euler(x)
            k = Env.A*x + Env.accel(x);
        end

        % acceleration
        function a = accel(x)
            xx = [x(1);x(3)];
            r2 = dot(xx,xx);
            r = sqrt(r2);
            aa = -Env.G * Env.Me / r2;
            xx = aa*xx / r;
            a = [0;xx(1);0;xx(2)];
        end
    end
end


