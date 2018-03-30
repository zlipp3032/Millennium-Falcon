function [relPos,relVel,qNorm,relPosLead,relVelLead] = agentRelative(qi,pi,qj,pj,qg,pg,n,Tsbar,Ni)

    relPos = zeros(Ni,3,n);
    relVel = zeros(Ni,3,n);
    qihat = zeros(n,3);
    qjhat = zeros(Ni,3,n);
    relqhat = zeros(Ni,3,n);
    qNorm = zeros(Ni,n);
    relPosLead = zeros(n,3);
    relVelLead = zeros(n,3);
    
    % Agent relative position
    for i = 1:n
        % Estimate self next position
        qihat(i,:) = qi(i,:) + Tsbar.*pi(i,:);
        for j = 1:Ni    
            relPos(j,:,i) = qj(j,:,i) - qi(i,:);
            relVel(j,:,i) = pj(j,:,i) - pi(i,:);
            % Compute Estimate of the next agent
            qjhat(j,:,i) = qj(j,:,i) + Tsbar.*pj(j,:,i);
            relqhat(j,:,i) = qjhat(j,:,i) - qihat(i,:);
            qNorm(j,i) = sqrt(relqhat(j,1,i)^2 + relqhat(j,2,i)^2 + relqhat(j,3,i));
        end
        % Relative to the leader
        relPosLead(i,:) = qg - qi(i,:); % Leader position is qg
        relVelLead(i,:) = pg - pi(i,:); % Leader velocity is pg
    end
end

