%% DT Quad-Rotor UAS control - Main
% Zachary Lippay
%
clear
clc
close all
%
global kphi ktheta kpsi kthrust

disp('Discrete Time Quad-Rotor UAS Control Simulation')
Tsbar = 0.05;
nbar = 3;
d = 0.5;
[velGains,attGains,mass,gravity,PDGains,flockGains] = setParams(nbar,Tsbar);
kphi = attGains(1);
ktheta = attGains(2);
kpsi = attGains(3);
kthrust = attGains(4);

% Some other stuff needed for some things
 
%% Define the simulation time parameters
% DT Parameters
Ts = Tsbar; % (s) DT timestep 0.05 = 20Hz
STOPTIME = 50; % (s) Total simulation time
TIME = [0:Ts:STOPTIME]'; % Total DT time vector

%CT parameters
Tscon = 0.001;
conTimei = [0:Tscon:Ts]';

%% Define the leader trajectory
leaderamp = 1;
qdesired =   leaderamp.*[-1+0.*TIME 5+0.*TIME 3+0.*TIME]; % leaderamp.*[-1.*TIME 5.*TIME 3.*TIME]; %leaderamp.*[sin(TIME) cos(TIME) -0.5/10.*TIME]; %
pdesired =  leaderamp.*[0.*TIME 0.*TIME 0.*TIME]; % leaderamp.*[-1+0.*TIME 5+0.*TIME 3+0.*TIME]; %leaderamp.*[cos(TIME) -sin(TIME) -0.5/10-0.*tan(TIME)]; %
% qdesired = leaderamp.*[rand(size(TIME)) 0.*TIME 0.*TIME];
% pdesired = leaderamp.*[0.*TIME 0.*TIME 0.*TIME];
qg = qdesired;
pg = pdesired;

%% Define initial conditions
% Define the agent initial conditions. Note that this section should be in
%                          meters. The OptiTrak Arena  provides a
%                          resolution of 0.001 but this will change due to
%                          encoding / decoding issues.
qi = [1.000 3.000 0.000; ...
    1.000 -3.000 0.000; ...
   -2.500 2.000 0.000]; ...
%     2.500 2.000 0.000; ...
%     -2.500 -2.000 0.000; ...
%     2.500 -2.000 0.000; ...
%     3.500 2.000 0.000; ...
%     -1.500 -0.000 0.000; ...
%     -0.500 -1.000 0.000]; ...
%     0.500 -1.000 0.000];

% Define the number of agents n in the simulation
if numel(qi) > 6
    n = length(qi); % Total number of agents
elseif numel(qi) > 3
    n = 2;
else
    n = 1;
end
pi = zeros(n,3);
attitudei = zeros(n,3);
thrusti = (0.45*(mass*gravity)).*ones(n,1);
velPrevi = pi;
accPrevi = pi;

 %% Sort each agent neighbor set
[qj,pj] = neighborSet(qi,pi,n);
Ni = n-1; % Number of relative agents in the communication radius (e.g. Neighbor set of the ith agent)

%% Allocate vector space
qk = zeros(n,3,length(conTimei),STOPTIME/Ts);
pk = zeros(n,3,length(conTimei),STOPTIME/Ts);
attitudek = zeros(n,3,length(conTimei),STOPTIME/Ts);
thrustk = zeros(n,1,length(conTimei),STOPTIME/Ts);
velPrevk = zeros(n,3,STOPTIME/Ts);



%% Simulate DT control input with CT dynamics
disp('Initiate Simulation')


for i = 1:length(TIME)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%  PD Controller %%%%%%%%%%%%%%
%     uk(:,:,i) = computePDControl(qi,pi,qg(i,:),pg(i,:),PDGains(1),PDGains(2));
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%% Flocking Controller %%%%%%%%%
    [relPos,relVel,qNorm,relPosLead,relVelLead] = agentRelative(qi,pi,qj,pj,qg(i,:),pg(i,:),n,Ts,Ni);
    uk(:,:,i) = computeFlockingControl(relPos,relVel,qNorm,relPosLead,relVelLead,flockGains,Ni,n,d);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    for j = 1:n
        [t,x,desVel,desAcc,sentCommand] = inputCTDynamics_DI(qi(j,:),pi(j,:),attitudei(j,:),thrusti(j,:),uk(j,:,i),velPrevi(j,:),accPrevi(j,:),conTimei,velGains(1),velGains(2),velGains(3),Ts);
%         [t,x,desVel,desAcc,sentCommand] = inputCTDynamics(qi(j,:),pi(j,:),attitudei(j,:),thrusti(j,:),uk(j,:,i),velPrevi(j,:),accPrevi(j,:),conTimei,velGains(1),velGains(2),velGains(3),Ts);
        qk(j,1,:,i) = x(:,1);
        qk(j,2,:,i) = x(:,2);
        qk(j,3,:,i) = x(:,3);
        pk(j,1,:,i) = x(:,4);
        pk(j,2,:,i) = x(:,5);
        pk(j,3,:,i) = x(:,6);
        attitudek(j,1,:,i) = x(:,7);
        attitudek(j,2,:,i) = x(:,8);
        attitudek(j,3,:,i) = x(:,9);
        thrustk(j,1,:,i) = x(:,10);
        desVelk(j,:,i) = desVel;
        desAcck(j,:,i) = desAcc;
        sentCommandk(j,:,i) = sentCommand;
    end
    conTimek(:,i) = conTimei(:,1); 
    clear qi pi qj pj attitudei thrusti conTimei velPrevi accPrevi
    conTimei = t + (Ts).*ones(length(t),1);
    qi = qk(:,:,end,i);
    pi = pk(:,:,end,i);
    attitudei(:,:) = attitudek(:,:,end,i);
    thrusti(:,:) = thrustk(:,:,end,i);
    velPrevi(:,:) = desVelk(:,:,i);
    accPrevi(:,:) = desAcck(:,:,i);
    [qj,pj] = neighborSet(qi,pi,n);
end

%% Plotting Sequence
disp('Initiate Plotting Sequence')
[q1,q2,q3,q4] = size(qk);
% disp('Plotting Velocities'), plotVelocity(pk,desVelk,desAcck,pg,q3,q4,Tscon,TIME);
% disp('Plotting Positions'), plotPosition(qk,qg,q3,q4,Tscon,TIME);
% disp('Plotting Attitude and Thrust'), plotCommand(attitudek,thrustk,sentCommandk,q3,q4,Tscon);
disp('Plot Average Distance'), plotDistance(qk,qg,q3,q4,Ni,d,Tscon,n)
disp('Plot Flock'), plotFlock(qk,qg,q3,q4,Tscon,TIME)


disp('End Main')











