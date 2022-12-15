%%Producing GG Diagram
ggInput=[0,ax_zero,ay_zero];

dvel=5;%dummy velocity
ax_d=0;
ay_d=0;%dummies
while(dvel<v_max)
    
   ax_d=ax_zero-0.5*rho*Cd*dvel*dvel/m;
   ay_d=ay_zero-0.5*rho*Cl*dvel*dvel/m;
   
   ggInput=[ggInput;dvel,ax_d,ay_d];
   dvel=dvel+5;
end