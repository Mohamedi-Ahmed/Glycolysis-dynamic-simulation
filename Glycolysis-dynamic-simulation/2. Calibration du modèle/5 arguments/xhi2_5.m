function xhi = xhi2_5(temps,G_moy,params)

Gi0 = 4500;
Gs0 = G_moy(1);
I0 = 10;

X0=[Gi0,Gs0,I0];

my_ode = @(Ici,Here)dGdI_5(Ici,Here,params);
[t,y] = ode45(my_ode,temps,X0);

if size(t) == size(y(:,2))
    xhi = sum((y(:,2)-G_moy).^2 )+any(params<0)*10^7;
else
    xhi = 10^7;
end 

xhi;

plot(t,y(:,2),t,G_moy,"r+")
legend("Glucose théorique", "Glucose expérimental")
drawnow