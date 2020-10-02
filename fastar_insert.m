function new_row = fastar_insert(c,p,hn,gn,fn)
% Function to Populate the open list
% open: is_on_list current parent h(n) g(n) f(n)

% Current node
% c: o p z r

% Parent node
% p: o p z r

% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

new_row = [1,12];
new_row(1,1) = 1;
new_row(1,2) = c(1);
new_row(1,3) = c(2);
new_row(1,4) = c(3);
new_row(1,5) = c(4);
new_row(1,6) = p(1);
new_row(1,7) = p(2);
new_row(1,8) = p(3);
new_row(1,9) = p(4);
new_row(1,10) = hn;
new_row(1,11) = gn;
new_row(1,12) = fn;

end