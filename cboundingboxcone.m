function [cyl] = cboundingboxcone(P1, P2, overlenght, direction, cyl_radius1, cyl_radius2, cyl_lateral_faces)
%BOUNDING_BOX Summary of this function goes here
%   Detailed explanation goes here

% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

    if nargin < 5
        cyl_radius1 = 200;
    end

    if nargin < 6
        cyl_radius2 = 0;
    end
    
    if nargin < 7
        cyl_lateral_faces = 8;
    end

cyl_height = pdist([P1; P2]) + overlenght; % distance between joints

if direction == 1
r = cyl_radius1 : -1 : cyl_radius2;
else
r = cyl_radius2 : 1 : cyl_radius1;
end

[X,Y,Z] = cylinder(r,cyl_lateral_faces);
Z = Z * cyl_height;
X(:,end) = [];
Y(:,end) = [];
Z(:,end) = [];
X = X(:);
Y = Y(:);
Z = Z(:);
cyl.vertices = [X Y Z];

DT = delaunayTriangulation(X,Y,Z);
[cyl.faces, cyl.vertices] = freeBoundary(DT);
cyl.vertices(:,4) = ones(length(cyl.vertices),1); %homogeneous coordinates



cyl.vertices = cyl.vertices * makehgtform('yrotate',-pi/2); % Cylinder along the x axis  

if direction == 1

    T2 = fp2t(-P1);
    P = ft2p(fp2t(P2) * T2);
    R = frotationbypoint(P);
    cyl.vertices = cyl.vertices * R;
    
    T = fp2t(P1');
    cyl.vertices = (T * cyl.vertices')';
    
    cyl.vertices = cyl.vertices(:,1:3);

else

    T2 = fp2t(-P2);
    P = ft2p(fp2t(P1) * T2);
    R = frotationbypoint(P);
    cyl.vertices = cyl.vertices * R;
    
    
    
    T = fp2t(P2');
    cyl.vertices = (T * cyl.vertices')';
    
    cyl.vertices = cyl.vertices(:,1:3);

end

end

