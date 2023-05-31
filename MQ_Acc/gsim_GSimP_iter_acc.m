function acc = gsim_GSimP_iter_acc(A,B,kmax,truth,QA,QB)

%gsim_GSimP_iter_acc Computes the accuracy of GSIMP in each iteration
%   Input: 
%             A,B: adjacency Matrix
%             kmax: maximum number of iteratoin
%             truth: the converged reult
%             QA,QB: same as the QA,QB used for get ground truth.
%   OUtput: 
%             acc: Accuracy of GSimP in each iteration

    fprintf('\n >> Start gsim_naive_iter\n');
    acc = zeros(kmax);

    nb = size(B,1);                 %length of B
    na = size(A,1);                 %length of A
   
    U = ones(nb,1);                 %initialize   
    V = ones(na,1);

    for k = 1:kmax
        
        U= [B*U B'*U];              %get U,V in this iteration
        V= [A*V A'*V];

        S = U(QB,:)*(V(QA,:))';     %get similarity matrix
        
        S1 = S/norm(S, 'fro');      %normalization

        acc(k) = norm(truth-S1,'fro'); %get accuracy under F-norm
    end
end
