function [T] = fp2t(P,T)
%P2T Summary of this function goes here
%   Detailed explanation goes here
% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------
    if nargin < 2
    	T = zeros(4,4);
        T(1,1:3) = [1 0 0];
        T(2,1:3) = [0 1 0];
        T(3,1:3) = [0 0 1];
        T(4,4) = 1;
    end
    
    if size(P,1) == 1 && size(P,2) == 3
        P = P';
    end
        
    T(1:3,4) = P;

end