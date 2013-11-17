% Given a data_mat which is an array of struct of {productId, userId, 
% profileName, helpfulness, score, time, summary, text}, create a mapping
% of all the words appeared in the summary and text to some integer
% indentifiers
% @return data_mat with summary and text hashed to the integer representation 

          
function [] = create_hash_table(hashed_data)
    data_length = length(hashed_data); % Number of reviews in file movie.txt    
    hash_table = containers.Map;

    integer_id = 1; % The integer id we'll be using for the mapping from word

    % Walk through every data structure stored in data_mat
    % Process the summary and text to convert them into an integer
    % representation
    for i = 1:data_length;
        s = hashed_data(i);
        % Process the summary
        s.summary, integer_id = process_words(s.summary, hash_table, integer_id);
        % Process the text
        s.text, integer_id = process_words(s.text, hash_table, integer_id);
        % Copy the data to the array
        hashed_data(i) = s;
    end

    % Save the hash table
    fprintf('Saving the hash table\n');
    outputfile = 'hash_table.mat';
    save(outputfile, 'hash_table');
    
    % Save the hashed data
    fprintf('Saving the hashed data\n');
    outputfile = 'movies_hashed.mat';
    save(outputfile, 'hashed_data');
end


function [hashed_array, next_id] = process_words(word_array, table, start_id)
    next_id = start_id;
    hashed_array = word_array;

    array_length = length(word_array);
    if array_length == 0;
        return;
    end
    
    % Process every word within the summary_array
    for i = 1:array_length;
        word = word_array(i);
        hashed_id, next_id = process_word(word, table, next_id);
        hashed_array(i) = hashed_id;
    end
end


function [hashed_id, next_id] = process_word(word, table, integer_id)
    % If the word already exists in the table, just used the integer id
    % stored in the table
    if isKey(table, word)
        hashed_id = table(word);
        next_id = integer_id;
    % Otherwise, create a new entry in the table
    else
        hashed_id = integer_id;
        table(word) = hashed_id;
        next_id = integer_id + 1;
    end
end