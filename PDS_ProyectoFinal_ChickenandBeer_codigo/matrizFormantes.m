function [FormantesLetra] = matrizFormantes (audio, Fs, nombre)
info = audioinfo(nombre);
    %sound(y, Fs);
    duracion = info.Duration;
    audio = audio(:,1);
    
    tiempo = 0;
    delta = 0.02;
    m = 0;
    
    for tiempo = 0:delta:(duracion - delta)
        inicio = floor(tiempo / (1 / Fs)) + 1;
        fin = floor((tiempo + delta) / (1 / Fs)) + 1;
        % W = rango de tiempo
        w = audio(inicio:fin); 
    
        try
            [formante] =  obtenerFormantes(w, Fs, ' ');
            m = m + 1;
            tam = min(3, length(formante));
            
            FormantesLetra(m, :) = [NaN, NaN, NaN];
            
           
            FormantesLetra(m, 1:tam) = formante(1:tam);
            
        catch ME
            tiempo
            sprintf('halp')
        end   
    end
end

