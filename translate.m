% Given an array of integer, return the string representation

function [string] = translate(array, int2word_table)
    string = '';
    
    is_integer = false;
    cell_array = array;
    if isnumeric(array)
       is_integer = true; 
       cell_array = num2cell(array);
    else
        if iscell(array)
            fprintf('ERROR: array has to be either an integer array or cell array');
            return; 
        end
    end
    
    for i = 1:length(cell_array)
        cell = cell_array(i);
        key = cell{1};
        if is_integer
            key = num2str(key);
        end
        word = int2word_table(key);
        string = sprintf('%s %s', string, word);
        if mod(i, 20) == 0
           string = sprintf('%s\n', string);
        end
    end
end