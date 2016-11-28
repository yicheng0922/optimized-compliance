function draw_fan( shape, S )
% this function draw the fan shape based on the shape data provided
% S is the same character string used for plot(). Please see help plot for
% detail explanation

% make sure the shape is a fan
assert(~shape.isRect);

% splitting the arc into 100 points
t = linspace(shape.alpha1,shape.alpha2);
xx = shape.x + shape.radius*cos(t);
yy = shape.y + shape.radius*sin(t);

% plot the shape
plot([shape.x,xx,shape.x],[shape.y,yy,shape.y],S);


end

