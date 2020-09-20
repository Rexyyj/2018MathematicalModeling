function [T,x,t]=cal_fun(layer_d,k,k_transition,C,ro,x_step,t_set,f,boundary_heat,boundary_body)
x_len=(layer_d(1)+layer_d(2)+layer_d(3)+layer_d(4))/x_step;
t_len=(t_set(2)-t_set(1))/t_set(3);
t=linspace(t_set(1),t_set(2),t_len);
x=linspace(0,(layer_d(1)+layer_d(2)+layer_d(3)+layer_d(4)),x_len);
T=zeros(t,x);

T(:,1)=boundary_heat(t);
T(:,x_len)=boundary_body(t);

T(1,:)=f(x);

for i=2:t_len
    U=zeros(x_len-2,x_len-2);
    constant_temp=zeros(x_len-2);
    for j=2:x_len-1
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
        
        AE=para(1)/x_step;
        AW=para(1)/x_step;
        AP=(para(3)*para(2)*x_step)/t_set(3);
        
        if(j==2)
            U(j-1,j-1)=1;
            constant_temp(j-1)=T(i,j-1)*AE+T(i-1,j)*AP;
            U(j-1,j)=-AW;
        elseif(j==x_len-1)
            U(j-1,j-1)=1;
            constant_temp(j-1)=T(i,j+1)*AW+T(i-1,j);
            U(j-1,j-2)=-AE;
        else
            U(j-1,j-1)=1;
            constant_temp=T(i-1,j)*AP;
            U(j-1,j-2)=-AE;%矩阵对角线前一格
            U(j-1,j)=-AW;%矩阵对角线后一格
        end
    end
    y_temp=constant_temp*U^-1;
    for l=2:x_len-1
        T(i,l)=y_temp(l-1);
    end
    
end

end