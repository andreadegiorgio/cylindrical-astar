function [n,s] = fnextmove(c,mjb)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% c: o,p,z,r
% mjb: o,p,z,r

% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

n = cell(1);
s = cell(1);
i_n = 1;
i_s = 1;

% Check OC
if c(1) ~= 1
    if mjb(1,c(2),c(3),c(4)) ~= 0
        n{i_n} = [1 c(2) c(3) c(4)];
        i_n = i_n + 1;
        s{i_s} = "oc";
        i_s = i_s + 1;
    end
end

% Check OU
if c(1) ~= 2
    if mjb(2,c(2),c(3),c(4)) ~= 0
        n{i_n} = [2 c(2) c(3) c(4)];
        i_n = i_n + 1;
        s{i_s} = "ou";
        i_s = i_s + 1;
    end
end

% Check OD
if c(1) ~= 3
    if mjb(3,c(2),c(3),c(4)) ~= 0
        n{i_n} = [3 c(2) c(3) c(4)];
        i_n = i_n + 1;
        s{i_s} = "od";
        i_s = i_s + 1;
    end
end

% Check OL
if c(1) ~= 4
    if mjb(4,c(2),c(3),c(4)) ~= 0
        n{i_n} = [4 c(2) c(3) c(4)];
        i_n = i_n + 1;
        s{i_s} = "ol";
        i_s = i_s + 1;
    end
end

% Check OR
if c(1) ~= 5
    if mjb(5,c(2),c(3),c(4)) ~= 0
        n{i_n} = [5 c(2) c(3) c(4)];
        i_n = i_n + 1;
        s{i_s} = "oor";
        i_s = i_s + 1;
    end
end

% Check GL
if c(2) > 1
    if mjb(c(1),c(2)-1,c(3),c(4)) ~= 0 
        n{i_n} = [c(1) c(2)-1 c(3) c(4)];
        i_n = i_n + 1;
        s{i_s} = "gl";
        i_s = i_s + 1;
    end
end

% Check GR
if c(2) < size(mjb,2)
    if mjb(c(1),c(2)+1,c(3),c(4)) ~= 0 
        n{i_n} = [c(1) c(2)+1 c(3) c(4)];
        i_n = i_n + 1;
        s{i_s} = "gr";
        i_s = i_s + 1;
    end
end

% Check GD
if c(3) > 1
    if mjb(c(1),c(2),c(3)-1,c(4)) ~= 0 
        n{i_n} = [c(1) c(2) c(3)-1 c(4)];
        i_n = i_n + 1;
        s{i_s} = "gd";
        i_s = i_s + 1;
    end
end

% Check GU
if c(3) < size(mjb,3)
    if mjb(c(1),c(2),c(3)+1,c(4)) ~= 0 
        n{i_n} = [c(1) c(2) c(3)+1 c(4)];
        i_n = i_n + 1;
        s{i_s} = "gu";
        i_s = i_s + 1;
    end
end

% Check GB
if c(4) > 1
    if mjb(c(1),c(2),c(3),c(4)-1) ~= 0 
        n{i_n} = [c(1) c(2) c(3) c(4)-1];
        i_n = i_n + 1;
        s{i_s} = "gb";
        i_s = i_s + 1;
    end
end

% Check GC
if c(4) < size(mjb,4)
    if mjb(c(1),c(2),c(3),c(4)+1) ~= 0 
        n{i_n} = [c(1) c(2) c(3) c(4)+1];
        i_n = i_n + 1;
        s{i_s} = "gc";
        i_s = i_s + 1;
    end
end
