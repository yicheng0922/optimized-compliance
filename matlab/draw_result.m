function draw_result( x, box1_springs, box2_springs )
% the function draws the result of the optimization
% x is a vector with the optimization result
% box1_springs is the uncompressed spring shape data from box1
% box2_springs is the uncompressed spring shape data from box2

% Modify the height of the shape based on the displacement of the spring
box1_spring_num = length(box1_springs);
modified_box1_springs = modify_spring_length(x(1:box1_spring_num), box1_springs);
modified_box2_springs = modify_spring_length(x(box1_spring_num+1:end), box2_springs);

figure();
hold on;
draw_springs( modified_box1_springs, 'r' );
draw_springs( modified_box2_springs, 'b' );
hold off;

end

