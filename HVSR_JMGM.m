%--------------------------------------------------------------------------
%----FUNCIÓN HVSR----------------------------------------------------------
%-----GARCÍA MÁRQUEZ JOSÉ MARÍA--------------------------------------------
%----CALCULAR UN H/V-------------------------------------------------------
%----MÉTODO NAKAMURA-------------------------------------------------------
%--------------------------------------------------------------------------

function []= HVSR_JMGM(t,v, h1 ,h2)
%----Gráficas--------------------------------------------------------------
figure(1)

subplot(3,1,1)
plot(t,v)
title("COMPONENTES DE LA SEÑAL")
subtitle("Componente vertical")
xlabel("Tiempo [min]")

subplot(3,1,2)
plot(t,h1)
subtitle("Componente horizontal 1")
xlabel("Tiempo [min]")

subplot(3,1,3)
plot(t,h2)
subtitle("Componente horizontal 2")
xlabel("Tiempo [min]")


%----Ventaneo de 7 minutos para los cocientes-----------------------------
%--------Avanzamos cada minuto--------------------------------------------
vv = [];
vt = [];
vh1 = [];
vh2 = [];
a = 100*60*7;
b = 100*60;

%----Creamos el dominio de Fourier-----------------------------------------
N = a; 
F0 = 1/(N*dt);
FN = 1/(2*dt);
%--------Por recursos de computo será de 0 a FN----------------------------
F = [0:F0:FN-F0];
SC1 = 0
SC2 = 0
NC = 19;
for c1 = 1:NC
    vv = v(1+(c1-1)*b: b*7+b*(c1-1));
    vh1 = h1(1+(c1-1)*b: b*7+b*(c1-1));
    vh2 = h2(1+(c1-1)*b: b*7+b*(c1-1));
    vt = t(1+(c1-1)*b: b*7+b*(c1-1));
%--------Se trandofma para pasar al dominio de Fourier---------------------
    VV = fft(vv);
    VV = abs(VV(1:N/2));

    VH1 = fft(vh1);
    VH1 = abs(VH1(1:N/2));
    C1 = VH1./VV;
    SC1 = SC1+C1;
    figure(2)
    hold on
    loglog(F,C1)
    xlabel("Frecuencias [Hz]")
    ylabel("Amplitud")
    title("H/V C1")


    VH2 = fft(vh2);
    VH2 = VH2(1:N/2);
    C2 = VH2./VV;
    SC2 = SC2 +C2;
    figure(3)
    hold on
    loglog(F,C2)
    xlabel("Frecuencias [Hz]")
    ylabel("Amplitud")
    title("H/V C2")

    C = (C1+C2)/2;
    figure(4)
    loglog(F,C)
    hold on
    xlabel("Frecuencias [Hz]")
    ylabel("Amplitud")
    title("H/V")


end
%----Promedio-------------------------------------------------------------
SC1 = SC1/NC;
SC2 = SC2/NC;

figure(5)
loglog(F,SC1)
xlabel("Frecuencias [Hz]")
ylabel("Amplitud")
title("H/V I")

figure(6)
loglog(F,SC2)
xlabel("Frecuencias [Hz]")
ylabel("Amplitud")
title("H/V II")
