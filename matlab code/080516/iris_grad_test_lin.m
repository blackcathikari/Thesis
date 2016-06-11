function [results, err] = iris_grad_test_lin(radius)
load fisheriris;
%X = meas;
X = meas(:, 1:2); % 2d version

%opt = [5.0057, 3.3698, 1.56047, 0.2906; 6.3010, 2.8866, 4.9588, 1.6959];
opt = [5.0057, 3.3698; 6.3010, 2.8866]; % 2d version
%opt_err = 152.35; % for 4d, idk for 2d
cases = 1 + radius*radius;
results = zeros(cases*cases, 8);
err = zeros(cases*cases, 1);

mins = min(X);
maxes = max(X);

x_min = mins(1);
y_min = mins(2);
x_max = maxes(1);
y_max = maxes(2);

x_lin = linspace(x_min, x_max, radius);
y_lin = linspace(y_min, y_max, radius);

[x_points, y_points] = meshgrid(x_lin, y_lin);

c1_points = [x_points(:), y_points(:)];
c2_points = [opt(2, :); c1_points];
c1_points = [opt(1, :); c1_points];
size(c1_points)
size(c2_points)

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

% For cluster 1

c1_init = results(:, 1:2);
c1_end = results(:, 5:6);
d1 = c1_end - c1_init;
h1 = quiver(c1_init(:, 1), c1_init(:, 2), d1(:, 1), d1(:, 2), 0, 'b');
hold on;


% For cluster 2
c2_init = results(:, 3:4);
c2_end = results(:, 7:8);
d2 = c2_end - c2_init;
h2 = quiver(c2_init(:, 1), c2_init(:, 2), d2(:, 1), d2(:, 2), 0, 'g');

hold off;


end