% Read and parse txt file with format
%   product/productId: B00006HAXW
%   review/userId: A1RSDE90N6RSZF
%   review/profileName: Joseph M. Kotow
%   review/helpfulness: 9/9
%   review/score: 5.0
%   review/time: 1042502400
%   review/summary: Pittsburgh - Home of the OLDIES
%   review/text: I have all of the doo wop DVD's and this one is as good or better than the
%       1st ones. Remember once these performers are gone, we'll never get to see them again.
%       Rhino did an excellent job and if you like or love doo wop and Rock n Roll you'll LOVE
%       this DVD !!

% Input:
%   filename - the filename to read
%   qualityFunction - a function that return 1 if a data is considered
%                     good. Return 0 if the data is bad
%   length - total number of good/bad data that we want. The read_file
%            function will keep looping until it finds a total of 'length' 
%            good and bad examples each exactly or until it reaches the end of the file


function [data_mat] = read_file(filename, length, qualityFunction)
    regex_list = {'product/productId: '; 'review/userId: '; 'review/profileName: '; ...
                  'review/helpfulness: '; 'review/score: '; 'review/time: '; ...
                  'review/summary: '; 'review/text: '};

    fid = fopen(filename);
    if fid == -1
        fprintf('\nERROR: Cannot open the file %s', filename);
        return;    
    end

    data_mat = repmat(struct('productId',0,'userId',0,'profileName',0,'helpfulness',zeros(2,1), ...
        'score',0,'time',0,'summary',[],'text',[]), 2*length, 1);

    good = 1;
    bad = length + 1; 
    line_idx = 1;
    
    tline = fgets(fid);
    while ischar(tline) && ~((good-1 == length) && ((bad-1 == 2*length)));
        %if mod(index, 100) == 0
        %    fprintf('Review %d\n', index);
        %end
        fprintf('Line %d - good: %d, bad: %d\n', line_idx, good-1, bad-1-length);
        line_idx = line_idx + 1;
        
        s = data_mat(1); % Struct to contain the data    
        % Parse the review data

        % Read productId
        s.productId = parser(tline, regex_list(1));

        % Read userId
        tline = fgets(fid);
        s.userId = parser(tline, regex_list(2));

        % Read profileName
        tline = fgets(fid);
        s.profileName = parser(tline, regex_list(3));

        % Read helpfulness; break it down into array of double of size 2
        % e.g: 9/9 -> [9; 9]
        tline = fgets(fid);
        string = parser(tline, 'review/helpfulness: ');
        s.helpfulness(:) = str2double(strsplit(string, '/'));

        % Read score and convert to double
        tline = fgets(fid);
        s.score = str2double(parser(tline, regex_list(5)));

        % Read time and convert to double
        tline = fgets(fid);
        s.time = str2double(parser(tline, regex_list(6)));

        % Read summary
        tline = fgets(fid);
        summary = parser(tline, 'review/summary: ');
        % Preprocess the string
        s.summary = GetDowncaseStemRemoveStop(summary);

        % Read text
        tline = fgets(fid);
        text = parser(tline, 'review/text: ');
        % Preprocess the string
        s.text = GetDowncaseStemRemoveStop(text);

        % Read empty line
        fgets(fid);

        % Determine if it's a good or bad data
        quality = qualityFunction(s);
        
        % Copy the data to the array
        %fprintf('Review Score: %d\n', s.score);
        if (quality == 1) && (good <= length)
            data_mat(good) = s;    
            good = good + 1;        
        elseif (quality == 0) && (bad <= 2*length)
            data_mat(bad) = s;    
            bad = bad + 1;   
        end
        
        % Go to the next review
        tline = fgets(fid);
    end

    % Close the file
    fclose(fid);
end


