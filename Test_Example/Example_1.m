A = [0, 1, 1, 0, 0, 0, 0, 0        %adjacency matrix for GA
0, 0, 1, 0, 0, 0, 1, 1 
0, 1, 0, 0, 1, 0, 1, 1 
1, 0, 0, 0, 1, 0, 0, 0 
0, 0, 0, 0, 0, 0, 1, 0 
0, 0, 0, 1, 1, 0, 1, 0 
0, 1, 1, 0, 0, 0, 0, 1 
0, 1, 1, 0, 0, 0, 1, 0];

B=[0, 0, 1, 0, 0                    %adjacency matrix for GB
1, 0, 1, 1, 1 
0, 1, 0, 1, 1 
0, 1, 1, 0, 1 
0, 1, 1, 1, 0];


QA = [1,3,7,8];                     %declear QA
QB = [2,3,4];                       %declear QB

kmax  = 50;                         %define kmax

S1 = gsim_GSim_iter_Q(B,A,kmax,QB,QA);
