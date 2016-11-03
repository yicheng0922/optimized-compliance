function [energy gradient] = obj_func( x, spring_num1, spring_num2, k1, k2)
% the objectve function calculates the sum of potential energy by the
% formula E = 1/2kd^2 where d is the diplacement of the spring end.
% input: 
% x: A vector that contains the displacement of all spring ends. 
%    The data are in the following order:
%       x(1:spring_num1): displacement of all springs from shape 1
%       x(spring_num1+1:spring_num1+spring_num2): displacement of all springs 
%                       from shape 2
% spring_num1: The number of springs from shape 1
% spring_num2: The number of springs from shape 2
% k1: Spring coeficient of shape 1
% k2: Spring coeficient of shape 2
% 
% output:
% energy: the energy of the system
% gradient: place holder required from the matlab function


   energy = 0;
   index = 1;
   for i = 1:spring_num1
       energy = energy +1/2*k1*x(index)^2;
       index = index+1;
   end
   for i = 1:spring_num2
       energy = energy +1/2*k2*x(index)^2;
       index =index+1;
   end
   
%TODO: remove the output
energy

end

