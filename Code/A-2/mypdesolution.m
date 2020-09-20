function mypdesolution
c=1;
a1 =48.06;  
b1 =764.3;  
c1 =1522;  
layer_d=[0.0006,0.006,0.0036,0.0055];
xspan=[0 sum(layer_d)];
tspan=[0 4000];
ngrid=[400000 10];%t,x
k=[0.082,0.37,0.045,0.028];
k_transition=[0.134,0.08,0.0345];
C=[1377,2100,1726,1005];
ro=[300,862,74.2,1.18];
f=@(x)37;
g1=@(t)65;
d1=ngrid(1)/range(tspan);
g2=@(t)37;%(t)a1*exp(-((t/d1-b1)/c1)^2);
[T,x,t]=rechuandao(c,f,g1,g2,xspan,tspan,ngrid,layer_d,k,k_transition,C,ro);
[x,t]=meshgrid(x,t);
fprintf('矩阵大小%f,%f',size(T))
fprintf('x=%f',size(x))
fprintf('t=%f',size(t))
mesh(x,t,T);
xlabel('x')
ylabel('t')
zlabel('T')
output_matrix=zeros(range(tspan),ngrid(2));
output_count=1;
for i=1:ngrid(1)
    if(mod(i-1,100)==0)
        output_matrix(output_count,:)=T(i,:);
        output_count=output_count+1;
    end
end
% data_cell=mat2cell(output_matrix,ones(range(tspan),1),ones(ngrid(2),1));
% title('time','x=1.52mm','x=3.04mm','x=4.56mm','x=6.08mm','x=7.6mm','x=9.12mm','x=10.64mm','x=12.16mm','x=13.68mm','x=15.2mm');
 %result=[title];
 s=xlswrite('E:\同济\大三上\数模\program\A3(基础模型) - 副本\problem2.xlsx',output_matrix);

