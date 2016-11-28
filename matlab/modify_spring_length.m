function modified_springs = modify_spring_length( X, springs )
% this function modifies the length of springs based on the displacement
% X should be a vector containing all the compression value
% springs should be a cell array containing all the shaped data of the
% uncompressed spring
% the function will return an cell array containing all modified shape data.

% X and springs should have the same length
assert(length(X) == length(springs));

modified_springs = cell(length(springs));
for i = 1:length(X)
    shape = springs{i};
    if(shape.isRect)
        shape.h = shape.h + X(i);
    else
        shape.radius = shape.radius + X(i);
    end
    modified_springs{i} = shape;
end


end

