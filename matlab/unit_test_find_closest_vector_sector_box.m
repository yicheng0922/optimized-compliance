% properties of shape1 (the box)
shape1.x = 3
shape1.y = 3
shape1.w = 1
shape1.h = 1
shape1.alpha = 0
shape1.isRect = true;

% data of shape2 (the fan shape)
shape2.x = 0
shape2.y = 0
shape2.alpha1 = 0
shape2.alpha2 = pi/4;
shape2.radius = 4
shape2.isRect = false;

axis = find_closest_vector_sector_box(shape2,shape1);
assert(axis(1) == -2.5 && axis(2) == -3 );