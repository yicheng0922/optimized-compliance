% a constraint test where all springs are compressed by one ( displace ment
% of the spring end is -1?
X = ones(43,1)*-1;
[c ceq] = con_func(X);
assert(ceq==0);
