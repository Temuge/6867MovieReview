
function [trainX, trainY, testX, testY] = divide_data(X, Y, train_fract)
    
    N = length(Y);
    train_size = floor(train_fract*N/100);
       
    shuffleX = X;
    shuffleY = Y;
    % Shuffle data in array
    for i = 1:N/2
        shuffleX = shuffleX(randperm(N),:);
        shuffleY = shuffleY(randperm(N),:);
    end
    
    %train_indices_pos = randperm(N/2,train_size/2);
    %train_indices_neg = N/2 + randperm(N/2,train_size/2);
    %trainX = [X(train_indices_pos) X(train_indices_neg)];
    %trainY = [Y(train_indices_pos) Y(train_indices_neg)];

    trainX = shuffleX(1:train_size,:);
    trainY = shuffleY(1:train_size,:);
    
    testX = shuffleX(train_size+1:N,:);
    testY = shuffleY(train_size+1:N,:);
    
    % Distributions of data
    train_pos = sum(trainY == 1);
    train_neg = length(trainY) - train_pos;
    test_pos = sum(testY == 1);
    test_neg = length(testY) - test_pos;
    fprintf('\nDivide Data: train_pos = %i, train_neg = %i, test_pos = %i, test_neg = %i\n', ...
        train_pos, train_neg, test_pos, test_neg);
    
end