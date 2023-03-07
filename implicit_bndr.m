function [coef, bp] = implicit_bndr(coef, msh, bp, par, first_proc, last_proc)
  
    if nargin < 5
        first_proc = true;
        last_proc = true;
    end

    m = msh.m;
    
    fnth = par.fnth;
    fsth = par.fsth;

    ap = coef.ap;
    an = coef.an;
    as = coef.as;

    if first_proc == true
        % ap(2) = ap(2) - as(2);
        % as(2) = 0.0;
        
        ap(2) = ap(2) + as(2);
        bp(2) = bp(2) + 2.0 * as(2) * fsth;
        as(2) = 0.0;
    end

    if last_proc == true
        
        ap(m) = ap(m) + an(m);
        bp(m) = bp(m) + 2.0 * an(m) * fnth;
        an(m) = 0.0;

    end

    coef.ap = ap;
    coef.as = as;
    coef.an = an;

end