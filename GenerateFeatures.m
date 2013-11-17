
%% Variables
M  = 500;
N
Dgood
Dbad
words

%%Features 1 Tf-Idf

labels = zeros(2*M,1);

for i=1:M,
    labels(i,1) = 1;
end

for i=M+1:2*M,
    labels(i,1) = -1;
end

% 1 tfIdf

[ topTerms, tfIdf ] = findTopFeatureTerms( Dgood, Dbad, M, N, k, words );

data = [labels tfIdf];