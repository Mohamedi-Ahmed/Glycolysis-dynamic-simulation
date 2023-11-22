%%      EXTRACTION DONNEES ET GRAPHES ASSOCIES
load("oggt_baria_pre.mat");
load("oggt_baria_post.mat");
% 31 car avant c'est le seuil de niveau basal, et qu'on s'interesse au
% glucose apres prise orale (donc à 31min)

%231 car après ce temps, on voit un pic aberrant, donc on n'utilise pas les
%données apres 231 min.
temps_pre=ogtt_pre(31:231,1);
temps_after=ogtt_after(31:231,1);

Insul_pre=ogtt_pre(31:231,2);        %pmol/L
Gluc_pre=ogtt_pre(31:231,3);         %mmol/L

Insul_after=ogtt_after(31:231,2);    %pmol/L
Gluc_after=ogtt_after(31:231,3);     %mmol/L

% subplot(211)
% plot(temps_pre,Insul_pre,"r",temps_pre,Gluc_pre,"b")
% legend("Insuline","Glucose")
% title("Taux d'insuline et de glucose AVANT opération")
% 
% subplot(212)
% plot(temps_after,Insul_after,"r",temps_after,Gluc_after,"b")
% legend("Insuline","Glucose")
% title("Taux d'insuline et de glucose APRES opération")

%%  Calcul de la concentration en glucose 
%{
On suppose que le poids d'un homme moyen est de 75kg.
75g glu /kg homme * 1 / 80 mL/kg  = 0.9375 g/mL = 93750 mg/dL
%{
On doit ensuite calculer la concentration en mmol.L-1 afin de pouvoir
donner la concentration initiale. 
La masse molaire du glucose (C6H12O6 = 6*12 + 12*1 + 6*16 = 180 g/mol)
0.9375 g/mL = 937.5g/L
937.5 / 180 = 5.21 mol/L de glucose 
%}
%}
%%      
GB_PRE=ogtt_pre(2,3);
InsulB_PRE=ogtt_pre(2,2);
U0= 0.0000197;
params0_pre = [0.0000024 ; 0.01136 ; GB_PRE ; 2.848; 0.0211; U0];
CI_Pre=[93750 ; GB_PRE ; InsulB_PRE  ; U0];

my_glu=@(Ici,Here) dGdI_diff(Ici,Here,params0_pre);
[t,y]=ode45(my_glu,temps_pre,CI_Pre);

subplot (211)
plot(t,y(:,2),"m",t,Gluc_pre,"r+")
legend("Glucose théorique","Glucose Expérimental")
subplot(212)
plot(t,y(:,3),"g",t,Insul_pre,"b+")
legend("Insuline théorique","Insuline Expérimental")