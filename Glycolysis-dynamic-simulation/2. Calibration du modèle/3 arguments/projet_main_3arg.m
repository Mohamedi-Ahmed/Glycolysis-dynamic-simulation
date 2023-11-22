%%      EXTRACTION DES DONNEES ET OPTIMISATION INITIALE
load ("calibration.mat");

temps=calibration(:,1);
moyenne=calibration(:,end);
plot(temps,moyenne,"r+")

Taille = size(calibration);
params0 = [0.0021*exp(-6.3) ; 0.00271 ; 150];
Cond_Initiale=[4500;119;10];
options = optimset('MaxFunEvals',1500);

my_ode=@(Ici,Here) dGdI_3(Ici,Here,params0);
[t,y]=ode45(my_ode,temps,Cond_Initiale);
plot(t,y(:,2),temps,moyenne,"r+")  %plot seulement le glucose sanguin

legend("Glucose théorique", "Glucose expérimental")
%%      CALCUL DES PARAMETRES OPTIMAUX GRACE AU XHI2
%{
my_ode = @(params)xhi2_3(temps,moyenne,params);
params_opt = fminsearch(my_ode,params0);

my_fit = @(Ici,Here) dGdI_3 (Ici,Here,params_opt);
[t,y_opt] = ode45 (my_fit, temps, Cond_Initiale);
plot(t,y_opt(:,2), temps,moyenne,"r+")
legend("Glucose théorique", "Glucose expérimental")

Tab_p_opt = [];
Tab_xhi2 =[];
for i = 2:11
    figure
    G_souris = calibration(:,i);
    my_souris = @(para)xhi2_3(temps,G_souris,para);
    p_opt=fminsearch(my_souris,params0,options);
    Tab_xhi2= cat(2,Tab_xhi2,my_souris(p_opt));
    Tab_p_opt=cat(2,Tab_p_opt,p_opt);
end

disp(Tab_xhi2)
disp(Tab_p_opt)
%}
%%      CALCUL DES ETENDUES (Ecart type)
%{
Tab_Etendu=[];
for i = 1:3
    etendu=max(Tab_p_opt(i,:))-min(Tab_p_opt(i,:));
    Tab_Etendu=cat(1,Tab_Etendu,etendu);
end

disp(Tab_Etendu)
%}
