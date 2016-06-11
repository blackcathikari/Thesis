function data = gen_gauss_sym_sph_2c(mu, s, n)
% Generates a mixture distribution of 2 symmetric, spherical Gaussians
% using the given n, mu and s values and centered at the origin.
% To generate an n by d dataset with Gaussians g1 and g2:
%   - mu = 1 by 2 vector, mu of g1 = mu, mu of g2 = -mu.
%   - s = scalar, s of g1 and g2 = [s, s]
%   - n = scalar, total number of points in resulting dataset
% Notes:
%   - g_n is the number of data points in each Gaussian - if n is even, g_n is
% n/2, if n is odd g_n = (n-1)/2 so the total data points in the resulting
% dataset is n-1.

g_n = floor(n/2);

g1 = mvnrnd(mu, [s, s], g_n);
g2 = mvnrnd(-mu, [s, s], g_n);

data = [g1; g2];

end