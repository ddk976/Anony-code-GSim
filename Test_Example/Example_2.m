
A = [0, 1, 1, 0, 0, 0, 0, 0                %adjacency mateix of GA
0, 0, 1, 0, 0, 0, 1, 1 
0, 1, 0, 0, 1, 0, 1, 1 
1, 0, 0, 0, 1, 0, 0, 0 
0, 0, 0, 0, 0, 0, 1, 0 
0, 0, 0, 1, 1, 0, 1, 0 
0, 1, 1, 0, 0, 0, 0, 1 
0, 1, 1, 0, 0, 0, 1, 0];

B=[0, 0, 1, 0, 0                           %adjacency mateix of GB
1, 0, 1, 1, 1 
0, 1, 0, 1, 1 
0, 1, 1, 0, 1 
0, 1, 1, 1, 0 
];

na = size(A,1);
nb = size(B,1);

S = ones(nb, na);                          %initialize S_0
S1 = S(:);                                 %vectorize S_0

kmax=6;                                    %define kmax
acc = zeros(5,1);               

truth = gsim_GSim_iter(A,B,100);           %get ground truth S



for k = 1:kmax    
    S = B*S*A' + B'*S*A;                   % iteration model 
    S = S/norm(S, 'fro');
    acc(k) = norm(truth-S,'fro');          %get acc1 = |S_k-S|_F
end


M = (kron(A,B)+kron(A',B'));               % get matrix M
[v,w] = eigs(M,na*nb);                     % get ranked eigenvector eigenvalue of M                          
c1 = v'*S1;                                % get c
acc2 = zeros(5,1);

% for k=1:kmax
%     LHS = ((M^k*S1)/(c(1)*w(1,1)^k))-v(:,1);
%     LHS = norm(LHS);
%     acc2(k) = LHS;                         %get acc2 
% end


l1 = abs(w(1,1));                          %get lambda1 and lambda2
l2 = abs(w(2,2));
m = l2/l1;

C=0;
for i=2:length(c_vec)
    C = (c(i)/c(1))^2+C;                
end
C = sqrt(C);                              %get C
acc3 = zeros(5,1);
for k=1:kmax
    RHS = m^k*C;
    acc3(k) = RHS;                        %get difference get by error bound
end
