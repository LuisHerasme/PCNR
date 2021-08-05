function atenuacion = FSL(f, D)
    atenuacion = 32.44 + 20 * log10(f) + 20 * log10(D);
end
