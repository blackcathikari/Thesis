function test_dataset_variations(X, X_name)

trials = 10;
num_points = size(X, 1);
ks = floor(linspace(2, num_points, 10));

X_norm = (X - min(X(:))) ./ (max(X(:)) - min(X(:)));
X_std = zscore(X); % This may be wrong for standardising?
X_half = X./2;
X_doub = X.*2;
X_ten = X.*10;

Xs = {X, X_norm, X_std, X_half, X_doub, X_ten};
X_names = {'X', 'X_norm', 'X_std', 'X_half', 'X_doub', 'X_ten'};

% Run k-means on each variation of X
for x = 1:size(Xs, 2)
    % Run k-means for each k value trials times
    for k = 1:size(ks, 2)
        disp(ks(k));
        for i=1:trials
            idx = (k-1)*trials + i;
            data = Xs{x};
            % [iters, err, ~, ~, ~] = kmeans_marcus(data(randperm(num_points), :), ks(k)); 
            [iters, err, ~, ~, ~] = kmeans_marcus(data, ks(k)); 
            X_results(idx, :) = [num_points, ks(k), iters, err];
        end
    end
    filename = strjoin(strcat('DSVars', {' '}, X_name, {' '}, X_names{x}, {' '}, num2str(now)));
    save(filename, 'X_results');
end



clear ks iters digits X num_ks X_results idx k_idx;

end