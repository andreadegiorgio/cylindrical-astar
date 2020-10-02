function i_min = fastar_min_fn(open,open_count,t)
% Function to return the node with minimum fn
% This function takes the open list as its input and returns the index of the
% node that has the least cost
%
% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------
% Target
% t: o p z r

% Open list
% open: is_on_list current parent h(n) g(n) f(n)
%--------------------------------------------------------------------------
%IS ON LIST 1/0 |X val |Y val |Parent X val |Parent Y val |h(n) |g(n)|f(n)|
%--------------------------------------------------------------------------

 temp_array = [];
 k = 1;
 flag = 0;
 goal_index = 0;
 for j = 1 : open_count
     if (open(j,1)==1)
         temp_array(k,:) = [open(j,:) j];
         if(isequal(open(j,2:5),t))
             flag = 1;
             goal_index = j; % Store the index of the goal node
         end
         k = k + 1;
     end
 end % Get all nodes that are on the list open
 if flag == 1 % One of the successors is the goal node so send this node
     i_min = goal_index;
 end
 % Send the index of the smallest node
 if ~isempty(temp_array)
  [min_fn,i_temp_min] = min(temp_array(:,12)); % Index of the smallest node in temp array
  i_min = temp_array(i_temp_min,13); % Index of the smallest node in the open array
 else
     i_min = -1; % The temp_array is empty i.e no more paths are available
 end