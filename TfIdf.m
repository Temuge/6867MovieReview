function [ tfIdf ] = TfIdf( i, text , IDF, method)
%UNTITLED3 Summary of this function goes here
%   i - index of the word
%   text - text as a vector of integers
%   IDF - idf table
%   method -
%           No method - standard frequency
%           boolean  - boolean frequency
%           logarithmic
%           augmented  

ft = sum( i == text);
tf = -1;

if nargin <4,
    tf = ft;
elseif  strcmp(method,'boolean'),
    if ft >0 ,
        tf =1;
    else
        tf =0;
    end
elseif strcmp(method,'logarithmic'),
    tf = log(ft +1);
elseif strcmp(method,'augmented')
    maxTf = tf;
    for i=1:size(text,1),
        next = sum(text(i) == text);
        if next > maxTf,
            maxTf = next;
        end
    end
    tf = 0.5 + (0.5+ft)/maxTf;
end 

tfIdf = tf * IDF(i);

end

