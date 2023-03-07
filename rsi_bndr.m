function coef = rsi_bndr(coef,msh,par,first_proc)

    rm = msh.rm;
    dy = msh.dy;
    rdify = msh.rdify;
    gam = par.gam;

    mp1 = msh.mp1;

    as = coef.as;
    an = coef.an;
    ap = coef.ap;
    
    if first_proc == true
        j = mp1;
        ijk = j;
        ijks = ijk - 1;
        gamrs = gam*rm(j)/dy(j);
        as(ijk) = gamrs/rdify(j);
        ap(ijk) = as(ijk);
        an(ijks) = 0.0;
    else
        j = 1;
        ijk = j;
        ijkn = ijk + 1;
        gamrn = gam*rm(j+1)/dy(j+1);
        an(ijk) = gamrn/rdify(j);
        ap(ijk) = an(ijk);
        as(ijkn) = 0.0;
    end
    
    coef.ap = ap;
    coef.an = an;
    coef.as = as;

end