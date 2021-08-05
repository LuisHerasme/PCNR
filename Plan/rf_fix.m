clear;
clc;
format long;

%%%%% Cálculo para el RSL dado el el perfil esperado y una antena comercial Para sd-na-ca-san
%Frecuencias (en MHz)
f = [7407.5  7717.5
     7447.5  7757.5
     7487.5  7797.5
     7527.5  7837.5
     7567.5  7877.5
     7607.5  7917.5];
freq = [f f];

% Esta parte esta en millas

tramo2=[53.5   53.5     31.200   31.200
        53.5   53.5     31.200   31.200
        53.5   53.5     31.200   31.200
        53.5   53.5     31.200   31.200
        53.5   53.5     31.200   31.200
        53.5   53.5     31.200   31.200];

FSLdB = 32.44 + 20*log10(freq) + 20*log10(tramo2 * 1.609344)

% Calculados para una disponibilidad de un 99.999%
a = 1;
b = 0.5;
Fade_margin = -10 * log10 ((1-99.999/100)./(2.5*a*b.*freq/1000.* tramo2.^3 * 10^-6));

% Calculando el RSL minimo =
T = -55.6
Fade_margin
RSL_min = T + Fade_margin; % Primera correccion

% RSL_min = P_tx - FSL + 2*G

P_tx = 29;

%G = 0.5 * (RSL_min + FSLdB - P_tx + 2*(0.5 + 5.5));
G = (RSL_min + FSLdB - P_tx + 2 * (0.5 + 5.5)) / 2

% Ganancias de las antenas a usar: La máxima comercial
% Fade Margins reales
RSL_real = 29 -2*(0.5+5.5) + 2 * (46.8) - FSLdB;

T = -55.6; % Umbral para nuestra recepcion con 4096 QAM
F_real = -T + RSL_real;

% Undp para las antenas dadas
%Undp = 2.5*1*0.5*(freq/1000).*(tramo2.^3).*(10.^(-F_real/10))*(10^-6);
Undp = 2.5* 1 * 0.5 * (freq/1000) .* (tramo2.^3) .* (10.^(-F_real/10)) * (10^-6);
Undp
A = (1 - Undp) * 100



%%% Considerando mejorías por diversidad (asumiendo k = 1.333)
% Parametros

FGhz = 8 * ones(6, 4);

lambda = 3e8./(FGhz*1e6);

Dmi = tramo2 * 1.609344;

S = 3 * lambda * 8472.1 ./ (Dmi);


% Mejoria
Isd =  1.2e-3 * (FGhz ./ Dmi) .* S .^ 2 .* 10.^(F_real/10)

Undp_mejor = Undp./Isd;
A_mejor = (1 - Undp_mejor) * 100
