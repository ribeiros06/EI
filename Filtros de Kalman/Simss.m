function [y,x] = Simss(sys,u,x0,q,r)
    A = sys.A;
    B = sys.B;
    C = sys.C;
    D = sys.D;
    N = size(u,1);
    n = length(A);
    x = nan(n,N);
    u = u';
    q=q';
    r=r';
    x(:,1)=x0;
    for t=1:N-1
        x(:,t+1)= A*x(:,t)+B*u(:,t)+q(:,t);
    end
    y = C*x + D*u + r;
    x=x';
    y=y';
