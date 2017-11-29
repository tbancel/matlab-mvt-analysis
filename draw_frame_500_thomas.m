function draw_frame_500_thomas(M)
    % draw the frame multiplying the length of the reference vector by 500
    O = M(1:3,4);
    X_2=O + (M(1:3,1)-O)*500;
    Y_2=O + (M(1:3,2)-O)*500;
    Z_2=O + (M(1:3,3)-O)*500;
    
    draw_line_3D(O,X_2);
    draw_line_3D(O,Y_2);
    draw_line_3D(O,Z_2);
    
    % quiver3(M(1,4),M(2,4),M(3,4),M(1,1), M(2,1), M(3,1)); hold on
    % quiver3(M(1,4),M(2,4),M(3,4),M(1,2), M(2,2), M(3,2)); hold on
    % quiver3(M(1,4),M(2,4),M(3,4),M(1,3), M(2,3), M(3,3)); hold on
    
end

function draw_line_3D(A,B)
    M(1,:)=A;
    M(2,:)=B;
    line(M(:,1),M(:,2),M(:,3));
end