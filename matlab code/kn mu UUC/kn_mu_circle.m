function kn_mu_circle(ns, mus, mu_name) 

num_ns = size(ns, 2);
num_mus = size(mus, 2);

trials = 10;

for n = 1:num_ns
    
    X_results = zeros(trials*num_mus, 4);
    
    for m = 1:num_mus
        disp(num_mus(m))
        % Generate data 
        radius = 1; % unit circle
        yc = 0;
        xc1 = mus(m);
        xc2 = -mus(m);
        theta = rand(1,ns(n)).*(2*pi);
        r = sqrt(rand(1,ns(n)))*radius;
        x1 = xc1 + r.*cos(theta);
        y1 = yc + r.*sin(theta);
        x2 = xc2 + r.*cos(theta);
        y2 = yc + r.*sin(theta);
        X = [x1', y1'; x2', y2'];
        
        % Run kmeans
        for i=1:trials
            idx = (m-1)*trials + i;
            [iters, err, ~, ~, ~] = kmeans_marcus(X, 2); 
            X_results(idx, :) = [ns(n), mus(m), iters, err];
        end
        
    end
    
    % Plot k/n for mu and iters    
    figure;
    plot(X_results(:, 2), X_results(:, 3), '.', 'MarkerSize', 10);
    xlabel('mu');
    ylabel('iters');
    
    % Save the data
    filename = strjoin(strcat('KN mu k2 circle', {' '}, num2str(ns(n)), {' '}, mu_name, {' '}, num2str(now)));
    save(filename, 'X_results');

    % Clear unneeded vars
    clear ks iters digits X num_ks X_results idx k_idx stats results;
    
end
    
end