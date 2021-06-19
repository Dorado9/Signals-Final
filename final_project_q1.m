
% part a qustion d 
sympref('HeavisideAtOrigin',1);
n = -10:1:10;
u_n = heaviside(n);
u_n_2 = heaviside(n - 2);
h_n = (1/2).^(n).*u_n + (3/4).^(n).*u_n_2;
figure(1);
stem(n,h_n);
ylim([0 1.1]);
title("The Pulse Response of the LTI System");

% part a qustion e 
syms h(n) H(z)  ;
u_n = heaviside(n);
u_n_2 = heaviside(n-2);
h(n) = ((1/2)^n)*u_n + ((3/4)^n)*u_n_2 ;
z_trans = ztrans(h(n));
H(z) =  z_trans;
disp(H(z));


%part a qustion f 
%we can find the zeros and poles of H(z) with finding the roots of the
%numerator and denominator
%and with the function zplan we will plot the zeros and poles into the unite circle
syms z
eqn_z = 32*z^3 - 24*(z^2)+18*z-9 ; % numerator polynomial that we got from qeustion 1e
eqn_p = 4*z*((2*z-1)*(4*z-3)) ;% denominator polynomial that we got from qeustion 1e
z = roots([32 -24 18 -9]);% calculates the roots of the numerator
p = roots([32 -40 12 0]); %calculates the roots of the denominator
figure(2)
zplane(z,p);
legend('zeros' ,'poles')
title('zeros and poles map');
grid


