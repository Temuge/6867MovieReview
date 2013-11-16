% Given the regex and a input string, remove substring within the input
% that matches the regex

function [out] = parser(str, regex)
    out = strrep(str, regex, '');
end