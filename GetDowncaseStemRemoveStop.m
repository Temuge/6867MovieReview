function [ output ] = GetDowncaseStemRemoveStop( text )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
load('stopwords.mat');

stemmed = porterStemmer(text);
a=regexp(stemmed,'(\w+)','tokens');
a=lower([a{:}]);
[Lia,~] = ismember(a, stopWords);

reducedLength = size(a,2) - sum(Lia);
output  = cell(1,reducedLength);
j=1;
for i=1:size(a,2),
    if Lia(i)==0,        
        output(1,j)= a(i);        
        j = j+1;
    end
    
end
end


