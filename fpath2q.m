function [q] = fpath2q(p,mj)
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
n_p = size(p,1);
q = zeros(n_p,6);
for i_p = 1 : n_p
    q(i_p,1:6) = (mj((1+6*(p(i_p,1)-1)):(6*p(i_p,1)),p(i_p,2),p(i_p,3),p(i_p,4)));
end
