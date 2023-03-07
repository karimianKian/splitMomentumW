function visualize(w, msh)

    wp = 0.5*(w(1:msh.m) + w(2:msh.mp1));
    plot(msh.rm(2:msh.mp1),wp , 'k-')

end