function [ topTerms, tfIdf ] = findTopFeatureTerms( Dgood, Dbad, M, N, k, words )
%UNTITLED6 Summary of this function goes here
%   Dgood = data of good reviews
%   Dbad = data of bad reviews
%   N   = Number of Words
%   M   = Number of Documents in each good and bad clusters
%   k   = Number of top Terms in each cluster
%   words = Indexes of entire word collections


goodIdf = BuildIdf(words, Dgood );
badIdf = BuildIdf(words, Dbad);



tfIdfGood = BuildTfIdf( Dgood, badIdf, N, M );
tfIdfBad = BuildTfIdf( Dbad, goodIdf, N, M );

[~, goodSortedTerms] = sort(sum(tfIdfGood,2),'descend');
[~, badSortedTerms] = sort(sum(tfIdfBad,2),'descend');

topTerms = [goodSortedTerms(1:k) badSortedTerms(1:k)];

entireIdf = BuildIdf(words, [Dgood; Dbad]);
entireTfIdf = BuildTfIdf( [Dgood; Dbad], entireIdf, 2*k, 2*M );
tfIdf = entireTfIdf;

end

