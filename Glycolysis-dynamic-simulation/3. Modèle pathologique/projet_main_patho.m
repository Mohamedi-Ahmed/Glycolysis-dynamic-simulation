%%      Extraction des données et optimisation initiale
load("control.mat");
load("ko.mat");

temps_CTRL=data_control(2:end,1);
souris_CTRL=data_control(2:end,2:end);
moy_CTRL=mean(souris_CTRL,2);

temps_KO=data_ko(2:end,1);
souris_KO=data_ko(2:end,2:end);
moy_KO=mean(souris_KO,2);

GB_CTRL= mean(data_control(2,2:end));
GB_KO= mean(data_ko(2,2:end));

options = optimset('MaxFunEvals',1500);

% subplot(221)
% plot(temps_CTRL,souris_CTRL)
% title("Glycémie des souris controle")
% 
% subplot(222)
% plot(temps_KO,souris_KO)
% title("Glycémie des souris KO")
% 
% subplot(223)
% plot(temps_CTRL,moy_CTRL)
% title("Glycémie moyenne des souris controle")
% 
% subplot(224)
% plot(temps_KO,moy_KO)
% title("Glycémie moyenne des souris KO")

params0_CTRL = [exp(-8)*0.0285 ; 0.00171 ; GB_CTRL ; 0.00731];
Cond_Initiale_CTRL=[2500 ; 150 ; 10 ; 0.00731];

my_ode=@(Ici,Here) Patho_dGdI_3_exp(Ici,Here,params0_CTRL);
[t,y]=ode45(my_ode,temps_CTRL,Cond_Initiale_CTRL);
plot(t,y(:,2),t,moy_CTRL,"-ro")  %plot seulement le glucose sanguin
title("Glycémie moyenne et approximation des paramètres optimaux")
legend("Glucose théorique", "Glucose expérimental")

%%      SOURIS CONTROL
%{
my_khi2 = @(params)Patho_xhi2_3_exp(temps_CTRL,moy_CTRL,params, Cond_Initiale_CTRL);
params_opt_CTRL = fminsearch(my_khi2,params0_CTRL);

my_fit = @(Ici,Here) Patho_dGdI_3_exp (Ici,Here,params_opt_CTRL);
[t,y_opt] = ode45 (my_fit, temps_CTRL, Cond_Initiale_CTRL);
plot(t,y_opt(:,2),'r', temps_CTRL, moy_CTRL, "b+")
legend("Glucose expérimental", "Glucose théorique")
Tab_p_opt_CTRL = [];
Tab_xhi2_CTRL =[];

for i = 2:length(data_control)
    figure
    G_souris = data_control(2:end,i);
    my_souris = @(para)Patho_xhi2_3_exp(temps_CTRL,G_souris, para, Cond_Initiale_CTRL);
    [p_opt,xhi2]=fminsearch(my_souris,params_opt_CTRL,options);
    Tab_xhi2_CTRL= cat(2,Tab_xhi2_CTRL,xhi2);
    Tab_p_opt_CTRL=cat(2,Tab_p_opt_CTRL,p_opt);
end

disp(Tab_xhi2_CTRL)
disp(Tab_p_opt_CTRL)

Tab_Etendu_CTRL=[];
for i = 1:3
    etendu=max(Tab_p_opt_CTRL(i,:))-min(Tab_p_opt_CTRL(i,:));
    Tab_Etendu_CTRL=cat(1,Tab_Etendu_CTRL,etendu);
end

disp(Tab_Etendu_CTRL)
%}
%%      SOURIS KO 
%{

params0_KO = [exp(-8.1)*0.0135 ; 0.0025 ; GB_KO ; 0.00221];
Cond_Initiale_KO=[2500 ; 150 ; 10 ; 0.00221];


my_ode=@(Ici,Here) Patho_dGdI_3_exp(Ici,Here,params0_KO);
[t,y]=ode45(my_ode,temps_CTRL,Cond_Initiale_KO);
plot(t,y(:,2),t,moy_KO,"-ro")  %plot seulement le glucose sanguin

legend("Glucose théorique", "Glucose expérimental")

my_khi2 = @(params)Patho_xhi2_3_exp(temps_KO,moy_KO,params, Cond_Initiale_KO);
params_opt_KO = fminsearch(my_khi2,params0_KO);

my_fit = @(Ici,Here) Patho_dGdI_3_exp (Ici,Here,params_opt_KO);
[t,y_opt] = ode45 (my_fit, temps_KO, Cond_Initiale_KO);
plot(t,y_opt(:,2),'r', temps_KO, moy_KO, "b+")
legend("Glucose expérimental", "Glucose théorique")
Tab_p_opt_KO = [];
Tab_xhi2_KO =[];



for i = 2:length(data_ko)
    options = optimset('MaxFunEvals',1500,"MaxIter",500);%,'Display','off');
    figure
    G_souris = data_control(2:end,i);
    my_souris = @(para)Patho_xhi2_3_exp(temps_KO,G_souris, para, Cond_Initiale_KO);
    [p_opt,xhi2]=fminsearch(my_souris,params0_KO,options);
    
    Tab_xhi2_KO= [Tab_xhi2_KO;xhi2];%cat(2,Tab_xhi2,xhi2);
    Tab_p_opt_KO=cat(2,Tab_p_opt_KO,p_opt);
    
end

display(Tab_xhi2_KO)
display(Tab_p_opt_KO)

Tab_Etendu_KO=[];
for i = 1:3
    etendu=max(Tab_p_opt_KO(i,:))-min(Tab_p_opt_KO(i,:));
    Tab_Etendu_KO=cat(1,Tab_Etendu_KO,etendu);
end

display(Tab_Etendu_KO)
%}
%%      TEST U DE MANN WHITNEY
%{
[p1,h1] = ranksum(Tab_p_opt_CTRL(:,1),Tab_p_opt_KO(:,1))      % Pour kdegG
[p2,h2] = ranksum(Tab_p_opt_CTRL(:,2),Tab_p_opt_KO(:,2))      % Pour k
[p3,h3] = ranksum(Tab_p_opt_CTRL(:,3),Tab_p_opt_KO(:,3))      % Pour Gb
[p4,h4] = ranksum(Tab_p_opt_CTRL(:,4),Tab_p_opt_KO(:,4))      % Pour U0
%}