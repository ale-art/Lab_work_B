%augmented space 
sigma(A,B,C,D)
Wp=((s+10)/s)*eye(3);
G_new=Gtot*Wp;
figure();
sigma(G_new);
grid on;
legend;