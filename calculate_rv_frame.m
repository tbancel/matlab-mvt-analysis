function RES = calculate_Rv_frame(T,R,B)
    % a, b and c are 3 vectors
    % the function returns the transformation matrix
    BR = B-R;
    BT = T-B;
    y = (BT)/norm(BT);
    z = cross(BR, y)/norm(cross(BR,y));
    x = cross(y,z);
    
    M=[reshape(x, [3,1]) reshape(y, [3,1]) reshape(z, [3,1])];
    RES = zeros(4,4);
    RES(1:3,1:3) = M;
    RES(4,4)=1;
end


