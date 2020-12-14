clear all
close all
mu=0.5;
noOfSpins=11;
wmax=pi;
w=linspace(-wmax,wmax,noOfSpins);
middle=0;
delta=pi./2;
weightings = cauchy(w,middle,delta);
sumweights=sum(weightings);
total_length=noOfSpins;
norm_factor=total_length./sumweights;
weightings=weightings.*norm_factor;