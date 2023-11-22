function xhi = xhi2_3_exp(temps,G_moy ,params, Cond_Initiales)

X0=[Cond_Initiales(1);Cond_Initiales(2);Cond_Initiales(3);params(4)];

my_ode = @(Ici,Here)dGdI_3_exp(Ici,Here,params(1:3));
[t,y] = ode45(my_ode,temps,X0);

if size(t) == size(y(:,2))
    xhi = sum((y(:,2)-G_moy).^2 )+any(params<0)*10^7;
else
    xhi = 10.^7;
end 

xhi
plot(t,y(:,2),t,G_moy,"r+")
legend("Glucose théorique", "Glucose expérimental")
drawnow