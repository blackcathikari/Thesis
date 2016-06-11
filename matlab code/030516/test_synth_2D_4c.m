function results = test_synth_2D_4c(synth_set_size)
% Generates 2D datasets of size data_size with 4 clusters, runs k-means on 
% them, then plots and returns the results.

results = cell(3,2);
c4_size = floor(synth_set_size/4);

%% 4 CLUSTERS, MU += [1,2,3,4] 
diffm = cell(1, 4);

% 2D NORMAL DISTRIBUTION WITH 1-DISTRIBUTED MU AND SIGMA=1 WITH FOUR CLUSTERS
diffm_1(1:c4_size, :) = mvnrnd([-1, 0], [1,1], c4_size);
diffm_1(c4_size+1:c4_size*2, :) = mvnrnd([1, 0], [1,1], c4_size);
diffm_1((c4_size*2)+1:c4_size*3, :) = mvnrnd([0, -1], [1,1], c4_size);
diffm_1((c4_size*3)+1:c4_size*4, :) = mvnrnd([0, 1], [1,1], c4_size);
diffm{1} = diffm_1;

% 2D NORMAL DISTRIBUTION WITH 2-DISTRIBUTED MU AND SIGMA=1 WITH FOUR CLUSTERS
diffm_2(1:c4_size, :) = mvnrnd([-2, 0], [1,1], c4_size);
diffm_2(c4_size+1:c4_size*2, :) = mvnrnd([2, 0], [1,1], c4_size);
diffm_2((c4_size*2)+1:c4_size*3, :) = mvnrnd([0, -2], [1,1], c4_size);
diffm_2((c4_size*3)+1:c4_size*4, :) = mvnrnd([0, 2], [1,1], c4_size);
diffm{2} = diffm_2;

% 2D NORMAL DISTRIBUTION WITH 3-DISTRIBUTED MU AND SIGMA=1 WITH FOUR CLUSTERS
diffm_3(1:c4_size, :) = mvnrnd([-3, 0], [1,1], c4_size);
diffm_3(c4_size+1:c4_size*2, :) = mvnrnd([3, 0], [1,1], c4_size);
diffm_3((c4_size*2)+1:c4_size*3, :) = mvnrnd([0, -3], [1,1], c4_size);
diffm_3((c4_size*3)+1:c4_size*4, :) = mvnrnd([0, 3], [1,1], c4_size);
diffm{3} = diffm_3;

% 2D NORMAL DISTRIBUTION WITH 4-DISTRIBUTED MU AND SIGMA=1 WITH FOUR CLUSTERS
diffm_4(1:c4_size, :) = mvnrnd([-4, 0], [1,1], c4_size);
diffm_4(c4_size+1:c4_size*2, :) = mvnrnd([4, 0], [1,1], c4_size);
diffm_4((c4_size*2)+1:c4_size*3, :) = mvnrnd([0, -4], [1,1], c4_size);
diffm_4((c4_size*3)+1:c4_size*4, :) = mvnrnd([0, 4], [1,1], c4_size);
diffm{4} = diffm_4;

% Plot graphs - data, boxplot, data histogram, pdist histogram
titles = num2cell(['Diff m=1'; 'Diff m=2'; 'Diff m=3'; 'Diff m=4'], 2);
plot_data_dist(diffm, 4, 2, titles);

% Run kmeans and return results + dataset
km_results = cell_kmeans(diffm);
results{1, 1} = diffm;
results{1, 2} = km_results;

%% UNIT DISTRIBUTED MU AND SIGMA = [1,2,3,4]
diffs_um = cell(1, 4);

% 2D NORMAL DISTRIBUTION WITH UNIT DISTRIBUTED MU AND SIGMA=1 WITH FOUR CLUSTERS
diffs_1_um(1:c4_size, :) = mvnrnd([-1, 0], [1,1], c4_size);
diffs_1_um(c4_size+1:c4_size*2, :) = mvnrnd([1, 0], [1,1], c4_size);
diffs_1_um((c4_size*2)+1:c4_size*3, :) = mvnrnd([0, -1], [1,1], c4_size);
diffs_1_um((c4_size*3)+1:c4_size*4, :) = mvnrnd([0, 1], [1,1], c4_size);
diffs_um{1} = diffs_1_um;

% 2D NORMAL DISTRIBUTION WITH UNIT DISTRIBUTED MU AND SIGMA=2 WITH FOUR CLUSTERS
diffs_2_um(1:c4_size, :) = mvnrnd([-2, 0], [2,2], c4_size);
diffs_2_um(c4_size+1:c4_size*2, :) = mvnrnd([2, 0], [2,2], c4_size);
diffs_2_um((c4_size*2)+1:c4_size*3, :) = mvnrnd([0, -2], [2,2], c4_size);
diffs_2_um((c4_size*3)+1:c4_size*4, :) = mvnrnd([0, 2], [2,2], c4_size);
diffs_um{2} = diffs_2_um;

% 2D NORMAL DISTRIBUTION WITH UNIT DISTRIBUTED MU AND SIGMA=3 WITH FOUR CLUSTERS
diffs_3_um(1:c4_size, :) = mvnrnd([-3, 0], [3,3], c4_size);
diffs_3_um(c4_size+1:c4_size*2, :) = mvnrnd([3, 0], [3,3], c4_size);
diffs_3_um((c4_size*2)+1:c4_size*3, :) = mvnrnd([0, -3], [3,3], c4_size);
diffs_3_um((c4_size*3)+1:c4_size*4, :) = mvnrnd([0, 3], [3,3], c4_size);
diffs_um{3} = diffs_3_um;

% 2D NORMAL DISTRIBUTION WITH UNIT DISTRIBUTED MU AND SIGMA=4 WITH FOUR CLUSTERS
diffs_4_um(1:c4_size, :) = mvnrnd([-4, 0], [4,4], c4_size);
diffs_4_um(c4_size+1:c4_size*2, :) = mvnrnd([4, 0], [4,4], c4_size);
diffs_4_um((c4_size*2)+1:c4_size*3, :) = mvnrnd([0, -4], [4,4], c4_size);
diffs_4_um((c4_size*3)+1:c4_size*4, :) = mvnrnd([0, 4], [4,4], c4_size);
diffs_um{4} = diffs_4_um;

% Plot graphs - data, boxplot, data histogram, pdist histogram
titles = num2cell(['Diff s=1, m=1'; 'Diff s=2, m=1'; 'Diff s=3, m=1'; 'Diff s=4, m=1'], 2);
plot_data_dist(diffs_um, 4, 2, titles);

% Run kmeans and return results + dataset
km_results = cell_kmeans(diffs_um);
results{2, 1} = diffs_um;
results{2, 2} = km_results;

%% 4*UNIT DISTRIBUTED MU AND SIGMA = [1,2,3,4]
diffs_4m = cell(1, 4);

% 2D NORMAL DISTRIBUTION WITH 4*UNIT DISTRIBUTED MU AND SIGMA=1 WITH FOUR CLUSTERS
diffs_1_4m(1:c4_size, :) = mvnrnd([-4, 0], [1,1], c4_size);
diffs_1_4m(c4_size+1:c4_size*2, :) = mvnrnd([4, 0], [1,1], c4_size);
diffs_1_4m((c4_size*2)+1:c4_size*3, :) = mvnrnd([0, -4], [1,1], c4_size);
diffs_1_4m((c4_size*3)+1:c4_size*4, :) = mvnrnd([0, 4], [1,1], c4_size);
diffs_4m{1} = diffs_1_4m;

% 2D NORMAL DISTRIBUTION WITH 4*UNIT DISTRIBUTED MU AND SIGMA=2 WITH FOUR CLUSTERS
diffs_2_4m(1:c4_size, :) = mvnrnd([-2, 0], [2,2], c4_size);
diffs_2_4m(c4_size+1:c4_size*2, :) = mvnrnd([2, 0], [2,2], c4_size);
diffs_2_4m((c4_size*2)+1:c4_size*3, :) = mvnrnd([0, -2], [2,2], c4_size);
diffs_2_4m((c4_size*3)+1:c4_size*4, :) = mvnrnd([0, 2], [2,2], c4_size);
diffs_4m{2} = diffs_2_4m;

% 2D NORMAL DISTRIBUTION WITH 4*UNIT DISTRIBUTED MU AND SIGMA=3 WITH FOUR CLUSTERS
diffs_3_4m(1:c4_size, :) = mvnrnd([-3, 0], [3,3], c4_size);
diffs_3_4m(c4_size+1:c4_size*2, :) = mvnrnd([3, 0], [3,3], c4_size);
diffs_3_4m((c4_size*2)+1:c4_size*3, :) = mvnrnd([0, -3], [3,3], c4_size);
diffs_3_4m((c4_size*3)+1:c4_size*4, :) = mvnrnd([0, 3], [3,3], c4_size);
diffs_4m{3} = diffs_3_4m;

% 2D NORMAL DISTRIBUTION WITH 4*UNIT DISTRIBUTED MU AND SIGMA=4 WITH FOUR CLUSTERS
diffs_4_4m(1:c4_size, :) = mvnrnd([-4, 0], [4,4], c4_size);
diffs_4_4m(c4_size+1:c4_size*2, :) = mvnrnd([4, 0], [4,4], c4_size);
diffs_4_4m((c4_size*2)+1:c4_size*3, :) = mvnrnd([0, -4], [4,4], c4_size);
diffs_4_4m((c4_size*3)+1:c4_size*4, :) = mvnrnd([0, 4], [4,4], c4_size);
diffs_4m{4} = diffs_4_4m;

% Plot graphs - data, boxplot, data histogram, pdist histogram
titles = num2cell(['Diff s=1, m=4'; 'Diff s=2, m=4'; 'Diff s=3, m=4'; 'Diff s=4, m=4'], 2);
plot_data_dist(diffs_4m, 4, 2, titles);

% Run kmeans and return results + dataset
km_results = cell_kmeans(diffs_4m);
results{3, 1} = diffs_4m;
results{3, 2} = km_results;


end