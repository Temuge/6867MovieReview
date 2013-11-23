
function [predict, error] = svm_classify(y_actual, svm_struct, x, varargin)

    p = inputParser;
    
    checkSvmStruct = @(x) true; 
    checkX = @(x) (isnumeric(x));
    checkY = @(y) (isnumeric(y) || ischar(y)) && (size(y, 2) == 1);
    
    defaultShowPlot = true;
    checkShowPlot = @(x) ((x == true) || (x == false));
    
    % Required parameter
    addRequired(p, 'y_actual', checkY);
    addRequired(p, 'svm_struct', checkSvmStruct);
    addRequired(p, 'x', checkX);
    
    % Optional parameter
    %addParameter(p, 'showplot', defaultShowPlot, checkShowPlot);
    
    parse(p, y_actual, svm_struct, x);%, varargin{:});
    
    %predict = svmclassify(svm_struct, x, 'showplot', p.Results.showplot);
    predict = svmclassify(svm_struct, x);
    
    error = sum(predict ~= y_actual)*100.0/(length(y_actual));
    
end