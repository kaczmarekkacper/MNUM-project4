function [xvalues, errors] = RK4const(dx1, dx2, x1, x2, h, limits)
xvalues = zeros( 20/h, 2);
x1values = zeros( 20/h, 1);
x2values = zeros( 20/h, 1);
errors = zeros( 20/h, 2);
i = 0;
k = zeros(4,2);
a = limits(1);

while ( a < limits(2))
    vectora(i+1) = a;
    x1values(i+1) = x1;
    x2values(i+1) = x2;
    
    % new points
    k(1,1) = dx1(x1, x2);
    k(1,2) = dx2(x1, x2);
    
    k(2,1) = dx1( (x1 + 0.5 * h), (x2 + 0.5 * h * k(1,1)) );
    k(2,2) = dx2( (x1 + 0.5 * h), (x2 + 0.5 * h * k(1,2)) );
    
    k(3,1) = dx1( (x1 + 0.5 * h), (x2 + 0.5 * h * k(2,1)) );
    k(3,2) = dx2( (x1 + 0.5 * h), (x2 + 0.5 * h * k(2,2)) );
    
    k(4,1) = dx1( (x1 + 0.5 * h), (x2 + 0.5 * h * k(3,1)) );
    k(4,2) = dx2( (x1 + 0.5 * h), (x2 + 0.5 * h * k(3,2)) );
    
    tempx1 = x1;
    tempx2 = x2;
    
    x1 = x1 + 1/6 * h * ( k(1,1) + 2*k(2,1) + 2*k(3,1) + k(4,1) );
    x2 = x2 + 1/6 * h * ( k(1,2) + 2*k(2,2) + 2*k(3,2) + k(4,2) );
    
    newx1 = x1;
    newx2 = x2;
    % errors
    % first half-step
    h = 0.5*h;
    x1 = tempx1;
    x2 = tempx2;
    
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
    
    %second half-step
    
    k(1,1) = dx1(x1, x2);
    k(1,2) = dx2(x1, x2);
    
    k(2,1) = dx1( (x1 + 0.5 * h), (x2 + 0.5 * h * k(1,1)) );
    k(2,2) = dx2( (x1 + 0.5 * h), (x2 + 0.5 * h * k(1,2)) );
    
    k(3,1) = dx1( (x1 + 0.5 * h), (x2 + 0.5 * h * k(2,1)) );
    k(3,2) = dx2( (x1 + 0.5 * h), (x2 + 0.5 * h * k(2,2)) );
    
    k(4,1) = dx1( (x1 + 0.5 * h), (x2 + 0.5 * h * k(3,1)) );
    k(4,2) = dx2( (x1 + 0.5 * h), (x2 + 0.5 * h * k(3,2)) );
    
    tempx12 = x1 + 1/6 * h * ( k(1,1) + 2*k(2,1) + 2*k(3,1) + k(4,1) );
    tempx22 = x2 + 1/6 * h * ( k(1,2) + 2*k(2,2) + 2*k(3,2) + k(4,2) );
    
    errors(i+1,1) = (tempx12 - x1)/15;
    errors(i+1,2) = (tempx22 - x2)/15;
    x1 = newx1;
    x2 = newx2;
    
    h = 2*h;
    
    a = a + h;
    i = i+1;
end
hold on
plot(x1values, x2values, 'b');
for i=1:limits(2)/h
    xvalues(i, 1) = x1values(i, 1); 
    xvalues(i, 2) = x2values(i, 1);
end