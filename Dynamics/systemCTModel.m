function [xdot] = systemCTModel(t,x)

global kphi ktheta kpsi kthrust thrustDesired thetaDesired phiDesired psiDesired

xdot = zeros(10,1);
% Define the real world properties 
mass = 2.25; % (kg) mass of the quad-rotor UAS
gravity = 9.81; % (m/s^2) accelertaion due to gravity

% Agent CT Position
xdot(1) = x(4);
xdot(2) = x(5);
xdot(3) = x(6);

% Agent CT Velocity
xdot(4) = -(x(10)/mass)*(cos(x(7))*sin(x(8))*cos(x(9)) + sin(x(7))*sin(x(9)));
xdot(5) = -(x(10)/mass)*(cos(x(7))*sin(x(8))*sin(x(9)) - sin(x(7))*cos(x(9)));
xdot(6) = gravity - (x(10)/mass)*cos(x(7))*cos(x(8));


% Agent CT Attitude (note this only applies such that the attitude is
% already stabalized by the quad's flight controller).
xdot(7) = kphi*(phiDesired-x(7));
xdot(8) = ktheta*(thetaDesired-x(8));
xdot(9) = kpsi*(psiDesired-x(9));
% 
% This is the Thrust state
xdot(10) = kthrust*(thrustDesired-x(10));


end

