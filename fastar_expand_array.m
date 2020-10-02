function exp_array=fastar_expand_array(p,hn,t,closed,map_max)
%Function to return an expanded array
%This function takes a node and returns the expanded list
%of successors, with the calculated fn values.
%The criteria being none of the successors are on the closed list.
%
% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------
%
% Position
% p: o p z r

% Target
% t: o p z r

% Successor
% s: o p z r

% Expanded array
% exp_array: s h(n) g(n) f(n)

exp_array = [];
exp_count = 1;
closed_max = size(closed,1); % Number of elements in closed including the zeros

successors = [];
for k = 1 : map_max(1)
    successors(k,:) = [k p(2) p(3) p(4)];
end
k = k + 1;
successors(k,:) = [p(1) p(2)+1 p(3) p(4)];
k = k + 1;
successors(k,:) = [p(1) p(2)-1 p(3) p(4)];
k = k + 1;
successors(k,:) = [p(1) p(2) p(3)+1 p(4)];
k = k + 1;
successors(k,:) = [p(1) p(2) p(3)-1 p(4)];
k = k + 1;
successors(k,:) = [p(1) p(2) p(3) p(4)+1];
k = k + 1;
successors(k,:) = [p(1) p(2) p(3) p(4)-1];

for i_s = 1 : size(successors,1)
    s = successors(i_s,:);
    if( (s(2) > 0 && s(2) <= map_max(2)) && (s(3) > 0 && s(3) <= map_max(3)) && (s(4) > 0 && s(4) <= map_max(4)) )% Node within array bounds
        flag=1;
        for i_closed = 1 : closed_max % Check if a successor is on the closed list
            if(isequal(s,closed(i_closed,:)))
                flag=0;
            end
        end % End of for loop to check if a successor is on the closed list.
        
        if (flag == 1) % Populate the exp_array list
            exp_array(exp_count,1:4) = s;
            exp_array(exp_count,5) = hn + fdistance(p,s); % Cost of travelling to successor node
            exp_array(exp_count,6) = fdistance(s,t); % Distance between successor node and goal
            exp_array(exp_count,7) = exp_array(exp_count,5) + exp_array(exp_count,6); % fn
            exp_count = exp_count + 1;
        end % End of populate the exp_array list
        
    end % End of node within array bound
end % End of successors for
