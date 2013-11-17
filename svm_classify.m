% Input

function [predict] = svm_classify(svm_struct, x, varargin)

    p = inputParser;
    
    checkSvmStruct = @(x) true; 
    checkX = @(x) (isnumeric(x) || ischar(x));
    
    defaultShowPlot = true;
    checkShowPlot = @(x) ((x == true) || (x == false));
    
    % Required parameter
    addRequired(p, 'svm_struct', checkSvmStruct);
    addRequired(p, 'x', checkX);
    
    % Optional parameter
    addParameter(p, 'showplot', defaultShowPlot, checkShowPlot);
    
    parse(p, svm_struct, x, varargin{:});
    
    predict = svmclassify(svm_struct, x, 'showplot', p.Results.showplot);
end