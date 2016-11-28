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


% Modify box1 springs
modified_box1_springs = modify_spring_length(x(1:box1_spring_num), box1_springs);

% Modify box2 springs
modified_box2_springs = modify_spring_length(x(box1_spring_num+1:end), box2_springs);


sum = 0;

% perform SAT test with every pair of springs
for i = 1:length(modified_box1_springs)
    
    shape1 = modified_box1_springs{i};
    
    for ii = 1:length(modified_box2_springs)
        
        shape2 = modified_box2_springs{ii};
        interpenetration = SAT(shape1,shape2);
        sum = sum + interpenetration;    
    end
        
   
end

% prints out the sum just for checking.
ceq = sum;
c=[];

end

