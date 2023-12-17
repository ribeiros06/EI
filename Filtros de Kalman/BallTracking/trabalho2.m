[xpos,ypos,radius]=BallTrajectory;

xdif = diff(xpos);

R = - mean(xdif(2:end).*xdif(1:end-1));

if R<0
    R=0;
end

Q = mean(xdif.^2) + 2*R;

%%

LIMIAR=2;
y_dif_2 = diff(diff(ypos));
figure()
plot(y_dif_2)
y_dif_2=find(y_dif_2>LIMIAR);

gT = mean(y_dif_2);
R = -0.25 * mean((y_dif_2(2:end)-mean(y_dif_2)).*(y_dif_2(1:end-1)-mean(y_dif_2)));

if R<0
    R=10;
end
Q1 = mean((y_dif_2-mean(y_dif_2)).^2) - 6*R;
Q = [0 0; 0 Q1];
S = [0; 0];

A = [1 1; 0 1];
B = [0; gT];
C = [1 0];
D = [0];
sys = idss(A,B,C,D);
N = length(ypos);
sinais.u = ones(N,1);
sinais.y = ypos';
noise.S = [0;0];
noise.Q = Q;
noise.R = R;
x0=[ypos(1); ypos(2)-ypos(1)];
P0 = [0.01 0; 0 Q1];
[xe,xt, ye, yt, K, P,Pt] = NonStatKalman(sinais,sys,x0,P0,noise);
yfa = xt(:,1);
ypa=xe(:,1);



