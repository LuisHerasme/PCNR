% Usando formula de Haversine.

function d = distLatLon(lat1, lon1, lat2, lon2)
    R = 6371e3;
    teta1 = lat1 * pi/180;
    teta2 = lat2 * pi/180;
    deltaTeta = (lat2 - lat1) * pi/180;
    deltaLong = (lon2 - lon1) * pi/180;
    a = sin(deltaTeta/2) * sin(deltaTeta/2) + cos(teta1) * cos(teta2) * sin(deltaLong/2) * sin(deltaLong/2);
    c = 2 * atan2(sqrt(a), sqrt(1 - a));
    d = R * c;
end
