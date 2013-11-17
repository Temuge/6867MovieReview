
disp('good');
for i=1:k,
    int2word_table(num2str(T.topTerms(i)))
end
disp ('***********************************************************************');
disp('bad');

for i=k+1:2*k,
    int2word_table(num2str(T.topTerms(i)))
end