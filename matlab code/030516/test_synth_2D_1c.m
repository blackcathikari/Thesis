function results = test_synth_2D_1c(data_size)
% Generates 2D datasets of size data_size with 1 cluster, runs k-means on 
% them, then plots and returns the results.

results = cell(3,2);

%% EQUAL SIGMA
eqs = cell(1, 4);

% 2D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=1 WITH ONE CLUSTER
eqs_s1 = mvnrnd([0,0], [1,1], data_size);
eqs{1} = eqs_s1;

% 2D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=2 WITH ONE CLUSTER
eqs_s2 = mvnrnd([0,0], [2,2], data_size);
eqs{2} = eqs_s2;

% 2D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=3 WITH ONE CLUSTER
eqs_s3 = mvnrnd([0,0], [3,3], data_size);
eqs{3} = eqs_s3;

% 2D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=4 WITH ONE CLUSTER
eqs_s4 = mvnrnd([0,0], [4,4], data_size);
eqs{4} = eqs_s4;

titles = num2cell(['Equal s=1'; 'Equal s=2'; 'Equal s=3'; 'Equal s=4'], 2);
plot_data_dist(eqs, 4, 2, titles);

km_results = cell_kmeans(eqs);
results{1, 1} = eqs;
results{1, 2} = km_results;


%% DIFF SIGMA - CHANGING Y RANGE
diffs_y = cell(1, 4);

% 2D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=[1,1] WITH ONE CLUSTER
diffs_y1 = mvnrnd([0,0], [1,1], data_size);
diffs_y{1} = diffs_y1;

% 2D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=[1,2] WITH ONE CLUSTER
diffs_y2 = mvnrnd([0,0], [1,2], data_size);
diffs_y{2} = diffs_y2;

% 2D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=[1,3] WITH ONE CLUSTER
diffs_y3 = mvnrnd([0,0], [1,3], data_size);
diffs_y{3} = diffs_y3;

% 2D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=[1,4] WITH ONE CLUSTER
diffs_y4 = mvnrnd([0,0], [1,4], data_size);
diffs_y{4} = diffs_y4;

titles = num2cell(['Diff s, y=1'; 'Diff s, y=2'; 'Diff s, y=3'; 'Diff s, y=4'], 2);
plot_data_dist(diffs_y, 4, 2, titles);

km_results = cell_kmeans(diffs_y);
results{2, 1} = diffs_y;
results{2, 2} = km_results;


%% DIFF SIGMA - CHANGING X RANGE
diffs_x = cell(1, 4);

% 2D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=[1,1] WITH ONE CLUSTER
diffs_x1 = mvnrnd([0,0], [1,1], data_size);
diffs_x{1} = diffs_x1;

% 2D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=[2,1] WITH ONE CLUSTER
diffs_x2 = mvnrnd([0,0], [2,1], data_size);
diffs_x{2} = diffs_x2;

% 2D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=[3,1] WITH ONE CLUSTER
diffs_x3 = mvnrnd([0,0], [3,1], data_size);
diffs_x{3} = diffs_x3;

% 2D STANDARD NORMAL DISTRIBUTION WITH MU=0 AND SIGMA=[4,1] WITH ONE CLUSTER
diffs_x4 = mvnrnd([0,0], [4,1], data_size);
diffs_x{4} = diffs_x4;

titles = num2cell(['Diff s, x=1'; 'Diff s, x=2'; 'Diff s, x=3'; 'Diff s, x=4'], 2);
plot_data_dist(diffs_x, 4, 2, titles);

km_results = cell_kmeans(diffs_x);
results{3, 1} = diffs_x;
results{3, 2} = km_results;


end