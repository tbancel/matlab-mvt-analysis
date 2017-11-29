function T = verify_base(x,y,z)
    d1 = (abs(dot(x,y)) < 1e-10);
    d2 = (abs(dot(y,z)) < 1e-10);
    d3 = (abs(dot(z,x))  < 1e-10);
        
    nx = (abs(norm(x)-1) < 1e-10);
    ny = (abs(norm(y)-1) < 1e-10);
    nz = (abs(norm(z)-1) < 1e-10);
    
    rot = (norm(cross(x,y)-z) < 1e-10);
    
    if all([d1,d2,d3, nx, ny, nz, rot])
        T = true;
    else
        T = false;
    end
end