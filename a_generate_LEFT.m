% ------------------------------------
%   Copyright 2020 Andrea de Giorgio  
%   Email: andreadg@kth.se
%
%   Please, cite: A. de Giorgio and L. Wang, "Artificial Intelligence Control in
%   4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access,
%   vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.
% ------------------------------------

%% ConfigA_LEFT

a_generate_RIGHT;
configA_LEFT = configA_RIGHT; %Binary validity matrix(Height(z)[0,1800],Depth(x)[-1500,1500]) steps every 100mm
center = (size(configA_LEFT, 2)-1)/2+1;

configA_LEFT_joints = zeros(6,19,31);

for z = 1 : 19
    for x = 1 : 31
configA_LEFT_joints(1,z,x) = -configA_RIGHT_joints(1,z,x);
configA_LEFT_joints(2,z,x) = configA_RIGHT_joints(2,z,x);
configA_LEFT_joints(3,z,x) = configA_RIGHT_joints(3,z,x);
configA_LEFT_joints(4,z,x) = -configA_RIGHT_joints(4,z,x);
configA_LEFT_joints(5,z,x) = configA_RIGHT_joints(5,z,x);
configA_LEFT_joints(6,z,x) = -configA_RIGHT_joints(6,z,x);
    end
end

%% Max and Min values
minval = 1000;
maxval = -1000;
for z = 1 : 19
    for x = 1 : 31
        tempmin = configA_LEFT_joints(4,z,x);
        if ((tempmin < minval) & (tempmin~=0))
            minval = tempmin;
        end
        tempmax = configA_LEFT_joints(4,z,x);
        if ((tempmax > maxval) & (tempmax~=0))
            maxval = tempmax;
        end
    end
end

configA_LEFT_joint4_min = minval;
configA_LEFT_joint4_max = maxval;

minval = 1000;
maxval = -1000;
for z = 1 : 19
    for x = 1 : 31
        tempmin = configA_LEFT_joints(5,z,x);
        if ((tempmin < minval) & (tempmin~=0))
            minval = tempmin;
        end
        tempmax = configA_LEFT_joints(5,z,x);
        if ((tempmax > maxval) & (tempmax~=0))
            maxval = tempmax;
        end
    end
end

configA_LEFT_joint5_min = minval;
configA_LEFT_joint5_max = maxval;