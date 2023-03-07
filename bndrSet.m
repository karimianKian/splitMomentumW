function w = bndrSet(par, msh, w)
    
    % w(1) = w(2);
    w(1)   = 2.0*par.fsth - w(2);
    w(msh.mp1) = 2.0*par.fnth - w(msh.m);
    
end 