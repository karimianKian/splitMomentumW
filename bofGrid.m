function msh = bofGrid(y1,y2,ny)

    m   = ny + 1;
    mp1 = ny + 2;
    mp2 = ny + 3;

    yf(2:mp1) = linspace(y1, y2, ny + 1);
    yf(1) = yf(2) - (yf(3)-yf(2));
    yf(mp2) = yf(mp1) + (yf(mp1) - yf(m));
    
    y = 0.5*(yf(1:end-1)+yf(2:end));
    dify = yf(2:end) - yf(1:end-1);
    dy(2:mp1) = y(2:end) - y(1:end-1); 
    
    rm = yf;
    r  = y ;
    
    rdify = r.*dify;

    
    msh.m = m;
    msh.mp1 = mp1;
    msh.mp2 = mp2;

    msh.yf  = yf;
    msh.y   = y;
    msh.dify = dify;
    msh.dy = dy;
    msh.r = r;
    msh.rm = rm;
    msh.rdify = rdify;

end