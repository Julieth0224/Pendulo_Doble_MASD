%%%% MAIN %%%%

disp('¡Bienvenido!')
disp(' ')
txt = 'Ingrese 0 si quiere realizar la simulación sin rozamiento y 1 de lo contrario: ';
condicion1 = input(txt);

if condicion1 ~= 0 & condicion1 ~= 1
    error('Entrada no válida')
end

txt2 = 'Ingrese el tiempo inicial: ';
ti = input(txt2);

if ti < 0
    error('Entrada no válida')
end

txt3 = 'Ingrese el tiempo final: ';
tf = input(txt3);

if tf <= 0
    error('Entrada no válida')
end

if tf <= 0
    error('Entrada no válida')
end

if tf <= ti
    error('Entrada no válida')
end

if condicion1
    txt4 = 'Ingrese la matriz de masas, longitudes y constantes de rozamiento: ';
else
    txt4 = 'Ingrese la matriz de masas y longitudes: ';
end
ML = input(txt4);


txt5 = 'Ingrese la matriz de condiciones iniciales: ';
CI = input(txt5);

if condicion1
    Pendulos_con_rozamiento(ti,tf,ML,CI);
else
    Pendulos_sin_rozamiento(ti,tf,ML,CI)
end


