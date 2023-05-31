function S= gsim_GSimP_iter(A,B,kmax)
%gsim_GSimP_iter Computes the Similarity with GSimP 
%   Input: 
%             A,B: adjacency Matrix
%             kmax: maximum number of iteratoin
%   Output: 
%             S  = Similairy matrix of QA an
    fprintf('\n >> Start gsim_GSimP_iter\n');

    nb = size(B,1);                 %length of B
    na = size(A,1);                 %length of A

    fprintf(' Computing S .');
    U = ones(na,1);                 %initialize   
    V = ones(nb,1);
    
    for k=1:kmax
       
        U= [A*U A'*U];              %iterating model
        V= [B*V B'*V];
        
        fprintf('.');
      
    end
 
        S = U*V';                   %similarity matrix
        S = S/norm(S, 'fro');       %normalization

end