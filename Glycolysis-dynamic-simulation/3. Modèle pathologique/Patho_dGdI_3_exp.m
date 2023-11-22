function dX = Patho_dGdI_3_exp(t,X,params)
G_intestin=X(1);
G_sang=X(2);
Insul=X(3);
U=X(4);

kdegG = params(1);    %Constante degradation glucose                
k = params(2);        %Constante associé à la décroissance exponentielle
Gb = params(3);       %Glucose basal  

dU = -k * U;
dG_intestin = -U * G_intestin ;
dG_sang = max(0, Gb-G_sang)  - kdegG * G_sang * Insul  + U * G_intestin ;
dInsul =  G_sang - (1/30) * Insul  ;

dX = [dG_intestin ; dG_sang ; dInsul ; dU];

end 