function pt = point_gen_3_equal(num) 
% Takes coords for 2 points in 2D e.g. [1, 0;, -1, 0] and returns a third
% point that forms an equilateral triangle with those points, for use as mu

points = [-num, 0; num, 0];
d = pdist(points);
h = (sqrt(3)/2)*d;
l = h*cos(pi/4);
pt = [-l, l];
mu = [points; pt];
check = pdist(mu);
if(~all(check == check(1)))
    pt = [l, l];
    mu = [points; pt];
    check = pdist(mu);
    if(~all(check == check(1)))
        pt = [l, -l];
        mu = [points; pt];
        check = pdist(mu);
        if(~all(check == check(1)))
            pt = [-l, -l];
            mu = [points; pt];
            check = pdist(mu);
        end
    end
end

end