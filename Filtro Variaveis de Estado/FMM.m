clc;
clear all;

janela = 100;

data = load('output.txt');

num_amostra = 5000;

ts = 1/1000;

for i = janela+1:num_amostra
    tempo(i) = i * ts;
    sum = 0;
    for j = 0:janela-1
        sum = sum + data(i-j);
    end
    filtered_data(i) = sum / janela;
end


figure;
plot(tempo, data);
hold on;
plot(tempo, filtered_data,'LineWidth',3);
xlabel('Tempo (s)');
ylabel('Tensao (v)');
legend('Original', 'Filtrado');

