% setup two boxes
shape1.x = 0            % center of the...
shape1.y = 0            % ...box x and y
shape1.w = 4            % width of the box
shape1.h = 5            % height of the box
shape1.d = 0            % displacement of the spring end
shape1.alpha = 0        % the angle of rotation for the box
shape1.isRect = true;   % if the shape isn't a box, it will be a sphere

shape2.x = 3            % center of the...
shape2.y = 0            % ...box x and y
shape2.w = 4            % width of the box
shape2.h = 5            % height of the box
shape2.alpha = 0        % the angle of rotation for the box
shape2.d = 0            % displacement of the spring end                     
shape2.isRect = true;   % if the shape isn't a box, it will be a sphere


% test SAT
% since the two box are overelapped by 1, SAT should return 1
assert(SAT(shape1,shape2) == 1);

