function beta = para_calculation(chi,y)
    A = chi';
    beta = (inv(A*chi))*A*y;
    %disp(beta);
end