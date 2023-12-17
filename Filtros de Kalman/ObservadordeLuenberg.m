function [xt, yt] = ObservadordeLuenberg(sinais, sys,xp0)
A = sys.A;
B=sys.B;
C=sys.C;
D=sys.D;

u = sinais.u;
y = sinais.y;
n = length(A);
N = size(u,1);
u = u';
y = y';
L = ganhoObservador(sys,[0.8;0.8]);
xt = nan(n,N);
xt(:,1) = xp0;
for t=1:(N)
    if t<N
        xt(:,t+1) = A*xt(:,t)+B*u(:,t)+L*(y(:,t)-C*xt(:,t)-D*u(:,t));
    end
    yt(:,t) = C*xt(:,t) + D*u(:,t);
end

yt = yt';
xt = xt';
   
    
