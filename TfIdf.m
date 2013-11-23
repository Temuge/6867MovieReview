function [ tfIdf ] = TfIdf( i,words, text , IDF, method)
%TfIdf finds TfIdf function
%   i - index of the word
%   text - text as a vector of integers
%   IDF - idf table
%   method -
%           No method - standard frequency
%           boolean  - boolean frequency
%           logarithmic
%           augmented  

ft = sum( words(i) == text);
tf = -1;

if nargin <5,
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
    for j=1:size(text,2),
        next = sum(text(1,j) == text);
        if next > maxTf,
            maxTf = next;
        end
    end
    tf = 0.5 + (0.5+ft)/maxTf;
end 

tfIdf = tf * IDF(i);

end

