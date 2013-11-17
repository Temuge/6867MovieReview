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

regex_list = {'product/productId: '; 'review/userId: '; 'review/profileName: '; ...
              'review/helpfulness: '; 'review/score: '; 'review/time: '; ...
              'review/summary: '; 'review/text: '};

filename = 'movies.txt';
fid = fopen(filename);
if fid == -1
    fprintf('\nERROR: Cannot open the file %s', filename);
    return;    
end

length = 7911684; % Number of reviews in file movie.txt
%length = 10;
data_mat = repmat(struct('productId',0,'userId',0,'profileName',0,'helpfulness',zeros(2,1), ...
    'score',0,'time',0,'summary',[],'text',[]), length, 1);

tline = fgets(fid);
index = 1;
while ischar(tline) && (index <= length);
    if mod(index, 100) == 0
        fprintf('Review %d\n', index);
    end
    s = data_mat(index); % Struct to contain the data    
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
    
    % Copy the data to the array
    data_mat(index) = s;
    
    % Go to the next review
    index = index + 1;
    tline = fgets(fid);
end

% Close the file
fclose(fid);

fprintf('Saving data_mat\n');
outputfile = 'movies_raw.mat';
save(outputfile, 'data_mat');


