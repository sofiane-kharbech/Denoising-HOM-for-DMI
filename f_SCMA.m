
function [G,yeg]=f_SCMA(Nt,Nr,y_mimo_SNR,R)

%----------------------------------> Pre-processing: batch whitening

Ry = (y_mimo_SNR*y_mimo_SNR')/size(y_mimo_SNR,2);

[U,SIG] = eig(Ry);                          % Eigendecomposition
SIG = SIG(Nr:-1:(Nr-Nt+1),Nr:-1:(Nr-Nt+1)); % Required condition: Nr>=Nt
U = U(:,Nr:-1:(Nr-Nt+1));

B = (SIG^-0.5)*U'; % Whitening matrix
YW = B*y_mimo_SNR; % Whited signals

%----------------------------------> Estimating the separator W    

W = eye(Nt);                       % Initialization
% W = toeplitz(1:Nt);
% W = toeplitz(1:Nr,1:Nt);

mu=1e-2;                           % Step size
% mu=5e-3;

for ns=1:size(YW,2)                % Stochastic gradient descent (SGD)

    YW_ns = YW(:,ns);
    z_ns = W.'*YW_ns;
    
    for n=1:Nt
 
        e = (real(z_ns(n)).^2-R).*real(z_ns(n));
        W(:,n) = W(:,n)-mu.*e.*conj(YW_ns);
        
    end
    
    W = f_GramSchmidt(W); % Post-processing: orthonormalization
    
end


%----------------------------------> Applying BSS

yeg = W.'*YW;
G = B.'*W;



function Q = f_GramSchmidt(W)

Q = zeros(size(W));

Q(:,1) = W(:,1)/norm(W(:,1));

for i=2:size(W,2)
   
    s_proj = 0;
    for j=1:i-1
        s_proj = s_proj+((Q(:,j)'*W(:,i))/(Q(:,j)'*Q(:,j)))*Q(:,j);
    end
    
    e = W(:,i)-s_proj;
    Q(:,i) = e/norm(e);
end