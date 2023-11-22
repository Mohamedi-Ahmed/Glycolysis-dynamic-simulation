%%      EXTRACTION DES DONNEES EXPERIMENTALES ET OPTIMISATION INITIALE
load ("calibration.mat");

temps=calibration(:,1);
moyenne=calibration(:,end);
%hold on
for i = 2:11
    plot(temps,calibration(:,i))
end
plot(temps,moyenne,"r+")
title("Représentation de la glycémie des souris en fonction du temps")
xlabel("Temps en s")
ylabel("Glycémie en mg/dL")
 
params0 = [0.024*exp(-6.75); 0.01 ;0.105; 0.00271 ; 150];
Cond_Initiale=[4500;calibration(1,end);10];
options = optimset('MaxFunEvals',1500);

my_ode=@(Ici,Here) dGdI_5(Ici,Here,params0);
[t,y]=ode45(my_ode,temps,Cond_Initiale);
plot(t,y(:,2),temps,moyenne,"r+")  %plot seulement le glucose sanguin
title("Glycémie moyenne des souris en fonction du temps, et approximation des variables")
legend("Glycémie théorique", "Glycémie expérimental")
xlabel("Temps en s")
ylabel("Glycémie en mg/dL")

%%      OPTIMISATION DES PARAMETRES PAS XHI2
%{
my_ode = @(params)xhi2_5(temps,moyenne,params);
params_opt = fminsearch(my_ode,params0,options);

my_fit = @(Ici,Here) dGdI_5 (Ici,Here,params_opt);
[t,y_opt] = ode45 (my_fit, temps, Cond_Initiale);
plot(t,y_opt(:,2), temps,moyenne,"r+")
legend("Glucose théorique", "Glucose expérimental")

Tab_p_opt = [];
Tab_xhi2 =[];
for i = 2:11
    figure
    G_souris = calibration(:,i);
    my_souris = @(para)xhi2_5(temps,G_souris,para);
    p_opt=fminsearch(my_souris,params0,options);
    Tab_xhi2= cat(2,Tab_xhi2,my_souris(p_opt));
    Tab_p_opt=cat(2,Tab_p_opt,p_opt);  
end

disp(Tab_xhi2)
disp(Tab_p_opt)
%}
%%      CALCUL DES ETENDUES POUR CHAQUE PARAMETRES (Ecart-type)
%{
Tab_Etendu=[];
for i = 1:4
    etendu=max(Tab_p_opt(i,:))-min(Tab_p_opt(i,:));
    Tab_Etendu=cat(1,Tab_Etendu,etendu);
end

disp(Tab_Etendu)
%}
