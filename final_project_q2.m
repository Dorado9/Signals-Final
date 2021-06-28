load('LPF.mat');

%Part b section a
% we will use the fft and fftshift functions to calculate all the Transfer
% functions of hi
n = length(h2);
w = linspace(-pi,pi,n);
H2 = fftshift(fft(h2));
H3 = fftshift(fft(h3));
H4 = fftshift(fft(h4));
H6 = fftshift(fft(h6));

plot_a('h2', w, H2, '|H(e^{jw})|');
plot_a('h3', w, H3, '|H(e^{jw})|');
plot_a('h4', w, H4, '|H(e^{jw})|');
plot_a('h6', w, H6, '|H(e^{jw})|');

%part b question b 
n = -10000:10000-1;
len = length(n);
w = linspace(-pi,pi,len);
x = 2*cos(3*pi*n/10).*cos(pi*n/10);
X = fftshift(fft(x));
figure
plot(w,abs(X));
title('X');
xlabel('\omega [rad/samp]');
ylabel('|X(e^{jw})|');
 

%part b section d
%we used the n paramter of the fft function to make Hi the same size as X
%its just adding zeros to the original vector Hi we do it 
%so we could use element by element multiplication in matlab to find the
%output Yi
H2 = fftshift(fft(h2,len));
H3 = fftshift(fft(h3,len));
H4 = fftshift(fft(h4,len));
H6 = fftshift(fft(h6,len));
Y2 = X.*H2; 
Y3 = X.*H3;
Y4 = X.*H4;
Y6 = X.*H6;

plot_a('Y2', w, Y2, '|Y(e^{jw})|');
plot_a('Y3', w, Y3, '|Y(e^{jw})|');
plot_a('Y4', w, Y4, '|Y(e^{jw})|');
plot_a('Y6', w, Y6, '|Y(e^{jw})|');


%part b question e
%we awant to use idtft to get the signal back from the Transfer function
%of the output back into the original output , we will need to use first
%the ifftshift and then the ifft (reverse order then the orser we used to
%calculate the original Transfer function
y2 = ifft(ifftshift(Y2));
y3 = ifft(ifftshift(Y3));
y4 = ifft(ifftshift(Y4));
y6 = ifft(ifftshift(Y6));

figure
plot(n,y2);
hold on
plot(n,y3);
plot(n,y4);
plot(n,y6);
plot(n,x);
hold off
xlim([-15 15]);
ylim([-1.5 2.02])
title('y2 y3 y4 y6 as compared to x');
legend('y2','y3','y4','y6','x');
xlabel('n');
ylabel('y');

function plot_a(g_title, w, Y, ylab)
    figure
    plot(w,abs(Y));
    title(g_title);
    xlabel('\omega [rad/samp]');
    ylabel(ylab);
end