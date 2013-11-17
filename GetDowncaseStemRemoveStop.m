function [ output ] = GetDowncaseStemRemoveStop( text )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
load('stopwords.mat');


a=regexp(text,'(\w+)','tokens');
a=lower([a{:}]);
if size(a,1) ==0,
    output =[];
    return
end

[Lia,~] = ismember(a, stopWords);

reducedLength = size(a,2) - sum(Lia);
output  = cell(1,reducedLength);
j=1;
for i=1:size(a,2),
    if Lia(i)==0,        
        word = a(i);
        output(1,j)= cellstr(porterStemmer(word{1}));  
        j = j+1;
    end    
end

end


