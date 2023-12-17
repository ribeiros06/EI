function [xe,xt, ye, yt, K, P,Pt] = NonStatKalman(sinais, sys, xp0, P0, noise)
A = sys.A;
B=sys.B;
C=sys.C;
D=sys.D;
S=noise.S;
Q=noise.Q;

u = sinais.u;
y = sinais.y;
R=noise.R;
n = length(A);
N = size(u,1);
xe = nan(n,N);
ell = size(C,1);
K = nan(n,ell,N);
Kf = nan(n,ell,N);
P = nan(n,n,N);
Pt = nan(n,n,N);
xe(:,1)= xp0;
P(:,:,1) = P0; %grau de confiança na estimativa inicial - P0 grande dá saltos maiores 
u = u';
y = y';
for t=1:(N)
        K(:,:,t)= (A*P(:,:,t)*C'+S)/(C*P(:,:,t)*C'+R);
        Kf(:,:,t) = (P(:,:,t)*C')/(C*P(:,:,t)*C'+R);
        if t<N
            xe(:,t+1) = A*xe(:,t)+B*u(:,t)+K(:,:,t)*(y(:,t)-C*xe(:,t)-D*u(:,t));
            P(:,:,t+1)=A*P(:,:,t)*A'+Q-K(:,:,t)*(A*P(:,:,t)*C'+S)';
            ye(:,t+1) = C*xe(:,t)+D*u(:,t);
        end
        xt(:,t) = xe(:,t) + Kf(:,:,t)*(y(:,t)-C*xe(:,t)-D*u(:,t));
        yt(:,t)=C*xt(:,t)+D*u(:,t);
        Pt(:,:,t)=P(:,:,t)-P(:,:,t)*C'/(C*P(:,:,t)*C'+noise.R)*C*P(:,:,t);
end

xe = xe';
xt = xt';
ye = ye';
yt = yt';

   
    
