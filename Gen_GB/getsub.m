function [subA,sub_nodes] = getsub(A,gsize,dir)
%getsub Generate a connected subgraph of GA 
%   Input: 
%             A: adjacency Matrix of GA
%             gsize: required size of GB
%             dir: 'dir' for directe GA, 'undir' for undirected GA 
%   Output: 
%             subA  = generated connected GB
%             sub_nodes = all vertices of GB
    subsize=gsize;
    if gsize>size(A,1)                      %check the demand sungraph size 
        subA ="subgraph size larger than graph size";
        disp("subgraph size larger than graph size");
        sub_nodes =[];
    else
    
        if strcmp(dir,"undir")              %check graph type and max graph size
            deg = sum(A,2);
            G = graph(A);
            [~,binsize] = conncomp(G);
        else
            deg = sum(A,2)+sum(A,1)';
            G=digraph(A);
            [~,binsize] = conncomp(G,'Type','weak');
        end
        
        if(subsize>max(binsize))            
            subsize=max(binsize);
        end
    
        [~, sort_idx] = sort(deg, 'descend'); %get the top-100 node has most degree
        idx = randperm(100, 1);               %random pick a start from top nodes
        start = sort_idx(idx);
        sub_nodes =  [start];
    
        sub_nodes = sel_conn(A,subsize,start);
    
        while length(sub_nodes)<gsize       %randonly select nodes when subgraph size not enough
            disp("not enough nodes")
            fprintf(' >      # of nodes now        :  %d \n', length(sub_nodes));
            nodes = sparse(setdiff(sort_idx,sub_nodes));
            num = gsize-length(sub_nodes);
            node_idx = randperm(min(100,length(nodes)), 1);
            start = nodes(node_idx);
            add_node = sel_conn(A,num,start);
            fprintf(' >      # of nodes added        :  %d \n', length(add_node));
            sub_nodes = unique([sub_nodes add_node]);
        end
        subA = A(sub_nodes,sub_nodes);
        col_num = sum(subA,2);
        col_num = col_num+sum(subA,1)';
        sn = size(col_num,1)-nnz(col_num);
        fprintf(' >      # of single node        :  %d \n', sn);
    end
end
function [sub_nodes] = sel_conn(A,subsize,start)
    sub_nodes =[start];
    A_t=A';

    disp("going to while loop")
    count=0;                                   %counter count loop time
    while length(sub_nodes)<subsize
        count=count+1;
        if count>5*subsize                     %avoid stuck 
            break;
        end

        node_idx = randperm(length(sub_nodes), 1);
        node = sub_nodes(node_idx);

        [row,~,~] =find(A(:,node)==1);
        [col,~,~] =find(A_t(:,node)==1);

        neighbor = unique([row' col']); 

        if isempty(neighbor)
            continue;
        end
        
        select_size = randi([1,min(length(neighbor),subsize-length(sub_nodes))]);
        idx = randperm(length(neighbor), select_size);
        sub_nodes = unique([sub_nodes neighbor(idx)]);

    disp("While loop finish")
end
