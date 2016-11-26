function result = SAT( shape1,shape2 )
% perform Separate axis thereom test(SAT)

% returns the minimal translational distance to separate the two bodies

%   The function performs SAT test
%   For a shape that is a box, the normal of the two edges in different 
%   orientations will be used as test edges.
%   If the shape is a sector of a circle, the normal of two 
%   straight edges will be added.
%   After these axes have been added, the program will then add the 
%   the line connecting the centers if both of the shapes are fans, or 
%   the line connecting the center to the vertex of the box that is closest
%   to the center if only one of them is a fan.
%   please see extra_edge_fan_fan.png and extra_edge_fan_box.png for a
%   graphical explanation


% find the axis that need to be tested
   test_edges = find_test_axis(shape1);
   test_edges = [test_edges;find_test_axis(shape2)];
    
    

    
    
% check for the extra edge required.
% the edge will be the vector connecting the center if both shapes are fan, or
% the vector connecting the center of the fan to the closest vertex of the box
% no extra edges need to be added if both shapes are box
    if(shape1.isRect == false && shape2.isRect == false)
        
        edge = [shape1.x - shape2.x, shape1.y-shape2.y];
        edge = edge/norm(edge);
        test_edges = [test_edges;edge];
    
    elseif(shape1.isRect == false && shape2.isRect == true)
    
        edge = find_closest_vector_sector_box(shape1,shape2);
        edge = edge/norm(edge);
        test_edges = [test_edges;edge];
   
    elseif(shape1.isRect == true && shape2.isRect == false)
    
        edge = find_closest_vector_sector_box(shape2,shape1);
        edge = edge/norm(edge);
        test_edges = [test_edges;edge];
    
    end
    
% start testing by projection
    min_overlap = inf;

    test_edge_num = size(test_edges,1);
    for i = 1:test_edge_num

        
        % find the projection of the shapes
        [min1,max1] = project(shape1,test_edges(i,:));
        [min2,max2] = project(shape2,test_edges(i,:));
        
        % check how the two lies on the axis
        o1 = max1 - min2;
        o2 = max2 - min1;
        
        % if both of the over lap is greater then zero, it means there is an
        % overlap
        if (o1 > 0 && o2 > 0)
            overlap = min(o1,o2);
            if(min_overlap > overlap)
                min_overlap = overlap;
            end
        else
         
        % if not then it means that there is an axis that can separate these
        % shapes   
            min_overlap = 0;
            break;
        end
    end

    
    result = min_overlap;
    
end

