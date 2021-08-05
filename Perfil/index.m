data = csvread("./perfiles/nevera_casabito.csv");
punto1 = data(1, :);
punto2 = data(end, :);

% Distancais en km

punto1 = punto1(2: 3);
punto2 = punto2(2: 3);
distancia = distLatLon(punto1(1), punto1(2), punto2(1), punto2(2))

% Convertir a km.
distancia = distancia/1000 

distancias0 = linspace(0, distancia, 100);

% Distancia en km

distancia0 = distancias0(length(distancias0));

% Altunas metros

alturas0 = data(:, 1);

% Frecuencia en GHz

frecuencia0 = 7

% Vegetacion (10 m)

vegetacion = 10

% Factor k

k = 1.33

disp("Zona de fresnel:")

f = fresnel(distancias0, frecuencia0, distancia0)

disp("60% de la zona de fresnel + 10m:")

f6 = 0.6 * f + 10

% Curvatura de la tierra tomando en cuenta el factor K.

disp("Curvatura Hm:")
Hm = curvatura(distancias0, k)

% Vegetacion asumimos que es de 10 m
vegetacion = 10;

disp("h + 60% Rm + 10m + Hm:")
final = Hm + f6 + vegetacion

final(1) = 0; 
final(length(final)) = 0;

terrenoVegetacion = alturas0 + vegetacion; 

% Quitar arboles en la base de las Antenas.
terrenoVegetacion(1) = alturas0(1);
terrenoVegetacion(length(terrenoVegetacion)) = alturas0(length(alturas0));

final = final + alturas0;

% Calculado linea
nTorre1 = alturas0(1);
nTorre2 = alturas0(length(alturas0));

torre1 = [0 nTorre1];
torre2 = [distancia0 nTorre2];

m = (torre1(2) - torre2(2)) / (torre1(1) - torre2(1));
b = torre1(2);

y = m * distancias0 + b;
y = y';

figure(1)
terrenoT = final - y;
plot(terrenoT)

% Nivel del suedo en las torres
[_ indx] = max(terrenoT);
alturaMaxima = final(indx);

dm = distancias0(indx);
dl = distancia0;

alturaTorres = -(dm/dl) * (nTorre2 - nTorre1) + alturaMaxima - nTorre1;

torre1 = [0 nTorre1 + alturaTorres];
torre2 = [distancia0 nTorre2 + alturaTorres];

m = (torre1(2) - torre2(2)) / (torre1(1) - torre2(1));
b = torre1(2);
y = m * distancias0 + b;

fresUp   = y' + 0.6 * f;
fresDown = y' - 0.6 * f;
figure(2)
plot(distancias0, alturas0, distancias0, final, distancias0, Hm, distancias0, terrenoVegetacion, distancias0, y, distancias0, fresUp, distancias0, fresDown)
legend('Terreno', '60% zona de Fresnel (Con margen de 10m) + Vegetacion 10m + Curvatura de la tierra + Alturas', 'Curvatura de la tierra', 'Terreno + Vegetacion', 'Zona de Fresnel superior', 'Zona de Fresnel inferior')
xlabel("Distancia (km)")
ylabel("Altura (m)")
alturaTorres