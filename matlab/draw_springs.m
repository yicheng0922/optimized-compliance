function draw_springs( springs, S )
% this function takes in the spring data and plot them
% S is the same character string used for plot(). Please see help plot for
% detail explanation

for i = 1:length(springs)
    shape = springs{i};
    if(shape.isRect)
       draw_box(shape,S);
    else
       
       draw_fan(shape,S);
    end
end
end
