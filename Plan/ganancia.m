function G = ganancia(angulo)
    patron = [
        0.00 0.00
        0.20 0.00
        0.40 -1.20
        0.50 -2.35
        0.67 -5.00
        0.84 -9.20
        1.80 -9.20
        2.00 -15.00
        4.00 -23.00
        5.00 -28.00
        6.00 -30.50
        7.00 -36.00
        20.00 -49.00
        40.00 -60.00
        100.00 -75.00
        180.00 -75.00        
    ];

    % Tomar valores pares de vector
    ganancias = patron(:, 2);

    % Tomar impares pares de vector
    angulos  = patron(:, 1);

    % Patron simetrico
    angulo = abs(angulo);
    diferencia_del_angulo = abs(angulos - angulo);

    % Angulo con la minima diferencia (mas parecido)
    [ _ idx ] = min(diferencia_del_angulo);
    G = ganancias(idx);
end