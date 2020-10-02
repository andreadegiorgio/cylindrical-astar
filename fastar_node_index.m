function n_index = fastar_node_index(open,p)
    %This function returns the index of the location of a node in the open list
    %
% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

    i = 1;
    while(~isequal(open(i,2:5),p))
        i = i + 1;
    end
    n_index = i;
end