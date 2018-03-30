function [xk1,xk2,xk3,totalTime] = analyzeFlock(xk,q3,q4,Tscon)

xk1 = zeros(3,q4,(q3-1));
xk2 = zeros(3,q4,(q3-1));
xk3 = zeros(3,q4,(q3-1));

for j = 1:q4
    if j ==1
        totalTime(j,1) = 0;  
    else
        totalTime(j,1) = totalTime(j-1,end);
    end
    for h = 1:(q3-1)
        xk1(:,j,h) = xk(1,:,h,j);
        xk2(:,j,h) = xk(2,:,h,j);
        xk3(:,j,h) = xk(3,:,h,j);
        if h == q3
            1;
        else
            totalTime(j,h+1) = totalTime(j,h) + Tscon;
        end
    end
end

end

