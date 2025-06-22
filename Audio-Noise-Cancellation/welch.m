function Px = welch(x,L,over,win)

%WELCH Welch's power spectral density estimate
%   Px = WELCH(x) computes power spectral density using the entire signal 
%   as a single segment (rectangular window)
%   Px = WELCH(x, L) specifies segment length L (default rectangular window)
%   Px = WELCH(x, L, over) specifies overlap ratio (0 <= over < 1)
%   Px = WELCH(x, L, over, win) specifies window function
%        win = 1 : Rectangular window (default)
%        win = vector: Custom window (length must equal L)
%
%   Input Arguments:
%       x   : Input signal vector
%       L   : Segment length (default = signal length)
%       over: Overlap ratio [0,1) (default = 0)
%       win : Window identifier or vector (default = rectangular)
%
%   Output Arguments:
%       Px  : Power spectral density estimate

if (nargin <= 3) win=1; end;
if (nargin <= 2) over=0; end;
if (nargin == 1) L=length(x); end
if (over >= 1) | (over < 0)  
   error('Overlap is invalid'), end
n1 = 1;
n2 = L;
n0 = (1-over)*L;
nsect=1+floor((length(x)-L)/(n0));
Px=0;
for i=1:nsect
    Px = Px + mper(x,win,n1,n2)/nsect;
    n1 = n1 + n0;  
    n2 = n2 + n0;
    end;




