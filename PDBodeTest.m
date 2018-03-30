
nbar = 10;
Tsbar = 0.05;
[velGains,attGains,mass,gravity,PDGains,flockGains] = setParams(nbar,Tsbar);

TitleStr = ['kp = ', num2str(PDGains(1)), ' & ' , 'kd = ', num2str(PDGains(2))];

s = tf('s');

G = (PDGains(2)*s + PDGains(1))/(s^2+PDGains(2)*s + PDGains(1));

figure()
bode(G)
title(TitleStr,'Fontsize',12)
grid('on')
