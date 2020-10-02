function [x, y, z] = ft2xyz(T)
%T2XYZ Gets the x,y,z coordinates from the T matrix

% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

        x = T(1,4);
        y = T(2,4);
        z = T(3,4);
end

