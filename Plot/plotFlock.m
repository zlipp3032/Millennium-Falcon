function plotFlock(qk,qg,q3,q4,Tscon,TIME)

[qk11,qk12,qk13,plotTime] = analyzeFlock(qk,q3,q4,Tscon);


xx= 0;
for i = 1:(q4-1)
    for j = 1:(q3-1)
        xx = xx+1;
        qk11x(:,xx) = qk11(:,i,j);
        qk12x(:,xx) = qk12(:,i,j);
        qk13x(:,xx) = qk13(:,i,j);
        time(xx) = plotTime(i,j);
    end
end


% Define certain plotting stuff
scale = 5000 - 1;
fsize = 12; %font size
ins = 'interpreter';
la = 'latex';
% xMargin = 1;                                            %Width margin is defined.
% yMargin = 1;                                            %Height margin is defined.
% xSize = 6;%3.0;                                            %Width of figure is defined.
% ySize = 5;%2.5;                                           %Height of figure is defined.

agent12 = [qk11x(1,end), qk11x(2,end),qk11x(3,end); ...
           qk12x(1,end), qk12x(2,end),qk12x(3,end);];
agent13 = [qk11x(1,end), qk11x(2,end),qk11x(3,end); ...
           qk13x(1,end), qk13x(2,end),qk13x(3,end);];
agent32 = [qk13x(1,end), qk13x(2,end),qk13x(3,end); ...
           qk12x(1,end), qk12x(2,end),qk12x(3,end);];

%% 3-D Plots
figure()
plot3(qk11x(1,:),qk11x(2,:),qk11x(3,:),'b -.','linewidth',1.5)
hold on
plot3(qk12x(1,:),qk12x(2,:),qk12x(3,:),'r -.','linewidth',1.5)
plot3(qk13x(1,:),qk13x(2,:),qk13x(3,:),'g -.','linewidth',1.5)
% plot3(qg(:,1),qg(:,2),qg(:,3),'k -','linewidth',1.5)
plot3(qk11x(1,1:scale:end),qk11x(2,1:scale:end),qk11x(3,1:scale:end),'b o','linewidth',3,'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','b')
plot3(qk12x(1,1:scale:end),qk12x(2,1:scale:end),qk12x(3,1:scale:end),'r o','linewidth',3,'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r')
plot3(qk13x(1,1:scale:end),qk13x(2,1:scale:end),qk13x(3,1:scale:end),'g o','linewidth',3,'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','g')
plot3(agent12(:,1),agent12(:,2),agent12(:,3),'k --','linewidth',2.0)
plot3(agent13(:,1),agent13(:,2),agent13(:,3),'k --','linewidth',2.0)
plot3(agent32(:,1),agent32(:,2),agent32(:,3),'k --','linewidth',2.0)
hold off
xlabel('X Position (m)',ins,la,'Fontsize',fsize)
ylabel('Y Position (m)',ins,la,'Fontsize',fsize)
zlabel('Z Position (m)',ins,la,'Fontsize',fsize)
axis equal
Lx = legend('Agent 1','Agent 2','Agent 3');
set(Lx,ins,la,'Location','NorthEast','FontSize',fsize);
grid('on')
% set(gcf,'Units','inches','PaperUnits','inches'...
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
% saveas(figure(8),['AgentThrust' '.pdf']);
% print -depsc AgentThrust_SV

%% 2-D Plots
figure()
plot(qk11x(1,:),qk11x(2,:),'b -.','linewidth',1.5)
hold on
plot(qk12x(1,:),qk12x(2,:),'r -.','linewidth',1.5)
plot(qk13x(1,:),qk13x(2,:),'g -.','linewidth',1.5)
% plot(qg(:,1),qg(:,2),'k --','linewidth',1.5)
plot(qk11x(1,1:scale:end),qk11x(2,1:scale:end),'b o','linewidth',3,'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','b')
plot(qk12x(1,1:scale:end),qk12x(2,1:scale:end),'r o','linewidth',3,'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','r')
plot(qk13x(1,1:scale:end),qk13x(2,1:scale:end),'g o','linewidth',3,'MarkerSize',10,'MarkerEdgeColor','k','MarkerFaceColor','g')
plot(agent12(:,1),agent12(:,2),'k --','linewidth',2.0)
plot(agent13(:,1),agent13(:,2),'k --','linewidth',2.0)
plot(agent32(:,1),agent32(:,2),'k --','linewidth',2.0)
hold off
xlabel('X Position (m)',ins,la,'Fontsize',fsize)
ylabel('Y Position (m)',ins,la,'Fontsize',fsize)
axis equal
Lx = legend('Agent 1','Agent 2','Agent 3');
set(Lx,ins,la,'Location','NorthEast','FontSize',fsize);
grid('on')
% set(gcf,'Units','inches','PaperUnits','inches'...
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
% saveas(figure(8),['AgentThrust' '.pdf']);
% print -depsc AgentThrust_SV
% 
% figure()
% plot(time,qk11x(2,:),'b -.','linewidth',1.5)
% hold on
% plot(time,qk12x(2,:),'r -.','linewidth',1.5)
% plot(time,qk13x(2,:),'g -.','linewidth',1.5)
% plot(TIME,qg(:,2),'k --','linewidth',1.5)
% plot(time(1:scale:end),qk11x(2,1:scale:end),'b o','linewidth',3,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor','k')
% plot(time(1:scale:end),qk12x(2,1:scale:end),'r o','linewidth',3,'MarkerSize',10,'MarkerEdgeColor','r','MarkerFaceColor','k')
% plot(time(1:scale:end),qk13x(2,1:scale:end),'g o','linewidth',3,'MarkerSize',10,'MarkerEdgeColor','g','MarkerFaceColor','k')
% hold off
% xlabel('Time (s)',ins,la,'Fontsize',fsize)
% ylabel('Z Position (m)',ins,la,'Fontsize',fsize)
% axis equal
% Lx = legend('Agent 1','Agent 2','Agent 3','Leader');
% set(Lx,ins,la,'Location','NorthEast','FontSize',fsize);
% grid('on')
% % set(gcf,'Units','inches','PaperUnits','inches'...
% %     ,'PaperOrientation','Portrait','PaperPosition'...
% %     ,[xMargin yMargin xSize ySize]);  
% % saveas(figure(8),['AgentThrust' '.pdf']);
% % print -depsc AgentThrust_SV
% 
% figure()
% plot(time,qk11x(3,:),'b -.','linewidth',1.5)
% hold on
% plot(time,qk12x(3,:),'r -.','linewidth',1.5)
% plot(time,qk13x(3,:),'g -.','linewidth',1.5)
% plot(TIME,qg(:,3),'k --','linewidth',1.5)
% plot(time(1:scale:end),qk11x(3,1:scale:end),'b o','linewidth',3,'MarkerSize',10,'MarkerEdgeColor','b','MarkerFaceColor','k')
% plot(time(1:scale:end),qk12x(3,1:scale:end),'r o','linewidth',3,'MarkerSize',10,'MarkerEdgeColor','r','MarkerFaceColor','k')
% plot(time(1:scale:end),qk13x(3,1:scale:end),'g o','linewidth',3,'MarkerSize',10,'MarkerEdgeColor','g','MarkerFaceColor','k')
% hold off
% xlabel('Time (s)',ins,la,'Fontsize',fsize)
% ylabel('Z Position (m)',ins,la,'Fontsize',fsize)
% axis equal
% Lx = legend('Agent 1','Agent 2','Agent 3','Leader');
% set(Lx,ins,la,'Location','NorthEast','FontSize',fsize);
% grid('on')
% % set(gcf,'Units','inches','PaperUnits','inches'...
% %     ,'PaperOrientation','Portrait','PaperPosition'...
% %     ,[xMargin yMargin xSize ySize]);  
% % saveas(figure(8),['AgentThrust' '.pdf']);
% % print -depsc AgentThrust_SV

end

