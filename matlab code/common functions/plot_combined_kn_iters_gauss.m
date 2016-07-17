function plot_combined_kn_iters_gauss(ns_to_plot, sigs_to_plot)

% Get filenames 
allFiles = dir('C:\Users\Millie\OneDrive\Uni\4_1\Thesis 1\Thesis\matlab code\gaussian single\results\');
allNames = {allFiles(~[allFiles.isdir]).name};
allNames = sort(allNames);

% Get an array of strings of values we're searching for
n_names = strtrim(cellstr(num2str(ns_to_plot'))');
s_names = strtrim(cellstr(num2str(sigs_to_plot'))');

%% PLOT BY N VALUE

% Initialise variables to tracks plots, etc.
sp = zeros(size(ns_to_plot, 2), 1);
results = cell(size(ns_to_plot));
iters = cell(size(ns_to_plot));

% Iterate through all the files
for i = 1:size(allNames, 2)
   temp = strsplit(allNames{i})
   n = temp(2);
   
   % Check file matches search values
   if(any(ns_to_plot == str2num(n{1}))) 
       % Load X_results from file
       load(allNames{i}, '-mat') ;
       
       % Copy data from file to results cell in same index as s in
       % sigs_to_plot
       data = X_results(:, 2)./X_results(:, 1);
       idx = find(ns_to_plot==str2num(n{1}));
       results{idx} = [results{idx}; data];
       iters{idx} = [iters{idx}; X_results(:, 3)];
   end
end

figure;

% Plot data
for i = 1:size(ns_to_plot, 2)
    colour = [rand; rand; rand];
    sp(i) = semilogx(results{i}, iters{i}, '.', 'Color', colour, 'MarkerSize', 12);
    hold on
end

% Add title, labels and legend
title('Gaussian comparison by n');
xlabel('k/n');
ylabel('iters');
legend(n_names); 

%% PLOT BY SIG VALUE

% Initialise variables to tracks plots, etc.
sp = zeros(size(sigs_to_plot, 2), 1);
% v_ind = [];
% count = 0;
% colour = {[rand; rand; rand]};  
results = cell(size(sigs_to_plot));
iters = cell(size(sigs_to_plot));

% Iterate through all the files
for i = 1:size(allNames, 2)
   temp = strsplit(allNames{i});
   s = temp(3);
   
   % Check file matches search values
   if(any(sigs_to_plot == str2num(s{1}))) 
       % Load X_results from file
       load(allNames{i}, '-mat') ;
       
       % Copy data from file to results cell in same index as s in
       % sigs_to_plot
       data = X_results(:, 2)./X_results(:, 1);
       idx = find(sigs_to_plot==str2num(s{1}));
       results{idx} = [results{idx}; data];
       iters{idx} = [iters{idx}; X_results(:, 3)];
   end
end

figure;

% Plot data
for i = 1:size(sigs_to_plot, 2)
    colour = [rand; rand; rand];
    sp(i) = semilogx(results{i}, iters{i}, '.', 'Color', colour, 'MarkerSize', 12);
    hold on
end

% Add title, labels and legend
title('Gaussian comparison by sigma');
xlabel('k/n');
ylabel('iters');
legend(s_names);

end