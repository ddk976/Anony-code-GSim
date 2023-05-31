function acc = gsim_GSVD_iter_acc(A,B,kmax,truth,r,QA,QB)

%gsim_GSVD_iter_acc Computes the accuracy of GSVD in each iteration
%   Input: 
%             A,B: adjacency Matrix
%             kmax: maximum number of iteratoin
%             truth: the converged reult
%             r: the approximation rank
%             QA,QB: same as the QA,QB used for get ground truth.
%   OUtput: 
%             acc: Accuracy of GGSVD in each iteration
   
    acc = zeros(kmax,1);
    
    S= ones(size(A,1),size(B,1));                  %initialize S
    [U,D,V]=svds(S/norm(S,'fro'),r);               %decomposition S

    fprintf('\n >> Start gsim_GSVD_iter_acc\n');
    for k=1:kmax

        U_1 = [A*U*D A'*U*D];                      %iteration model
        U_2 = [A*U_1 A'*U_1];
        V_1 = [B*V B'*V];
        V_2 = [B*V_1 B'*V_1];
        [Q_U,R_U] = qr(U_2,0);
        [Q_V,R_V] = qr(V_2,0);
        [U_3,D_3,V_3] = svds(R_U*R_V',r);
        U = Q_U*U_3;
        D = D_3/norm(D_3);
        V = Q_V*V_3;

        
        S =  U(QA,:)*D*V(QB,:)';                  %get S_K  
        
        S= S/norm(S,'fro');                       %normalization

        acc(k) = norm(truth-S,'fro');             %get accuracy under F-norm
    end

end