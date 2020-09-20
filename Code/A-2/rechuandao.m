function [U,x,t]=rechuandao(c,f,g1,g2,xspan,tspan,ngrid,layer_d,k,k_transition,C,ro)
n=ngrid(1);
m=ngrid(2);
h=range(xspan)/(m-1);
x=linspace(xspan(1),xspan(2),m);
t_step=range(tspan)/(n-1);
t=linspace(tspan(1),tspan(2),n);
x_step=h;
r=c^2*t_step/h^2;
% if r>0.5
%     error('jakfjl')
% end


U=zeros(ngrid);
U(1,:)=f(x);
U(:,1)=g1(t);
%U(:,m)=g2(t); 
for i=1:n%range(tspan)
   
    U(i,m)=g2(i);
    fprintf('uim=%f',U(i,m))

end




for j=2:n
    for i=2:m-1
        if (j<(layer_d(1))/x_step-1)
            para=[k(1),C(1),ro(1)];
        elseif  (j>((layer_d(1))/x_step-1)&&j<(layer_d(1)/x_step))
            para=[k_transition(1),C(1),ro(1)];
        elseif (j>((layer_d(1))/x_step)&&j<(layer_d(1)/x_step+1))
            para=[k_transition(1),C(2),ro(2)];
        elseif (j>(layer_d(1)/x_step+1)&&j<((layer_d(1)+layer_d(2))/x_step-1))
            para=[k(2),C(2),ro(2)];
        elseif (j>((layer_d(1)+layer_d(2))/x_step-1)&&j<((layer_d(1)+layer_d(2))/x_step))
            para=[k_transition(2),C(2),ro(2)];
        elseif (j>((layer_d(1)+layer_d(2))/x_step)&&j<((layer_d(1)+layer_d(2))/x_step+1))
            para=[k_transition(2),C(3),ro(3)];
        elseif (j>((layer_d(1)+layer_d(2))/x_step+1)&&j<((layer_d(1)+layer_d(2)+layer_d(3))/x_step-1))
            para=[k(3),C(3),ro(3)];
        elseif (j>((layer_d(1)+layer_d(2)+layer_d(3))/x_step-1)&&j<((layer_d(1)+layer_d(2)+layer_d(3))/x_step))
            para=[k_transition(3),C(3),ro(3)];
        elseif (j>((layer_d(1)+layer_d(2)+layer_d(3))/x_step)&&j<((layer_d(1)+layer_d(2)+layer_d(3))/x_step)+1)
            para=[k_transition(3),C(4),ro(4)];
        else
            para=[k(4),C(4),ro(4)];
        end      
        a=para(1)/(para(2)*para(3));
        Fo=(a*t_step)/x_step^2;
        Bi=(h*x_step)/para(1);
        temp1=1/(2*Bi+2);
        if Fo>temp1
            fprintf('error')
        end
        U(j,i)=Fo*(U(j-1,i-1)+U(j-1,i+1))+(1-2*Fo)*U(j-1,i);
    end
end