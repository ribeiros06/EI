function L = ganhoObservador(sys,Lambda)

% Calcula o ganho do observador de Lueberger
%  x_e(t+1)=Ax_e(t)+Bu(t)+L(y(t)-Cx_e(t)-Du(t))
%
% do sistema
%    x(t+1)=Ax(t)+Bu(t)
%    y(t==Cx(t)+Du(t)
%
% Entradas:
%    sys - objeto idss com o sistema
%    Lambda=vetor com os valores próprios do observador

A=sys.A;
C=sys.C;
ell=size(C,1);
n=length(A);
carPoli=1;
for i=1:n
    carPoli=conv(carPoli,[1 -Lambda(i)]);
end
Aob=[zeros(1,n-1) -carPoli(end); eye(n-1) -carPoli(end-1:-1:2)'];
Lo=rand(n,ell);
T=nan(n,n);
T(:)=(kron(A',eye(n))-kron(eye(n),Aob))\kron(C',eye(n))*Lo(:);
%T=sylvester(-Aob,A,Lo*C);
L=T\Lo;
