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
        as(ijk) = gamrs;     
        ap(ijk) = as(ijk);
        ap(ijks) = ap(ijks) - an(ijks);
        an(ijks) = 0.0;
        ap(ijks) = ap(ijks)*rdify(j-1);
        as(ijks) = as(ijks)*rdify(j-1);
    else
        j = 1;
        ijk = j;
        ijkn = ijk + 1;
        gamrn = gam*rm(j+1)/dy(j+1);
        an(ijk) = gamrn;
        ap(ijk) = an(ijk);
        ap(ijkn) = ap(ijkn) - as(ijkn);
        as(ijkn) = 0.0;
        ap(ijkn) = ap(ijkn)*rdify(j+1);
        an(ijkn) = an(ijkn)*rdify(j+1);
    end
    
    coef.ap = ap;
    coef.an = an;
    coef.as = as;

end