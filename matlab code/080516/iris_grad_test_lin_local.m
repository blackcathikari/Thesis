function [results, err] = iris_grad_test_lin_local(X, num_pts, epsilon)
% Creates a grid o num_pts x num_pts points using epsilon as the step-size
% around each optimal centroid, runs kmeans for each point and creates a
% quiver plot of the centroid movement.

%opt = [5.0057, 3.3698, 1.56047, 0.2906; 6.3010, 2.8866, 4.9588, 1.6959];
opt = [5.0057, 3.3698; 6.3010, 2.8866]; % 2d version
cases = 1 + num_pts*num_pts;
results = zeros(cases*cases, 8);
err = zeros(cases*cases, 1);

    function points = create_grid(opt, num_pts, epsilon)
        range = (num_pts*epsilon)/2;
        a_lin = linspace(opt(1) - range, opt(1) + range, num_pts);
        b_lin = linspace(opt(2) - range, opt(2) + range, num_pts);
        
        [a_points, b_points] = ndgrid(a_lin, b_lin);
        points = [a_points(:), b_points(:)];
        points = [opt; points];        
    end

c1_points = create_grid(opt(1, :), num_pts, epsilon);
c2_points = create_grid(opt(2, :), num_pts, epsilon);

for i=1:cases
    for j=1:cases
        idx = (i-1)*cases + j;
        [~, err(idx), recc, ~, ~] = kmeans_known_centers(X, 2, [c1_points(i, :); c2_points(j, :)]);
        init = recc(:, :, 1);
        last = recc(:, :, end);
        results(idx, 1:4) = [init(1, :), init(2, :)];
        results(idx, 5:8) = [last(1, :), last(2, :)];
    end
end

hold on;
plot(X(:, 1), X(:, 2), 'r.');
plot(opt(:, 1), opt(:, 2), 'k.', 'MarkerSize', 15);

% For cluster 1
c1_init = results(:, 1:2);
c1_end = results(:, 5:6);
d1 = c1_end - c1_init;
h1 = quiver(c1_init(:, 1), c1_init(:, 2), d1(:, 1), d1(:, 2), 0, 'b', 'ShowArrowHead', 'off');

% For cluster 2
c2_init = results(:, 3:4);
c2_end = results(:, 7:8);
d2 = c2_end - c2_init;
h2 = quiver(c2_init(:, 1), c2_init(:, 2), d2(:, 1), d2(:, 2), 0, 'g', 'ShowArrowHead', 'off');

hold off;


end