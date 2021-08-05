function f = fresnel(distancias, frecuencia, distancia)
    f = zeros(length(distancias), 1);
    for i = 1: length(distancias)
        d1 = distancias(i);
        d2 = distancia - d1;
        f(i) = 17.3 * sqrt((d1*d2)/(frecuencia*distancia));
    end
end
