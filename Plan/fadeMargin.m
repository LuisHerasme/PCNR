function F = fadeMargin(D, a, b, f)
    noDisponibilidad = 1e-5;
    F = - 10 * log10(noDisponibilidad/(2.5 * a * b * f * ( D ^ 3 ) * (1e-6) ));
end
