function result_axis = find_axis_sector_box( sector, box ) 
% find the vector that connects the center of the sector an the closest
% vertex of the box to it.
% input:
%   sector: The shape data of the sector (fan shape). Contains following member:
%           x: the x coordinate of the center of the sector 
%           y: the y coordinate of the center of the sector
%   box: The shape data of the box. Contains following members:
%           x: the x coordinate of the center of the box
%           y: the y coordinate of the center of the box
%           w: the width of the box
%           h: the height of the box 
%           alpha: the orientation of the box    
% output:
%   result_axis: the edge vector    

    % calculating vertex
    x = box.x;
    y = box.y;
    w = box.w;
    h = box.h;
    alpha = box.alpha;
    
    % setting up box vertices
    vertices_x_box =[0.5*w 0.5*w -0.5*w -0.5*w];
    vertices_y_box =[0.5*h -0.5*h -0.5*h 0.5*h]; 

    % transforming vertex into world frame
    % rotate the vertex by alpha
    vertices_box = [vertices_x_box; vertices_y_box];
    vertices_world =[cos(alpha) -sin(alpha);sin(alpha) cos(alpha)] * vertices_box;
    % shift the vertex by (x,y)
    vertices_world(1,:)= vertices_world(1,:)+x;
    vertices_world(2,:)= vertices_world(2,:)+y;
    
    % get center of the sector (the fan shape)
    sector_x = sector.x;
    sector_y = sector.y;
    
    % find the vertex of the box that is closest to the 
    min_dist = realmax;
    min_i = 0;
    [dim vertice_num] = size(vertices_world)
    for i = 1:vertice_num
       dist = norm([sector_x; sector_y] - vertices_world(:,i));
       if(dist < min_dist)
           min_dist = dist;
           min_i = i;
       end
    end
    
    % compute the result axis
    result_axis = [sector_x; sector_y] - vertices_world(:,min_i);
    result_axis = result_axis';

end