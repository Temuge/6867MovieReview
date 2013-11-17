function [] = BuildTfIdf( D, IDF, N, M )
%UNTITLED5 Summary of this function goes here
%   IDF = ID table
%   N   = Number of Words
%   M   = Number of Documents
outputFile = 'tfidf.mat';
TfIdf = zeros(N,M);

for i=1:N,
    for j=1:M,
        text = [D(j).summary D(j).text];
        TfIdf (i,j) = TfIdf( i, text , IDF, method);
    end
end

save (outputFile, 'TfIdf');
end

