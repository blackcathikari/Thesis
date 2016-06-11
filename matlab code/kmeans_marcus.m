function [iterations,errorclust,reccenters,runflag, ind] = kmeans_marcus(data,k)
% Marcus: My simple implementation of k-means clustering!
% Millie: modified to also return ind (values = 1:k, cluster assignment)

%Variables
numpts = size(data,1);
dim = size(data,2);
centers = zeros(k,size(data,2));
oldcenters = zeros(k,size(data,2));

iterations = 0;

% First, initialize cluster centers to the first k data points
%---Note: taking the first k points should be fine, but if it seemed a problem I could do a 
%---random permutation of the data points before we start and then still
%---take the first.

%size(centers)
%size(data)
%k
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

%Main iterative k-means loop
while ~exitcond
    % Now, calculate ownership of points

    %Pairwise distances of all data points
    D = pdist2(centers,data);
    %D = reshape(D,(numpts-1),(size(D,2)/(numpts-1)))

    %Find which cluster center each data point is closest(owns) to (ind)
    %---Note: this breaks if k=1, so don't do that!
    [c,ind]=min(D);
    
    %Debugging bit
    %if (any(any(isnan(centers))))
    %    disp('problem')
        %data(find(ind==i),:)
        %centers
        %data
        %D
        %plot(data(:,1),data(:,2),'*')
        %hold on
        %plot(oldcenters(:,1),oldcenters(:,2),'r*')
    %end
    
    %Calculate error value for current clustering
    errorclust = 0;
    for i=1:k
        errorclust = errorclust + sum( pdist2(centers(i,:),data(find(ind==i),:)).^2 );
    end
    %errorclust
    %
    %21/5/13: Note, this next bit should now never happen, I think.
    %It seemed to be because of the bug below and the theory says that
    %k-means can't oscillate!!!
    %
    %If error has increased compared to prev. iteration, we're oscillating
    %and should stop
    if (errorclust > preverror) && (iterations > 0)
        disp('Problem: oscillation');
        D
        c
        sort(ind)
        oldcenters
        centers
        oldcenters-centers
        find(ind==2)
        mean( data(find(ind==2),:) )
        find(ind==1)
        mean( data(find(ind==1),:) )
        runflag = 2;
        exitcond = 1;
    else
        preverror = errorclust;
    end
    
    oldcenters = centers;
    %Update the cluster centers to be means of owned points
    
    %21/5/13: Ok, there has been a tricky little problem here, when a
    %center only owns one point, the mean calc below doesn't work because
    %it's input argument is a vector rather than a matrix (I think!).
    %So let's check for that and just assign if it's one point.
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
    
    %Check for NaNs, which indicates a cluster centre that owns no points
    if (any(any(isnan(centers))))
        disp('Problem: a cluster centre owns no points?');
        runflag=1;
        exitcond=1;
    end
        
    %Terminate loop if cluster centers did not change
    if (all(all(centers == oldcenters)))
        exitcond = 1;
    end
    iterations = iterations + 1;
    %if iterations==2
    %    exit=1;
    %end
end
%iterations