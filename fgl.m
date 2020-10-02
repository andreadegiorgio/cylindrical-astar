function [c] = fgl(c,mj,mjb)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

% c: o,p,z,r
if c(2) > 1
    if mjb(c(1),c(2)-1,c(3),c(4)) ~= 0
        a_moveJoints(mj((1+6*(c(1)-1)):(6*c(1)),c(2)-1,c(3),c(4)));
        c(2) = c(2) - 1;
    end
end

% OLD
% c: p,z,r,o
% if c(1) > 1
%     if mjb(c(4),c(1)-1,c(2),c(3)) ~= 0
%         a_moveJoints(mj((1+6*(c(4)-1)):(6*c(4)),c(1)-1,c(2),c(3)));
%         c(1) = c(1) - 1;
%     end
% end