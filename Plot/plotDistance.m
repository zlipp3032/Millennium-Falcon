function plotDistance(qk,qg,q3,q4,Ni,d,Tscon,n)

[deltaAgent,AvgLeadDist,totalContTime] = distanceFunction(qk,q3,q4,qg,Tscon,n,Ni);

AgentNorm1 = zeros(Ni,q3*(q4-1));
AgentNorm2 = zeros(Ni,q3*(q4-1));
% AgentNorm3 = zeros(Ni,q3*(q4-1));
% AgentNorm4 = zeros(Ni,q3*(q4-1));

for j = 1:(length(totalContTime)-1)
    for e = 1:Ni
        AgentNorm1(e,j) = sqrt(deltaAgent(e,1,1,j)^2+deltaAgent(e,2,1,j)^2+deltaAgent(e,3,1,j)^2);
        AgentNorm2(e,j) = sqrt(deltaAgent(e,1,2,j)^2+deltaAgent(e,2,2,j)^2+deltaAgent(e,3,2,j)^2);
%         AgentNorm3(e,j) = sqrt(deltaAgent(e,1,3,j)^2+deltaAgent(e,2,3,j)^2+deltaAgent(e,3,3,j)^2);
%         AgentNorm4(e,j) = sqrt(deltaAgent(e,1,4,j)^2+deltaAgent(e,2,4,j)^2+deltaAgent(e,3,4,j)^2);
    end
    AvgLeadNorm(j) = sqrt(AvgLeadDist(1,j)^2+AvgLeadDist(2,j)^2+AvgLeadDist(3,j)^2);
end

time = totalContTime(1:end-1);
dvector = d.*ones(length(time),1);


figure()
% for i = 1:Ni
% plot(time,AgentNorm1(i,:),'linewidth',1.5)
% hold on
% end
plot(time,AgentNorm1(1,:),'b -',time,AgentNorm1(2,:),'r -','linewidth',1.5)
hold on
plot(time,dvector,'-- k','linewidth',1.5)
hold off
xlabel('Time (s)','interpreter','latex','Fontsize',12)
ylabel('Distance','interpreter','latex','Fontsize',12)
title('Agent 1 Relative Distances','interpreter','latex','Fontsize',12)
xlim([0 time(end)])
grid('on')
L = legend('Agent 2', 'Agent 3','d');%,'Agent 5')
set(L,'Interpreter','Latex','Location','NorthEast','FontSize',10);
% xMargin = 1;                                            %Width margin is defined.
% yMargin = 1;                                            %Height margin is defined.
% xSize = 3.0;                                            %Width of figure is defined.
% ySize = 2.5;                                           %Height of figure is defined.
% set(gcf,'Units','inches','PaperUnits','inches'...       %Specify desired formatting.
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
%saveas(figure(2),['AgentPosition' '.eps']);
% print -depsc Agent1Distance

figure()
% for i = 1:Ni
% plot(time,AgentNorm2(i,:),'linewidth',1.5)
% hold on
% end
plot(time,AgentNorm2(1,:),'b -',time,AgentNorm2(2,:),'r -','linewidth',1.5)
hold on
plot(time,dvector,'-- k','linewidth',1.5)
hold off
xlabel('Time (s)','interpreter','latex','Fontsize',12)
ylabel('Distance','interpreter','latex','Fontsize',12)
title('Agent 2 Relative Distances','interpreter','latex','Fontsize',12)
xlim([0 time(end)])
grid('on')
L = legend('Agent 1', 'Agent 3','d');%,'Agent 5')
% set(L,'Interpreter','Latex','Location','NorthEast','FontSize',10);
% set(gcf,'Units','inches','PaperUnits','inches'...       %Specify desired formatting.
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
%saveas(figure(2),['AgentPosition' '.eps']);
% print -depsc Agent2Distance

figure()
plot(time,AvgLeadNorm,'linewidth',1.5)
xlabel('Time (s)','interpreter','latex','Fontsize',12)
ylabel('Distance from Leader','interpreter','latex','Fontsize',12)
xlim([0 time(end)])
grid('on')
L = legend('Flock Dist');%,'Agent 5')
set(L,'Interpreter','Latex','Location','NorthEast','FontSize',10);
% set(gcf,'Units','inches','PaperUnits','inches'...       %Specify desired formatting.
%     ,'PaperOrientation','Portrait','PaperPosition'...
%     ,[xMargin yMargin xSize ySize]);  
%saveas(figure(2),['AgentPosition' '.eps']);
% print -depsc AvgLeadDistance

end