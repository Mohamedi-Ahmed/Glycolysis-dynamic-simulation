%%      EXTRACTION DES DONNEES ET OPTIMISATION INITIALE
load ("calibration.mat");

temps=calibration(:,1);
moyenne=calibration(:,end);
plot(temps,moyenne,"r+")

k= 0.01;
params0 = [0.0021*exp(-6.3) ; k ; 150 ; 0.0031];
Cond_Initiale=[4500 ; 119 ; 10 ; 0.0031];
options = optimset('MaxFunEvals',1500);

my_ode=@(Ici,Here) dGdI_3_exp(Ici,Here,params0);
[t,y]=ode45(my_ode,temps,Cond_Initiale);
plot(t,y(:,2),temps,y(:,3),"gx",temps,moyenne,"r+")  

legend("Glucose théorique","Insuline", "Glucose expérimental")
%%          RECHERCHE DE PARAMETRES PLUS OPTIMAUX AVEC XHI2
%{
my_khi2 = @(params)xhi2_3_exp(temps,moyenne,params, Cond_Initiale);
params_opt = fminsearch(my_khi2,params0);

my_fit = @(Ici,Here) dGdI_3_exp (Ici,Here,params_opt);
[t,y_opt] = ode45 (my_fit, temps, Cond_Initiale);
plot(t,y_opt(:,2), temps, moyenne, "r+")
legend("Glucose expérimental", "Glucose théorique")

Tab_p_opt = [];
Tab_xhi2 =[];

for i = 2:11
    figure
    G_souris = calibration(:,i);
    my_souris = @(para)xhi2_3_exp(temps,G_souris,para, Cond_Initiale);
    p_opt=fminsearch(my_souris,params0);
    Tab_xhi2= cat(2,Tab_xhi2,my_souris(p_opt));
    Tab_p_opt=cat(2,Tab_p_opt,p_opt); 
end

display(Tab_xhi2)
display(Tab_p_opt)
%}
%%      CALCUL DES ETENDUES (Ecart type)
%{
Tab_Etendu=[];
for i = 1:3
    etendu=max(Tab_p_opt(i,:))-min(Tab_p_opt(i,:));
    Tab_Etendu=cat(1,Tab_Etendu,etendu);
end

display(Tab_Etendu)
%}