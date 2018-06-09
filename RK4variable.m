function [xvalues, errors] = RK4variable(dx1, dx2, x1, x2, h, epsr, epsa, limits)
% x1 - first value of x1
% x2 - first value of x2
% h - step
% epsr - relative epsilon
% epsa - absolute epsilon
i = 0;
k = zeros(4,2);
a = limits(1);
while ( a < limits(2) )
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
    
    eps(1) = abs(x1) * epsr + epsa;
    eps(2) = abs(x2) * epsr + epsa;
    
    alpha1 = ( eps(1) / abs(errors(i+1, 1)*(h^5)) )^(1/5);
    alpha2 = ( eps(2) / abs(errors(i+1, 2)*(h^5)) )^(1/5);
    
    alpha = min(alpha1, alpha2);
    
    hnew = 0.9 * alpha * h;
    
    if ( 0.9 * alpha >= 1 )
        if ( a + hnew >= 20 )
            break;
        else
            a = a + h;
            h = min([hnew, 5*h, 20-a]);
            i = i+1;
        end
    else
        if ( hnew < h )
            h = hnew;
        else
            error('Cant solve with this epsilon');
        end
    end
end
hold on
plot(x1values, x2values, 'b');
for j = 1:(i-1)
    xvalues(j, 1) = x1values(j);
    xvalues(j, 2) = x2values(j);
end
sum(abs(errors))
