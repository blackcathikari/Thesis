function uniform_unit_square_log(ns)
% Assumes ns is a row vector of n values

num_ns = size(ns, 2);
trials = 10;

for n=1:num_ns
  
   % Create a log series of k values
   ks = [2:9];
   iters = log10(ns(n));
   for digits = 1:iters
      ks = [ks, [1:9]*(10^digits)];
   end
   % Remove any ks < ns(n)
   ks = ks(ks <= ns(n));
   
   % Create data variables
   X = rand(ns(n), 2);
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
   
   %disp(X_results)
   stats = [X_results(:, 1)./X_results(:, 2), X_results(:, 2)./X_results(:, 1)];
   %disp(stats)
   
   figure;
   
   subplot(2, 4, 1);
   plot(X(:, 1), X(:, 2), 'b.');
   xlabel('X');
   ylabel('y');
   
   subplot(2, 4, 2);
   semilogx(X_results(:, 2), X_results(:, 3), 'b.');
   xlabel('k');
   ylabel('iters');
   
   subplot(2, 4, 3);
   semilogx(X_results(:, 2), X_results(:, 4), 'b.');
   xlabel('k');
   ylabel('err');
   
   subplot(2, 4, 4);
   semilogx(X_results(:, 3), X_results(:, 4), 'b.');
   xlabel('iters');
   ylabel('err');
   
   subplot(2, 4, 5);
   semilogx(stats(:, 1), X_results(:, 3), 'b.');
   xlabel('n/k');
   ylabel('iters');
   
   subplot(2, 4, 6);
   semilogx(stats(:, 1), X_results(:, 4), 'b.');
   xlabel('n/k');
   ylabel('err');
   
   subplot(2, 4, 7);
   semilogx(stats(:, 2), X_results(:, 3), 'b.');
   xlabel('k/n');
   ylabel('iters');
   
   subplot(2, 4, 8);
   semilogx(stats(:, 2), X_results(:, 4), 'b.');
   xlabel('k/n');
   ylabel('err');
   
   %Save the data
   filename = strjoin(strcat('UUSL', {' '}, num2str(ns(n)), {' '}, num2str(now)));
   save(filename, 'X_results');
   
   % Clear most of the variables to free up memory
   % varlist = {'ks', 'iters', 'digits', 'X', 'num_ks', 'X_results', 'idx', 
       %'k_idx', 'stats', 'results'};
   % clear(varlist{:})
   clear ks iters digits X num_ks X_results idx k_idx stats results;
end

end