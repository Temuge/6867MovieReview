function [ topTerms, tfIdf ] = findTopFeatureTerms( Dgood, Dbad, M, N, k, words )
%UNTITLED6 Summary of this function goes here
%   Dgood = data of good reviews
%   Dbad = data of bad reviews
%   N   = Number of Words
%   M   = Number of Documents in each good and bad clusters
%   k   = Number of top Terms in each cluster
%   words = Indexes of entire word collections
load('word2int_table_500.mat');
outputFile = 'tfIdfData.mat';

%% Build IDf for each words for good and bad clusters
disp('building idf...');
T.goodIdf = BuildIdf(words, Dgood );
T.badIdf = BuildIdf(words, Dbad);


%% Building tf-idf- half for good, bad
disp('building tfidf ...');

T.tfIdfGood = BuildTfIdf( Dgood, words, T.badIdf, N, M );
T.tfIdfBad = BuildTfIdf( Dbad, words, T.goodIdf, N, M );

load(outputFile);

%% sort the words according good and bad terms
disp('sorting...');
[~, goodSortedTerms] = sort(sum(T.tfIdfGood,2),'descend');
[~, badSortedTerms] = sort(sum(T.tfIdfBad,2),'descend');

T.topTerms = [goodSortedTerms(1:k); badSortedTerms(1:k)];

%T.topTerms = SelectedWords( word2int_table )';


%% build actual idf
disp('building entire idf');
T.entireIdf = BuildIdf(T.topTerms', [Dgood; Dbad]);
numel(T.entireIdf)
entireTfIdf = BuildTfIdf( [Dgood; Dbad], T.topTerms' , T.entireIdf, 2*k, 2*M );
T.tfIdf = entireTfIdf;

topTerms = T.topTerms;
tfIdf = T.tfIdf;

%% Save data

save(outputFile, 'T');


end

