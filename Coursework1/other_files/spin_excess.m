function spin_excess_ratio=spin_excess(gamma,B0,T)
%Input the gyromagnetic ratio, static magnetic field strength and
%temperature.
%h and k are constants
h=6.63e-34;
k=1.38e-23;
%the ratio of spins in parts per million
spin_excess_ratio=10e6.*(exp(-(gamma.*B0.*h)./(2.*pi.*k.*T)))-10e6;
end
