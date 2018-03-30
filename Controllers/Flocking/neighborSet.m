function [qj,pj] = neighborSet(qi,pi,n)

%Allocate space for the data
qj = zeros(n-1,3,n);
pj = zeros(n-1,3,n);
bar = zeros(n-1,3,2);

% This scheme sorts the data such that the information for the ith agent is
% replaced by the previous agent's. This type of ordering scheme will be
% used throughout this simulation --> 1st agent => qj(:,:,1) = [q2;q3;q4;...;qn]
%                                     2nd agent => qj(:,:,2) = [q1;q3;q4;...;qn]
%                                     3rd agent => qj(:,:,3) = [q1;q2;q4;...;qn]
%                                     nth agent => qj(:,:,n) = [q1;q2;q3;...;q_n-1]

for i = 1:n
    if i == 1
        for j = 1:n-1
            qj(j,:,i) = qi(i+j,:);
            pj(j,:,i) = pi(i+j,:);
        end
        clear j
        bar(:,:,1) = qj(:,:,i);
        bar(:,:,2) = pj(:,:,i);
    else
        for j = 1:n-1
            bar(i-1,:,1) = qi(i-1,:);
            bar(i-1,:,2) = pi(i-1,:);
            qj(j,:,i) = bar(j,:,1);
            pj(j,:,i) = bar(j,:,2);
        end  
        clear j
        clear bar
        bar(:,:,1) = qj(:,:,i);
        bar(:,:,2) = pj(:,:,i);
    end
end


end
