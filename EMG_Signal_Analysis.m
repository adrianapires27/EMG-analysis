load 'emg_healthy.txt';
load 'emg_myopathy.txt';
load 'emg_neuropathy.txt';

who %Your variables are
whos % Name Size Bytes Class Attributes

% primeira coluna é o tempo e a segunda coluna é o sinal 

time_healthy = emg_healthy(:, 1);
signal_healthy = emg_healthy(:, 2);

time_myopathy = emg_myopathy(:, 1);
signal_myopathy = emg_myopathy(:, 2);

time_neuropathy = emg_neuropathy(:, 1);
signal_neuropathy = emg_neuropathy(:, 2);

%---------------------------------------------------------
% Analise do tempo (Time/Amplitude):

figure(1)

% Healthy
subplot(3,1,1)
plot(time_healthy, signal_healthy) %tempo no eixo do x e a amplitude no eixo do y
axis([1 1.5 -0.4 0.4])
title('EMG Healthy');
xlabel('Time (s)');
ylabel('Amplitude');

% Myopathy
subplot(3,1,2)
plot(time_myopathy, signal_myopathy) %tempo no eixo do x e a amplitude no eixo do y
axis([1 1.5 -1 1])
title('EMG Myopathy');
xlabel('Time (s)');
ylabel('Amplitude');

% Neuropathy
subplot(3,1,3)
plot(time_neuropathy, signal_neuropathy) %tempo no eixo do x e a amplitude no eixo do y
axis([1 1.5 -3 2])
title('EMG Neuropathy');
xlabel('Time (s)');
ylabel('Amplitude');

%-----------------------------------
% Calcular a amplitude dos sinais:

% Healthy
amplitude_healthy = max(signal_healthy) - min(signal_healthy);
fprintf('Amplitude Healthy: %.2f\n', amplitude_healthy);

% Myopathy
amplitude_myopathy = max(signal_myopathy) - min(signal_myopathy);
fprintf('Amplitude Myopathy: %.2f\n', amplitude_myopathy);

% Neuropathy
amplitude_neuropathy = max(signal_neuropathy) - min(signal_neuropathy);
fprintf('Amplitude Neuropathy: %.2f\n', amplitude_neuropathy);

%------------------------------------------
% Calcular a duração dos sinais:

% Taxa de amostragem
fa = 4000; % 4000 amostras por segundo

% Healthy
Tsinal_healthy = length(signal_healthy) / fa;
fprintf('Duração do sinal EMG Healthy: %.2f segundos\n', Tsinal_healthy);

% Myopathy
Tsinal_myopathy = length(signal_myopathy) / fa;
fprintf('Duração do sinal EMG Myopathy: %.2f segundos\n', Tsinal_myopathy);

% Neuropathy
Tsinal_neuropathy = length(signal_neuropathy) / fa;
fprintf('Duração do sinal EMG Neuropathy: %.2f segundos\n', Tsinal_neuropathy);

%--------------------------------------------------------------------------
% Calcular a energia do sinal e do ruído, e o SNR para cada sinal

% Healthy
Es_healthy = sum(signal_healthy.^2); % energia total do sinal
ruido_healthy = signal_healthy(1:300); % ruído
Er_healthy = sum(ruido_healthy.^2); % energia total do ruído
SNR_healthy = 10 * log10(Es_healthy / Er_healthy); % SNR em dB

% Myopathy
Es_myopathy = sum(signal_myopathy.^2); % energia total do sinal
ruido_myopathy = signal_myopathy(1:300); % ruído
Er_myopathy = sum(ruido_myopathy.^2); % energia total do ruído
SNR_myopathy = 10 * log10(Es_myopathy / Er_myopathy); % SNR em dB

% Neuropathy
Es_neuropathy = sum(signal_neuropathy.^2); % energia total do sinal
ruido_neuropathy = signal_neuropathy(1:300); % ruído
Er_neuropathy = sum(ruido_neuropathy.^2); % energia total do ruído
SNR_neuropathy = 10 * log10(Es_neuropathy / Er_neuropathy); % SNR em dB

% Exibir os resultados
fprintf('Energia do Sinal (Healthy): %.2f\n', Es_healthy);
fprintf('Energia do Ruído (Healthy): %.2f\n', Er_healthy);
fprintf('SNR EMG Healthy: %.2f dB\n', SNR_healthy);

fprintf('Energia do Sinal (Myopathy): %.2f\n', Es_myopathy);
fprintf('Energia do Ruído (Myopathy): %.2f\n', Er_myopathy);
fprintf('SNR EMG Myopathy: %.2f dB\n', SNR_myopathy);

fprintf('Energia do Sinal (Neuropathy): %.2f\n', Es_neuropathy);
fprintf('Energia do Ruído (Neuropathy): %.2f\n', Er_neuropathy);
fprintf('SNR EMG Neuropathy: %.2f dB\n', SNR_neuropathy);

% Visualizar os SNRs em um gráfico de barras
figure(2)
SNR_values = [SNR_healthy, SNR_myopathy, SNR_neuropathy]; % vetor que contém os valores de SNR para os três sinais
bar(SNR_values) % função para criar um gráfico de barras
set(gca, 'XTickLabel', {'Healthy', 'Myopathy', 'Neuropathy'}) % função para configurar o eixo X

% Gráfico de barras:
xlabel('Signal Type')
ylabel('SNR (dB)')
title('SNR of EMG Signals') 
%----------------------------------------------------------
% Filtros: Passa-Baixo, Passa-Alto, Rejeita-Banda, Passa-Banda

% Taxa de amostragem
fa = 4000;

% Definir as frequências de corte para cada filtro
fc_PBaixo = 50; % Passa-Baixo
fc_PAlto = 20; % Passa-Alto
fc1_RBanda = 45; % Rejeita-Banda (limite inferior)
fc2_RBanda = 55; % Rejeita-Banda (limite superior)
fc1_PBanda = 20; % Passa-Banda (limite inferior)
fc2_PBanda = 60; % Passa-Banda (limite superior)

% Ordem do filtro Butterworth
ordem = 2;

% Criar filtros Butterworth
[B_PBaixo, A_PBaixo] = butter(ordem, fc_PBaixo/(fa/2), 'low');
[B_PAlto, A_PAlto] = butter(ordem, fc_PAlto/(fa/2), 'high');
[B_RBanda, A_RBanda] = butter(ordem, [fc1_RBanda, fc2_RBanda]/(fa/2), 'stop');
[B_PBanda, A_PBanda] = butter(ordem, [fc1_PBanda, fc2_PBanda]/(fa/2), 'bandpass');

% Aplicar os filtros aos sinais usando filtfilt para evitar atraso de fase
sf_PBaixo_healthy = filter(B_PBaixo, A_PBaixo, signal_healthy);
sf_PAlto_healthy = filter(B_PAlto, A_PAlto, signal_healthy);
sf_RBanda_healthy = filter(B_RBanda, A_RBanda, signal_healthy);
sf_PBanda_healthy = filter(B_PBanda, A_PBanda, signal_healthy);

sf_PBaixo_myopathy = filter(B_PBaixo, A_PBaixo, signal_myopathy);
sf_PAlto_myopathy = filter(B_PAlto, A_PAlto, signal_myopathy);
sf_RBanda_myopathy = filter(B_RBanda, A_RBanda, signal_myopathy);
sf_PBanda_myopathy = filter(B_PBanda, A_PBanda, signal_myopathy);

sf_PBaixo_neuropathy = filter(B_PBaixo, A_PBaixo, signal_neuropathy);
sf_PAlto_neuropathy = filter(B_PAlto, A_PAlto, signal_neuropathy);
sf_RBanda_neuropathy = filter(B_RBanda, A_RBanda, signal_neuropathy);
sf_PBanda_neuropathy = filter(B_PBanda, A_PBanda, signal_neuropathy);

% Calcular e plotar FFT dos sinais filtrados

% Healthy Signal
Nh = length(signal_healthy); % Número de amostras do sinal healthy
fr_healthy = fa / Nh; % Resolução em frequência
fh = (0:Nh-1) * fr_healthy; % Vetor das frequências absolutas (Hz)

figure(3);
subplot(4,1,1);
plot(fh, abs(fft(sf_PBaixo_healthy)) / Nh);
title('FFT do Sinal Filtrado Passa-Baixo (Healthy)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(4,1,2);
plot(fh, abs(fft(sf_PAlto_healthy)) / Nh);
title('FFT do Sinal Filtrado Passa-Alto (Healthy)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(4,1,3);
plot(fh, abs(fft(sf_RBanda_healthy)) / Nh);
title('FFT do Sinal Filtrado Rejeita-Banda (Healthy)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(4,1,4);
plot(fh, abs(fft(sf_PBanda_healthy)) / Nh);
title('FFT do Sinal Filtrado Passa-Banda (Healthy)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% Myopathy Signal
Nm = length(signal_myopathy); % Número de amostras do sinal myopathy
fr_myopathy = fa / Nm; % Resolução em frequência
fm = (0:Nm-1) * fr_myopathy; % Vetor das frequências

figure(4);
subplot(4,1,1);
plot(fm, abs(fft(sf_PBaixo_myopathy)) / Nm);
title('FFT do Sinal Filtrado Passa-Baixo (Myopathy)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(4,1,2);
plot(fm, abs(fft(sf_PAlto_myopathy)) / Nm);
title('FFT do Sinal Filtrado Passa-Alto (Myopathy)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(4,1,3);
plot(fm, abs(fft(sf_RBanda_myopathy)) / Nm);
title('FFT do Sinal Filtrado Rejeita-Banda (Myopathy)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(4,1,4);
plot(fm, abs(fft(sf_PBanda_myopathy)) / Nm);
title('FFT do Sinal Filtrado Passa-Banda (Myopathy)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

% Neuropathy Signal
Nn = length(signal_neuropathy); % Número de amostras do sinal neuropathy
fr_neuropathy = fa / Nn; % Resolução em frequência
fn = (0:Nn-1) * fr_neuropathy; % Vetor das frequências

figure(5);
subplot(4,1,1);
plot(fn, abs(fft(sf_PBaixo_neuropathy)) / Nn);
title('FFT do Sinal Filtrado Passa-Baixo (Neuropathy)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(4,1,2);
plot(fn, abs(fft(sf_PAlto_neuropathy)) / Nn);
title('FFT do Sinal Filtrado Passa-Alto (Neuropathy)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(4,1,3);
plot(fn, abs(fft(sf_RBanda_neuropathy)) / Nn);
title('FFT do Sinal Filtrado Rejeita-Banda (Neuropathy)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

subplot(4,1,4);
plot(fn, abs(fft(sf_PBanda_neuropathy)) / Nn);
title('FFT do Sinal Filtrado Passa-Banda (Neuropathy)');
xlabel('Frequency (Hz)');
ylabel('Amplitude');

%-------------------------------------------------------------
% Analise da frequencia (Frequencia/Periodo)

% Calcula a FFT dos sinais de EMG:
% transformada discreta de Fourier
% altera o domínio da frequencia: converte na representação no tempo em freq.

fft_healthy = fft(signal_healthy);
fft_myopathy = fft(signal_myopathy);
fft_neuropathy = fft(signal_neuropathy);

% Calcula o comprimento dos sinais:
Nh = length(signal_healthy);
Nm = length(signal_myopathy);
Nn = length(signal_neuropathy);

% Define o menor comprimento de sinal
min_length = min([Nh, Nm, Nn]);

% Calcula o vetor de frequência
f = (0:min_length-1)*(fa/min_length);

% Calcula a magnitude da FFT e normaliza
mag_fft_healthy = abs(fft_healthy(1:min_length)/min_length); % Normaliza pela quantidade de pontos
mag_fft_myopathy = abs(fft_myopathy(1:min_length)/min_length); % Normaliza pela quantidade de pontos
mag_fft_neuropathy = abs(fft_neuropathy(1:min_length)/min_length); % Normaliza pela quantidade de pontos

% Apenas a metade do espectro é necessária devido à simetria
half_length = floor(min_length/2);
f = f(1:half_length);
mag_fft_healthy = mag_fft_healthy(1:half_length);
mag_fft_myopathy = mag_fft_myopathy(1:half_length);
mag_fft_neuropathy = mag_fft_neuropathy(1:half_length);

% Plot dos espectros de frequência
figure(6);

% Healthy
subplot(3,1,1);
plot(f, mag_fft_healthy);
title('Espectro de Frequência - EMG Healthy');
xlabel('Frequência (Hz)');
ylabel('Magnitude');
xlim([0 fa/2]); %exibe somente frequências positivas até a metade da taxa de amostragem

% Myopathy
subplot(3,1,2);
plot(f, mag_fft_myopathy);
title('Espectro de Frequência - EMG Myopathy');
xlabel('Frequência (Hz)');
ylabel('Magnitude');
xlim([0 fa/2]); %exibe somente frequências positivas até a metade da taxa de amostragem

% Neuropathy
subplot(3,1,3);
plot(f, mag_fft_neuropathy);
title('Espectro de Frequência - EMG Neuropathy');
xlabel('Frequência (Hz)');
ylabel('Magnitude');
xlim([0 fa/2]); %exibe somente frequências positivas até a metade da taxa de amostragem
