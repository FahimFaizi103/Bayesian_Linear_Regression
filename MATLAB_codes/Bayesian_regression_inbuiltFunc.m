function[w_vector, mu, lambda] = Bayesian_regression_inbuiltFunc(X,Y,small_sigma_squared,eta_squared, numsamples)
%% Do Bayesian regression.

% beta is vector of regressors
% P(beta|D) ~ N(beta| mu, lambda)
% mu = lambda * X{transpose} * big_sigma^(-1) * Y
% lambda = (X{transpose} * inv(sigma) * X + inv(big_omega))^{-1}
% $P(\beta|D) \sim N(\beta| \mu, \lambda)$ % posterior distribution.
% $\mu = \Lambda * X^{T} * \Sigma^{-1} * Y$ %
% $\Lambda = (X^{T} * \Sigma^{-1} * X + \Omega^{-1})^{-1}$

NumMeasurements = size(X,1); % number of data points.
NumRegressors   = size(X,2); % number of coefficients.

big_sigma = small_sigma_squared * eye(NumMeasurements); %a = 0.01 * eye(5); % eye is identity matrix
big_omega = eta_squared * eye(NumRegressors); %b = 0.01 * eye(5);

%% The  mean and covraince matrix of the posterior: P(beta|D) ~ N(beta| mu, lambda).
lambda = inv(X' * inv(big_sigma) * X + inv(big_omega));% covariance matrix in the posterior probability distribution P(beta|D) ~ N(beta| mu, lambda).
mu     = lambda * X' * inv(big_sigma) * Y; % mean vector of posterior distribution P(beta|D) ~ N(beta| mu, lambda).

%% Draw samples from posterior: P(beta|D) ~ N(beta| mu, lambda) using in built Matlab function for multivariate Gaussian

w_vector = zeros(numsamples,NumRegressors);
for iCount=1:numsamples    
    w_vector(iCount,:) = [mvnrnd(mu,lambda)]; % Sample from the multivariate Gaussian.  
end


end
