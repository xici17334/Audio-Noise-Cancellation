function [noise_est, target_est, w] = nlms_noise_cancel(x, v, order, beta)

% NLMS Adaptive Noise Cancellation
% Inputs:
%   x      - Noisy signal (primary input)
%   v      - Reference noise signal(s)
%   order  - Filter order
%   beta   - Step size parameter (0 < beta < 1)
%
% Outputs:
%   noise_est  - Estimated noise component
%   target_est - Denoised target signal
%   w          - Final filter coefficients
%
% Algorithm: Normalized Least Mean Squares (NLMS) adaptive filtering

[N, M] = size(v);           
x = x(:);                  

w = zeros(order * M, 1);    
noise_est = zeros(N, 1);    
target_est = zeros(N, 1);   

for n = order:N

    X = [];
    for m = 1:M
        X = [X; v(n:-1:n-order+1, m)];
    end

    noise_est(n) = w' * X;
    target_est(n) = x(n) - noise_est(n);

    power = X' * X;    %x^2
    if power > 0
        mu = beta / (2 * power); 
        w = w + mu * target_est(n) * X;  %w(n+1)=w(n)+uex(n)
    end
end
end
