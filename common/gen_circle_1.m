function [X] = gen_circle_1(n, radius)

% Generate data
xc = 0; % centered on origin
yc = 0;
theta = rand(1, n).*(2*pi);
r = sqrt(rand(1, n))*radius;
x = xc + r.*cos(theta);
y = yc + r.*sin(theta);
X = [x', y'];

% Plot the data
figure;
plot(X(:, 1), X(:, 2), 'b.');
hold on;
xlabel('x');
ylabel('y');

end