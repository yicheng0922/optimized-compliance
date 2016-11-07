% a objective function test where all springs are not compressed 

% total spring numbers
spring_num_total = 43;
% numbers of springs from shape 1
spring_num_shape1 = 20;
% numbers of springs from shap 2
spring_num_shape2 = 23;
% spring constant for shape 1
k1 = 5;
%spring constant for shape 2
k2 = 10;
% spring deformation vector
X = zeros(spring_num_total,1);
% The result should be zero, b/c there is zero deformation/compression.
assert(obj_func(X, spring_num_shape1, spring_num_shape2, k1, k2)==0);

% a objection function test where all springs are compressed by 1
compression = 2;
X = ones(spring_num_total,1)* -compression;

% total enery calculated based on the formula E=1/2kd^2 where k is the
% spring constant and d is the displacement of the end of the spring.
energy = spring_num_shape1*1/2*k1*compression^2+ spring_num_shape2*1/2*k2*compression^2;

assert(obj_func(X, spring_num_shape1, spring_num_shape2, k1, k2)==(energy));
