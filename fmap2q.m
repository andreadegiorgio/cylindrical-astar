function [q] = fmap2q(map_joints,pos)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

q = map_joints((1+6*(pos(1,1)-1)):(6*pos(1,1)),pos(1,2),pos(1,3),pos(1,4));
q = q';
end