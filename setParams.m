function [velGain,attGain,mass,gravity,PDGains,flockGains] = setParams(nbar,Tsbar)
%% Set the physical parameters
mass = 2.25; % (kg) mass of the agent
gravity = 9.81; % (m/s^2) acceleration due to gravity


%% Set the velocity controller gains
kuGain = 3.5;
kvGain = 3.5;
kwGain = 2.5;
velGain = [kuGain kvGain kwGain];

%% Set the attitude / thrust low-pass filter time constants
kphiGain = 15;
kthetaGain = 15;
kpsiGain = 15;
kthrustGain = 15;
attGain = [kphiGain kthetaGain kthrustGain kpsiGain];

%% Set the PD Gains
kpGain = 3;
kdGain = 1;
PDGains = [kpGain kdGain];

%% Set the flocking controller gains
alpha1 = 0.01;%0.001;% % For more repulsion/attraction --> make this value smaller
alpha2 = 0.3;%0.03; % % Increases magntiude of Phi function in computeControl when this value increases
beta = 0.8;%0.04;% %2/(nbar*Tsbar)*(1-0.05); %typically operates better when close to upper bound
gamma1 = 0.8; %0.1;% %guidance "frequecy term", basically extends or contracts the radius of the circle when following a circular leader
gamma2 = 0.8;%0.07;% % Guidance "damping term"
gamma3q = 0.83; %0.16;%% Altitude position leader gain
gamma4p = 0.9;%0.09;% % Altiude velocity leader gain
flockGains = [alpha1,alpha2,beta,gamma1,gamma2,gamma3q,gamma4p];

% gainLimits(alpha1,alpha2,beta,gamma1,gamma2,Tsbar,nbar)
% A1LL = 0;
% A1UL = inf;
% A2LL = 0;
% A2UL = 4*(alpha1+1)/(nbar*Tsbar^2);
% BLL =  alpha2*Tsbar/(2*(alpha1+1));
% BUL =  2/(nbar*Tsbar);
% G1LL = 0;
% G1UL = 2/Tsbar^2;
% G2LL = Tsbar*gamma1/2;
% G2UL = 1/Tsbar;
% disp(['Alpha 1: ' num2str(alpha1)])
% disp(['Alpha 1 Limits: ' '[' num2str(A1LL,1) ',' num2str(A1UL,1) ']'])                       
% disp(['Alpha 2: ' num2str(alpha2)])
% disp(['Alpha 2 Limits: ' '[' num2str(A2LL,1) ',' num2str(A2UL,1) ']'])                       
% disp(['Beta: ' num2str(beta)])
% disp(['Beta Limits: ' '[' num2str(BLL,1) ',' num2str(BUL,1) ']'])
% disp(['Gamma 1: ' num2str(gamma1)])
% disp(['Gamma 1 Limits: ' '[' num2str(G1LL,1) ',' num2str(G1UL,1) ']'])
% disp(['Gamma 2: ' num2str(gamma2)])
% disp(['Gamma 2 Limits: ' '[' num2str(G2LL,1) ',' num2str(G2UL,1) ']'])

end

