[y, Fs] = audioread('oLore.wav');
info = audioinfo('oLore.wav');
duracion = info.Duration;
y = y(:,1);

ventana = 100;
noverlap = 90;
NFFT = 128;
spectrogram(y, ventana, noverlap, NFFT, Fs, 'yaxis');

load('BaseDeDatos.mat',"data");
vocales = vertcat(data.formantes);

tiempo = 0;
delta = 0.02; 

for tiempo = 0:delta:(duracion - delta)
    inicio = floor(tiempo / (1 / Fs)) + 1;
    fin = floor((tiempo + delta) / (1 / Fs)) + 1;
    % W = rango de tiempo
    w = y(inicio:fin); 

    try
        [formanteAux] =  obtenerFormantes(w, Fs, ' ');
        tam = min(3, length(formante));
        formante = [NaN, NaN, NaN];
        formante (1:tam) = formanteAux(1:tam);
        %formante
        
        idx = knnsearch(vocales, formante);
        objetivo = vocales(idx, :);
        
        for i = 1:length(data) 
            if ismember(data(i).formantes, objetivo, 'rows') == [1, 1, 1]
                letra = data(i).val;   
            end
        end
    catch ME
        tiempo
        sprintf('halp')
    end   
end