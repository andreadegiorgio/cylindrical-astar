% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

target = [1 37 13 24]; % Home coordinates
% t: [o p z r]

[c,p] = fmovetotargetd(current,target,mini_joints,mini);

if ~exist('viewrobot','var')
    viewrobot = 0;
end

if ~isempty(p)
    p = [current; p];
    fview4D(p,mini_joints,mini_p,mini_z,mini_r,viewrobot);
    fviewvolume(p,mini_joints,mini_p,mini_z,mini_r);
end
current = c
[n,s] = fnextmove(current,mini);
s