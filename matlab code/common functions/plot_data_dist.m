function plot_data_dist(data, num_sets, dim, titles)

figure;

if(dim ~= 0)
    mins = zeros(num_sets, dim); % Minimum data values
    maxes = zeros(num_sets, dim); % Maximum data values
end
plots = []; % Array of all subplots for linking axes. Can't size to allocate
hms = []; % Histogram max bin values. Can't size to allocate.
lims = zeros(num_sets, 2); % Histogram bin limits

% Vars for row start and end indexes in the subplot because not doing this
% makes makes a lot more coding.
row2_s = num_sets+1;
row2_e = num_sets*2;
row3_s = (num_sets*2)+1;
row3_e = num_sets*3;
row4_s = (num_sets*3)+1;
row4_e = num_sets*4;

% Iterate through data sets and create plots
for i=1:num_sets
    % Data plot
    d = data{i};
    plots(i) = subplot(4,num_sets,i);
    if (dim == 2) 
        plot(d(:, 1), d(:, 2), 'b.');
    else 
       red_d = pca(d, 2); 
       plot(red_d(:, 1), red_d(:, 2), 'b.');
    end
    title(titles{i});

    if(dim ~= 0) 
        mins(i, :) = min(d);
        maxes(i, :) = max(d);
    end
    
    % Boxplots
    plots(num_sets+i) = subplot(4,num_sets,(num_sets + i));
    boxplot(d);
    
    % Data histogram
    plots((row2_e)+i) = subplot(4,num_sets,(row2_e)+i);
    h1 = histogram(d, 20);
    hms(i) = max(h1.Values);
    lims(i, :) = h1.BinLimits;
    
    % Pairwise distance histogram
    plots((row3_e)+i) = subplot(4,num_sets,(row3_e)+i);
    h2 = histogram(pdist(d), 20);
    hms(num_sets+i) = max(h2.Values);
    lims(num_sets+i, :) = h2.BinLimits;
    
end

if (num_sets > 1 && dim ~= 0)
    % Link plots axes along rows of subplots so all x and y are the same scale
    % Link data plot axes
    linkaxes(plots(1:num_sets), 'xy');
    a = min(min(mins))-1;
    b = max(max(maxes))+1;
    xlim(plots(1), [a, b]);
    ylim(plots(1), [a, b]);

    % Link boxplot axes
    linkaxes(plots(row2_s:row2_e), 'y');
    ylim(plots(row2_s), [min(min(mins(:, :)))-1, max(max(maxes(:, :)))+1]);

    % Link data histogram axes
    linkaxes(plots(row3_s:row3_e), 'xy');
    xlim(plots(row3_s), [min(lims(1:num_sets, 1)), max(lims(1:num_sets, 2))]);
    upper = max(hms(1:num_sets));
    upper = upper + mod(-upper, upper/10);
    ylim(plots(row3_s), [0, upper]);

    % Link pdist histogram axes
    linkaxes(plots(row4_s : row4_e), 'xy');
    xlim(plots(row4_s), [min(lims(row2_s:row2_e, 1)), max(lims(row2_s:row2_e, 2))]);
    upper = max(hms(row2_s : row2_e));
    upper = upper + mod(-upper, upper/10);
    ylim(plots(row4_s), [0, upper]);
end


end