function [] = BuildIdf( D , N)
%Build Idf Table
%   D - whole dataset
%   N - total number of words

IDF = zeros(1, N);
M = size(D,1);
outputFile = 'idf.mat';

for i = 1:N
    count = 0;
    for d=1:M,
        if (ismember(i, D(d).summary)==1 || ismember(i, D(d).text)==1),
            count = count + 1;
        end
    end
    % set Idf
    IDF(1,i) =log(M/(count+0.5));    

end
%save idf 
save(outputFile, 'IDF');


end

