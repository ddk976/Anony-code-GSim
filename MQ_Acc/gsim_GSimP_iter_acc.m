function acc = gsim_GSimP_iter_acc(A,B,kmax,truth,QA,QB)

%gsim_GSimP_iter_acc Computes the accuracy of GSIMP in each iteration
%   Input: 
%             A,B: adjacency Matrix
%             kmax: maximum number of iteratoin
%             truth: the converged reult
%             QA,QB: same as the QA,QB used for get ground truth.
%   OUtput: 
%             acc: Accuracy of GSimP in each iteration

    fprintf('\n >> Start gsim_GSimP_iter_acc\n');
    acc = zeros(kmax,1);

    nb = size(B,1);                 %length of B
    na = size(A,1);                 %length of A
   
    U = ones(na,1);                 %initialize   
    V = ones(nb,1);

    for k = 1:kmax
        
        U= [A*U A'*U];              %get U,V in this iteration
        V= [B*V B'*V];

        S = U(QA,:)*(V(QB,:))';     %get similarity matrix
        
        S1 = S/norm(S, 'fro');      %normalization

        acc(k) = norm(truth-S1,'fro'); %get accuracy under F-norm
    end
end