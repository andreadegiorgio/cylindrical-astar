function [bb] = fgeneratevolume(q)
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

robot.d1 = 486.5;
robot.d2 = 150;
robot.d3 = 700;
robot.d4 = 600;
robot.d5 = 65;

[A_0_1,A_1_2,A_2_3,A_3_4,A_4_5,A_5_6,A_6_7,A_7_8] = cforwardKinematicsboundbox(robot,q);

A_0_2 = A_0_1*A_1_2;
A_0_3 = A_0_1*A_1_2*A_2_3;
A_0_4 = A_0_1*A_1_2*A_2_3*A_3_4;
A_0_5 = A_0_1*A_1_2*A_2_3*A_3_4*A_4_5;
A_0_6 = A_0_1*A_1_2*A_2_3*A_3_4*A_4_5*A_5_6; %Tranformation matrix for frame 6 represented in frame 0
A_0_7 = A_0_1*A_1_2*A_2_3*A_3_4*A_4_5*A_5_6*A_6_7;
A_0_8 = A_0_1*A_1_2*A_2_3*A_3_4*A_4_5*A_5_6*A_6_7*A_7_8;

A = cell(8,1);
A{1} = A_0_1;
A{2} = A_0_2;
A{3} = A_0_3;
A{4} = A_0_4;
A{5} = A_0_5;
A{6} = A_0_6;
A{7} = A_0_7;
A{8} = A_0_8;

p = zeros(9,3);

for k = 2 : 9
    p(k,1:3) = ft2p(A{k-1});
end

bb = cell(6,1);
k = 1;
bb{k} = cboundingbox(p(1,:),p(2,:),20,1,345);
k = k + 1;
bb{k} = cboundingbox(p(2,:),p(3,:),100,1,150);
k = k + 1;
bb{k} = cboundingbox(p(3,:),p(4,:),100,1,240);
k = k + 1;
bb{k} = cboundingboxcone(p(4,:),p(5,:),80,1,120,80);
k = k + 1;
bb{k} = cboundingboxcone(p(6,:),p(7,:),180,0,220,80);
k = k + 1;
bb{k} = cboundingboxcone(p(8,:),p(9,:),40,0,80,70);

end

