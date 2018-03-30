function [t,x,desVel,desAcc,sentCommand] = inputCTDynamics(position,velocity,attitude,thrust,input,velPrev,accPrev,conTime,ku,kv,kw,Tsbar)

global thrustDesired thetaDesired phiDesired psiDesired
% Define the real world properties 
mass = 2.25; % (kg) mass of the quad-rotor UAS
gravity = 9.81; % (m/s^2) accelertaion due to gravity

u1 = input(1);
u2 = input(2);
u3 = input(3);

% Velocity Estimates
% uapprox = input(1)*Tsbar + velPrev(1);
% vapprox = input(2)*Tsbar + velPrev(2);
% wapprox = input(3)*Tsbar + velPrev(3);
uapprox = 0.5*input(1)*Tsbar + velPrev(1) + 0.5*Tsbar*accPrev(1);
vapprox = 0.5*input(2)*Tsbar + velPrev(2) + 0.5*Tsbar*accPrev(2);
wapprox = 0.5*input(3)*Tsbar + velPrev(3) + 0.5*Tsbar*accPrev(3);

thrustDesired = (mass*(gravity - u3 + kw*(velocity(3) - wapprox)))/(cos(attitude(1))*cos(attitude(2)));
thetaDesired = atan(((u1-ku*(velocity(1) - uapprox))*cos(attitude(3)) + (u2-kv*(velocity(2) - vapprox))*sin(attitude(3)))/(-gravity + u3 - kw*(velocity(3) - wapprox)));
phiDesired = atan(((u1-ku*(velocity(1) - uapprox))*cos(thetaDesired)*sin(attitude(3)) - (u2-kv*(velocity(2) - vapprox))*cos(thetaDesired)*cos(attitude(3)))/(-gravity + u3 - kw*(velocity(3) - wapprox)));
psiDesired = 0;

xo = [position(1) position(2) position(3) velocity(1) velocity(2) velocity(3) attitude(1) attitude(2) attitude(3) thrust];

[t,x] = ode45(@systemCTModel,conTime,xo);

desAcc = [u1,u2,u3]';
desVel = [uapprox, vapprox,wapprox]';
sentCommand = [phiDesired, thetaDesired, thrustDesired, psiDesired];
clear u1 u2 u3 uapprox vapprox wapprox phiDesired thetaDesired thrustDesired psiDesired


end

