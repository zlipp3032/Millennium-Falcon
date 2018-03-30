function [xk11,totalTime] = analyzeThrust(xk,q3,q4,Tscon)

xk11 = zeros(q4,(q3-1));

for j = 1:q4
    if j ==1
        totalTime(j,1) = 0;  
    else
        totalTime(j,1) = totalTime(j-1,end);
    end
    for h = 1:(q3-1)
        xk11(j,h) = xk(1,1,h,j);
        if h == q3
            1;
        else
            totalTime(j,h+1) = totalTime(j,h) + Tscon;
        end
    end
end

end

