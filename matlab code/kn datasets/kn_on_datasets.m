function kn_on_datasets(ns) 

load datasets;

trials = 10;
dataset_sz = size(iris, 1);

% Create a log series of k values
ks = [2:9];
iters = log10(dataset_sz);
for digits = 1:iters
  ks = [ks, [1:9]*(10^digits)];
end
% Remove any ks < size(dataset)
ks = ks(ks <= dataset_sz);
% Add k == size(dataset)
ks = [ks, dataset_sz];

for n = 1:size(ns, 2)
   % Run k-means for each k value trials times
   for k_idx = 1:size(ks(ks<=ns(n)), 2)
       %disp(ks(k_idx));
       for i=1:trials
           idx = (k_idx-1)*trials + i;
           [iters, err, ~, ~, ~] = kmeans_marcus(iris(1:ns(n), :), ks(k_idx)); 
           X_results(idx, :) = [n, ks(k_idx), iters, err];
       end
   end

   %Save the data
   filename = strjoin(strcat('KNDatasets', {' '}, 'iris', {' '}, num2str(ns(n)), {' '},num2str(now)));
   save(filename, 'X_results');

   clear iters digits num_ks X_results idx k_idx;
    
end

end