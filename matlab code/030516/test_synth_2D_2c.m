function results = test_synth_2D_2c(data_size)
% Generates 2D datasets of size data_size with 2 clusters, runs k-means on 
% them, then plots and returns the results.

results = cell(3,2);
c2_size = floor(data_size/2);

%% 2 CLUSTERS, MU X += [1,2,3,4]
diffm_x = cell(1, 4);

% 2D NORMAL DISTRIBUTION WITH 1-DISTRIBUTED XMU AND SIGMA=1 WITH TWO CLUSTERS
diffm_x1(1:c2_size, :) = mvnrnd([-1, 0], [1,1], c2_size);
diffm_x1(c2_size+1:data_size, :) = mvnrnd([1, 0], [1,1], c2_size);
diffm_x{1} = diffm_x1;

% 2D NORMAL DISTRIBUTION WITH 2-DISTRIBUTED XMU AND SIGMA=1 WITH TWO CLUSTERS
diffm_x2(1:c2_size, :) = mvnrnd([-2, 0], [1,1], c2_size);
diffm_x2(c2_size+1:data_size, :) = mvnrnd([2, 0], [1,1], c2_size);
diffm_x{2} = diffm_x2;

% 2D NORMAL DISTRIBUTION WITH 3-DISTRIBUTED XMU AND SIGMA=1 WITH TWO CLUSTERS
diffm_x3(1:c2_size, :) = mvnrnd([-3, 0], [1,1], c2_size);
diffm_x3(c2_size+1:data_size, :) = mvnrnd([3, 0], [1,1], c2_size);
diffm_x{3} = diffm_x3;

% 2D NORMAL DISTRIBUTION WITH 4-DISTRIBUTED XMU AND SIGMA=1 WITH TWO CLUSTERS
diffm_x4(1:c2_size, :) = mvnrnd([-4, 0], [1,1], c2_size);
diffm_x4(c2_size+1:data_size, :) = mvnrnd([4, 0], [1,1], c2_size);
diffm_x{4} = diffm_x4;

titles = num2cell(['Diff m, x=1'; 'Diff m, x=2'; 'Diff m, x=3'; 'Diff m, x=4'], 2);
plot_data_dist(diffm_x, 4, 2, titles);

diffm_x_results = cell_kmeans(diffm_x);
results{1, 1} = diffm_x;
results{1, 2} = diffm_x_results;


%% 2 CLUSTERS, MU Y += [1,2,3,4]
diffm_y = cell(1, 4);

% 2D NORMAL DISTRIBUTION WITH 1-DISTRIBUTED YMU AND SIGMA=1 WITH TWO CLUSTERS
diffm_y1(1:c2_size, :) = mvnrnd([0, -1], [1,1], c2_size);
diffm_y1(c2_size+1:data_size, :) = mvnrnd([0, 1], [1,1], c2_size);
diffm_y{1} = diffm_y1;

% 2D NORMAL DISTRIBUTION WITH 2-DISTRIBUTED YMU AND SIGMA=1 WITH TWO CLUSTERS
diffm_y2(1:c2_size, :) = mvnrnd([0, -2], [1,1], c2_size);
diffm_y2(c2_size+1:data_size, :) = mvnrnd([0, 2], [1,1], c2_size);
diffm_y{2} = diffm_y2;

% 2D NORMAL DISTRIBUTION WITH 3-DISTRIBUTED YMU AND SIGMA=1 WITH TWO CLUSTERS
diffm_y3(1:c2_size, :) = mvnrnd([0, -3], [1,1], c2_size);
diffm_y3(c2_size+1:data_size, :) = mvnrnd([0, 3], [1,1], c2_size);
diffm_y{3} = diffm_y3;

% 2D NORMAL DISTRIBUTION WITH 4-DISTRIBUTED YMU AND SIGMA=1 WITH TWO CLUSTERS
diffm_y4(1:c2_size, :) = mvnrnd([0, -4], [1,1], c2_size);
diffm_y4(c2_size+1:data_size, :) = mvnrnd([0, 4], [1,1], c2_size);
diffm_y{4} = diffm_y4;

titles = num2cell(['Diff m, y=1'; 'Diff m, y=2'; 'Diff m, y=3'; 'Diff m, y=4'], 2);
plot_data_dist(diffm_y, 4, 2, titles);

diffm_y_results = cell_kmeans(diffm_y);
results{2, 1} = diffm_y;
results{2, 2} = diffm_y_results;


%% 2 CLUSTERS, EQUAL MU = [1,2,3,4]
diffm = cell(1, 4);

% 2D NORMAL DISTRIBUTION WITH 1-DISTRIBUTED MU AND SIGMA=1 WITH TWO CLUSTERS
diffm_1(1:c2_size, :) = mvnrnd([-1, -1], [1,1], c2_size);
diffm_1(c2_size+1:data_size, :) = mvnrnd([1, 1], [1,1], c2_size);
diffm{1} = diffm_1;

% 2D NORMAL DISTRIBUTION WITH 2-DISTRIBUTED MU AND SIGMA=1 WITH TWO CLUSTERS
diffm_2(1:c2_size, :) = mvnrnd([-2, -2], [1,1], c2_size);
diffm_2(c2_size+1:data_size, :) = mvnrnd([2, 2], [1,1], c2_size);
diffm{2} = diffm_2;

% 2D NORMAL DISTRIBUTION WITH 3-DISTRIBUTED MU AND SIGMA=1 WITH TWO CLUSTERS
diffm_3(1:c2_size, :) = mvnrnd([-3, -3], [1,1], c2_size);
diffm_3(c2_size+1:data_size, :) = mvnrnd([3, 3], [1,1], c2_size);
diffm{3} = diffm_3;

% 2D NORMAL DISTRIBUTION WITH 4-DISTRIBUTED MU AND SIGMA=1 WITH TWO CLUSTERS
diffm_4(1:c2_size, :) = mvnrnd([-4, -4], [1,1], c2_size);
diffm_4(c2_size+1:data_size, :) = mvnrnd([4, 4], [1,1], c2_size);
diffm{4} = diffm_4;

titles = num2cell(['Diff m=1'; 'Diff m=2'; 'Diff m=3'; 'Diff m=4'], 2);
plot_data_dist(diffm, 4, 2, titles);

diffm_results = cell_kmeans(diffm);
results{3, 1} = diffm;
results{3, 2} = diffm_results;


end