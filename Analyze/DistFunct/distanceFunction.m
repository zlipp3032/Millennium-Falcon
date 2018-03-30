function [deltaAgent,AvgLeadDist,totalContTime] = distanceFunction(qk,q3,q4,qg,Tscon,n,Ni) % AgentNorm2,AgentNorm3,AgentNorm4,


xxx = 0;
Dirty = zeros(n,3,q3,q4);
deltaAgent = zeros(Ni,3,n,(q4-1)*q3);
deltaLead = zeros(n,3,(q4-1)*q3);
AvgLeadDist = zeros(3,(q4-1)*q3);
totalContTime = zeros(q3*(q4-1),1);
[qj,~] = neighborSet_Dist(qk,Dirty,q3,q4,n);

for j = 1:(q4-1)
    for h = 1:q3
        xxx = xxx + 1;
        for i = 1:n   
            for e = 1:Ni
                deltaAgent(e,:,i,xxx) = qk(i,:,h,j) - qj(e,:,i,h,j);
            end
            deltaLead(i,:,xxx) = qk(i,:,h,j) - qg(j,:);
%             AvgAgentDist(:,i,xxx) = [sum(deltaAgent(:,1,i,xxx)), sum(deltaAgent(:,2,i,xxx)), sum(deltaAgent(:,3,i,xxx))]./Ni;
        end
        totalContTime(xxx+1) = totalContTime(xxx) + Tscon;
        AvgLeadDist(:,xxx) = [sum(deltaLead(:,1,xxx)), sum(deltaLead(:,2,xxx)), sum(deltaLead(:,3,xxx))]./n;
    end
end


end
