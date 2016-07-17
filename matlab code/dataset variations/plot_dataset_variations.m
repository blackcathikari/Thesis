function plot_dataset_variations(X_name)

% Get filenames 
allFiles = dir('C:\Users\Millie\OneDrive\Uni\4_1\Thesis 1\Thesis\matlab code\dataset variations\results\');
allNames = {allFiles(~[allFiles.isdir]).name}
allNames = sort(allNames)

%% PLOT BY N VALUE

% Initialise variables to tracks plots, etc.
var_types = 6; % X, X_norm, X_std, X_half, X_doub, X_ten
X_names = {'X', 'X_norm', 'X_std', 'X_half', 'X_doub', 'X_ten'};
X_names_spaces = {'X', 'X norm', 'X std', 'X half', 'X doub', 'X ten'};

kns = cell(var_types, 1);
iters = cell(var_types, 1);

figure;

% Iterate through all the files
for i = 1:size(allNames, 2)
    temp = strsplit(allNames{i});
    data_name = temp(2);
    data_var = temp(3);
   
    % Check file matches search values
    if (size(X_name) == size(data_name{1}))
        if (X_name == data_name{1})
            % Load X_results from file
            load(allNames{i}, '-mat') ;

            % Copy data from file to results cell in same index as s in
            % sigs_to_plot
            data = X_results(:, 2)./X_results(:, 1);
            [~, idx] = ismember(data_var, X_names);
            kns{idx} = [kns{idx}; data];
            iters{idx} = [iters{idx}; X_results(:, 3)];
        end
   end
end

% Plot data
for i = 1:var_types
    subplot(2, 3, i);
    size(unique([kns{i}, iters{i}], 'rows'), 1)
    plot(kns{i}, iters{i}, '.', 'MarkerSize', 10);
    title(strcat('Dataset variations on', {' '}, X_name, {' '}, X_names_spaces{i}));
    xlabel('k/n');
    ylabel('iters');
    hold on
end

% Add title, labels and legend


end