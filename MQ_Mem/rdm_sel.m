function [qa,qb] = rdm_sel(A,B,na,nb)
%rdm_sel randomly select queries from A and B with different degree size
%   Input: 
%             A,B: adjacency Matrix
%             na,nb: query set size
%   Output: 
%             qa,qb: randomly selected query sets
    if na>size(A,1)
        disp("QA size too large");
    elseif nb>size(B,1)
        disp("QB size too large");
    else
    
        Va = length(A);
        bin_size_A = floor(Va/10);              %get bin size
        
        Vb = length(B);
        bin_size_B = floor(Vb/10);
        
        select_size_a = ceil(na/10);
        select_size_b = ceil(nb/10);
        
        deg_A = sum(A,2)+sum(A,1)';
        [~, sort_idx_A] = sort(deg_A, 'descend'); %ranking A by degree

        deg_B = sum(B,2)+sum(B,1)';
        [~, sort_idx_B] = sort(deg_B, 'descend'); %ranking B by degree

        qa=[];
        qa = sparse(qa);
        qb=[];
        qb = sparse(qb);
        disp("generating QA"); 

        for i=1:10
            if length(qa)>=na
                break; 
            end
            idx_A = randperm(bin_size_A, select_size_a);
            idx_A = idx_A+bin_size_A*(i-1);       % getting QA in each bin
            qa = [qa;sort_idx_A(idx_A)];
            
        end

        disp("generating QB");
        for i=1:10
            if length(qb)>=nb
                break;
            end
            idx_B = randperm(bin_size_B, select_size_b);
            idx_B = idx_B+bin_size_B*(i-1);      % getting QB in each bin
            qb = [qb;sort_idx_B(idx_B)];
        end
        qa = sort(qa(1:na));
        qb = sort(qb(1:nb));
    
    end
end