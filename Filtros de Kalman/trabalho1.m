data = importfile("T1-Dados.mat");

sys = idss(data.A,data.B,data.C,data.D);
N = 1000;
u = idinput(N, "rbs");
q = zeros(N,length(A));
q(:,2) = randn(N,1)*sqrt(data.Q(2,2));
r = randn(N,size(data.C,1)).*sqrt(data.R);
x0=[-500;100];

[y,x] = Simss(sys,u,x0,q,r);

sinais=iddata(y,u);
noise.S = [0;0];
noise.Q = data.Q;
noise.R = data.R;
n = length(A);
P0 = 100*eye(n); %grau de confiança na estimativa inicial - P0 grande dá saltos maiores 

[xe,xt, ye, yt, K, P,Pt] = NonStatKalman(sinais,sys,x0*0,P0,noise);

[xt_2,yt_2] = ObservadordeLuenberg(sinais,sys,x0*0);