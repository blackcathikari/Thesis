function [results, avg_errs] = cell_kmeans(datasets)
% Takes a cell array of datasets, runs kmeans on them all and outputs the
% results as a cell and the average error for each k and dataset as an
% array.

num_datasets = size(datasets, 1); % num of datasets
results = cell(num_datasets, 9); % 9 k values for c datasets - contains 1x5 cells of kmeans results
avg_errs = zeros(num_datasets, 9); % avg error for each k for each dataset

num_trials = 10; % number of times to repeat kmeans for each k and dataset

for d=1:num_datasets % iterate through all the datasets
    for k=2:10 % iterate through k = 2...10
        avg_err = 0;
        temp = cell(num_trials,5);
        for t = 1:num_trials % run kmeans #trials times on each dataset for each k
            % Store results of kmeans - [iterations, errorclust, reccenters, runflag, ind]
            [temp{t, 1}, temp{t, 2}, temp{t, 3}, temp{t, 4}, temp{t, 5}] = kmeans_marcus(datasets{d}, k);
            avg_err = avg_err + temp{t, 2};
        end
        results{d, k-1} = temp;
        avg_errs(d, k-1) = avg_err/num_trials;
    end
end

end