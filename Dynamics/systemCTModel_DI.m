function [xdot] = systemCTModel_DI(t,x)

global kphi ktheta kpsi kthrust thrustDesired thetaDesired phiDesired psiDesired u1 u2 u3

xdot = zeros(10,1);
% Define the real world properties 
mass = 2.25; % (kg) mass of the quad-rotor UAS
gravity = 9.81; % (m/s^2) accelertaion due to gravity

% Agent CT Position
xdot(1) = x(4);
xdot(2) = x(5);
xdot(3) = x(6);

% Agent CT Velocity
xdot(4) = u1;
xdot(5) = u2;
xdot(6) = u3;


% Agent CT Attitude (note this only applies such that the attitude is
% already stabalized by the quad's flight controller).
xdot(7) = kphi*(phiDesired-x(7));
xdot(8) = ktheta*(thetaDesired-x(8));
xdot(9) = kpsi*(psiDesired-x(9));
% 
% This is the Thrust state
xdot(10) = kthrust*(thrustDesired-x(10));


end

