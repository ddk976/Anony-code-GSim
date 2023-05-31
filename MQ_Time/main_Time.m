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


qa= 200;                                                     %set query size
qb = 100;
[QA,QB] = rdm_sel(a,b,qa,qb);                                %get queries


fprintf('\n\n========== GSim ============\n\n');
tic 
[~,~,time] = gsim_GSim_iter_Q(a,b,kmax,QA,QB);             %get running time
period_time = toc;

 
% fprintf('\n\n========== GSim+ ============\n\n');
% tic
% [~,~,time] = gsim_GSimP_iter_Q(a,b,kmax,QA,QB);  
% period_time = toc;

% fprintf('\n\n========== GSVD ============\n\n');
% 
% r=4;                                                         %setting approximation rank      
% 
% tic
% [~,~,time] = gsim_GSVD_iter_Q(a,b,kmax,r,QA,QB);  
% period_time = toc;

fprintf(' >         dataset              :  %s \n', fname);
fprintf(' >      # of nodes (Ga)         :  %d \n', na);
fprintf(' >      # of edges (Ga)         :  %d \n', ma);
fprintf(' >      # of nodes (Gb)         :  %d \n', nb);
fprintf(' >      # of edges (Gb)         :  %d \n', mb);
fprintf(' >      # of QA (qa)         :  %d \n', length(QA));
fprintf(' >      # of QB (qb)         :  %d \n', length(QB));

fprintf(' >  total CPU time        :  %fs \n', period_time);
fprintf(' >  Extraction time        :  %fs \n', time(end));
fprintf(' >  # of Iterations             :  %d \n', kmax);
time(kmax)
