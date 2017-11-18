function [x,y,z] = create_base_from(T,R,B)
    % a, b and c are 3 vectors
    % the function return
    BR = B-R;
    BT = T-B;
    y = (BT)/norm(BT);
    z = cross(BR, y)/norm(cross(BR,y));
    x = cross(y,z)
end
