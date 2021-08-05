format longg
central =  [ 18.45264, -69.98052 ];

nodos = [
    18.493137, -69.918273;
    18.493138, -69.935561;
    18.484809, -69.910039;
    18.500816, -69.906818;
    18.508113, -69.896805;
    18.484871, -69.893289;
    18.470304, -69.894795;
    18.477162, -69.919302;
    18.453849, -69.921604;
    18.468656, -69.943828;
    18.451318, -69.938188;
    18.478914, -69.950688;
    18.487378, -69.96012;
    18.454394, -69.964941;
    18.481001, -69.976092;
    18.430122, -69.973917;
    18.463482, -69.98554;
    18.498559, -69.977104;
    18.472034, -69.994046;
    18.42671, -69.999375;
    central
];

conectado = [
    12;
    13;
    10;
    1;
    2;
    3;
    11;
    9;
    14;
    21;
    21;
    21;
    21;
    21;
    21;
    21;
    21;
    15;
    17;
    16
];

% Calcular distancias
distancias = [];

for i = 1: 20
    nodo1 = nodos(i, :);
    nodo2 = nodos(conectado(i, :), :);
    distancia_km = distancia(nodo1, nodo2)/1000;
    distancias = [ distancias distancia_km];

    if conectado(i, :) == 21
        disp([num2str(i) " -> central"])
    else
        disp( [ num2str(i) " -> " num2str(conectado(i, :)) ] )
    end
end

% Configuracion 
PTX = 17;
perdidas = 0.5;
sensibilidad = -60;
F0 = 21.196;

a0 = 0.1;
b0 = 3.5e-3;
c0 = 0.01;
e0 = 7.16; 

ganancias = [];
FMs = [];
RSLmins = [];
FSLs= [];

for d = distancias
    FSL0 = FSL(F0, d, a0, b0, c0, e0);
    FSLs = [FSLs FSL0];
    FM0 = fadeMargin(d, 1, 0.5, F0);
    FMs = [FMs FM0];
    
    RSLmin = sensibilidad + FM0;

    RSLmins = [RSLmins RSLmin];
    G = 0.5 * (RSLmin + FSL0 - PTX + 2 * perdidas );
    ganancias = [ganancias G];
end

% max(ganancias)

G_FIJA = 44.8;


    % Presupuesto del enlace
    RSL = PTX - perdidas + G_FIJA - FSLs + G_FIJA - perdidas;

% F = RSL - T
FM_con_antena = RSL - sensibilidad;

% Disponibilidad
disponibilidades = [];
for i = 1: 20
    D = distancias(i);
    FM = FM_con_antena(i);
    disponibilidad0 = disponibilidad(1, 0.5, F0, D, FM);
    disponibilidades = [disponibilidades disponibilidad0];
end


%% INTERFERENCIA

% AB = B - A
% ENLACE_9_14 = nodo14 - nodo9;

    v_9_14  = nodos(14, :) - nodos(9, :);
    v_9_15  = nodos(15, :) - nodos(9, :);

    v_15_18 = nodos(18, :) - nodos(15, :);
    v_15_9  = -v_9_15;

    angulo_g1 = angle(v_9_14, v_9_15)
    angulo_g2 = angle(v_15_18, v_15_9)
    p1 = ganancia(angulo_g1);
    p2 = ganancia(angulo_g2);

    D0 = distancia(nodos(9, :), nodos(15, :));
    FSL0 = FSL(F0, D0, a0, b0, c0, e0);
    RSL0 = PTX - perdidas + G_FIJA - FSL0 + G_FIJA - perdidas - 52 - 75

