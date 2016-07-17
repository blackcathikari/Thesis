function plot_combined_kn_iters_dataset(ns_to_plot)

% Get filenames 
allFiles = dir('C:\Users\Millie\OneDrive\Uni\4_1\Thesis 1\Thesis\matlab code\kn datasets\results\');
allNames = {allFiles(~[allFiles.isdir]).name};
allNames = sort(allNames);

% Get an array of strings of values we're searching for
n_names = strtrim(cellstr(num2str(ns_to_plot'))');

% Initialise variables to tracks plots, etc.
sp = zeros(size(ns_to_plot, 2), 1);
results = cell(size(ns_to_plot));
Xs = cell(size(ns_to_plot));

% Iterate through all the files
for i = 1:size(allNames, 2)
   temp = strsplit(allNames{i});
   n = temp(3);
   
   % Check file matches search values
   if(any(ns_to_plot == str2num(n{1}))) 
       % Load X_results from file
       load(allNames{i}, '-mat') ;
       
       % Copy data from file to results cell in same index as s in
       % sigs_to_plot
       data = X_results(:, 2)./X_results(:, 1);
       idx = find(ns_to_plot==str2num(n{1}));
       results{idx} = [results{idx}; data];
       Xs{idx} = [Xs{idx}; X_results(:, 3)];
   end
end

figure;

% Plot data
for i = 1:size(ns_to_plot, 2)
    colour = [rand; rand; rand];
    sp(i) = semilogx(results{i}, Xs{i}, '.', 'Color', colour, 'MarkerSize', 12);
    hold on
end

% Add title, labels and legend
title('Dataset comparison by n');
xlabel('k/n');
ylabel('iters');
legend(n_names); 

end