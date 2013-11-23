% Input: 
%   X:  a Nxd matrix where N is the number of the training data and d is 
%       the dimension of the feature vector
%   y:  a vector of size Nx1 of 1 (if it is a positive example) or -1
%       if it is a negative example
%
%   kernel_function:  Kernel function svmtrain uses to map the training data 
%                   into kernel space. The default kernel function is the 
%                   dot product. 
%   See http://www.mathworks.com/help/stats/svmtrain.html for more optional
%   parameters.
% 
% Return:
%   svm_struct: the svm_struct predictor


function [svm_struct] = svm_train(X, y, varargin)
    p = inputParser;
    
    checkY = @(y) (isnumeric(y) || ischar(y)) && (size(y, 2) == 1);
    checkX = @(X) (isnumeric(X));
    
    defaultShowPlot = true;
    checkShowPlot = @(x) ((x == true) || (x == false));

    defaultKernelFunction = 'linear';
    checkKernelFunction = @(x) true;
    
    defaultPolyOrder = 3;
    defaultRbfSigma = 1;   
    defaultBoxConstraint = 1;
    
    defaultAutoScale = true;
    checkAutoScale = @(x) ((x == true) || (x == false));

    defaultMethod = 'LP';
    validMethod = {'LP', 'QP', 'SMO'};
    checkMethod = @(x) any(validatestring(x, validMethod));
    
    defaultOptions = statset('MaxIter', 15000, 'Display', 'off');
    checkOptions = @(x) (true);
    
    % Required parameter
    addRequired(p, 'y', checkY);
    addRequired(p, 'X', checkX);
    
    % Optional parameter
    addParameter(p, 'showplot', defaultShowPlot, checkShowPlot);
    addParameter(p, 'kernel_function', defaultKernelFunction, checkKernelFunction);
    addParameter(p, 'polyorder', defaultPolyOrder, @isnumeric);
    addParameter(p, 'rbf_sigma', defaultRbfSigma, @isnumeric);
    addParameter(p, 'boxconstraint', defaultBoxConstraint, @isnumeric);
    addParameter(p, 'autoscale', defaultAutoScale, checkAutoScale);
    addParameter(p, 'method', defaultMethod, checkMethod);
    addParameter(p, 'options', defaultOptions, checkOptions);
    
    parse(p, y, X, varargin{:});
    
    if strcmpi(p.Results.kernel_function, 'polynomial')
        svm_struct = svmtrain(X, y, 'showplot', p.Results.showplot, 'kernel_function', p.Results.kernel_function, ...
            'polyorder', p.Results.polyorder, 'boxconstraint', p.Results.boxconstraint, ...
            'autoscale', p.Results.autoscale, 'method', p.Results.method, 'options', p.Results.options);
        
    elseif strcmpi(p.Results.kernel_function, 'rbf')
        svm_struct = svmtrain(X, y, 'showplot', p.Results.showplot, 'kernel_function', p.Results.kernel_function, ...
            'rbf_sigma', p.Results.rbf_sigma, 'boxconstraint', p.Results.boxconstraint, ...
            'autoscale', p.Results.autoscale, 'method', p.Results.method, 'options', p.Results.options);
    else
        svm_struct = svmtrain(X, y, 'showplot', p.Results.showplot, 'kernel_function', p.Results.kernel_function, ...
            'boxconstraint', p.Results.boxconstraint, 'autoscale', p.Results.autoscale, 'method', p.Results.method, ...
            'options', p.Results.options);
    end
end