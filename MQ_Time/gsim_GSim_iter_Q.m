function [S, bytes, time] = gsim_GSim_iter_Q(A, B, kmax,QA,QB)

%gsim_GSim_iter_acc Computes the accuracy of GSIM in each iteration
%   Input: 
%             A,B: adjacency Matrix
%             kmax: maximum number of iteratoin
%             QA,QB: same as the QA,QB used for get ground truth.
%   Output: 
%             acc: Accuracy of GSim in each iteration
%             bytes: memory usage of GSim in each iteration
%             time: running time of GSim in each iteration
fprintf('\n >> Start gsim_naive_iter\n');

    time = zeros(kmax,1);
    bytes = zeros(kmax,1);

    na = size(A,1);             % get size of A and B
    nb = size(B,1);

    fprintf(' Computing S .');
    S = ones(na, nb);           % initialise similatity matrix

    for k = 1:kmax
             
        S= A*S*B'+A'*S*B;       % iteration model 
        
        fprintf('.');
        time(end+1) = toc;                % time
        mem = whos;
        bytes(end+1) = sum([mem.bytes]); % memory
    end
         
         S = S(QA,QB);
         S = S/norm(S, 'fro');  % normalization 
            
end

