
outputfile = 'C:\Users\temuge_ez\Documents\MIT\6.867MovieReview\stopwords.mat';
stopWordsFile = 'stopwords.txt';
numOfStopWords = 174;
stopWords = cell(1,numOfStopWords);

fid = fopen(stopWordsFile);

tline = fgets(fid);
i=1;
while ischar(tline)
    %disp(tline); % Display the text
    stopWords (1,i) = cellstr(tline);
    tline = fgets(fid);
    i = i+1;
end

fclose(fid);

save (outputfile, 'stopWords');