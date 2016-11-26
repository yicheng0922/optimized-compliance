function [c, ceq ] = con_func( x, box1_springs, box2_springs )

% the constraint function. 
% This constraint is statisfied if ceq = 0
% The function takes in a vector (x) that contains the displacement of the
% ends of all springs, and the uncompressed spring shape data (box1_springs
% and box2_springs). The height of the shape data will be modified based on
% x to get the shape data for the compressed springs


% The function perform SAT test on every pair of springs.
% If two springs intersect, SAT will return the magnitude(norm) of the MTLD
% the sum of the magnitude of MTLD will be returned as ceq.
% If they do not intersect, SAT will return zero.
% since there is no inequality constraint, c is returned as an empty vector.

% Modify the height of the shape based on the displacement of the spring
box1_spring_num = length(box1_springs);
for i = 1:length(x)
    
    % the first box1_spring_num elements in x will be the displacement of 
    % springs in shape1
    if( i <= box1_spring_num)
        shape = box1_springs{i};
        if(shape.isRect)
            shape.h = shape.h + x(i);
        else
            shape.radius = shape.radius + x(i);
        end
        box1_springs{i} = shape;
    else
        shape = box2_springs{i-box1_spring_num};
        if(shape.isRect)
            shape.h = shape.h + x(i);
        else
            shape.radius = shape.radius + x(i);
        end
        box2_springs{i-box1_spring_num} = shape;
    end
end

sum = 0;

% perform SAT test with every pair of springs
for i = 1:length(box1_springs)
    
    shape1 = box1_springs{i};
    
    for ii = 1:length(box2_springs)
        
        shape2 = box2_springs{ii};
        interpenetration = SAT(shape1,shape2);
        sum = sum + interpenetration;    
    end
        
   
end

% prints out the sum just for checking.
ceq = sum;
c=[];

end

