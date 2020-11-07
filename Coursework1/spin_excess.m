function spin_excess_ratio=spin_excess(gamma,B0,h,k,T)
spin_excess_ratio=exp(-(gamma.*B0.*h)./(2.*pi.*k.*T));
end
