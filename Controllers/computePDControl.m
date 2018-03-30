function u = computePDControl(q,p,qg,pg,kp,kd)


[rq,~] = size(q);

    for i = 1:rq
       u(i,:) = kp.*(qg - q(i,:)) + kd.*(pg - p(i,:));
    end
end 
