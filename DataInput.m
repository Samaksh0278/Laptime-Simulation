
    load FILE.mat
    %% 
    % * AMBTMP: Ambient Temperature
    AMBTMP = FILE(:,20);
    %% 
    % * ET: Elapsed Time [s]
    ET = FILE(:,1); 
    %% 
    % * FX: Traction Force [N]
    FX = FILE(:,9);
    %% 
    % * FY: Lateral Force [N]
    FY = FILE(:,10);
    %% 
    % * FZ: Vertical Force [N]
    FZ = FILE(:,11);
   % FZ = FZ*-1;%
    %% 
    % * IA: Inclination Angle [deg]
    IA = FILE(:,5);
    %% 
    % * MX: Overturning Moment [Nm]
    MX = FILE(:,12);
    %% 
    % * MZ: Aligning Moment [Nm]
    MZ = FILE(:,13);
    %% 
    % * N: Wheel rotational speed [rpm]
    N = FILE(:,3);
    %% 
    % * NFX: Normal Force in X [normalized against vectorial load]
    NFX = FILE(:,14); 
    %% 
    % * NFY: Normal Force in Y  [normalized against vectorial load]
    NFY = FILE(:,15);
    %% 
    % * P: Pressure [kPa]
    P = FILE(:,8);
    %% 
    % * RE: Effective Radius [cm]
    RE = FILE(:,7); 
    %% 
    % * RL: Loaded Radius [cm]
    RL = FILE(:,6);
   % RL = RL*.01;%
    %% 
    % * RST: Road Surface Temperature [°C]
    RST = FILE(:,16);
    %% 
    % * SA: Slip Angle [deg]
    SA = FILE(:,4);
    %% 
    % * SR: Slip Ratio [none]
    SR = FILE(:,21);
    %% 
    % * TSTC: Tire Surface Temperature Center [°C]
    TSTC = FILE(:,18);
    %% 
    % * TSTI: Tire Surface Temperature Inner [°C]
    TSTI = FILE(:,17);
    %% 
    % * TSTO: Tire Surface Temperature Outer [°C]
    TSTO = FILE(:,19);
    %% 
    % * V: Road Velocity [m/s]
    V = FILE(:,2);
   % V = V * 3.6;%

for(i=1:length(F    Z))
    FZ(i,1)=-FZ(i,1)
end