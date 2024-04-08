%Generic Forward Euler Method 
%This function solves for equation du/dt=f(u,t) using Forward Euler's Method
% function [u,t] = forward_euler(f,a,b,ua,n,flag)
% INPUT:
% f   = Matlab inline function f(u,t)
% a   = Interval start
% b   = Interval end
% ua  = Initial condition
% n   = Number of nodes
% flag= Plotting flag, yes=1, no<1
% OUTPUT: 
% u   = Computed Solution
% t   = Independent Variable
% Written by Nirni Kumar, UW, 2020
% Partially based on codes from Louise Kettle and some other online codes

function [u,t] = forward_euler(f,a,b,ua,n,flag)
dh    = abs(b-a)/n;
ui    = ua;
ti    = a;
u(1,:)= ui;
t(1)  = a;

for i=1:1:n
    tn       = ti+dh;
    un       = ui + f(ui,ti)*dh;
    ui       = un;
    ti       = tn;
    u(i+1,:) = un;
    t(i+1,:) = tn;
end

if flag >= 1
    figure
    plot(t,u,'b','linewidth',2);
    grid 
    hold on
    xlim([0 max(t)]);
    xlabel('$t$','interpreter','latex','fontsize',16);
    ylabel('$u$','interpreter','latex','fontsize',16);
    h2=legend(['$\Delta T=~',num2str(dh),'$']);
    set(h2,'interpreter','latex','fontsize',15);
    h1=gca;
    set(h1,'tickdir','out','xminortick','on','yminortick','on');
end
