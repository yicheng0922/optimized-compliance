function [energy gradient] = obj_func( x )
%OBJ_FUNC Summary of this function goes here
% the objectve function calculates the sum of potential energy by the
% formula E = 1/2kd^2 where d is the amound of deforming.
%   Detailed explanation goes here
   spring_num1 = 23;
   spring_num2 = 20;
   energy = 0;
   k1 = 5; k2 = 10;
   index = 1;
   for i = 1:spring_num1
       energy = energy +1/2*k1*x(index)^2;
       index = index+1;
   end
   for i = 1:spring_num2
       energy = energy +1/2*k2*x(index)^2;
       index =index+1;
   end
   
 
   energy

end

