% Given a data_mat which is an array of struct of {productId, userId, 
% profileName, helpfulness, score, time, summary, text}, create a mapping
% of all the words appeared in the summary and text to some integer
% indentifiers
% @return data_mat with summary and text hashed to the integer representation 

          
function [word2int_table, data_mat, int2word_table] = create_hash_table(data_mat, create_int2word_table)
    data_length = length(data_mat); % Number of reviews in file movie.txt    
    word2int_table = containers.Map();
    if create_int2word_table
        int2word_table = containers.Map();
    end
    
    integer_id = 1; % The integer id we'll be using for the mapping from word

    % Walk through every data structure stored in data_mat
    % Process the summary and text to convert them into an integer
    % representation
    for i = 1:data_length;
        s = data_mat(i);
        % Process the summary
        if create_int2word_table
            [s.summary, integer_id] = process_words(s.summary, word2int_table, integer_id, int2word_table);
        else
            [s.summary, integer_id] = process_words(s.summary, word2int_table, integer_id);
        end
        % Process the text
        if create_int2word_table
            [s.text, integer_id] = process_words(s.text, word2int_table, integer_id, int2word_table);
        else
            [s.text, integer_id] = process_words(s.text, word2int_table, integer_id);
        end
        % Copy the data to the array
        data_mat(i) = s;
    end
end


function [hashed_array, next_id] = process_words(word_array, table, start_id, int2word_table)
    create_int2word = true;
    if (exist('int2word_table', 'var') ~= 1)
        create_int2word = false;
    end
    
    next_id = start_id;
    array_length = length(word_array);
    hashed_array = zeros(size(word_array));
    if array_length == 0;
        return;
    end
    
    % Process every word within the summary_array
    for i = 1:array_length;
        word = word_array(i);
        if (create_int2word)
            [hashed_id, next_id] = process_word(word, table, next_id, int2word_table);
        else
            [hashed_id, next_id] = process_word(word, table, next_id);
        end
        hashed_array(i) = hashed_id;
    end
end


function [hashed_id, next_id] = process_word(cell, word2int_table, integer_id, int2word_table)
    create_int2word = true;
    if (exist('int2word_table', 'var') ~= 1)
        create_int2word = false;
    end

    % If the word already exists in the table, just used the integer id
    % stored in the table
    word = sprintf('%s', cell{:});
    if isKey(word2int_table, word)
        hashed_id = word2int_table(word);
        next_id = integer_id;
    % Otherwise, create a new entry in the table
    else
        hashed_id = integer_id;
        word2int_table(word) = hashed_id;
        next_id = integer_id + 1;
        
        if (create_int2word)
            int2word_table(num2str(hashed_id)) = word;
        end
    end
end