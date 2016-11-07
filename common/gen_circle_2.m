function [X] = gen_circle_2(n, radius, mu)

% Generate data
xc1 = mu; 
xc2 = -mu;
yc = 0; % centered on origin

theta = rand(1, floor(n/2)).*(2*pi);

r1 = sqrt(rand(1, floor(n/2)))*radius;
x1 = xc1 + r1.*cos(theta);
y1 = yc + r1.*sin(theta);

r2 = sqrt(rand(1, floor(n/2)))*radius;
x2 = xc2 + r2.*cos(theta);
y2 = yc + r2.*sin(theta);

X = [x1', y1'; x2', y2'];
X = X(randperm(n), :);

% Plot the data
figure;
plot(x1', y1', 'b.');
hold on;
plot(x2', y2', 'g.');
xlabel('x');
ylabel('y');

end