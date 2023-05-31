fpath = '../datasets/';                                    %load A
fname = ['dblp']; 

% real datasets available: 
% https://www.cise.ufl.edu/research/sparse/matrices/SNAP/
%
% as-735 dblp_03-05 dblp_06-08 dblp_09-11 email-Enron
% cit-HepPh p2p-Gnutella08 cit-Patents web-BerkStan web-Stanford 
% web-Google email-EuAll soc-LiveJournal1 uk-2002

fn = [fpath, fname, '.mat'];
load(fn);
a = Problem.A;
clear Problem;

fnb  = ['./GB_file/', fname, '_GB.mat'];
load(fnb);                                                   %load B 
b = subA;
clear subA;

kmax = 5;                                                  %set kmax

qa= 200;                                                    %set QA, QB size
qb = 100;

[QA,QB] = rdm_sel(a,b,qa,qb);                                %generate QA,QB

na = size(a,1);
ma = nnz(a);
nb = size(b,1);
mb = nnz(b);

S = ones(na, nb);                                            % initialise similatity matrix

fprintf('\n\n========== get ground truth ============\n\n');
for k = 1:100
             
    S= a*S*b'+a'*S*b;                                        % get converged matrix
    S = S/norm(S, 'fro');                                    %normalization
end
         
S = S(QA,QB);                                                %extract query
S = S/norm(S, 'fro');                                        %normalize query matrix
            

fprintf('\n\n========== get acc ============\n\n');
acc_svd = gsim_GSVD_iter_acc(a,b,kmax,S,4,QA,QB);

acc = gsim_GSimP_iter_acc(a,b,kmax,S,QA,QB);

fprintf(' >         dataset              :  %s \n', fname);
fprintf(' >      # of nodes (Ga)         :  %d \n', na);
fprintf(' >      # of edges (Ga)         :  %d \n', ma);
fprintf(' >      # of nodes (Gb)         :  %d \n', nb);
fprintf(' >      # of edges (Gb)         :  %d \n', mb);
fprintf(' >      # of QA (qa)         :  %d \n', length(QA));
fprintf(' >      # of QB (qb)         :  %d \n', length(QB));

fprintf(' >  accuaracy of GSimP       :  %fs \n', acc);
fprintf(' >  accuracy of GSVD       :  %fs \n', acc_svd);
