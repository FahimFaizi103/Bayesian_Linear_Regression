function[X_train,Y_train,X_test,Y_test] = contruct_synthetic_data(DataSize, NumRegressors, r)

%%
X = randn(DataSize,NumRegressors-1);% predictors
X = [ones(1,DataSize)', X]; % this is to accomodataethe intercept value r(1) or beta_0 in the matrix equation Y = X*r + \verepsilon
Y = X*r + randn(DataSize,1)*.1; % responses Y, % small added noise.

[m,~] = size(X);

P = 0.70 ;% ~70 percent of the data is for training.
idx = randperm(m);
X_train = X(idx(1:round(P*m)),:); 
Y_train = Y(idx(1:round(P*m)));

X_test = X(idx(round(P*m)+1:end),:);
Y_test = Y(idx(round(P*m)+1:end));

end