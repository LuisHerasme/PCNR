function Hm = curvatura(distancias, k)
    Hm = zeros(length(distancias), 1);
    distancia = distancias(length(distancias));
    for i = 1: length(distancias)
        d1 = distancias(i);
        d2 = distancia - d1;
        Hm(i) = 0.078 * d1 * d2 / k;
    end
end
