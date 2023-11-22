function dX = dGdI_4(t,X,params)
G_intestin=X(1);
G_sang=X(2);
Insul=X(3);

kdegG=params(1);    %Constante degradation glucose 
kdegI=params(2);    %Constante de dégradation de l'insu               
kabsG=params(3);    %Constante d'absorption du glucose
Gb = params(4);     % Glucose basal

dG_intestin = -kabsG * G_intestin ;
dG_sang = max(0, Gb-G_sang)  - kdegG * G_sang * Insul  + kabsG * G_intestin ;
dInsul =  G_sang - kdegI * Insul  ;

dX = [dG_intestin ; dG_sang ; dInsul];      

end 