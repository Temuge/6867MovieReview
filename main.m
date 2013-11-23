load('data_10_selected.mat');

train_fract = 90; % Fraction of data used for training (in %)
[trainX, trainY, testX, testY] = divide_data(Data.X, Data.Y, train_fract);

option = statset('MaxIter', 100000);
C = 1;
svm_struct = svmtrain(trainX, trainY, 'showplot', false, 'method', 'LS', ...
    'boxconstraint', C);

[~, error] = svm_classify(trainY, svm_struct, trainX);
fprintf('\nNumber of prediction error on the training data: %.2f percent\n', error);

predict = svmclassify(svm_struct, testX, 'showplot', false);
error = sum(predict ~= testY)*100.0/(length(testY));
fprintf('\nNumber of prediction error on the test data: %.2f percent\n', error);

