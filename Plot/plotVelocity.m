function plotVelocity(pk,desVelk,desAcck,pg,q3,q4,Tscon,TIME)

[pk11,pk12,pk13,plotTime] = analyzeVelPos(pk,q3,q4,Tscon);
[uk11,uk12,uk13,~] = analyzeControl(desVelk,q3,q4,Tscon);
[uuk11,uuk12,uuk13,~] = analyzeControl(desAcck,q3,q4,Tscon);



xx= 0;
for i = 1:(q4-1)
    for j = 1:(q3-1)
        xx = xx+1;
        pk11x(xx) = pk11(i,j);
        pk12x(xx) = pk12(i,j);
        pk13x(xx) = pk13(i,j);
        time(xx) = plotTime(i,j);
        
        uk11x(xx) = uk11(i,j);
        uk12x(xx) = uk12(i,j);
        uk13x(xx) = uk13(i,j);
        
        uuk11x(xx) = uuk11(i,j);
        uuk12x(xx) = uuk12(i,j);
        uuk13x(xx) = uuk13(i,j);
    end
end

errorx = uk11x - pk11x;
errory = uk12x - pk12x;
errorz = uk13x - pk13x;


% Define certain plotting stuff
fsize = 12; %font size
ins = 'interpreter';
la = 'latex';
% xMargin = 1;                                            %Width margin is defined.
% yMargin = 1;                                            %Height margin is defined.
% xSize = 6;%3.0;                                            %Width of figure is defined.
% ySize = 5;%2.5;                                           %Height of figure is defined.


figure()
subplot(3,1,1)
plot(time,uuk11x,'b .',time,uk11x,'r .','linewidth',1.5)
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('X',ins,la,'Fontsize',fsize)
grid('on')
subplot(3,1,2)
plot(time,uuk12x,'b .',time,uk12x,'r .','linewidth',1.5)
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('Y',ins,la,'Fontsize',fsize)
grid('on')
subplot(3,1,3)
plot(time,uuk13x,'b .',time,uk13x,'r .','linewidth',1.5)
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('Z',ins,la,'Fontsize',fsize)
grid('on')
Lx = legend('Accel','Vel');
set(Lx,ins,la,'Location','NorthEast','FontSize',fsize);


figure()
plot(time,pk11x,'b -',time,uk11x,'r .','linewidth',1.5)
hold on
plot(TIME,pg(:,1),'k --','linewidth',1.5)
hold off
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('X Velocity (m/s)',ins,la,'Fontsize',fsize)
Lx = legend('u','ud','ug');
set(Lx,ins,la,'Location','NorthEast','FontSize',fsize);
grid('on')
% set(gcf,'Units','inches','PaperUnits','inches'...
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
% saveas(figure(8),['AgentThrust' '.pdf']);
% print -depsc AgentThrust_SV

figure()
plot(time,pk12x,'b -',time,uk12x,'r .','linewidth',1.5)
hold on
plot(TIME,pg(:,2),'k --','linewidth',1.5)
hold off
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('Y Velocity (m/s)',ins,la,'Fontsize',fsize)
Ly = legend('v','vd','vg');
set(Ly,ins,la,'Location','NorthEast','FontSize',fsize);
grid('on')
% set(gcf,'Units','inches','PaperUnits','inches'... 
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
% saveas(figure(8),['AgentThrust' '.pdf']);
% print -depsc AgentThrust_SV

figure()
plot(time,pk13x,'b -',time,uk13x,'r .','linewidth',1.5)
hold on
plot(TIME,pg(:,3),'k --','linewidth',1.5)
hold off
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('Z Velocity (m/s)',ins,la,'Fontsize',fsize)
Lz = legend('w','wd','wg');
set(Lz,ins,la,'Location','NorthEast','FontSize',fsize);
grid('on')
% set(gcf,'Units','inches','PaperUnits','inches'...
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
% saveas(figure(8),['AgentThrust' '.pdf']);
% print -depsc AgentThrust_SV

figure()
plot(time,errorx,'b -',time,errory,'r -.',time,errorz,'k -','linewidth',1.5)
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('Velocity Error (m/s)',ins,la,'Fontsize',fsize)
Lz = legend('eu','ev','ew');
set(Lz,ins,la,'Location','NorthEast','FontSize',fsize);
grid('on')
% set(gcf,'Units','inches','PaperUnits','inches'...
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
% saveas(figure(8),['AgentThrust' '.pdf']);
% print -depsc AgentThrust_SV

end

