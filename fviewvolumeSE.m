function [] = fviewvolumeSE(trajectory,mini_joints,mini_p,mini_z,mini_r)
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
figure(2);

% %% Draw the 4D map
% 
% % trajectory: [L] x [o p z r]
% 
% cyl_o = zeros(size(trajectory,1),1);
% x = zeros(size(trajectory,1),1);
% y = zeros(size(trajectory,1),1);
% z = zeros(size(trajectory,1),1);
% linecolor = zeros(size(trajectory,1),3);
% 
% for k = 1 : size(trajectory,1)
%     cyl_o(k) = trajectory(k,1);
%     cyl_p = trajectory(k,2);
%     cyl_z = trajectory(k,3);
%     cyl_r = trajectory(k,4);
%     x(k) = mini_r(cyl_r) * cos(mini_p(cyl_p) * (2 * pi) ./ 360);
%     y(k) = mini_r(cyl_r) * sin(mini_p(cyl_p) * (2 * pi) ./ 360);
%     z(k) = mini_z(cyl_z);
%     switch cyl_o(k)
%         case 1
%             linecolor(k,:) = [0 0.7 0.9];
%         case 2
%             linecolor(k,:) = [0 0.8 0.4];
%         case 3
%             linecolor(k,:) = [0.8 0 0];
%         otherwise
%             linecolor(k,:) = [0.33 0.33 0.33];
%     end
%         
%     scatter3(x(k),y(k),z(k),'MarkerEdgeColor',[0.33 0.33 0.33],'MarkerEdgeAlpha',0.8,'MarkerFaceColor',linecolor(k,:),'MarkerFaceAlpha',0.4);
%     hold on;
%     if k > 1
%         p=plot3([x(k-1) x(k)],[y(k-1) y(k)],[z(k-1) z(k)],'Color',linecolor(k-1,:));
%         p.LineWidth = 3;
%         hold on;
%     end
% end

n_trajectory = size(trajectory,1);

for k = 1 : n_trajectory
    q = mini_joints((1+6*(trajectory(k,1)-1)):(6*trajectory(k,1)),trajectory(k,2),trajectory(k,3),trajectory(k,4));
    q = q';
    bb = fgeneratevolume(q);
    n_bb = size(bb,1);
    if k == 1
        for i = 1 : n_bb
            trisurf(bb{i}.faces,bb{i}.vertices(:,1),bb{i}.vertices(:,2),bb{i}.vertices(:,3),'FaceColor', 'red', 'faceAlpha', 0.4,'LineStyle','-', 'edgecolor',[0.3 0.3 0.3],'edgealpha',0.4);
            hold on;
        end
    elseif k == n_trajectory
        for i = 1 : n_bb
            trisurf(bb{i}.faces,bb{i}.vertices(:,1),bb{i}.vertices(:,2),bb{i}.vertices(:,3),'FaceColor', 'green', 'faceAlpha', 0.4,'LineStyle','-', 'edgecolor',[0.3 0.3 0.3],'edgealpha',0.4);
            hold on;
        end
    else
        for i = 1 : n_bb
            trisurf(bb{i}.faces,bb{i}.vertices(:,1),bb{i}.vertices(:,2),bb{i}.vertices(:,3),'FaceColor', 'cyan', 'faceAlpha', 0.4,'LineStyle','-', 'edgecolor',[0.3 0.3 0.3],'edgealpha',0.4);
            hold on;
        end
    end

end


axis equal;
axis auto;
view(3), xlabel('x axis'), ylabel('y axis'), zlabel('z axis'), grid on;
view(35.2467,19.6904);

end

