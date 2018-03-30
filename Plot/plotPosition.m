function plotPosition(qk,qg,q3,q4,Tscon,TIME)

[qk11,qk12,qk13,plotTime] = analyzeVelPos(qk,q3,q4,Tscon);


xx= 0;
for i = 1:(q4-1)
    for j = 1:(q3-1)
        xx = xx+1;
        qk11x(xx) = qk11(i,j);
        qk12x(xx) = qk12(i,j);
        qk13x(xx) = qk13(i,j);
        qg1(xx) = qg(i,1);
        qg2(xx) = qg(i,2);
        qg3(xx) = qg(i,3);
        time(xx) = plotTime(i,j);
    end
end

errorx = qg1 - qk11x;
errory = qg2 - qk12x;
errorz = qg3 - qk13x;

% Define certain plotting stuff
fsize = 12; %font size
ins = 'interpreter';
la = 'latex';
% xMargin = 1;                                            %Width margin is defined.
% yMargin = 1;                                            %Height margin is defined.
% xSize = 6;%3.0;                                            %Width of figure is defined.
% ySize = 5;%2.5;                                           %Height of figure is defined.


figure()
plot(time,qk11x,'b -','linewidth',1.5)
hold on
plot(TIME,qg(:,1),'k --','linewidth',1.5)
hold off
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('X Position (m)',ins,la,'Fontsize',fsize)
Lx = legend('x','xg');
set(Lx,ins,la,'Location','NorthEast','FontSize',fsize);
grid('on')
% set(gcf,'Units','inches','PaperUnits','inches'...
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
% saveas(figure(8),['AgentThrust' '.pdf']);
% print -depsc AgentThrust_SV

figure()
plot(time,qk12x,'b -','linewidth',1.5)
hold on
plot(TIME,qg(:,2),'k --','linewidth',1.5)
hold off
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('Y Position (m)',ins,la,'Fontsize',fsize)
Lx = legend('y','yg');
set(Lx,ins,la,'Location','NorthEast','FontSize',fsize);
grid('on')
% set(gcf,'Units','inches','PaperUnits','inches'...
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
% saveas(figure(8),['AgentThrust' '.pdf']);
% print -depsc AgentThrust_SV

figure()
plot(time,qk13x,'b -','linewidth',1.5)
hold on
plot(TIME,qg(:,3),'k --','linewidth',1.5)
hold off
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('Z Position (m)',ins,la,'Fontsize',fsize)
Lx = legend('z','zg');
set(Lx,ins,la,'Location','NorthEast','FontSize',fsize);
grid('on')
% set(gcf,'Units','inches','PaperUnits','inches'...
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
% saveas(figure(8),['AgentThrust' '.pdf']);
% print -depsc AgentThrust_SV

figure()
plot(time,errorx,'b -',time,errory,'r -.',time,errorz,'k -','linewidth',1.5)
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('Position Error (m)',ins,la,'Fontsize',fsize)
Lz = legend('ex','ey','ez');
set(Lz,ins,la,'Location','NorthEast','FontSize',fsize);
grid('on')
% set(gcf,'Units','inches','PaperUnits','inches'...
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
% saveas(figure(8),['AgentThrust' '.pdf']);
% print -depsc AgentThrust_SV


end

