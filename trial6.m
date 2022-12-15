clc
load TrackData.mat
load ReqVar.mat
L = TrackData.Length;
R = TrackData.CornerRadius;
temp =(1:30000);
N = 1;
c = 0;
for j = 1:length(R)
    while L(j)>1
      if(j>1)
              temp(N) = R(j)* (1-c) + R(j-1) * c;
              L(j) = L(j) - 1 + c;
              N = N + 1;
              c = 0;
      end
        
      if(j == 1 )
              temp(N) = R(j);
              L(j) = L(j) -1;
              N = N + 1;
              c = 0;
          end
          
    end
    c  = L(j);
    
end
j = 0;
for j = 1:N
    if(temp(j) ~= 0)
        temp(j) = 1/temp(j);
    end
end
dist = (1:N-1);
rho_v_filter1 = temp(1:N-1);%this graph gives the curvature of 1m segments taking distance 
%weighted averages of the segment when there are several values in the same segment


Cl = ReqVar.Coefficient_Of_Lift;
S = ReqVar.Frontal_Area;
rho = ReqVar.Density;
ay_max = ReqVar.Max_Acceleration;
m = ReqVar.Mass;
lat_acc = ReqVar.Lateral_Acceleration_at_zero_velocity;
max_vel = ReqVar.Maximum_Velocity;
Cd = ReqVar.Coefficient_Of_Drag;
Roll_Res = ReqVar.Roll_Res;
Tire_radius = ReqVar.Tire_radius;
Gear_Ratio = ReqVar.Gear_Ratio;
T0 = ReqVar.T0;



N = length(rho_v_filter1);
g = 9.80665;

ax_actual =(1:N);
ax = (1:N);
ax_n = (1:N);%max lateral acceleration possible
v_new = (1:N);%final velocity based on the cars paramters
ay_actual = (1:N);
vel = (1:N);%max possible velocity without skidding
max_vel = max_vel/3.6;%convert to m/s

%%
%Aero modified Max_velcoity profile for cornering
for i = 1:N
    vel(i) = 2*lat_acc *g *m;
    vel(i) = vel(i)/(2*rho_v_filter1(i)*g*m - Cl*rho*lat_acc*S);
    vel(i) = sqrt(vel(i));
    vel(i) = min(max_vel,vel(i));
    ax(i) = lat_acc + lat_acc*Cl*S*rho*vel(i)*vel(i)*0.5/g;  
end
v_act1 = vel;
%%
%Backward Braking Pass
for i=N:-1:2
 ay_actual(i-1) = min(ay_max, v_act1(i)^2*abs(rho_v_filter1(i-1)));%amount of lateral force required to prevent skidding
 ax_n(i-1) = real(sqrt(min(ay_max,ax(i))^2 - (ay_actual(i-1))^2));%to calculate amount of unused friction which can be put into braking
 v_act1(i-1)=min(vel(i), sqrt(v_act1(i)^2+2*ax_n(i-1)));
 end
v_act2 = vel;
%%
%Forward Acceleration Pass
for i=1:1:N-1
 ay_actual(i+1)=min(ay_max,v_act2(i)^2*abs(rho_v_filter1(i+1)));
 ax_n(i+1)=real(sqrt(min(ay_max,ax(i))^2 - (ay_actual(i+1)^2)));%to calculate amount of unused friction which can be put into accelerating
 v_act2(i+1)=min(vel(i), sqrt(v_act2(i)^2+2*ax_n(i+1)));
end
 %%
 %Calculating Minimum From both
for i=1:1:N
 v_new(i) = min(real(v_act1(i)), real(v_act2(i)));%this makes the car continuosly accelerate and brake to remain within the limits while going at the highest possibe speed
 
end
%plot(dist, v_new , dist , vel)

%% transposes the v(s) to t(s) 
t_s=0;
for i=1:N-1
    a=(v_new(i+1)+v_new(i));
    t_s=[t_s,(t_s(i)+(2/a))];
end
%% This gives v(t) with time steps of 0.1 s 
i=1;
m=1;
v_tnew=zeros(1,1000);
t_s=[t_s,1000];
while(i<1000)
    counter=0;
    v_dummy=0;
    while(t_s(i)<(m*0.1))
        
        v_dummy=v_dummy+v_new(i);
        counter=counter+1;
        i=i+1;
    end
    if counter>0
         v_tnew(m)=(v_dummy/counter);
        
    else
        v_tnew(m)=v_tnew(m-1);
    end
    
    m=m+1;
end
plot(1:N , v_new)
v_tnew(v_tnew==0) = [];
tfinal=t_s(N)+5;
    