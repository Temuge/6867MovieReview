% Input: 
%   X:  a Nxd matrix where N is the number of the training data and d is 
%       the dimension of the feature vector
%   k:  the number of gaussian cluster
%
%   See http://www.mathworks.com/help/stats/svmtrain.html for more optional
%   parameters.
% 
% Return:
%   svm_struct: the svm_struct predictor


function [gm_obj] = gauss_train(X, k, varargin)
    p = inputParser;
    
    defaultStart = 'randSample';
    checkStart = @(x) true;
    
    defaultReplicates = 1;

    defaultCovType = 'full';
    validCovType = {'diagonal', 'full'};
    checkCovType = @(x) any(validatestring(x, validCovType));
    
    defaultRegularize = 0;
    
    defaultOptions = statset('Display','final');
    checkOptions = @(x) true;

    % Required parameter
    addRequired(p, 'k', @isnumeric);
    addRequired(p, 'X', @isnumeric);
    
    % Optional parameter
    addParameter(p, 'Start', defaultStart, checkStart);
    addParameter(p, 'Replicates', defaultReplicates, @isnumeric);
    addParameter(p, 'CovType', defaultCovType, checkCovType);
    addParameter(p, 'Regularize', defaultRegularize, @isnumeric);
    addParameter(p, 'Options', defaultOptions, checkOptions);
    
    parse(p, k, X, varargin{:});
    
    gm_obj = gmdistribution.fit(X, k, 'Start', p.Results.Start, 'Replicates', p.Results.Replicates, ...
        'CovType', p.Results.CovType, 'Regularize', p.Results.Regularize, 'Options', p.Results.Options);
end