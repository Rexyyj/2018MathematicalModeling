function mypdesolution
c=1;
a1 =48.06;  
b1 =764.3;  
c1 =1522;  
layer_d=[0.0006,0.006,0.0036,0.005];
xspan=[0 sum(layer_d)];
tspan=[0 1000];
ngrid=[100000 10];%t,x
k=[0.082,0.37,0.045,0.028];
k_transition=[0.134,0.08,0.0345];
C=[1377,2100,1726,1005];
ro=[300,862,74.2,1.18];
f=@(x)37;
g1=@(t)75;
d1=ngrid(1)/range(tspan);
g2=@(t)a1*exp(-((t/d1-b1)/c1)^2);
[T,x,t]=rechuandao(c,f,g1,g2,xspan,tspan,ngrid,layer_d,k,k_transition,C,ro);
[x,t]=meshgrid(x,t);
fprintf('æÿ’Û¥Û–°%f,%f',size(T))
fprintf('x=%f',size(x))
fprintf('t=%f',size(t))
mesh(x,t,T);
xlabel('x')
ylabel('t')
zlabel('T')


