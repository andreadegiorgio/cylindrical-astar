function [] = fview4D(trajectory,mini_joints,mini_p,mini_z,mini_r,rob)
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

%close all;
figure(1);

if (nargin < 6) rob = 0; end
    
if rob
    robot = a_robot_parameters();
    
    %% Draw the ABB IRB 1600 Robot
    
    % The link length and link offsets
    global d1 d2 d3 d4 d5 sc
    sc = 1; %scaling
    d1 = 486.5/sc; d2 = 150/sc; d3 = 700/sc; d4 = 600/sc; d5 = 65/sc;
    
    ABB_color = [0.8 0.44 0.33];
    % Reading the STL files
    link1 = stlread('link1.stl'); link1.facecolor = ABB_color; link1.edgecolor = ABB_color-0.1; link1.vertices = link1.vertices / sc;
    link2 = stlread('link2.stl'); link2.facecolor = ABB_color; link2.edgecolor = ABB_color-0.1; link2.vertices = link2.vertices / sc;
    link3 = stlread('link3.stl'); link3.facecolor = ABB_color; link3.edgecolor = ABB_color-0.1; link3.vertices = link3.vertices / sc;
    link4 = stlread('link4.stl'); link4.facecolor = ABB_color; link4.edgecolor = ABB_color-0.1; link4.vertices = link4.vertices / sc;
    link5 = stlread('link5.stl'); link5.facecolor = ABB_color; link5.edgecolor = ABB_color-0.1; link5.vertices = link5.vertices / sc;
    link6 = stlread('link6.stl'); link6.facecolor = ABB_color; link6.edgecolor = ABB_color-0.1; link6.vertices = link6.vertices / sc;
    link7 = stlread('link7.stl'); link7.facecolor = [0.8 0.8 0.8]; link7.edgecolor = 'none'; link7.vertices = link7.vertices / sc;
    
    % Initial transformation equations.
    th1 = mini_joints(1+6*(trajectory(end,1)-1),trajectory(end,2),trajectory(end,3),trajectory(end,4));
    th2 = mini_joints(2+6*(trajectory(end,1)-1),trajectory(end,2),trajectory(end,3),trajectory(end,4));
    th3 = mini_joints(3+6*(trajectory(end,1)-1),trajectory(end,2),trajectory(end,3),trajectory(end,4));
    th4 = mini_joints(4+6*(trajectory(end,1)-1),trajectory(end,2),trajectory(end,3),trajectory(end,4));
    th5 = mini_joints(5+6*(trajectory(end,1)-1),trajectory(end,2),trajectory(end,3),trajectory(end,4));
    th6 = mini_joints(6+6*(trajectory(end,1)-1),trajectory(end,2),trajectory(end,3),trajectory(end,4));
    
    [ A_0_1, A_1_2, A_2_3, A_3_4, A_4_5, A_5_6 ] = forwardKinematics( th1, th2, th3, th4, th5, th6 );
    
    A_0_2 = A_0_1*A_1_2;
    A_0_3 = A_0_1*A_1_2*A_2_3;
    A_0_4 = A_0_1*A_1_2*A_2_3*A_3_4;
    A_0_5 = A_0_1*A_1_2*A_2_3*A_3_4*A_4_5;
    A_0_6 = A_0_1*A_1_2*A_2_3*A_3_4*A_4_5*A_5_6;
    
    % Moving the links to their correct position in the MATLAB simulation
    bringLinksToOrigin();
    
    link2_current = homogeneousTransformation(link2_moved, A_0_1);
    link3_current = homogeneousTransformation(link3_moved, A_0_2);
    link4_current = homogeneousTransformation(link4_moved, A_0_3);
    link5_current = homogeneousTransformation(link5_moved, A_0_4);
    link6_current = homogeneousTransformation(link6_moved, A_0_5);
    link7_current = homogeneousTransformation(link7_moved, A_0_6);
    
    %Draw the point
    patch(link1_moved);
    patch(link2_current);
    patch(link3_current);
    patch(link4_current);
    patch(link5_current);
    patch(link6_current);
    patch(link7_current);
    hold on;
    
end

%% Draw the 4D map

% trajectory: [L] x [o p z r]

cyl_o = zeros(size(trajectory,1),1);
x = zeros(size(trajectory,1),1);
y = zeros(size(trajectory,1),1);
z = zeros(size(trajectory,1),1);
linecolor = zeros(size(trajectory,1),3);

for k = 1 : size(trajectory,1)
    cyl_o(k) = trajectory(k,1);
    cyl_p = trajectory(k,2);
    cyl_z = trajectory(k,3);
    cyl_r = trajectory(k,4);
    x(k) = mini_r(cyl_r) * cos(mini_p(cyl_p) * (2 * pi) ./ 360);
    y(k) = mini_r(cyl_r) * sin(mini_p(cyl_p) * (2 * pi) ./ 360);
    z(k) = mini_z(cyl_z);
    switch cyl_o(k)
        case 1
            linecolor(k,:) = [0 0.7 0.9];
        case 2
            linecolor(k,:) = [0 0.8 0.4];
        case 3
            linecolor(k,:) = [0.8 0 0];
        case 4
            linecolor(k,:) = [1 0.9 0.4];
        case 5
            linecolor(k,:) = [0.8 0.2 0.5];
        otherwise
            linecolor(k,:) = [0.33 0.33 0.33];
    end
        
    scatter3(x(k),y(k),z(k),'MarkerEdgeColor',[0.33 0.33 0.33],'MarkerEdgeAlpha',0.8,'MarkerFaceColor',linecolor(k,:),'MarkerFaceAlpha',0.4);
    hold on;
    if k > 1
        p=plot3([x(k-1) x(k)],[y(k-1) y(k)],[z(k-1) z(k)],'Color',linecolor(k-1,:));
        p.LineWidth = 3;
        hold on;
    end
end

% Define obstacle
% Make shape 1
% V1 = 100*[4 -1 8;6 -1 8;6 1 8;4 1 8;4 -1 10;6 -1 10;6 1 10;4 1 10];
% F1 = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
% S1.Vertices = V1;
% S1.Faces = F1;
% S1.FaceVertexCData = jet(size(V1,1));
% S1.FaceColor = 'interp';
% 
% S1Obj = patch(S1);
% hold on;

if rob
    axis equal;
    axis([-800 800 -500 500 0 1500]);
    view(3), xlabel('x axis'), ylabel('y axis'), zlabel('z axis'), grid on;
    view(35.2467,19.6904);
else
    axis equal;
    view(3), xlabel('x axis'), ylabel('y axis'), zlabel('z axis'), grid on;
    view(35.2467,19.6904);
end

end

