clearvars;
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

kmax = 2;                                                    %set kmax 

na = size(a,1);
ma = nnz(a);
nb = size(b,1);
mb = nnz(b);


qa= 2000;                                                    %set query size
qb = 200;
[QA,QB] = rdm_sel(A,B,qa,qb);                                %get queries


fprintf('\n\n========== GSim ============\n\n');

[~,space,~] = gsim_naive_iter_Q(A,B,kmax,QB,QA);              %get mempry usage


 
% fprintf('\n\n========== GSim+ ============\n\n');
% tic
% [~,space,~] = gsim_lowrank_iter_Q(b,a,kmax,QB,QA);  
% period_time = toc;

% fprintf('\n\n========== GSVD ============\n\n');
% tic
% [~,space,~] = gsim_SVD_iter_Q(b,a,kmax,QB,QA);  
% period_time = toc;

fprintf(' >         dataset              :  %s \n', fname);
fprintf(' >      # of nodes (Ga)         :  %d \n', na);
fprintf(' >      # of edges (Ga)         :  %d \n', ma);
fprintf(' >      # of nodes (Gb)         :  %d \n', nb);
fprintf(' >      # of edges (Gb)         :  %d \n', mb);
fprintf(' >      # of QA (qa)         :  %d \n', length(QA));
fprintf(' >      # of QB (qb)         :  %d \n', length(QB));

fprintf(' >  Extraction time        :  %fs \n', time(end));
fprintf(' >  total space         :  %f \n', space(kmax));
fprintf(' >  # of Iterations             :  %d \n', kmax);
time(kmax)
