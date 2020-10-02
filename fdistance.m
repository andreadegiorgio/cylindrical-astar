function [distance] = fdistance(c,d)
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

N_theta = 72;
c(4) = c(4) - 16;
d(4) = d(4) - 16;

if (c(4)>=0 && d(4)<=0) || (c(4)<=0 && d(4)>=0)
    R = 0;
elseif (abs(c(4)) >= abs(d(4)))
    R = d(4);
else
    R = c(4);
end

if (c(1) == d(1))
    distance_o = 1;
else
    distance_o = 2;
end

% c: o,p,z,r
distance = distance_o * sqrt( (2*pi/N_theta).^2 * R.^2 * (c(2)-d(2)).^2 + (c(3)-d(3)).^2 + (c(4)-d(4)).^2);

% Working version:
% if d(4) >= c(4)
%     distance = distance_o * sqrt( (2*pi/N_theta).^2 * (d(4)).^2 * (c(2)-d(2)).^2 + (c(3)-d(3)).^2 + (c(4)-d(4)).^2);
% else
%     distance = distance_o * sqrt( (2*pi/N_theta).^2 * (c(4)).^2 * (c(2)-d(2)).^2 + (c(3)-d(3)).^2 + (c(4)-d(4)).^2);
% end

% OLD
% if d(4) >= c(4)
%     distance = sqrt( (2*pi/N_theta).^2 * (d(4)).^2 * (c(2)-d(2)).^2 + (c(3)-d(3)).^2 + (c(4)-d(4)).^2 + (c(1)-d(1)).^2);
% else
%     distance = sqrt( (2*pi/N_theta).^2 * (c(4)).^2 * (c(2)-d(2)).^2 + (c(3)-d(3)).^2 + (c(4)-d(4)).^2 + (c(1)-d(1)).^2);
% end

% OLD
% c: p,z,r,o
% if d(3) >= c(3)
%     distance = sqrt( (2*pi/N_theta).^2 * (d(3)).^2 * (c(1)-d(1)).^2 + (c(2)-d(2)).^2 + (c(3)-d(3)).^2 + (c(4)-d(4)).^2);
% else
%     distance = sqrt( (2*pi/N_theta).^2 * (c(3)).^2 * (c(1)-d(1)).^2 + (c(2)-d(2)).^2 + (c(3)-d(3)).^2 + (c(4)-d(4)).^2);
% end
% By applying a factor to the orientation coordinate in the distance equation
% we can either postpone or anticipate the change of orientation in the search

%Almost working:
%distance = sqrt( (pi/36).^2 * c(3) * d(3) * (c(1)-d(1)).^2 + (c(2)-d(2)).^2 + (c(3)-d(3)).^2 + (c(4)-d(4)).^2);