%constant
X_AXIS = [1 0];
Y_AXIS = [0 1];
NEGATIVE_Y_AXIS = [0 -1];

% setup a box
shape1.x = 2;            % x coordinate of the center of the box
shape1.y = 2;            % y coordinate of the center of the box
shape1.w = 4;            % width of the box
shape1.h = 4;            % height of the box
shape1.alpha = 0;        % the angle of rotation for the box
shape1.isRect = true;   % this is a box


% this test for projecting a box onto an axis
% the box is centered at (2,2) with side length of 4
% the maximum dot product should be 4 which is dot((4,0),(1,0)), where (4,0) 
% is the bottom right vertex of the box and the minimum should be 0 which is
% dot((0,0),(1,0)), where (0,0) is the bottom left vertex of the box 
[min, max] = project(shape1, X_AXIS);
assert((min==0 && max==4));

% set up a fan
shape2.x = 0;            % x coordinate of the center of the fan
shape2.y = 0;            % y coordinate of the center of the fan
shape2.radius = 2;       % radius of the fan
shape2.alpha1 = pi/4;    % starting angle                        
shape2.alpha2 = 3*pi/4;  % ending angle
shape2.isRect = false;   % this is not a box

% this test is for projecting a fan shape onto the axis (1,0) that does not intersect
% with the arc
% the fan is centered at (0,0) with radius 2
% the maximum dot product should be 4 which is dot((sqrt(2),sqrt(2)),(1,0)),
% where (sqrt(2),sqrt(2)) is where the arc starts, and the minimum should 
% be -sqrt(2) which is dot((-sqrt(2),sqrt(2)),(1,0)), where 
% (-sqrt(2),sqrt(2)) is the end of the arc 

[min max] = project(shape2, X_AXIS);
assert(( abs(min - -sqrt(2)) <0.001 && abs(max - sqrt(2)) < 0.001 ))

% this test is for projecting a fan shape onto the axis (0,1) that does intersect
% with the arc
% the fan is centered at (0,0) with radius 2
% the maximum dot product should be 4 which is dot((0,1),(0,1)),
% where (0,1) is where the arc intersects with the axis, and the minimum should 
% be 0 which is dot((0,0)),(0,1)), where (0,0) is the center of the fan 

[min max] = project(shape2, Y_AXIS);
assert((min == 0 && max == 2 ))

% this test is for projecting a fan shape onto the axis (0,-1) that does intersect
% with the arc on the other end 
% the fan is centered at (0,0) with radius 2
% the maximum dot product should be 4 which is dot((0,0),(0,-1)),
% where (0,1) is where the arc intersects with the axis, and the minimum should 
% be -1 which is dot(0,1),(0,-1)), where (0,1) is the intersection of 
% the opposite direction ray of (0,-1) and the arc

[min max] = project(shape2, NEGATIVE_Y_AXIS);
assert((min == -2 && max == 0 ))



