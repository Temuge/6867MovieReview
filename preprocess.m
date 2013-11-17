%% Preprocess the document

filename = 'movies.txt';

%% READING DATA

% Read the data from the file
%length = 7911684; % Number of reviews in file movie.txt
length = 500;    
[data_mat] = read_file(filename, length, @isDataGood);

% Save the data_mat
fprintf('Saving data_mat\n');
outputfile = 'movies_raw.mat';
save(outputfile, 'data_mat', '-v7.3');


%% PREPROCESS

% Preprocess the data, convert summary and text into the integer
% representation
create_int2word_table = 1;
[word2int_table, data_mat, int2word_table] = create_hash_table(data_mat, create_int2word_table);

% Save the hash table
fprintf('Saving the word2int_table\n');
outputfile = 'word2int_table.mat';
save(outputfile, 'word2int_table', '-v7.3');

if create_int2word_table
    fprintf('Saving the int2word_table\n');
    outputfile = 'int2word_table.mat';
    save(outputfile, 'int2word_table', '-v7.3');
end

% Save the hashed data
fprintf('Saving the hashed data\n');
outputfile = 'movies_hashed.mat';
save(outputfile, 'hashed_data', '-v7.3');