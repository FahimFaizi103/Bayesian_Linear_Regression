% Script runs Bayesian linear regression with synthetic data
% Replace synthetic data wit your own data.

clear all
clc

%% Construct some synthetic data.

DataSize = 100; 
r = [1;2;3;4;5;6]; % only two nonzero coefficients % shoud'nt this be denoted as beta?
NumRegressors = length(r); % number of coefficients
[X_train,Y_train,X_test,Y_test] = contruct_synthetic_data(DataSize, NumRegressors, r);

%% Initialize parameters.

small_sigma_squared = 0.01; % The variance on the likelihood.
eta_squared = 0.01; % the variance on the prior.
MCMC_steps = 10^5; % MCMC steps in MH to sample from posteriror.

%% Bayesian regression with training data

[w_vector, acceptance_ratio, mu, lambda] = Bayesian_regression_with_MH(X_train,Y_train,small_sigma_squared,eta_squared,MCMC_steps);
% [w_vector, mu, lambda] = Bayesian_regression_inbuiltFunc(X_train,Y_train,small_sigma_squared,eta_squared,MCMC_steps);
%% Get mean from posterior

mean_w = zeros();
mode_w = zeros();

disp('Mean and mode value of inferred parameters')
for i = 1:1:NumRegressors
    
   mean_w(i) =  mean(w_vector(1:end,i));
   mode_w(i) = mode(w_vector(1:end,i));
   
end

disp(mean_w)
disp(mode_w)
