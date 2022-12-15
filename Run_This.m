%%One executable code to rule them all.Load TrackData into TrackData.mat
%%and vehicle data into ReqVar.mat
Comp_Input;
All_inputs;
gginput1;
base_velocity_profile;
%t_s=transpose1(v_new);
%v_t=transpose2(v_new,t_s);
%tfinal=t_s(N)+5;
tfinal = 100;
v_t=(1:(tfinal*10+1));
v_tnew=[0:0.1:tfinal;v_t];
v_tnew=transpose(v_tnew);
g = 9.80665;