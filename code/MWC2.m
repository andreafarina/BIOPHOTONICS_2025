% Multiply With Carry




close all;
clear all;
N=90000;
Z=zeros(1,N);
Z(1)=3;
%======= PROVARE CON a=2^16+1 e 2^16+3 =====================
%        | a | c | M |
%        | 2^16+1 0 2^11 --> muovere lentamente il volume (piani)
%        | 2^16+3 0 2^11 --> idem
%        | 65539 0 2^11  --> idem
%        | 65539 1 2^31  --> piani evidenti
%        | 4294967118 1 2^11 --> ok


a=2^16 + 1;   %1229;%65539;%2^16+3;
c=1;            %1;%13%0;
M=2^11;         %2^11;%1024%2^31;%2^31;%2^11;%2^31;

% ========= PRNG ============================================
for i=1:(N-1)
    Z(i+1)=mod((a*Z(i)+c),M);
    c=floor((a*Z(i)+c)./M);
end

% ===========================================================
X=Z./M;
%X=Z;
subplot(1,2,1)
plot(X(1:(N-1)),X(2:N),'.','MarkerSize',6),grid,
xlabel('X_k','FontSize',14)
ylabel('X_{k+1}','FontSize',14)
title('(X_k, X_{k+1}) correlation','FontSize',18)
subplot(1,2,2)
A=X(1:(N-2));
B=X(2:N-1);
C=X(3:N);
plot3(A,B,C,'.','MarkerSize',6),grid
xlabel('X_k','FontSize',14)
ylabel('X_{k+1}','FontSize',14)
zlabel('X_{k+2}','FontSize',14)

title('(X_k, X_{k+1}, X_{k+2}) correlation','FontSize',18)
% figure
% G=reshape(X,3,N/3);
% G=G';
% plot3(G(:,1),G(:,2),G(:,3),'.')
