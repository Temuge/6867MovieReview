% Given an array of integer, return the string representation

function [string] = translate(int_array, int2word_table)
    cell_array = num2cell(int_array);
    string = '';
    for i = 1:length(cell_array)
        cell = cell_array(i);
        key = num2str(cell{1});
        word = int2word_table(key);
        string = sprintf('%s %s', string, word);
        if mod(i, 20) == 0
           string = sprintf('%s\n', string);
        end
    end
end