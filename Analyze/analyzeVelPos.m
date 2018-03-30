function [xk11,xk12,xk13,totalTime] = analyzeVelPos(xk,q3,q4,Tscon)

xk11 = zeros(q4,(q3-1));
xk12 = zeros(q4,(q3-1));
xk13 = zeros(q4,(q3-1));

for j = 1:q4
    if j ==1
        totalTime(j,1) = 0;  
    else
        totalTime(j,1) = totalTime(j-1,end);
    end
    for h = 1:(q3-1)
        xk11(j,h) = xk(1,1,h,j);
        xk12(j,h) = xk(1,2,h,j);
        xk13(j,h) = xk(1,3,h,j);
        if h == q3
            1;
        else
            totalTime(j,h+1) = totalTime(j,h) + Tscon;
        end
    end
end

end

