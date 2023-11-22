function dX = dGdI_3(t,X,params)
G_intestin=X(1);
G_sang=X(2);
Insul=X(3);


kdegG=params(1);    %Constante degradation glucose                
kabsG=params(2);    %Constante d'absorption glucose
Gb = params(3);     %Glucose basal


dG_intestin = -kabsG * G_intestin ;
dG_sang = max(0, Gb-G_sang)  - kdegG * G_sang * Insul  + kabsG * G_intestin ;
dInsul =  G_sang - (1/30) * Insul  ;

dX = [dG_intestin ; dG_sang ; dInsul];

end 