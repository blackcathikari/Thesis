function plot_combined_kn_iters(values_to_plot)

% Get filenames 
allFiles = dir('C:\Users\Millie\OneDrive\Uni\4_1\Thesis 1\Thesis\matlab code\uniform unit circle\results\');
allNames = {allFiles(~[allFiles.isdir]).name};
allNames = sort(allNames);

% Get an array of strings of values we're searching for
value_names = sort(strtrim(cellstr(num2str(values_to_plot'))'));

% Initialise variables to tracks plots, etc.
sp = zeros(size(values_to_plot, 2), 1);
v_ind = [];
count = 0;
colour = {[rand; rand; rand]};  

figure;

% Iterate through all the files
for i = 1:size(allNames, 2)
   temp = strsplit(allNames{i})
   n = temp(2)
   
   % Check file matches search values
   if(any(values_to_plot == str2num(n{1}))) 
       % Load X_results from file
       load(allNames{i}, '-mat') ;
       
       % If this is the first valid file, initialise more variables
       count = count + 1;
       if(count == 1) 
          temp = strsplit(allNames{1});
          last = temp(2);    
       end
   
       % If new search value, create a colour and save the file index
       if(str2num(n{1}) ~= str2num(last{1})) 
           colour = {[rand; rand; rand]};
           last = n;
           v_ind = [v_ind, i];
       end
       
       % Plot k/n vs iters
       stats = X_results(:, 2)./X_results(:, 1);
       sp(i) = semilogx(stats, X_results(:, 3), '.', 'Color', colour{1}, 'MarkerSize', 12);
       hold on;
   end
end

% Add labels and legend
xlabel('k/n');
ylabel('iters');
legend(sp(v_ind), value_names); 

end