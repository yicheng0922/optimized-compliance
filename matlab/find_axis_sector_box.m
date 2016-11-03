function result_axis = find_axis_sector_box( sector, box ) 
%find the vector that connects the center of the sector an the closest
%vertex of the box to it.
%input:
%   sector : The shape data of the sector. Contains following member:
%           x: the x coordinate of the center 
%           y: the y coordinate of the center
%   box ?The shape data of the box. Contains following members:
%           x: the x coordinate of the top right corner
%           y: the y coordinate of the top right corner
%           w: the width of the box
%           h: the height of the box 
%           d: the compression of the box (maybe this should detucted
%               form w/h before passing into this function) 
%           alpha: the orientation of the box    
    %calculating vertex
    x = box.x;
    y = box.y;
    w = box.w;
    h = box.h;
    d = box.d;
    alpha = box.alpha;
    
    % this was a hot fix to the problem where width actually became the 
    % length of the spring. Should be fixed later
    xv=[0 h h 0 ];yv=[0 0 w+d w+d]; 

    
    %rotate angle alpha
    R=[xv;yv];
    vertex=[cos(alpha) -sin(alpha);sin(alpha) cos(alpha)]*R;
    vertex(1,:)=vertex(1,:)+x;
    vertex(2,:)=vertex(2,:)+y;
    
    sx = sector.x;
    sy = sector.y;
    
    min_dist = realmax;
    min_i = 0;
    for i=1:4
       dist = norm([sx;sy]-vertex(:,i));
       if(dist<min_dist)
           min_dist = dist;
           min_i = i;
       end
    end
    
    result_axis = [sx;sy] - vertex(:,min_i);
    result_axis = result_axis';




end