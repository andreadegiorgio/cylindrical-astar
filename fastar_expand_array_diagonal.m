function exp_array=fastar_expand_array_diagonal(p,hn,t,closed,map_max)
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

% Position
% p: o p z r

% Target
% t: o p z r

% Successor
% s: o p z r

exp_array = [];
exp_count = 1;
closed_max = size(closed,1); % Number of elements in closed including the zeros
for i_o = 1 : map_max(1)
    for i_p = 1:-1:-1
        for i_z = 1:-1:-1
            for i_r = 1:-1:-1
                if ~(i_o==p(1) && i_p==0 && i_z==0 && i_r==0) % The node itself is not its successor
                    s = [i_o p(2)+i_p p(3)+i_z p(4)+i_r];
                    
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
                        
                    end% End of node within array bound
                    
                end%End of if node is not its own successor loop
                
            end % End of i_r for loop
        end % End of i_z for loop
    end % End of i_p for loop
end % End of i_o for loop