function test_gauss_sym_sph_2c(n_min, n_max, n_interval, m_vals)
% Generates 3 2D mixtures of 2 symmetric, spherical Gaussians centered at 
% the origin for each n_min:n_interval:n_max using the three m_vals values 
% for the mean x and 0 for mean y, runs kmeans on them then plots the data, 
% data boxplots, data histograms, pdist histograms and kmeans error plots 
% for each.
%   - n_min = scalar, minimum number of points per cluster
%   - n_max = scalar, maximum number of points per cluster
%   - n_interval = scalar, cluster size step value
%   - m_vals = 3 x 1 vector, mean x values for the 3 trials
% Note: only takes 3 m_vals because more makes the plots unreadable.
% Example: > test_gauss_sym_sph_2c(100, 200, 100, [2,4,6])

% Minimum, maximum and interval values for n (number of datapoints).
ns = (n_max-n_min)/n_interval + 1;

% Cell array of datasets and results
datasets = cell(3*ns, 2);
titles = cell(3*ns, 2);

% Iterate through n values, running s and mu for each n
for n = 1:ns
    num = n_min + (n-1)*n_interval;
    idx = 3*(n-1) + 1;
    datasets{idx} = gen_gauss_sym_sph_2c([m_vals(1), 0], 2, num);   
    titles{idx} = strcat(['2, [' num2str(m_vals(1)) ', 0], ' num2str(num)]);
    datasets{idx+1} = gen_gauss_sym_sph_2c([m_vals(2), 0], 2, num);
    titles{idx+1} = strcat(['2, [' num2str(m_vals(2)) ', 0], ' num2str(num)]);
    datasets{idx+2} = gen_gauss_sym_sph_2c([m_vals(3), 0], 2, num);
    titles{idx+2} = strcat(['2, [' num2str(m_vals(3)) ', 0], ' num2str(num)]);
end

type = strcat(['2_GSS2c_' num2str(m_vals(1)) ' ' num2str(m_vals(2)) ' ' num2str(m_vals(3)) '_0_']);
fig_names = strcat(repmat(type, ns, 1), num2str(linspace(n_min, n_max, ns)'));
fig_file = strcat(['2_GSS2c_' num2str(m_vals(1)) ' ' num2str(m_vals(2)) ' ' num2str(m_vals(3)) '_0_' num2str(n_min) ' ' num2str(n_max) ' ' num2str(n_interval)]);

plot_data_dist(datasets, 3*ns, 2, num2cell(titles, 2), 50, fig_file, fig_names);




end