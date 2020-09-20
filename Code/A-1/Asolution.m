function Asolution
 layer_d=[0.0006,0.006,0.0036,0.005];
 k=[0.082,0.37,0.045,0.028];
 k_transition=[0.134,0.08,0.0345];%待定
 C=[1377,2100,1726,1005];
 ro=[300,862,74.2,1.18];
 
 x_step=0.0001;
 t_set=[0 100 1];%起始 终点 步长
 f=@(x)37;
 boundary_heat=@(t)75;
 boundary_body=@(t)37;
 [T,x,t]=cal_fun(layer_d,k,k_transition,C,ro,x_step,t_set,f,boundary_heat,boundary_body);
[x,t]=meshgrid(x,t);
mesh(x,t,T);
xlabel('x')
ylabel('t')
zlabel('T')
 
 