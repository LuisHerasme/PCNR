function atenuacion = FSL(f, D, a0, b0, c0, e0)
    atenuacion = 92.45 + 20 * log10(f) + 20 * log10(D) + a0 + b0 + c0 + e0;
end
