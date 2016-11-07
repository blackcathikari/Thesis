function [iterations, errorclust, reccenters, runflag, ind, centers, data] = kmeans(data,k)
% Originally written by Marcus Gallagher, modified by Millie Macdonald

% Variables
numpts = size(data,1);
dim = size(data,2);
centers = zeros(k,size(data,2));
oldcenters = zeros(k,size(data,2));

iterations = 0;

% Randomise the data points in case they're sorted
data = data(randperm(numpts), :);

% First, initialize cluster centers to the first k data points
% This requires that we have at least as many data points as cluster centres
if (k > size(data,1))
    disp('Problem: more cluster centres than data points');
    return
end
centers(1:k,:) = data(1:k,:);
reccenters(:,:,1) = centers(:,:);

exitcond = 0;
runflag = 0;
preverror = 0;

% Main iterative k-means loop
while ~exitcond
    % Now, calculate ownership of points

    % Pairwise distances of all data points
    D = pdist2(centers,data);
    
    % Find which cluster center each data point is closest(owns) to (ind)
    % ---Note: this breaks if k=1, so don't do that!
    [c,ind]=min(D);
    
    % Calculate error value for current clustering
    errorclust = 0;
    for i=1:k
        errorclust = errorclust + sum( pdist2(centers(i,:),data(find(ind==i),:)).^2 );
    end
    
    % If error has increased compared to prev. iteration, we're oscillating
    % and should stop
    if (errorclust > preverror) && (iterations > 0)
        disp('Problem: oscillation');
        disp(D);
        disp(c);
        disp(sort(ind));
        disp(oldcenters);
        disp(centers);
        disp(oldcenters-centers);
        disp(find(ind==2));
        disp(mean( data(find(ind==2),:) ));
        disp(find(ind==1));
        disp(mean( data(find(ind==1),:) ));
        runflag = 2;
        exitcond = 1;
    else
        preverror = errorclust;
    end
    
    % Update the cluster centers to be means of owned points
    oldcenters = centers;
        
    % 21/5/13: Ok, there has been a tricky little problem here, when a
    % center only owns one point, the mean calc below doesn't work because
    % it's input argument is a vector rather than a matrix (I think!).
    % So let's check for that and just assign if it's one point.
    for i=1:k
        dups = data(find(ind==i),:);
        if (size(dups,1)==1)
            disp('Warning: a cluster centre owns 1 point...');
            centers(i,:) = dups;
        else
            centers(i,:) = mean( dups );
        end
    end
    reccenters(:,:,(iterations+2)) = centers(:,:);
    
    % Check for NaNs, which indicates a cluster centre that owns no points
    if (any(any(isnan(centers))))
        disp('Problem: a cluster centre owns no points?');
        runflag=1;
        exitcond=1;
    end
        
    % Terminate loop if cluster centers did not change
    if (all(all(centers == oldcenters)))
        exitcond = 1;
    end
    iterations = iterations + 1;
    
end