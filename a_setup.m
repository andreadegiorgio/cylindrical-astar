clc; clear all; close all;

% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

%Mini binary validity matrix(orientation, Phi(p) [-36,36], Height(z),Radius(r)) steps every 100mm
mini = zeros(5,73,19,31);
mini_joints = zeros(30,73,19,31);

mini_p = 180 : -5 : -180; % angle p from 180 to -180 by 5 degrees, tot 73 values
mini_z = 0 : 100 : 1800; % height z from 0 to 1800 by 100mm, tot 19 values
mini_r = -1500 : 100 : 1500; % radius r from -1500 to 1500 by 100mm, tot 31 values

% mini_p = zeros(1,73);
% mini_z = zeros(1,19);
% mini_r = zeros(1,31);
% for p = 1 : size(mini_p,2)
%     mini_p(p) = -(5*p-185); % from 180 to -180 by 5 degrees
% end
% for r = 1 : size(mini_r,2)
%     mini_r(r) = r * 100;
% end
% for z = 1 : size(mini_z,2)
%     mini_z(z) = (z + 7) * 100;
% end

a_generate_CENTER;
a_generate_UP;
a_generate_DOWN;
a_generate_LEFT;
a_generate_RIGHT;

mini(1,1,1:19,1:31) = configA_CENTER(1:19,1:31);
mini(2,1,1:19,1:31) = configA_UP(1:19,1:31);
mini(3,1,1:19,1:31) = configA_DOWN(1:19,1:31);
mini(4,1,1:19,1:31) = configA_LEFT(1:19,1:31);
mini(5,1,1:19,1:31) = configA_RIGHT(1:19,1:31);

for i = 2 : 73
    mini(1,i,1:19,1:31) = mini(1,1,1:19,1:31);
    mini(2,i,1:19,1:31) = mini(2,1,1:19,1:31);
    mini(3,i,1:19,1:31) = mini(3,1,1:19,1:31);
    mini(4,i,1:19,1:31) = mini(4,1,1:19,1:31);
    mini(5,i,1:19,1:31) = mini(5,1,1:19,1:31);
end

mini_joints(1:6,37,1:19,1:31) = configA_CENTER_joints(1:6,1:19,1:31);
mini_joints(7:12,37,1:19,1:31) = configA_UP_joints(1:6,1:19,1:31);
mini_joints(13:18,37,1:19,1:31) = configA_DOWN_joints(1:6,1:19,1:31);
mini_joints(19:24,37,1:19,1:31) = configA_LEFT_joints(1:6,1:19,1:31);
mini_joints(25:30,37,1:19,1:31) = configA_RIGHT_joints(1:6,1:19,1:31);

for r = 1 : size(mini_r,2)
    for z = 1 : size(mini_z,2)
        for p = 1 : size(mini_p,2)
            if p ~= 37
                if mini(1,p,z,r) == 1
                    mini_joints(1:6,p,z,r) = mini_joints(1:6,37,z,r);
                    mini_joints(1,p,z,r) = -(5*p-185);
                end
                if mini(2,p,z,r) == 1
                    mini_joints(7:12,p,z,r) = mini_joints(7:12,37,z,r);
                    mini_joints(7,p,z,r) = -(5*p-185);
                end
                if mini(3,p,z,r) == 1
                    mini_joints(13:18,p,z,r) = mini_joints(13:18,37,z,r);
                    mini_joints(13,p,z,r) = -(5*p-185);
                end
            end
            if p >= 7 && p ~= 37 && p <= 67
                if mini(4,p,z,r) == 1
                    mini_joints(19:24,p,z,r) = mini_joints(19:24,37,z,r);
                    mini_joints(19,p,z,r) = -(5*p-185);
                end
                if mini(5,p,z,r) == 1
                    mini_joints(25:30,p,z,r) = mini_joints(25:30,37,z,r);
                    mini_joints(25,p,z,r) = -(5*p-185);
                end
            end
        end
    end
end

current = [1 37 13 24] % close to HOME
a_moveJoints(mini_joints(1:6,37,13,24));