function plotCommand(attitudek,thrustk,sentCommandk,q3,q4,Tscon,TIME)

[pk11,pk12,pk13,plotTime] = analyzeVelPos(attitudek,q3,q4,Tscon);
[qk11,~,~,~] = analyzeVelPos(thrustk,q3,q4,Tscon);
[uk11,uk12,uk13,~] = analyzeCommand(sentCommandk,q3,q4,Tscon);



xx= 0;
for i = 1:(q4-1)
    for j = 1:(q3-1)
        xx = xx+1;
        pk11x(xx) = pk11(i,j);
        pk12x(xx) = pk12(i,j);
        pk13x(xx) = pk13(i,j);
        time(xx) = plotTime(i,j);
        
        qk11x(xx) = qk11(i,j);
        
        uk11x(xx) = uk11(i,j);
        uk12x(xx) = uk12(i,j);
        uk13x(xx) = uk13(i,j);
    end
end

% Define certain plotting stuff
fsize = 12; %font size
ins = 'interpreter';
la = 'latex';
% xMargin = 1;                                            %Width margin is defined.
% yMargin = 1;                                            %Height margin is defined.
% xSize = 6;%3.0;                                            %Width of figure is defined.
% ySize = 5;%2.5;                                           %Height of figure is defined.


figure()
plot(time,pk11x,'b -',time,uk11x,'r .','linewidth',1.5)
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('Roll (rad)',ins,la,'Fontsize',fsize)
Lx = legend('phi','phid');
set(Lx,ins,la,'Location','NorthEast','FontSize',fsize);
grid('on')
% set(gcf,'Units','inches','PaperUnits','inches'...
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
% saveas(figure(8),['AgentThrust' '.pdf']);
% print -depsc AgentThrust_SV

figure()
plot(time,pk12x,'b -',time,uk12x,'r .','linewidth',1.5)
xlabel('Time (s)',ins,la,'Fontsize',fsize)
ylabel('Pitch (rad)',ins,la,'Fontsize',fsize)
Lx = legend('theta','thetad');
set(Lx,ins,la,'Location','NorthEast','FontSize',fsize);
grid('on')
% set(gcf,'Units','inches','PaperUnits','inches'...
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
% saveas(figure(8),['AgentThrust' '.pdf']);
% print -depsc AgentThrust_SV


end