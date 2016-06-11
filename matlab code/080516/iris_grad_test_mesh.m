function [results, err] = iris_grad_test(radius)
load fisheriris;
%X = meas;
X = meas(:, 1:2); % 2d version

%opt = [5.0057, 3.3698, 1.56047, 0.2906; 6.3010, 2.8866, 4.9588, 1.6959];
opt = [5.0057, 3.3698; 6.3010, 2.8866]; % 2d version
%opt_err = 152.35; % for 4d, idk for 2d
cases = 1 + 4*(radius^2);
results = zeros(cases, 8);
err = zeros(cases, 1);

mins = min(X);
maxes = max(X);

x_min = mins(1);
y_min = mins(2);
x_max = maxes(1);
y_max = maxes(2);

% Generate set of points in search space for each cluster by dividing the
% search space into four quadrants:
% q1 = x_min:opt(1,1) and y_min:opt(1,2)
% q2 = x_min:opt(1,1) and opt(1,2):y_min
% q3 = opt(1,1):x_max and y_min:opt(1,2)
% q4 = opt(1,1):x_max and opt(1,2):y_min
% Each quadrant has radius x radius points. I think.

% row vectors of radius linspaced points in quadrants bounded by relevant min or max and opt
c1_x_lower = linspace(x_min, opt(1, 1), radius);
c1_x_upper = linspace(opt(1,1), x_max, radius);
c1_y_lower = linspace(y_min, opt(1, 2), radius);
c1_y_upper = linspace(opt(1,2), y_max, radius);

c2_x_lower = linspace(x_min, opt(2, 1), radius);
c2_x_upper = linspace(opt(2,1), x_max, radius);
c2_y_lower = linspace(y_min, opt(2, 2), radius);
c2_y_upper = linspace(opt(2,2), y_max, radius);

% meshgrid of linspaced points
[c1_q1_x, c1_q1_y] = meshgrid(c1_x_lower, c1_y_lower);
[c1_q2_x, c1_q2_y] = meshgrid(c1_x_lower, c1_y_upper);
[c1_q3_x, c1_q3_y] = meshgrid(c1_x_upper, c1_y_lower);
[c1_q4_x, c1_q4_y] = meshgrid(c1_x_upper, c1_y_upper);

[c2_q1_x, c2_q1_y] = meshgrid(c2_x_lower, c2_y_lower);
[c2_q2_x, c2_q2_y] = meshgrid(c2_x_lower, c2_y_upper);
[c2_q3_x, c2_q3_y] = meshgrid(c2_x_upper, c2_y_lower);
[c2_q4_x, c2_q4_y] = meshgrid(c2_x_upper, c2_y_upper);

% all points in each quadrant
c1_q1 = [c1_q1_x(:), c1_q1_y(:)];
c1_q2 = [c1_q2_x(:), c1_q2_y(:)];
c1_q3 = [c1_q3_x(:), c1_q3_y(:)];
c1_q4 = [c1_q4_x(:), c1_q4_y(:)];

c2_q1 = [c2_q1_x(:), c2_q1_y(:)];
c2_q2 = [c2_q2_x(:), c2_q2_y(:)];
c2_q3 = [c2_q3_x(:), c2_q3_y(:)];
c2_q4 = [c2_q4_x(:), c2_q4_y(:)];

% optimal centroids plus combined points from all quadrants
c1_points = [opt(1, :); c1_q1; c1_q2; c1_q3; c1_q4];
c2_points = [opt(2, :); c2_q1; c2_q2; c2_q3; c2_q4];

size(c1_points)

% left = [-1, 0];
% right = [1, 0];
% up = [0, 1];
% down = [0, -1];
% dir = [left; right; up; down; up+left; up+right; down+left; down+right];

[~, err(1), recc, ~, ~] = kmeans_known_centers(X, 2, opt);
init = recc(:, :, 1);
last = recc(:, :, end);
results(1, 1:4) = [init(1, :), init(2, :)];
results(1, 5:8) = [last(1, :), last(2, :)];

for i=1:size(c1_points, 1)
    for j=1:size(c2_points, 1)
%     centers = repmat([opt(1:2), opt(3:4)], 8, 1);
%     centers(1, 1) = c1_x_lower(i);
%     centers(2, 2) = c1_y_lower(i);
%     centers(3, 3) = c2_x_lower(i);
%     centers(4, 4) = c2_y_lower(i);
%     centers(5, 1) = c1_x_upper(i);
%     centers(6, 2) = c1_y_upper(i);
%     centers(7, 3) = c2_x_upper(i);
%     centers(8, 4) = c2_y_upper(i);
%     for j=1:8
%         idx = (i-1)*8 + j + 1;
        idx = (i-1)*cases + j + 1;
        %sdisp('param: ')
        %disp(opt+(i*repmat(dir(j, :), 2, 1)))
%         [~, err(idx), recc, ~, ~] = kmeans_known_centers(X, 2, opt+((i/2)*repmat(dir(j, :), 2, 1)));
%         [~, err(idx), recc, ~, ~] = kmeans_known_centers(X, 2, [centers(j, 1:2); centers(j, 3:4)]);
        [~, err(idx), recc, ~, ~] = kmeans_known_centers(X, 2, [c1_points(i, :); c2_points(j, :)]);
        init = recc(:, :, 1);
        last = recc(:, :, end);
        results(idx, 1:4) = [init(1, :), init(2, :)];
        results(idx, 5:8) = [last(1, :), last(2, :)];
    end
end

size(results)

% For cluster 1
c1_init = results(:, 1:2);
c1_end = results(:, 5:6);
size(c1_end)
d1 = c1_end - c1_init;
size(d1)
h1 = quiver(c1_init(:, 1), c1_init(:, 2), d1(:, 1), d1(:, 2), 0, 'b');
hold on;


% For cluster 2
c2_init = results(:, 3:4);
c2_end = results(:, 7:8);
d2 = c2_end - c2_init;
h2 = quiver(c2_init(:, 1), c2_init(:, 2), d2(:, 1), d2(:, 2), 0, 'g');

hold off;


end