function Px = mper(x,win,n1,n2)
%MPER Modified Periodogram Power Spectral Density Estimate
%   Px = MPER(x, win, n1, n2) computes windowed periodogram of signal segment
%
%   Inputs:
%       x    - Input signal vector
%       win  - Window type: 
%              1: Rectangular (default)
%              2: Hamming
%              3: Hanning
%              4: Bartlett
%              5: Blackman
%       n1   - Start index (default: 1)
%       n2   - End index (default: signal length)
%
%   Output:
%       Px   - Power spectral density estimate (1024-point FFT)

x   = x(:);
if nargin == 2
    n1 = 1;  n2 = length(x);  end;
N  = n2 - n1 +1;
w  = ones(N,1);
if (win == 2) w = hamming(N);
   elseif (win == 3) w = hanning(N);
   elseif (win == 4) w = bartlett(N);
   elseif (win == 5) w = blackman(N); 
   end;
U  = norm(w)^2/N;
xw = x(n1:n2).*w;
Px = abs(fft(xw,1024)).^2/(N*U);
Px(1)=Px(2);

