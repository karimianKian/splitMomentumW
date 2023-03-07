function coef = sourw(msh,par,coef)
    
    m = msh.m;

    gam = par.gam;
    r   = msh.r;

    for j = 2:m
        ijk = j;
        coef.ap(ijk) = coef.ap(ijk) + gam/(r(j)^2);
    end

end