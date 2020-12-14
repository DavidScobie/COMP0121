function probs = cauchy(w, w0, delta)

w_dims=size(w);

    for i=1:w_dims(2)
    probs(i)=1./((pi.*delta)+(pi.*(((w(i)-w0).^2))./delta));


end