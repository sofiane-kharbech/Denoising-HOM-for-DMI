
function hos=f_CalcHOS(x,Pb)

x=x-mean(x);

%--------------------------> Moments <--------------------------%

m20=real(mean(x.^2));
m22=real(mean(conj(x).^2));
m40=real(mean(x.^4));
m60=real(mean(x.^6));

m21y=real(mean(x.*(conj(x))));
m41y=real(mean((x.^3).*(conj(x))));
m42y=real(mean((x.^2).*(conj(x).^2)));
m43y=real(mean(x.*(conj(x).^3)));
m61y=real(mean((x.^5).*(conj(x))));
m62y=real(mean((x.^4).*(conj(x).^2)));
m63y=real(mean((x.^3).*(conj(x).^3)));
m84y=real(mean((x.^4).*(conj(x).^4)));

% denoising
m21=m21y-Pb;
m41=m41y-3*m20*Pb;
m42=m42y-2*Pb^2-4*Pb*m21;
m43=m43y-3*m22*Pb;
m61=m61y-5*m40*Pb;
m62=m62y-12*m20*Pb^2-8*m41*Pb;
m63=m63y-18*m21*Pb^2-9*m42*Pb-6*Pb^3;
m84=m84y-16*m63*Pb-72*m42*Pb^2-96*m21*Pb^3-24*Pb^4;

%--------------------------> Cumulants <--------------------------%

c40=m40-3*(m20.^2);
c60=m60-15*m20*m40+30*(m20.^3);

% denoising
c41=m41-3*m20*m21;
c42=m42-(abs(m20).^2)-2*(m21.^2);
c61=m61-5*m21*m40-10*m20*m41+30*m21*(m20.^2);
c62=m62-6*m42*m20-8*m21*m41-m22*m40+6*m22*m20^2+24*m20*m21^2;
c63=m63-9*m42*m21+12*(m21.^3)-3*m20*m43-3*m22*m41+18*m20*m21*m22;

%--------------------------> Normalization <--------------------------%

m40_n=m40/m21^2;
m41_n=m41/m21^2;
m42_n=m42/m21^2;
m60_n=m60/m21^3;
m61_n=m61/m21^3;
m62_n=m62/m21^3;
m63_n=m63/m21^3;
m84_n=m84/m21^4;

c40_n=c40/m21^2;
c41_n=c41/m21^2;
c42_n=c42/m21^2;
c60_n=c60/m21^3;
c61_n=c61/m21^3;
c62_n=c62/m21^3;
c63_n=c63/m21^3;

m41y_n=m41y/m21y^2;
m42y_n=m42y/m21y^2;
m61y_n=m61y/m21y^3;
m62y_n=m62y/m21y^3;
m63y_n=m63y/m21y^3;
m84y_n=m84y/m21y^4;

hos=real([m40_n m41_n m41y_n m42_n m42y_n m60_n m61_n m61y_n m62_n m62y_n m63_n m63y_n m84_n m84y_n ...
          c40_n c41_n c42_n c60_n c61_n c62_n c63_n]);
