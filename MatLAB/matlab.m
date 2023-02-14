G=tf(ss(A,B,C,D))
Grga=G;
s=tf('s');
 Grga(1,1)=Grga(1,1)*s
Grga(1,2)=Grga(1,2)*s
Grga(1,3)=Grga(1,3)*s
 Grga=minreal(Grga)

 G0=dcgain(Grga)
 RGA=G0.*inv(G0)'


 G10=evalfr(Grga,10)
 DRGA=G10.*inv(G10)'

