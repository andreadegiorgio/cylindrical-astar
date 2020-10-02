% Define obstacle
% Make shape 1
V1 = 100*[4 -1 8;6 -1 8;6 1 8;4 1 8;4 -1 10;6 -1 10;6 1 10;4 1 10];
F1 = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
S1.Vertices = V1;
S1.Faces = F1;
S1.FaceVertexCData = jet(size(V1,1));
S1.FaceColor = 'interp';

image(10);
S1Obj = patch(S1);
view(3);
axis equal;
hold on;


q = fmap2q(mini_joints,current);
bb = fgeneratevolume(q);
n_bb = size(bb,1);
if current(1,1) == 1
    for i = 1 : n_bb
        trisurf(bb{i}.faces,bb{i}.vertices(:,1),bb{i}.vertices(:,2),bb{i}.vertices(:,3),'FaceColor', [0 0.7 0.9], 'faceAlpha', 0.4,'LineStyle','-', 'edgecolor',[0.3 0.3 0.3],'edgealpha',0.4);
        hold on;
    end
elseif current(1,1) == 2
    for i = 1 : n_bb
        trisurf(bb{i}.faces,bb{i}.vertices(:,1),bb{i}.vertices(:,2),bb{i}.vertices(:,3),'FaceColor', [0 0.8 0.4], 'faceAlpha', 0.4,'LineStyle','-', 'edgecolor',[0.3 0.3 0.3],'edgealpha',0.4);
        hold on;
    end
elseif current(1,1) == 3
    for i = 1 : n_bb
        trisurf(bb{i}.faces,bb{i}.vertices(:,1),bb{i}.vertices(:,2),bb{i}.vertices(:,3),'FaceColor', [0.8 0 0], 'faceAlpha', 0.4,'LineStyle','-', 'edgecolor',[0.3 0.3 0.3],'edgealpha',0.4);
        hold on;
    end
elseif current(1,1) == 4
    for i = 1 : n_bb
        trisurf(bb{i}.faces,bb{i}.vertices(:,1),bb{i}.vertices(:,2),bb{i}.vertices(:,3),'FaceColor', [1 0.9 0.4], 'faceAlpha', 0.4,'LineStyle','-', 'edgecolor',[0.3 0.3 0.3],'edgealpha',0.4);
        hold on;
    end
elseif current(1,1) == 5
    for i = 1 : n_bb
        trisurf(bb{i}.faces,bb{i}.vertices(:,1),bb{i}.vertices(:,2),bb{i}.vertices(:,3),'FaceColor', [0.8 0.2 0.5], 'faceAlpha', 0.4,'LineStyle','-', 'edgecolor',[0.3 0.3 0.3],'edgealpha',0.4);
        hold on;
    end
else
    for i = 1 : n_bb
        trisurf(bb{i}.faces,bb{i}.vertices(:,1),bb{i}.vertices(:,2),bb{i}.vertices(:,3),'FaceColor', 'cyan', 'faceAlpha', 0.4,'LineStyle','-', 'edgecolor',[0.3 0.3 0.3],'edgealpha',0.4);
        hold on;
    end
end

for i = 5 %1 : n_bb
    % Make shape 2
    S2.Vertices = bb{i, 1}.vertices;
    S2.Faces = bb{i, 1}.faces;
    S2.FaceVertexCData = jet(size(bb{i, 1}.vertices,1));
    S2.FaceColor = 'interp';
    S2Obj = patch(S2);
    hold on;
    iterationsAllowed = 6;
    collisionFlag = GJK(S1Obj,S2Obj,iterationsAllowed);
    
    if collisionFlag
        t = text(3,3,3,'Collision!','FontSize',30);
        break
    end
end