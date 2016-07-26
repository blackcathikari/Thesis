function plot_combined_kn_iters_gauss_3c(ns_to_plot, sigs_to_plot, rs_to_plot)
% ns = [100, 500, 1000, 5000, 10000];
% sigs = [1, 5, 10, 50, 100];
% mus = [0, 2, 5, 10, 15, 20];

% Get filenames 
allFiles = dir('C:\Users\Millie\OneDrive\Uni\4_1\Thesis 1\Thesis\matlab code\gaussian 3c\results\3c');
allNames = {allFiles(~[allFiles.isdir]).name};
allNames = sort(allNames);

% Initialise variables to tracks plots, etc.
n_results = cell(size(ns_to_plot));
n_iters = cell(size(ns_to_plot));
s_results = cell(size(sigs_to_plot));
s_iters = cell(size(sigs_to_plot));
r_results = cell(size(rs_to_plot));
r_iters = cell(size(rs_to_plot));

% Iterate through all the files
for i = 1:size(allNames, 2)
   temp = strsplit(allNames{i});
   type = temp(2);
   
   % Load X_results from file
   if (type{1} == 'results') 
       n = temp(3);
       s = temp(4);
       r = temp(5);
       disp(allNames{i})
       load(allNames{i}, '-mat');
       data = X_results(:, 2)./X_results(:, 1);

       % Check file matches search values
       if(any(ns_to_plot == str2num(n{1}))) 
           % Copy data from file to results cell in same index as s in
           % sigs_to_plot
           idx = find(ns_to_plot==str2num(n{1}));
           n_results{idx} = [n_results{idx}; data];
           n_iters{idx} = [n_iters{idx}; X_results(:, 3)];
       end

       if(any(sigs_to_plot == str2num(s{1}))) 
           % Copy data from file to results cell in same index as s in
           % sigs_to_plot
           idx = find(sigs_to_plot==str2num(s{1}));
           s_results{idx} = [s_results{idx}; data];
           s_iters{idx} = [s_iters{idx}; X_results(:, 3)];
       end

       if(any(rs_to_plot == str2num(r{1}))) 
           % Copy data from file to results cell in same index as s in
           % sigs_to_plot
           idx = find(rs_to_plot==str2num(r{1}));
           r_results{idx} = [r_results{idx}; data];
           r_iters{idx} = [r_iters{idx}; X_results(:, 3)];
       end
   end
end

figure;

disp(size(n_results))
size(n_iters)
size(ns_to_plot, 2)

% Plot data
for i = 1:size(ns_to_plot, 2)
    i
    subplot(2, 3, i);
    semilogx(n_results{i}, n_iters{i}, '.', 'MarkerSize', 8);
    % Add title, labels and legend
    title(strcat('Gaussian comparison by n', {' '}, num2str(ns_to_plot(i))));
    xlabel('k/n');
    ylabel('iters');
    hold on
end

figure;

% Plot data
for i = 1:size(sigs_to_plot, 2)
    subplot(2, 3, i);
    semilogx(s_results{i}, s_iters{i}, '.', 'MarkerSize', 8);
    % Add title, labels and legend
    title(strcat('Gaussian comparison by s', {' '}, num2str(sigs_to_plot(i))));
    xlabel('k/n');
    ylabel('iters');
    hold on
end

figure;

% Plot data
for i = 1:size(rs_to_plot, 2)
    subplot(2, 3, i);
    semilogx(r_results{i}, r_iters{i}, '.', 'MarkerSize', 8);
    % Add title, labels and legend
    title(strcat('Gaussian comparison by r', {' '}, num2str(rs_to_plot(i))));
    xlabel('k/n');
    ylabel('iters');
    hold on
end

end