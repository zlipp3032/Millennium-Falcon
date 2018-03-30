function u = computeFlockingControl(relq,relp,qnorm,relqg,relpg,flockGains,Ni,n,d)

    Phi = zeros(Ni,n);
    AR = zeros(Ni,3,n);
    ART = zeros(n,3);
    VC = zeros(Ni,3,n);
    VCT = zeros(n,3);
    FCG = zeros(Ni,3,n);
    FCGT = zeros(n,3);
    GUI = zeros(n,3);
    GUIT = zeros(n,3);
    u = zeros(n,3);
    
    for i = 1:n
        for j = 1:Ni
            % Attraction \ Repulsion
            Phi(j,i) = flockGains(2)/(flockGains(1)+1) - flockGains(2)/(flockGains(1)+qnorm(j,i)^2/d^2);
            AR(j,:,i) = Phi(j,i).*relq(j,:,i);
            ART(i,:) = ART(i,:) + AR(j,:,i);
            %
            % Velocity Consensus
            VC(j,:,i) = flockGains(3).*relp(j,:,i);
            VCT(i,:) = VCT(i,:) + VC(j,:,i);
            %
            % Flock Correction to Guidance
            FCG(j,:,i) = (flockGains(4)/(Ni+1)).*relq(j,:,i) + (flockGains(5)/(Ni+1)).*relp(j,:,i);
            FCGT(i,:) = FCGT(i,:) + FCG(j,:,i);
        end
        % Guidance terms
        GUI(i,1) = flockGains(4).*relqg(i,1) + flockGains(5).*relpg(i,1);
        GUI(i,2) = flockGains(4).*relqg(i,2) + flockGains(5).*relpg(i,2);
        GUI(i,3) = flockGains(6).*relqg(i,3) + flockGains(7).*relpg(i,3);
        GUIT(i,:) = GUIT(i,:) + GUI(i,:);
        %Compute Control
        u(i,:) = ART(i,:) + VCT(i,:) + GUIT(i,:) - FCGT(i,:);
    end
    



end
