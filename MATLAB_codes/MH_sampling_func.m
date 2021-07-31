function[w_vector, acceptance_ratio]  = MH_sampling_func(mu, Sigma, dim, MCMC_steps)
%% Metropolis-Hatsings with mutivariate Gaussian distribution

% dim = 6; % Dimensions of the multivariate normal distribution.
% Sigma = diag(diag_elements); % covariance matrix.
sigma_factor = 0.2*10^3; % determines step size from mean in proposal
w_current = zeros();
for j = 1:1:dim   
    %initial vallues 
    w_current(j) = unifrnd(mu(j) - sigma_factor*Sigma(j,j),mu(j) + sigma_factor*Sigma(j,j));   
end

w_vector = zeros(MCMC_steps,dim);
w_vector(1,:) = w_current;
%%
accept_freq = 0;
for i = 1:1:MCMC_steps
    %%
    w_propose = zeros();
    for j = 1:1:dim    
        % proposal
        w_propose(j) = unifrnd(mu(j) - sigma_factor*Sigma(j,j),mu(j) + sigma_factor*Sigma(j,j));   
    end
    %%
    r =  mvnpdf(w_propose,mu',Sigma)./mvnpdf(w_current,mu',Sigma);
    
    P = min(1,r);
    u = rand(1);
    
    if u <= P    
        w_current = w_propose;
        accept_freq = accept_freq + 1; % frequency of acceptance  
    end
    
    w_vector(i+1,:) = w_current;
    
    
end

acceptance_ratio = accept_freq./MCMC_steps; % acceptance ratio. generally ~30% is a rule of thumb.

end
