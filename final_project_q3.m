%Part c section a 
% as we did in part 2 we will use the fft and fftshift to  calculate all the Transfer
% functions of xi
t = -9000:9000-1;
x1 = sinc(t/6);
x2 = cos(pi/12*t)+sin(pi/6*t);
X1 = fftshift(fft(x1));
X2 = fftshift(fft(x2));
omega = linspace(-pi,pi,length(t));

figure
plot(omega,abs(X1));
title('X1');
xlabel('\Omega [rad/samp]');
ylabel('|X(j\Omega)|');
ylim([0 8]);

figure
plot(omega,abs(X2));
title('X2');
xlabel('\Omega [rad/samp]');
ylabel('|X(j\Omega)|');


%Part c section d
% we will pick Ts = 2, amd we will smaple the original signals every 2
% sec , and put it in our new discrete signals 
T = 2; 
n = -4500:4500-1;
w = linspace(-pi,pi,length(n));
x1_n = x_sample(T,x1,1,w,n);
x2_n = x_sample(T,x2,2,w,n);


%Part c section e 
x1_new = zeros(1,18000);
x2_new = zeros(1,18000);


%now we make all the LPF for the diffrent kinds of reconstructions 
h_r = sinc(t/T); % for the ideal 
h_0 = zeros(1,18000); %
h_0(1:T) = 1; %for the zoh
h_1 = tripuls(t,2*T); % for the foh

for i = 1 : 18000 % padding the xi sampled with zeros between two sample so we could get 
    %a vector of the same size of the original xi vector
    if (mod(i,T) == 0)
        x1_new(i) = x1_n(i/T);
        x2_new(i) = x2_n(i/T);
    end
end

plot_rec(x1, x2, x1_new, x2_new, h_r, h_0, h_1, t, T);


%Part c section F
%section D
T = 9; 
n = -1000:1000-1;
w = linspace(-pi,pi,length(n));
x1_n = x_sample(T,x1,1,w,n);
x2_n = x_sample(T,x2,2,w,n);

%section E
x1_new = zeros(1,18000);
x2_new = zeros(1,18000);

h_r = sinc(t/T); % for the ideal 
h_0 = zeros(1,18000);
h_0(1:T) = 1; %for the zoh
h_1 = tripuls(t,2*T); % for the foh

for i = 1 : 18000
    %a vector of the same size of the original xi vector
    if (mod(i,T) == 0)
        x1_new(i) = x1_n(i/T);
        x2_new(i) = x2_n(i/T);
    end
end

plot_rec(x1, x2, x1_new, x2_new, h_r, h_0, h_1, t, T);


% all the plots of the diffrent methods with the original signals
function plot_rec(x1, x2, x1_new, x2_new, h_r, h_0, h_1, t, T)
    %reconstructions with convolution and fft and ifft
    x_ideal_r_1 = conv(x1_new,h_r,'same');
    x_ideal_r_2 = conv(x2_new,h_r,'same');
    X1_zoh = fftshift(fft(x1_new)).*fftshift(fft(h_0));
    x1_zoh = ifft(ifftshift(X1_zoh));
    X2_zoh = fftshift(fft(x2_new)).*fftshift(fft(h_0));
    x2_zoh = ifft(ifftshift(X2_zoh));
    x1_foh = conv(x1_new,h_1,'same');
    x2_foh = conv(x2_new,h_1,'same');

    figure
    plot(t,x_ideal_r_1,"--",'LineWidth',2);
    hold on 
    plot(t,x1);
    hold off
    xlabel('t[sec]');
    legend('x ideal r 1','x1');
    ylabel('x');
    title("ideal reconstruction of the signal x1, T = " +T);
    xlim([-40 40]);

    figure
    plot(t,x_ideal_r_2,"--",'LineWidth',2);
    hold on
    plot(t,x2);
    hold off 
    xlabel('t[sec]');
    legend('x ideal r 2','x2');
    ylabel('x');
    title("ideal reconstruction of the signal x2, T = " +T);
    xlim([-40 40]);

    figure
    stairs(t,x1_zoh,"--",'LineWidth',2);
    hold on
    plot(t,x1);
    hold off
    xlabel('t[sec]');
    legend('x zoh 1','x1');
    ylabel('x');
    title("zoh reconstruction of the signal x1, T = " +T);
    xlim([-40 40]);

    figure
    stairs(t,x2_zoh,"--",'LineWidth',2);
    hold on
    plot(t,x2);
    hold off
    xlabel('t[sec]');
    legend('x zoh 2','x2');
    ylabel('x');
    title("zoh reconstruction of the signal x2, T = " +T);
    xlim([-40 40]);

    figure
    plot(t,x1_foh,"--",'LineWidth',2);
    hold on
    plot(t,x1);
    hold off
    xlabel('t[sec]');
    legend('x foh 1','x1');
    ylabel('x');
    title("foh reconstruction of the signal x1, T = " +T);
    xlim([-40 40]);

    figure
    plot(t,x2_foh,"--",'LineWidth',2);
    hold on
    plot(t,x2);
    hold off
    xlabel('t[sec]');
    legend('x foh 2','x2');
    ylabel('x');
    title("foh reconstruction of the signal x2, T = " +T);
    xlim([-40 40]);
end

function x_n = x_sample(T,x,y,w,n)
    x_n = zeros(1,length(n));
    for i = 1 : length(n)  % sampling the continues signal every T sec  
        x_n(i) = x(i*T);
    end
    X_n = fftshift(fft(x_n));
    figure
    plot(w,abs(X_n));
    title("X" +y +", T = " +T);
    xlabel('\Omega [rad/samp]');
    ylabel('|X(e^{jw})|');
    xlim([-4 4]);
end