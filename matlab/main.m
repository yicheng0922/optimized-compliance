% The main script
% -- Run this to start the optimized compliance example

% The X values are the amount of shape change that happens. A positive X
% element will mean extension and a negative one will mean compression.
options = optimoptions('fmincon','MaxFunEvals',50000);

% compute the spring lengths (for forty-three springs in the example)
X = fmincon(@obj_func, ones(43,1)*0,[],[],[],[],[],[],@con_func,options);

    
