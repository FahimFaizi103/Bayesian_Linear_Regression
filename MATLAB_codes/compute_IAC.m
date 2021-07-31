function[IAC] = compute_IAC(corr)

R = find(corr < 0, 1); % find the index of the first negative autocorrelation.

if isempty(R) % if the autocorrelation is not negative
    R = find(corr == min(corr)); % find the minimum (positive) autocorrelation value.
    
    Sum_corr = sum(corr(1:R)); % take the sum of autocorrelation up to this minimum (positive) value.
else
    
    Sum_corr = sum(corr(1:R-1)); % take the sum up to the minium (positive) value.
end



IAC = 1 + 2.*Sum_corr; % definiton of integrated autocorrelation.


end