function [S, bytes, time] = gsim_GSVD_iter_Q(B,A,kmax,r,QB,QA)
%gsim_GSVD_iter_Q Computes similarity of QA and QA by GSVD
%   Input: 
%             A,B: adjacency Matrix
%             kmax: maximum number of iteratoin
%             r: the approximate rank
%             QA,QB: same as the QA,QB used for get ground truth.
%   Output: 
%             S: similaity matrix of QA and QB
%             bytes: memory usage of GSimP in each iteration
%             time: running time of GSimP in each iteration

    fprintf('\n >> Start gsim_GSVD_iter\n');

    time = zeros(kmax,1);
    bytes = zeros(kmax,1);

    tic
    fprintf(' Computing S .');

    S= ones(size(A,1),size(B,1));     %initialize U,D,V
    [U,D,V]=svds(S/norm(S,'fro'),r);


    for k=1:kmax
        U_1 = [A*U*D A'*U*D];         %iterating model
        U_2 = [A*U_1 A'*U_1];
        V_1 = [B*V B'*V];
        V_2 = [B*V_1 B'*V_1];
        [Q_U,R_U] = qr(U_2,'econ');
        [Q_V,R_V] = qr(V_2,'econ');
        [U_3,D_3,V_3] = svds(R_U*R_V',k);
        U = Q_U*U_3;
        D = D_3/norm(D_3);
        V = Q_V*V_3;

        fprintf('.');
        time(k) = toc;               %record running time
        
        mem=whos;                    %record memory
        bytes(k) =sum([mem.bytes]); 
    end

    S =  U(QA,:)*D*V(QB,:)';         %extract queries and compute similarity
    S = S/norm(S, 'fro');            %normalization

end
