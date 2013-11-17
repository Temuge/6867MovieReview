function [t] = BuildTfIdf( D, words, IDF, N, M )
%UNTITLED5 Summary of this function goes here
%   t is the N*M matrix of tf-idf values 
%   IDF = ID table
%   N   = Number of Words
%   M   = Number of Reviews
%outputFile = 'tfidf.mat';

t = zeros(N,M);


for i=1:N,
    for j=1:M,
        
        text = [D(j).summary D(j).text];
        t (i,j) = TfIdf( i, words, text , IDF, 'boolean');
    end
end

%save (outputFile, 'TfIdf');

end

