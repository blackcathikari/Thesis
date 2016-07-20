function plot_combined_kn_iters_gauss_2c(ns_to_plot, sigs_to_plot, mus_to_plot)

% Get filenames 
allFiles = dir('C:\Users\Millie\OneDrive\Uni\4_1\Thesis 1\Thesis\matlab code\gaussian 2c\results\');
allNames = {allFiles(~[allFiles.isdir]).name};
allNames = sort(allNames);

% Get an array of strings of values we're searching for
n_names = strtrim(cellstr(num2str(ns_to_plot'))');
s_names = strtrim(cellstr(num2str(sigs_to_plot'))');
m_names = strtrim(cellstr(num2str(mus_to_plot'))');

% PLOT BY N VALUE

% Initialise variables to tracks plots, etc.
n_results = cell(size(ns_to_plot));
n_iters = cell(size(ns_to_plot));
s_results = cell(size(sigs_to_plot));
s_iters = cell(size(sigs_to_plot));
m_results = cell(size(mus_to_plot));
m_iters = cell(size(mus_to_plot));

% Iterate through all the files
for i = 1:size(allNames, 2)
   temp = strsplit(allNames{i})
   type = temp(2);
   
   % Load X_results from file
   if (type{1} == 'results') 
       n = temp(3);
       s = temp(4);
       m = temp(5);
       load(allNames{i}, '-mat') ;
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

       if(any(mus_to_plot == str2num(m{1}))) 
           % Copy data from file to results cell in same index as s in
           % sigs_to_plot
           idx = find(mus_to_plot==str2num(m{1}));
           m_results{idx} = [m_results{idx}; data];
           m_iters{idx} = [m_iters{idx}; X_results(:, 3)];
       end
   end
end

figure;

% Plot data
for i = 1:size(ns_to_plot, 2)
    colour = [rand; rand; rand];
    semilogx(n_results{i}, n_iters{i}, '.', 'Color', colour, 'MarkerSize', 8);
    hold on
end

% Add title, labels and legend
title('Gaussian comparison by n');
xlabel('k/n');
ylabel('iters');
legend(n_names); 

figure;

% Plot data
for i = 1:size(sigs_to_plot, 2)
    colour = [rand; rand; rand];
    semilogx(s_results{i}, s_iters{i}, '.', 'Color', colour, 'MarkerSize', 8);
    hold on
end

% Add title, labels and legend
title('Gaussian comparison by sigma');
xlabel('k/n');
ylabel('iters');
legend(s_names);

figure;

% Plot data
for i = 1:size(mus_to_plot, 2)
    colour = [rand; rand; rand];
    semilogx(m_results{i}, m_iters{i}, '.', 'Color', colour, 'MarkerSize', 8);
    hold on
end

% Add title, labels and legend
title('Gaussian comparison by mu');
xlabel('k/n');
ylabel('iters');
legend(m_names);

end