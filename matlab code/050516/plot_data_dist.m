function kmeans_results = plot_data_dist(data, num_sets, link, titles, bins, fig_file, fig_names)

max_sets_per_fig = 3; % because any more and the plots are too small to read
kmeans_results = cell(num_sets, 1);

if(link ~= 0)
    mins = zeros(max_sets_per_fig, 1); % Minimum data values
    maxes = zeros(max_sets_per_fig, 1); % Maximum data values
end

% Vars for row start and end indexes in the subplot because not doing this
% makes makes a lot more coding.
rows = 5;
row2_s = max_sets_per_fig+1;
row2_e = max_sets_per_fig*2;
row3_s = (max_sets_per_fig*2)+1;
row3_e = max_sets_per_fig*3;
row4_s = (max_sets_per_fig*3)+1;
row4_e = max_sets_per_fig*4;
row5_s = (max_sets_per_fig*4)+1;
row5_e = max_sets_per_fig*5;

figures = [];

% Iterate through data sets and create plots
for i=1:ceil(num_sets/max_sets_per_fig)
    figures(i) = figure('units', 'normalized', 'outerposition', [0 0 1 1]);
    
    plots = []; % Array of all subplots for linking axes. Don't know type to init.
    hms = []; % Histogram max bin values. Don't know type to init.
    lims = zeros(max_sets_per_fig, 2); % Histogram bin limits
        
    for j=1:max_sets_per_fig
        idx = (i-1)*max_sets_per_fig + j; % index into data and titles cell arrays
        
        % Data plot
        d = data{idx};
        plots(j) = subplot(5, max_sets_per_fig,j);
        if (link == 2) 
            plot(d(:, 1), d(:, 2), 'b.');
        else 
           red_d = pca(d, 2); 
           plot(red_d(:, 1), red_d(:, 2), 'b.');
        end
        title(titles{idx});

        if(link ~= 0) 
            mins(j, :) = min(min(d));
            maxes(j, :) = max(max(d));
        end

        % Boxplots
        plots(max_sets_per_fig+j) = subplot(5, max_sets_per_fig,(max_sets_per_fig + j));
        boxplot(d);

        % Data histogram
        plots(row2_e+j) = subplot(5, max_sets_per_fig,row2_e+j);
        h1 = histogram(d, bins);
        hms(j) = max(h1.Values);
        lims(j, :) = h1.BinLimits;

        % Pairwise distance histogram
        plots(row3_e+j) = subplot(5, max_sets_per_fig,row3_e+j);
        h2 = histogram(pdist(d), bins);
        hms(max_sets_per_fig+j) = max(h2.Values);
        lims(max_sets_per_fig+j, :) = h2.BinLimits;
        
        % K-means error plot
        [kmeans_results{idx}, avg_err] = cell_kmeans(num2cell(d, [1,2]));
        plots(row4_e+j) = subplot(5, max_sets_per_fig, row4_e+j);
        err = plot(2:10, avg_err, 'b');
    end
    
    if (num_sets > 1 && link ~= 0)
        % Link plots axes along rows of subplots so all x and y are the same scale
        % Link data plot axes
        linkaxes(plots(1:max_sets_per_fig), 'xy');
        a = min(mins)-1;
        b = max(maxes)+1;
        xlim(plots(1), [a, b]);
        ylim(plots(1), [a, b]);

        % Link boxplot axes
        linkaxes(plots(row2_s:row2_e), 'y');
        ylim(plots(row2_s), [min(mins(:, :))-1, max(maxes(:, :))+1]);

        % Link data histogram axes
        linkaxes(plots(row3_s:row3_e), 'xy');
        xlim(plots(row3_s), [min(lims(1:max_sets_per_fig, 1)), max(lims(1:max_sets_per_fig, 2))]);
        upper = max(hms(1:max_sets_per_fig));
        upper = upper + mod(-upper, upper/10);
        ylim(plots(row3_s), [0, upper]);

        % Link pdist histogram axes
        linkaxes(plots(row4_s : row4_e), 'xy');
        xlim(plots(row4_s), [min(lims(row2_s:row2_e, 1)), max(lims(row2_s:row2_e, 2))]);
        upper = max(hms(row2_s : row2_e));
        upper = upper + mod(-upper, upper/10);
        ylim(plots(row4_s), [0, upper]);
    end
    
    saveas(figures(i), strcat(fig_names(i, :), '.png')); 
    
end

savefig(figures, strcat(fig_file, '.fig'));


end