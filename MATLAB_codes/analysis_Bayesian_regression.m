%% plot Histograms of the coefficients.

NumBins = 200;
for i = 1:1:NumRegressors
    
    figure
    histogram(w_vector(1:end,i),NumBins)
    
end

%% plot Histograms  on the same graph

NumBins = 100;
figure
for i = 1:1:NumRegressors
    
    subplot(3,3,i)
    histogram(w_vector(1:end,i),NumBins)
    xlabel(['\beta_' num2str(i-1)])
end
hold off

%% Plot Monte Carlo trace plots of the co-efficients

figure
hold on
for i = 1:1:NumRegressors
    
    subplot(3,3,i)
    plot(w_vector(:,i))
    
    ylabel(['\beta_' num2str(i-1)])
    xlabel('t');
    xlim([0 10^4])
end
hold off


%% Autocorrelation on the coefficients

burn_in = round(0.1*size(w_vector,1));
Lags = (size(w_vector,1) - burn_in) - 1;
IAC = zeros();

figure
hold on
for i = 1:1:NumRegressors
   
    corr = autocorr(w_vector( (burn_in+1:end), i),Lags,[]); % magnetisation.
    [IAC(i)] = compute_IAC(corr);
    plot(corr,'Linewidth', 2)
    
end

xlim([0 100])
% set(gca,'Xscale','log')
disp(IAC)
legend('$\beta_0$','$\beta_1$','$\beta_2$','$\beta_3$','$\beta_4$','$\beta_5$','$\beta_6$','$\beta_7$','$\beta_8$','Interpreter','latex')
box on
set(gca,'Fontsize',20)
set(gca,'TicklabelInterpreter','latex')
xlabel('t','Interpreter','latex')
ylabel('autocorrelation','Interpreter','latex')
%% predict using training set

Y_predict = X_train*mode_w';

figure
scatter(Y_train,Y_predict,'fill')
set(gca,'Fontsize',20)
set(gca,'TicklabelInterpreter','latex')
xlabel('$Y_{train}$','Interpreter','latex')
ylabel('$Y_{predict}$','Interpreter','latex')


[R_squared_training] = calculateR2(Y_train,Y_predict);
disp(['Training set score:' num2str(R_squared_training)]);
box on
%% predict using test set

Y_predict = X_test*mode_w';

figure
scatter(Y_test,Y_predict,'fill')
set(gca,'Fontsize',20)
set(gca,'TicklabelInterpreter','latex')
xlabel('$Y_{test}$','Interpreter','latex')
ylabel('$Y_{predict}$','Interpreter','latex')

[R_squared_test] = calculateR2(Y_test,Y_predict);
disp(['Training set score:' num2str(R_squared_test)]);