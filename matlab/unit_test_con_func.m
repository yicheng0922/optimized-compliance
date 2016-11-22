% a constraint test where all springs are compressed by one (displacement
% of the spring end is -2)
X = ones(43,1)*-2;
[c ceq] = con_func(X);
% the constraint function should return 0 because there should not be any 
% collision happening if all the spring is compressed by 1
assert(ceq==0);
