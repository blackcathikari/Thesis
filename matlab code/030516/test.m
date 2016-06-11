function test

close all;

%% GLOBALS
synth_set_size = 240; % use avg of real dataset sizes? should be %[2,3,4]==0, so multiple of 12 is good.


%% REAL DATASETS

num_reals = 9;
reals_1 = cell(1, 3);
reals_2 = cell(1, 3);
reals_3 = cell(1, 3);
titles_1 = cell(3, 1);
titles_2 = cell(3, 1);
titles_3 = cell(3, 1);

% IRIS
% From Matlab
load fisheriris;
iris = meas;
% iris_y = ones(150, 1);
% iris_y(51:100) = 2;
% iris_y(101:synth_set_size) = 3;
reals_1{1} = iris;
titles_1{1} = 'Iris';

% RUSPINI
% From realopt.uqcloud.net/ess_clustering.html
rusp = importdata('ruspini.mat');
reals_1{2} = rusp;
titles_1{2} = 'Ruspini';

% SPATH
% From realopt.uqcloud.net/ess_clustering.html
spath = importdata('spath.mat');
reals_1{3} = spath;
titles_1{3} = 'Spath';

% WHOLESALE 
% From UCI - http://archive.ics.uci.edu/ml/datasets/Wholesale+customers
% Full dataset:
ws_8 = importdata('wholesale.csv');
reals_2{1} = ws_8;
titles_2{1} = 'Wholesale (8 vars)';

% Partial dataset - only using first 6 of 8 attributes because the last 2 
% are classes (channel and region). May make a difference to the results?
ws_6 = ws_8(:, 1:6);
reals_2{2} = ws_6;
titles_2{2} = 'Wholesale (6 vars)';

% CLOUD
% From http://archive.ics.uci.edu/ml/datasets/Cloud
cloud = importdata('cloud.data');
reals_2{3} = cloud;
titles_2{3} = 'Cloud';

% INTRUSION - NOT USING BECAUSE TOO BIG, NOT VERY USEFUL RESULTS FROM 
% FIRST 20K POINTS
% % From http://archive.ics.uci.edu/ml/datasets/KDD+Cup+1999+Data
% % Using the 10% dataset because Matlab on my laptop won't load the full one
% % - it's too big. Note that vars 20 and 21 are 0 for all values (binary
% % attributes). Var 2 was converted to [1,2,3] from [tcp, udp, icmp] and
% % vars 3,4 and 42 were removed because they were symbolic and annoying to
% % convert to digits. May do that later.
% % Also only using the first 4000 points because Matlab can't deal with 400k.
% kdd = csvread('kddcup_data_10_edit.csv', 0, 0, [0, 0, 19999, 38]);
% reals_3{1} = kdd;
% titles_3{1} = 'KDD Intrusion';

% OPTDIGITS
% From http://archive.ics.uci.edu/ml/datasets/Optical+Recognition+of+Handwritten+Digits
opt_train = importdata('optdigits_tra.csv');
opt_test = importdata('optdigits_test.csv');
reals_3{1} = opt_train;
reals_3{2} = opt_test;
titles_3{1} = 'OptDigits Train';
titles_3{2} = 'OptDigits Test';

plot_data_dist(reals_1, 3, 0, titles_1);
plot_data_dist(reals_2, 3, 0, titles_2);
plot_data_dist(reals_3, 2, 0, titles_3);

km_results = cell_kmeans({iris});
results{1, 1} = iris;
results{1, 2} = km_results;

disp('End of real datasets, pausing...');
pause;

%% 4D NORMAL DISTRIBUTION DATASETS
% test_synth_4D(synth_set_size, iris);


%% 2D NORMAL DISTRIBUTION DATASETS

res_2D_1c = test_synth_2D_1c(synth_set_size);

res_2D_2c = test_synth_2D_2c(synth_set_size);

res_2D_3c = test_synth_2D_3c(synth_set_size);

res_2D_4c = test_synth_2D_4c(synth_set_size);





end