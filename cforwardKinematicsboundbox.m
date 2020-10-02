function [A_0_1, A_1_2, A_2_3, A_3_4, A_4_5, A_5_6, A_6_7, A_7_8] = cforwardKinematicsboundbox(robot,th)
%This function gives out the forward kinematics transformation matrices for
%the ABB 1600-X/1.2
%The DH Parameter are as follows
%   i       Link twist     Link Length     Link Offset    Joint Angle    
%--------------------------------------------------------------------------
%   1        -90              d2             d1                 theta1*     
%   2         0               d3              0               theta2 - 90*  
%   3        -90               0              0                 theta3*     
%   4         90               0             d4                 theta4*     
%   5        -90               0              0                 theta5*     
%   6         0                0             d5                 theta6*     

% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

%Transformation matrix for frame 1 represented in frame 0
A_0_1 = make_tfMatrix(0, 0, 0 ,robot.d1);  
%Transformation matrix for frame 2 represented in frame 1
A_1_2 = make_tfMatrix(robot.d2, -90, th(1) ,0);
%Transformation matrix for frame 3 represented in frame 2
A_2_3 = make_tfMatrix(0,  0, 0 , -162.835);
%Transformation matrix for frame 4 represented in frame 3
A_3_4 = make_tfMatrix(robot.d3,  0, th(2) - 90 , 0);
%Transformation matrix for frame 5 represented in frame 4
A_4_5 = make_tfMatrix(0, -90,      th(3)    ,  162.835);
%Transformation matrix for frame 6 represented in frame 5
A_5_6 = make_tfMatrix(0,  90,      th(4)    , robot.d4);
%Transformation matrix for frame 7 represented in frame 6
A_6_7 = make_tfMatrix(0, -90,      th(5)    , 0);
%Transformation matrix for frame 8 represented in frame 7
A_7_8 = make_tfMatrix(0,   0,      th(6)    , robot.d5);
end

