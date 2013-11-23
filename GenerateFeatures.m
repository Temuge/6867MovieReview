
%% Variables
outputFile = 'data_1000.mat';
load('movies_hashed_500.mat');
%load('tfIdfData.mat');
M  = 500;
N  = 8997;
k=1000;
Dgood = hashed_data(1:M);
Dbad = hashed_data(M+1: 2*M);
words = [1:N];

%%Features 1 Tf-Idf

Y = zeros(2*M,1);

for i=1:M,
    Y(i,1) = 1;
end

for i=M+1:2*M,
    Y(i,1) = -1;
end

% 1 tfIdf

[ topTerms, tfIdf ] = findTopFeatureTerms( Dgood, Dbad, M, N, k, words );

X = tfIdf;

Data.Y = Y;
Data.X = X';

save(outputFile,'Data');