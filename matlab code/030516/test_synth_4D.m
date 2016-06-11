function test_synth_4D(synth_set_size, iris)
% Generates 4D datasets from data that is:
%   - standard normal
%   - standard normal with mu=0, sigma = 1 and 1 cluster
%   - standard normal with mu and sigma from Iris and 1 cluster
%   - standard normal with equally-spaced mu, sigma = 1 and 3 clusters
% [incomplete]

% Iris stats
mu_iris = mean(iris);
sigma_iris = cov(iris);

%% 4D NORMAL DISTRIBUTION DATASETS
d4_std_sigma = ones(1, 4);

% 4D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=1 WITH ONE CLUSTER
d4_norm_one = mvnrnd([0,0,0,0], d4_std_sigma, synth_set_size);

% 4D NORMAL DISTRIBUTION WITH MU AND SIGMA FROM IRIS AND ONE CLUSTER
%d4_norm_one = randn(size(iris)) * sqrt(sigma_iris) + repmat(mu_iris, synth_set_size, 1)
d4_norm_iris_one = mvnrnd(mu_iris, sigma_iris, synth_set_size);

% 4D NORMAL DISTRIBUTION WITH EQUALLY-SPACED MU, SIGMA = 1 AND WITH THREE CLUSTERS
% Create three centrals points to use as means
% Draw 6 evenly-spaced points from a 2D circle and pair opposing points to
% make 3 4D points (dodgy, I know, but anyway)
points = zeros(6, 2);
radius = 3; % semi-arbitrary - sigma = 1 and I don't want them overlapping
theta = (pi*2)/6;
for i=1:6
    angle = theta*i;
    points(i, 1) = radius*cos(angle);
    points(i, 2) = radius*sin(angle);
end
mu_norm_three(1, :) = [points(1, :), points(2, :)];
mu_norm_three(2, :) = [points(3, :), points(4, :)];
mu_norm_three(3, :) = [points(5, :), points(6, :)];

d4_norm_three(1:50, :) = mvnrnd(mu_norm_three(1, :), d4_std_sigma, 50);
d4_norm_three(51:100, :) = mvnrnd(mu_norm_three(2, :), d4_std_sigma, 50);
d4_norm_three(101:synth_set_size, :) = mvnrnd(mu_norm_three(3, :), d4_std_sigma, 50);

% Randomise because kmeans_marcus inits the centroids as the first 3 data points
order = randperm(synth_set_size);
d4_norm_three = d4_norm_three(order, :);



end