function xvalues =  PKAdams4 ( dx1, dx2, x1, x2, h, limits)
xvalues = zeros( 20/h, 2);
x1values = zeros( 20/h, 1);
x2values = zeros( 20/h, 1);
i = 0;
k = zeros(4,2);
a = limits(1);

for i = 1:3
    x1values(i) = x1;
    x2values(i) = x2;
    
    % new points
    k(1,1) = dx1(x1, x2);
    k(1,2) = dx2(x1, x2);
    
    k(2,1) = dx1( (x1 + 0.5 * h), (x2 + 0.5 * h * k(1,1)) );
    k(2,2) = dx2( (x1 + 0.5 * h), (x2 + 0.5 * h * k(1,2)) );
    
    k(3,1) = dx1( (x1 + 0.5 * h), (x2 + 0.5 * h * k(2,1)) );
    k(3,2) = dx2( (x1 + 0.5 * h), (x2 + 0.5 * h * k(2,2)) );
    
    k(4,1) = dx1( (x1 + 0.5 * h), (x2 + 0.5 * h * k(3,1)) );
    k(4,2) = dx2( (x1 + 0.5 * h), (x2 + 0.5 * h * k(3,2)) );

    x1 = x1 + 1/6 * h * ( k(1,1) + 2*k(2,1) + 2*k(3,1) + k(4,1) );
    x2 = x2 + 1/6 * h * ( k(1,2) + 2*k(2,2) + 2*k(3,2) + k(4,2) );
end

for i= 4:(limits(2)/h)
    
    tmp1 = x1 + (h/24)*55*dx1(x1, x2) - 59*(h/24)*dx1(x1values(i-1), x2values(i-1)) + 37*(h/24)*dx1(x1values(i-2), x2values(i-2)) - 9*(h/24)*dx1(x1values(i-3), x2values(i-3));
    tmp2 = x2 + (h/24)*55*dx2(x1, x2) - 59*(h/24)*dx2(x1values(i-1), x2values(i-1)) + 37*(h/24)*dx2(x1values(i-2), x2values(i-2)) - 9*(h/24)*dx2(x1values(i-3), x2values(i-3));
    
    x1 = x1 + (h/720)*646*dx1(x1,x2) - 264*(h/720)*dx1(x1values(i-1), x2values(i-1)) + 106*(h/720)*dx1(x1values(i-2), x2values(i-2)) - 19*(h/720)*dx1(x1values(i-3), x2values(i-3)) + h*(251/720)*dx1(tmp1, tmp2);
    x2 = x2 + (h/720)*646*dx2(x1,x2) - 264*(h/720)*dx2(x1values(i-1), x2values(i-1)) + 106*(h/720)*dx2(x1values(i-2), x2values(i-2)) - 19*(h/720)*dx2(x1values(i-3), x2values(i-3)) + h*(251/720)*dx2(tmp1, tmp2);

    x1values(i) = x1;
    x2values(i) = x2;    
end

for i=1:limits(2)/h
    xvalues(i, 1) = x1values(i, 1); 
    xvalues(i, 2) = x2values(i, 1);
end
plot(x1values, x2values);