function coef = condif(msh, par)

    m = msh.m;
    mp1 = msh.mp1;

    gam = par.gam;
    
    rm  = msh.rm;
    dy  = msh.dy;
    rdify = msh.rdify;

    an = zeros(mp1,1);
    as = zeros(mp1,1);
    
    for j = 2:m
        ijk = j;
        rgamn = gam*rm(j+1)/dy(j+1);
        rgams = gam*rm(j)/dy(j);
        an(ijk) = rgamn/rdify(j);
        as(ijk) = rgams/rdify(j);
    end
    
    ap = an + as;

    coef.ap = ap;
    coef.an = an;
    coef.as = as;

end