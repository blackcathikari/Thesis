Folders:

030516
	- pca(X, k) - Applies PCA to reduce X to k dimensions
	- plot_data_dist(data, num_sets, dim, titles) - Plots the num_sets sets of data and results in data using the given titles. dim is used to specify how things should be plotted in certain sections of the following code. [Deprecated?]
	- test - loads a bunch of datasets and runs test_synth_2D_1c, test_synth_2D_2c, test_synth_2D_3c, test_synth_2D_4c [incomplete]
	- test_synth_2D_1c(data_size) - generates 2D datasets of size data_size with 1 cluster, runs k-means on them, then plots and returns the results.
	- test_synth_2D_2c(data_size) - generates 2D datasets of size data_size with 2 clusters, runs k-means on them, then plots and returns the results.
	- test_synth_2D_3c(data_size) - generates 2D datasets of size data_size with 3 clusters, runs k-means on them, then plots and returns the results.
	- test_synth_2D_4c(data_size) - generates 2D datasets of size data_size with 4 clusters, runs k-means on them, then plots and returns the results.
	- test_synth_4D(synth_set_size, iris) - Generates 4D datasets from data that is, standard normal, standard normal with mu=0, sigma = 1 and 1 cluster, standard normal with mu and sigma from Iris and 1 cluster, and standard normal with equally-spaced mu, sigma = 1 and 3 clusters. [incomplete]
	
050516
	- gen_gauss_sym_nsph_2c(mu, s, n) - Generates a mixture distribution of 2 symmetric, non-spherical Gaussians using the given n, mu and s values and centered at the origin.
	- gen_gauss_sym_sph_2c(mu, s, n) - Generates a mixture distribution of 2 symmetric, spherical Gaussians using the given n, mu and s values and centered at the origin.
	- plot_data_dist(data, num_sets, link, titles, bins, fig_file, fig_names) - more complicated version of the file in 030516
	- test_gauss_sym_sph_2c(n_min, n_max, n_interval, m_vals) - Generates 3 2D mixtures of 2 symmetric, spherical Gaussians centered at the origin for each n_min:n_interval:n_max using the three m_vals values for the mean x and 0 for mean y, runs kmeans on them then plots the data, data boxplots, data histograms, pdist histograms and kmeans error plots for each.