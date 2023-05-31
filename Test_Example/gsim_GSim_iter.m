function S= gsim_GSim_iter(A, B, kmax)

%gsim_GSim_iter Computes the similarity with GSim
%   Input: 
%             A,B: adjacency Matrix
%             kmax: maximum number of iteratoin
%   Output: 
%             S: Similarity matrix of QA and QB
fprintf('\n >> Start gsim_naive_iter\n');

    na = size(A,1);             % get size of A and B
    nb = size(B,1);

    fprintf(' Computing S .');
    S = ones(na, nb);           % initialise similatity matrix

    for k = 1:kmax
             
        S= A*S*B'+A'*S*B;       % iteration model 
        S = S/norm(S, 'fro');  % normalization 
        fprintf('.');
    end
         
end

