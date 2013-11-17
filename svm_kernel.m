% Given the kernel type, return the corresponding kernel value
% The returned value, K, is a matrix of size M-by-N, where U and V 
% have M and N rows respectively

function K = svm_kernel(kernel_type, U, V, p1, p2)
    if (nargin < 1) % Check for the correct number of arguments
        help svm_kernel
    else    
        switch lower(kernel_type)
            case 'linear'
                K = U*V';
            case 'poly'
                K = (U*V' + 1)^p1;
            case 'rbf'
                K = exp(-(U-V)*(U-V)'/(2*p1^2));
            case 'erbf'
                K = exp(-sqrt((U-V)*(U-V)')/(2*p1^2));
            case 'sigmoid'
                K = tanh(p1*U*V'/length(U) + p2);
            case 'fourier'
                z = sin(p1 + 1/2)*2*ones(length(U),1);
                i = find(U-V);
                z(i) = sin(p1 + 1/2)*(U(i)-V(i))./sin((U(i)-V(i))/2);
                K = prod(z);
            case 'spline'
                z = 1 + U.*V + (1/2)*U.*V.*min(U,V) - (1/6)*(min(U,V)).^3;
                K = prod(z);
            case 'bspline'
                z = 0;
                for r = 0: 2*(p1+1)
                    z = z + (-1)^r*binomial(2*(p1+1),r)*(max(0,U-V + p1+1 - r)).^(2*p1 + 1);
                end
                K = prod(z);
            case 'anovaspline1'
                z = 1 + U.*V + U.*V.*min(U,V) - ((U+V)/2).*(min(U,V)).^2 + (1/3)*(min(U,V)).^3;
                K = prod(z);
            case 'anovaspline2'
                z = 1 + U.*V + (U.*V).^2 + (U.*V).^2.*min(U,V) - U.*V.*(U+V).*(min(U,V)).^2 + (1/3)*(U.^2 + 4*U.*V + V.^2).*(min(U,V)).^3 - (1/2)*(U+V).*(min(U,V)).^4 + (1/5)*(min(U,V)).^5;
                K = prod(z);
            case 'anovaspline3'
                z = 1 + U.*V + (U.*V).^2 + (U.*V).^3 + (U.*V).^3.*min(U,V) - (3/2)*(U.*V).^2.*(U+V).*(min(U,V)).^2 + U.*V.*(U.^2 + 3*U.*V + V.^2).*(min(U,V)).^3 - (1/4)*(U.^3 + 9*U.^2.*V + 9*U.*V.^2 + V.^3).*(min(U,V)).^4 + (3/5)*(U.^2 + 3*U.*V + V.^2).*(min(U,V)).^5 - (1/2)*(U+V).*(min(U,V)).^6 + (1/7)*(min(U,V)).^7;
                K = prod(z);
            case 'anovabspline'
                z = 0;
                for r = 0: 2*(p1+1)
                    z = z + (-1)^r*binomial(2*(p1+1),r)*(max(0,U-V + p1+1 - r)).^(2*p1 + 1);
                end
                K = prod(1 + z);
            otherwise
                K = U*V';
        end
    end
  end
