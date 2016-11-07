function reduced_X = pca(X, k)

[~, n] = size(X);
m = mean(X);
for i=1:n
   X(:, i) = X(:, i) - m(i); 
end

covar = cov(X);
[e_vectors, e_values_diag] = eig(covar);
e_values = diag(e_values_diag)';
[e_values, idx] = sort(e_values, 'descend');
e_vectors = e_vectors(:, idx);

reduced_X = X*e_vectors(:, 1:k);

end