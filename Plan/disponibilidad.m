function A = disponibilidad(a0, b0, f0, D, FM)
    U = 2.5 * a0 * b0 * f0 * D^3 * 10^(-FM/10) * 1e-6;
    A = 100 * (1 - U);
end
