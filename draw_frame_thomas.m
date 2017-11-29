function draw_frame_thomas(M)    
    quiver3(M(1,4),M(2,4),M(3,4),M(1,1), M(2,1), M(3,1)); hold on
    quiver3(M(1,4),M(2,4),M(3,4),M(1,2), M(2,2), M(3,2)); hold on
    quiver3(M(1,4),M(2,4),M(3,4),M(1,3), M(2,3), M(3,3)); hold on

