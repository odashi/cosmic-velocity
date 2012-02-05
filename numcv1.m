function [min, max] = numcv1(n, infx, supx)
    minx = infx;
    maxx = supx;

    min = [minx, zeros(1, n)];
    max = [maxx, zeros(1, n)];

    for i = 1:n
        fprintf('%d: max = %f, min = %f\n', i, maxx, minx);
        midx = 0.5*(maxx+minx);
        if Env.cv1(midx, 100)
            maxx = midx;
        else
            minx = midx;
        end
        min(i+1) = minx;
        max(i+1) = maxx;
    end
end