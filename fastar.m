function [optimal_path] = fastar(start,target,map,diagonal)
% FASTAR [optimal_path] = fastar(start,target,map,diagonal)
% A star algorithm on a 4D map
%
% start position: [o p z r]
% target position: [o p z r]
% map: [o] x [p] x [z] x [r]
% diagonal: true/false (to allow diagonal movements)

% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

%% Add the missing arguments

if nargin < 4, diagonal = 0; end

%% Initialize the open and closed lists

% Obtain obstacles from map
% Initialize the map with input values
% obstacle = 0, space = 1

% Open list
% open: is_on_list position parent h(n) g(n) f(n)

% Current node
% position: o p z r

% Parent node
% parent: o p z r

% Limits of the map coordinates
map_max = [size(map,1) size(map,2) size(map,3) size(map,4)];

open = [];

% Closed list structure
% closed: i_c * [o p z r]
closed = [];

% Put all the obstacles on the closed list:
i_c = 1;
for i_o = 1 : map_max(1)
    for i_p = 1 : map_max(2)
        for i_z = 1 : map_max(3)
            for i_r = 1 : map_max(4)
                if(map(i_o,i_p,i_z,i_r) == 0)
                    closed(i_c,1) = i_o;
                    closed(i_c,2) = i_p;
                    closed(i_c,3) = i_z;
                    closed(i_c,4) = i_r;
                    i_c = i_c + 1;
                end
            end
        end
    end
end

closed_count = size(closed,1);

%% Set the current position as the first node
position = start;
open_count = 1;
path_cost = 0;
goal_distance = fdistance(position,target);
open(open_count,:) = fastar_insert(position,position,path_cost,goal_distance,goal_distance);
open(open_count,1) = 0;
closed_count = closed_count + 1;
closed(closed_count,:) = position;
no_path = 1;

%% Astar Algorithm

while (~isequal(position,target) && no_path == 1)
    if diagonal
        exp_array = fastar_expand_array_diagonal(position,path_cost,target,closed,map_max);
    else
        exp_array = fastar_expand_array(position,path_cost,target,closed,map_max);
    end
    exp_count = size(exp_array,1);
    % Update the open list with the successor nodes
    
    % Expanded array
    % exp_array: s h(n) g(n) f(n)
    
    % Open list
    % open: is_on_list current parent h(n) g(n) f(n)
    
    for i = 1 : exp_count
        flag = 0;
        for j = 1 : open_count
            if (isequal(exp_array(i,1:4),open(j,2:5)))
                open(j,12) = min(open(j,12),exp_array(i,7)); % Assign minimum fn
                if open(j,12) == exp_array(i,7) % Check minimum fn
                    % Update parents, hn, gn:
                    open(j,6:9) = position;
                    open(j,10) = exp_array(i,5); %hn
                    open(j,11) = exp_array(i,6); %gn
                    
                end % End of minimum fn check
                flag = 1;
            end %End of node check
            %         if flag == 1
            %             break;
        end % End of j for
        if flag == 0
            open_count = open_count + 1;
            open(open_count,:) = fastar_insert(exp_array(i,1:4),position,exp_array(i,5),exp_array(i,6),exp_array(i,7));
        end % End of insert new element into the open list
    end %End of i for
    
    % Find out the node with the smallest fn
    index_min_node = fastar_min_fn(open,open_count,target);
    
    if (index_min_node ~= -1)
        % Set position to the node with minimum fn:
        position = open(index_min_node,2:5);
        path_cost = open(index_min_node,10); % Update the cost of reaching the parent node
        % Move the position to the closed list:
        closed_count = closed_count + 1;
        closed(closed_count,1:4) = position;
        open(index_min_node,1) = 0;
    else
        % No path exists to the target
        no_path = 0; % Exits the loop
    end % End of index_min_node check
    
end % End of while loop of Astar Algorithm

%% Generate the optimal path

%Once algorithm has run The optimal path is generated by starting of at the
%last node (if it is the target node) and then identifying its parent node
%until it reaches the start node. This is the optimal path

k = size(closed,1);
optimal_path = [];

i = 1;
optimal_path(i,:) = closed(k,:);

i = i + 1;
if (isequal(closed(k,:),target))
    
    %Traverse the open list and determine the parent nodes
    i_node = fastar_node_index(open,position); % fastar_node_index returns the index of the node
    parent = open(i_node,6:9);
    
    while(~isequal(parent,start))
        optimal_path(i,:) = parent;
        % Get the grandparents
        i_node = fastar_node_index(open,parent);
        parent = open(i_node,6:9);
        i = i + 1;
    end
    
    optimal_path = flip(optimal_path,1);
    
    % Plot the optimal path here
    
else
    % h = msgbox('Sorry, no path exists to the target!','warn');
    % uiwait(h,5);
    optimal_path = [];
end
