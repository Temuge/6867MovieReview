% Read and parse txt file with format
% product/productId: B00006HAXW
% review/userId: A1RSDE90N6RSZF
% review/profileName: Joseph M. Kotow
% review/helpfulness: 9/9
% review/score: 5.0
% review/time: 1042502400
% review/summary: Pittsburgh - Home of the OLDIES
% review/text: I have all of the doo wop DVD's and this one is as good or better than the
% 1st ones. Remember once these performers are gone, we'll never get to see them again.
% Rhino did an excellent job and if you like or love doo wop and Rock n Roll you'll LOVE
% this DVD !!

fid = fopen('movie.txt');

tline = fgets(fid);
while ischar(tline)
    disp(tline); % Display the text
    tline = fgets(fid);
end

fclose(fid);