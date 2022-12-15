
% DATA ARRAYS INTIALIZATION --------------------------------------------
% ===========================
N=length(rho_v_filter1); % N ... declaration of array length (depends on track length)
v_base_ay=zeros(1, N); % v_base_ay ... basic velocity profile (only ay)
v_new=zeros(1, N); % v_new ... final velocity profile (ay & ax)
ay_n=zeros(1, N); % ay_n ... data array for lateral acc. while braking
ay_p=zeros(1, N); % ay_p ... data array for lateral acc. while accelerating
ax_neg=zeros(1, N); % ax_neg ... data array for neg. acc.
ax_pos=zeros(1, N); % ax_pos ... data array for pos. acc.
ay_aero_actual=zeros(1, N);
v_basic_ay=zeros(1, N);
% DATA INPUTS ----------------------------------------------------------
% =============

ggTable=ggInput;
v_aero = (ggTable(:,1))/3.6; % velocity array
ax_aero = ggTable(:,2); % ax_acc fce(v)
ay_aero = ggTable(:,3); % ay_acc fce(v)
ay_basic = min(ggTable(1,3)); % ay_acc intial
ay_max = ggTable(6,3);


% CALCULATION MODEL ----------------------------------------------------
% ===================
% Step no.1 - Calculation of basic speed profile according ay=v^2/R
% -----------------------------------------------------------------
%
%
% ---- Step 1.1: v_base = sqrt(ay*R) ... for ay = konst.
%
for i=1:1:N
v_basic_ay(i)=min(v_max, sqrt((ay_basic)/abs(rho_v_filter1(i))));
end
% ---- Step 1.2: correction of v_base profile for ay = fce(v)
%
for i=1:1:N
 ay_aero_actual(i)=interp1(v_aero, ay_aero, v_basic_ay(i),'spline'); % interpolation of gg data
 v_base_ay(i)=min(v_max, sqrt(ay_aero_actual(i)/abs(rho_v_filter1(i))));
end
v_baseay(1)=0;
% Step no.2 - Calculation of braking maneuvers ... backwards loop (N->1)
% --------------------------------------------------------------------
%
%
v_actual1=v_base_ay; % definition of extra speed array for this step
for i=N:-1:2
 ay_n(i-1)=min(ay_max, v_actual1(i)^2*abs(rho_v_filter1(i-1)));
 % real lateral acc. for v_base_ay
 ay_aero_actual=interp1(v_aero, ay_aero, v_actual1(i));
 % max. laterall acc for v_actual
 ax_aero_actual=interp1(v_aero, ax_aero, v_actual1(i));
 % max. longitudinal acc for v_actual
 p=ax_aero_actual^2/ay_aero_actual^2;
 % elipse parameter
 ax_neg(i-1)=real(sqrt(p*(ay_aero_actual)^2 - p*(ay_n(i-1))^2));
 % actual ax for braking (elipse)
 v_actual1(i-1)=min(v_base_ay(i), sqrt(v_actual1(i)^2+2*ax_neg(i-1)*(s_v(i)-s_v(i-1))));
 % final speed iteration, backwards loop (N->1)
end

% Step no.3 - Calculation of acceleration maneuvers ... forwards loop (1->N)
% --------------------------------------------------------------------
%
%
v_actual2 = v_base_ay; % definition of extra speed array for this step
for i=1:1:N-1
 ay_p(i+1)=min(ay_max,v_actual2(i)^2*abs(rho_v_filter1(i+1)));
 % real lateral acc. for v_base_ay
 ay_aero_actual=interp1(v_aero, ay_aero, v_actual2(i));
 % max. laterall acc for v_actual
 ax_aero_actual=interp1(v_aero, ax_aero, v_actual2(i));
 % max. longitudinal acc for v_actual
 p=ax_aero_actual^2/ay_aero_actual^2;
 % elipse parameter
 ax_pos(i+1)=real(sqrt(p*(ay_aero_actual)^2 - p*(ay_p(i+1))^2));
 % actual ax for accelerating (elipse)
 v_actual2(i+1)=min(v_base_ay(i), sqrt(v_actual2(i)^2+2*ax_pos(i+1)*(s_v(i+1)-s_v(i))));
 % final speed iteration, forwards loop (1->N)
end
% Step no.4 - Addition of both arrays -> Generate the final speed profile
% --------------------------------------------------------------------
%
%
for i=1:1:N
 v_new(i) = min(real(v_actual1(i)), real(v_actual2(i)));
end
v_new_km = v_new*3.6; % convert to km/h; boundary profile for control input!