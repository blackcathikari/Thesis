function results = uniform_unit_square(ns)
% Assumes ns is a row vector of n values

num_ns = size(ns, 2);
results = cell(num_ns, 1);

for n=1:num_ns
   X = rand(ns(n), 2);
   num_ks = 10*(9*log10(ns(n))) - 1;
   X_results = zeros(num_ks, 4);
   
   ks = [2:9];
   ks = [ks, linspace(10, ns(n), ns(n)/10)];
   for k_idx = 1:size(ks, 2);
       disp(ks(k_idx));
       for i=1:10
           idx = (k_idx-1)*10 + i;
           [iters, err, ~, ~, ~] = kmeans_marcus(X, ks(k_idx)); 
           X_results(idx, :) = [ns(n), ks(k_idx), iters, err];
       end
   end
   
   %disp(X_results)
   stats = [X_results(:, 1)./X_results(:, 2), X_results(:, 2)./X_results(:, 1)];
   %disp(stats)
   results{n} = [X_results, stats];
   
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
end

end