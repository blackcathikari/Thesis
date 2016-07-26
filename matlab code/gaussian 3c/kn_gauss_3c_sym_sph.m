function kn_gauss_3c_sym_sph(ns, sigs, rs)
% Generates datasets, runs kmeans on them and save data so k/n can be
% plotted.
% Input: 
%   - ns = array of n vals
%   - sigs = array of sigma values to try

trials = 10;

for r=1:size(rs, 2)
    for s=1:size(sigs, 2)
        for n=1:size(ns, 2)

           % Create a log series of k values
           ks = [2:9];
           iters = log10(ns(n));
           for digits = 1:iters
              ks = [ks, [1:9]*(10^digits)];
           end
           

           % Create data variables
           X = mvnrnd([rs(r),0], [sigs(s), sigs(s)], floor(ns(n)/3));
           X = [X; mvnrnd([-rs(r),0], [sigs(s), sigs(s)], floor(ns(n)/3))];
           pt = (rs(r)*2)*cos(pi/6);
           X = [X; mvnrnd([0, pt], [sigs(s), sigs(s)], floor(ns(n)/3))];
           X = X(randperm(size(X, 1)), :);
           
           % Remove any ks > size(X)
           ks = ks(ks <= size(X, 1));
           
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
           filename = strjoin(strcat('G3cSS results', {' '}, num2str(ns(n)), {' '}, num2str(sigs(s)), {' '}, num2str(rs(r)), {' '}, num2str(now)));
           save(filename, 'X_results');
           
           filename = strjoin(strcat('G3cSS X', {' '}, num2str(ns(n)), {' '}, num2str(sigs(s)), {' '}, num2str(rs(r)), {' '}, num2str(now)));
           save(filename, 'X');


           clear ks iters digits X num_ks X_results idx k_idx;
        end
    end
end
end