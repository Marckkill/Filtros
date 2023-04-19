clc;
clear all;

%Variaveis e estado inicial
phi = [ 1 1 ; 0 1];
B = [-0.5 ; -1];
g = 9.8;
h = [1 0];
r=20000;
Ppriori(1:2,1:2,1) = 1000000*eye(2);
Xpriori(1:2,1) = [9000;0];
q = 100*eye(2);
z(1)=10000;
v(1)=0;
x(1:2,1)=[z(1) ; v(1)];

for k = 1:45
%Simulacao de sistema em malha aberta
z(k) = h*x(1:2,k)+(2 * (rand(1) - 0.5))*200;
x(1:2,k+1) = phi*x(1:2,k)+B*g;

%Ganho de Kalman
Kgain(1:2,k) = Ppriori(1:2,1:2,k) * h' * (h*Ppriori(1:2,1:2,k) * h' + r) ^-1;

%Etapa de correcao
Xposteriori(1:2,k) = Xpriori(1:2,k) + Kgain(1:2,k) * (z(k) - h * Xpriori(1:2,k));

%Covariancia de erro
Pposteriori(1:2,1:2,k) = (eye(2) - Kgain(1:2,k) * h) * Ppriori(1:2,1:2,k);

%Etapa de predicao
Ppriori(1:2,1:2,k+1) = phi * Pposteriori(1:2,1:2,k) * phi' + q;
Xpriori(1:2,k+1) = phi * Xposteriori(1:2,k) + B*g;
end


figure;
plot(Xpriori(1,:),'LineWidth',1);
hold on;
plot(z,'LineWidth',1);
xlabel('Tempo (s)');
ylabel('Altura (M)');
legend('Filtrado', 'Original');

