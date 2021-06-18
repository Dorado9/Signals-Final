load('LPF.mat');

%Part b question a
n = length(h2);
w = linspace(-pi,pi,n);
H2 = fftshift(fft(h2));
H3 = fftshift(fft(h3));
H4 = fftshift(fft(h4));
H6 = fftshift(fft(h6));


figure
plot(w,abs(H2));
title('h2');
xlabel('w [rad/sec]');
ylabel('|H(e^{jw})|');

figure
plot(w,abs(H3));
title('h3');
xlabel('w [rad/sec]');
ylabel('|H(e^{jw})|');

figure
plot(w,abs(H4));
title('h4');
xlabel('w [rad/sec]');
ylabel('|H(e^{jw})|');

figure
plot(w,abs(H6));
title('h6');
xlabel('w [rad/sec]');
ylabel('|H(e^{jw})|');

%part b question b 
n = -10000:10000-1;
len = length(n);
w = linspace(-pi,pi,len);
x = 2.*cos(3*pi.*n./10).*cos(pi.*n./10);
X = fftshift(fft(x));
figure
plot(w,abs(X));
title('X');
xlabel('w [rad/sec]');
ylabel('|X(e^{jw})|');
 

%part b question d
%we used the n paramter of the fft function to make Hi the same size as X
%its just adding zeros to the original vector Hi we do it 
%so we could use element by element multiplication in matlab to find the
%output Yi
H2 = fftshift(fft(h2,len));
H3 = fftshift(fft(h3,len));
H4 = fftshift(fft(h4,len));
H6 = fftshift(fft(h6,len));
Y2 = abs(X).*H2; 
Y3 = abs(X).*H3;
Y4 = abs(X).*H4;
Y6 = abs(X).*H6;

figure
plot(w,abs(Y2));
title('Y2');
xlabel('w [rad/sec]');
ylabel('|Y(e^{jw})|');

figure
plot(w,abs(Y3));
title('Y3');
xlabel('w [rad/sec]');
ylabel('|Y(e^{jw})|');

figure
plot(w,abs(Y4));
title('Y4');
xlabel('w [rad/sec]');
ylabel('|Y(e^{jw})|');


figure
plot(w,abs(Y6));
title('Y6');
xlabel('w [rad/sec]');
ylabel('|Y(e^{jw})|');


%part b question e
y2 =ifft(ifftshift(Y2));
y3 = ifft(ifftshift(Y3));
y4 = ifft(ifftshift(Y4));
y6 = ifft(ifftshift(Y6));


figure
plot(n(1:100),y2(1:100));
hold on 
plot(n,x);
hold off 
title('y2');
xlabel('n');
ylabel('|Y(e^{jw})|');
% 
% figure
% plot(n,y3);
% title('y3');
% xlabel('n');
% ylabel('|Y(e^{jw})|');
% 
% figure
% plot(n,y4);
% title('y4');
% xlabel('n');
% ylabel('');
% 
% 
% figure
% plot(n,y6);
% title('y6');
% xlabel('n');
% ylabel('|Y(e^{jw})|');





