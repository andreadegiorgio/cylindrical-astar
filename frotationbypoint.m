function [ R ] = frotationbypoint(P)
%ROTATIONBYPOINT Summary of this function goes here
%   rotating the point (x,y,z) about the line through (a,b,c) with
%   direction vector (u,v,w)

% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

[azimuth,elevation,~] = cart2sph(P(1),P(2),P(3));

% elevation is the angle to move a point from plane xy to axis z
R1 = makehgtform('yrotate',elevation);

% azimuth goes from axis x to axis y
R2 = makehgtform('zrotate',-azimuth); 

R = R1 * R2;

end

