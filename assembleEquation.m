function [A, b] = assembleEquation(msh, coef, bp, first_proc)

    ny = msh.m - 1;
    m  = msh.m;
    mp1 = msh.mp1;

    ap = coef.ap;
    an = coef.an;
    as = coef.as;    
    
    jstr = 2;
    jend = m;

    if nargin > 3
        if first_proc == true
            jend = mp1;
        else
            jstr = 1;
        end
    end

    nnz = 3 * ny;

    si = zeros(nnz,1);
    sj = zeros(nnz,1);
    sv = zeros(nnz,1);
    
    kk = 1;
    
    for j = 2:m
        ijk = j;
        ijkn = ijk + 1;
        ijks = ijk - 1;
        si(kk) = ijk;
        sj(kk) = ijk;
        sv(kk) = ap(ijk);
        kk = kk + 1;
        si(kk) = ijk;
        sj(kk) = ijkn;
        sv(kk) = -an(ijk);
        kk = kk + 1;
        si(kk) = ijk;
        sj(kk) = ijks;
        sv(kk) = -as(ijk);
        kk = kk + 1;
    end
    
    A = sparse(si,sj,sv,mp1,mp1);
    A = A(jstr:jend,jstr:jend);
    b = bp(jstr:jend);

end