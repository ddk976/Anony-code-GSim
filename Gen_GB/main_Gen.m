clear all;

fpath = '../datasets/';
fname = 'uk-2002';
fn = [fpath, fname, '.mat'];
load(fn);                                 %load GA
A = Problem.A;
clear Problem;

fnb = ['./GB_file/', fname, '_GB.mat'];   %define storage location

nb = 10000;                               %define |V_B|

tic
[subA,sub_node] = getsub(A,nb,'dir');
toc

save(fnb,'subA');                         %save GB
