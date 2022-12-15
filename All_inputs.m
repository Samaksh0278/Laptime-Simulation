
load('ReqVar.mat')

%Taking req inputs
Coefficient_Of_Lift = ReqVar.Coefficient_Of_Lift;
Frontal_Area = ReqVar.Frontal_Area;
Density = ReqVar.Density;
Max_Acceleration = ReqVar.Max_Acceleration;

Maximum_Velocity = ReqVar.Maximum_Velocity;

Cd=ReqVar.Coefficient_Of_Drag;
Cl = Coefficient_Of_Lift(1);
rho = Density(1);


ay_zero = ReqVar.Lateral_Acceleration_at_zero_velocity;
v_max = Maximum_Velocity;
m=ReqVar.Mass;
ax_zero = ReqVar.Max_Acceleration;%long_acc
W=m;%(some crap with weight and mass)
T0=ReqVar.T0;
Gear_Ratio=ReqVar.Gear_Ratio;
Tire_Radius=ReqVar.Tire_radius;
Roll_Res=ReqVar.Roll_Res;

%inputs are the first elements of the arrays 




v_max = v_max/3.6;%convert to m/s