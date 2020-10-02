function [done] = a_moveJoints(joints)
%moveJoints This function sends the joint positions to the robot controller
%through TCP/IP protocol

% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

tc = tcpip('127.0.0.1',4000,'NetworkRole','client');
conn = true;
while conn
    try
        fopen(tc);
        conn = false;
    catch ME
    end
end
%message = fread(tc);
%message = native2unicode(message');
fwrite(tc,mat2str(joints));
fclose(tc);
done = 1;
end

