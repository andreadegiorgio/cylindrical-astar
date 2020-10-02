function [c,p] = fmovetotarget(c,t,mj,mjb)
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

p = fastar(c,t,mjb);
% p: P x [o,p,z,r]

if ~isempty(p)
    for i_p = 1 : size(p,1)
        a_moveJoints(mj((1+6*(p(i_p,1)-1)):(6*p(i_p,1)),p(i_p,2),p(i_p,3),p(i_p,4)));
    end
    c = t;
else
end