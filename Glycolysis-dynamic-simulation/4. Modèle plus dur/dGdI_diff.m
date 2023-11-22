function dX = dGdI_diff(t,X,params_GLU)
G_intestin=X(1);
G_sang=X(2);
Insul=X(3);
U=X(4);

a = params_GLU(1);                %Constante de dégradation du glucose
k = params_GLU(2);                %Constante associée à la décroissance expo
Gb= params_GLU(3);                %Glucose basal
kprodI= params_GLU(4);             %Constante de production de l'insuline
kdegI= params_GLU(5);             %Constante de dégradation de l'insuline

dU = -k * U;
dG_intestin = -U * G_intestin ;
dG_sang = max(0, Gb-G_sang)  - a * G_sang * Insul  + U * G_intestin ;
dInsul =  kprodI * G_sang - kdegI * Insul  ;

dX = [dG_intestin ; dG_sang ; dInsul ; dU];

end 