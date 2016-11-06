% a objection function test where all springs are not compressed 
X = zeros(43,1);
assert(obj_func(X)==0);

% a objection function test where all springs are compressed by 2
X = ones(43,1)*-2;
energy = 1/2*23*5*4+1/2*20*10*4
assert(obj_func(X)==(energy));
