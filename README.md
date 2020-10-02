# cylindrical-astar

Please cite this work:
A. de Giorgio and L. Wang, "Artificial Intelligence Control in 4D Cylindrical Space for Industrial Robotic Applications," in IEEE Access, vol. 8, pp. 174833-174844, 2020, doi: 10.1109/ACCESS.2020.3026193.

Instructions

ABB
Create an ABB IRB 1600 controller in ABB RobotStudio and load "Module1.mod" as a RAPID code module. Run the module.

MATLAB
1) Import all the files in the same folder.
2) Run "a_setup.m".

Use of the A* control:
- Control the robot with A* using the command "fm". Input each coordinate when requested.
- Control the robot with diagonal-A* using the command "fmd". Input each coordinate when requested. This allows the robot TCP to move diagonally and skip adjacent cells.

Manual commands:
gu: go up one cell;
gd: do down one cell;
gc: go one cell towards the human facing the robot;
gb: go one cell backwards from the human facing the robot;
gl: go left one cell;
gr: go right one cell;
ou: change orientation UP;
od: change orientation DOWN;
oc: change orientation CENTER;
ol: change orientation LEFT;
oor: change orientation RIGHT;
gh: go to home position with A*;
ghd: go to home position with diagonal-A* (moving diagonally too).

