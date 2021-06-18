% part a qustion d 
sympref('HeavisideAtOrigin',1);
n = -10:1:10;
u_n = heaviside(n);
u_n_2 = heaviside(n - 2);
h_n = (1/2).^(n).*u_n + (3/4).^(n).*u_n_2;
figure(1);
stem(n,h_n);
title("The Pulse Response of the LTI System");

% part a qustion e 
syms h(n) H(z) x y  ;
u_n = heaviside(n);
u_n_2 = heaviside(n-2);
h(n) = ((1/2)^n)*u_n + ((3/4)^n)*u_n_2 ;
z_trans = ztrans(h(n));
H(z) =  z_trans;
disp(H(z));


%part a qustion f 
%we can find the zeros and poles from the H_z we found in the last qustion
%and with the function zplan we will plost the into the unite circle 
H_p_z;
pzmap(H_p_z)
r = roots(H(z));


