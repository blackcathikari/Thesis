function kn_gauss_1c_sym_sph(ns, sigs)
% Generates datasets, runs kmeans on them and save data so k/n can be
% plotted.
% Input: 
%   - ns = array of n vals
%   - sigs = array of sigma values to try

trials = 10;

for s=1:size(sigs, 2)
    for n=1:size(ns, 2)

       % Create a log series of k values
       ks = [2:9];
       iters = log10(ns(n));
       for digits = 1:iters
          ks = [ks, [1:9]*(10^digits)];
       end
       % Remove any ks < ns(n)
       ks = ks(ks <= ns(n));

       % Create data variables
       X = mvnrnd([0,0], [sigs(s), sigs(s)], ns(n));
       num_ks = size(ks, 2)*trials;
       X_results = zeros(num_ks, 4);

       % Run k-means for each k value trials times
       for k_idx = 1:size(ks, 2)
           disp(ks(k_idx));
           for i=1:trials
               idx = (k_idx-1)*trials + i;
               [iters, err, ~, ~, ~] = kmeans_marcus(X, ks(k_idx)); 
               X_results(idx, :) = [ns(n), ks(k_idx), iters, err];
           end
       end

       %Save the data
       filename = strjoin(strcat('G1cSS', {' '}, num2str(ns(n)), {' '}, num2str(sigs(s)), {' '}, num2str(now)));
       save(filename, 'X_results');

       clear ks iters digits X num_ks X_results idx k_idx;
    end
end

end