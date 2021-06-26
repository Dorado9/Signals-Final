%Part c question a 
% as we did in part 2 we will use the fft and fftshift to  calculate all the Transfer
% functions of xi
t = -10000:10000-1;
x1 = sinc(t/6);
x2 = cos(pi/12*t)+sin(pi/6*t);
X1 = fftshift(fft(x1));
X2 = fftshift(fft(x2));
omega = linspace(-pi,pi,length(t));


figure
plot(omega,abs(X1));
title('X1');
xlabel('\Omega [rad/sec]');
ylabel('| X(j\Omega) |');
ylim([0 8]);

figure
plot(omega,abs(X2));
title('X2');
xlabel('\Omega [rad/sec]');
ylabel('| X(j\Omega) |');

%Part c question d
% we will pick Ts = 2 , amd we will smaple the original signals every 2
% sec , and put it in our new discrete signals 
T = 2 ; 
n = -5000:5000 -1;
w = linspace(-pi,pi,length(n));
x1_n = x_sample(T,x1,1,w);
x2_n = x_sample(T,x2,2,w);





%Part c question e 
x1_new = zeros(1,20000);
x2_new = zeros(1,20000);


%now we make all the LPF for the diffrent kinds of reconstructions 
h_r = sinc(t/T); % for the ideal 
h_0 = zeros(1,20000); %
h_0(1:T) = 1; %for the zoh
h_1 = tripuls(t,2*T); % for the foh



for i = 1 : 20000 % padding the xi sampled with zeros between two sample so we could get 
    %a vector of the same size of the original xi vector
    if (mod(i,T) == 0)
        x1_new(i) = x1_n(i/T);
        x2_new(i) = x2_n(i/T);
    end
end

%reconstructions with convolution and fft and ifft

x_ideal_r_1 = conv(x1_new,h_r,'same');
x_ideal_r_2 = conv(x2_new,h_r,'same'); 
X1_zoh = fftshift(fft(x1_new)).* fftshift(fft(h_0));
x1_zoh = ifft(ifftshift(X1_zoh));
X2_zoh = fftshift(fft(x2_new)).* fftshift(fft(h_0));
x2_zoh = ifft(ifftshift(X2_zoh));
x1_foh = conv(x1_new,h_1,'same'); 
x2_foh = conv(x2_new,h_1,'same'); 

% all the plots of the diffrent mathods with the original signals
figure
plot(t,x_ideal_r_1,"--",'LineWidth',2);
hold on 
plot(t,x1);
hold off
xlabel('t[sec]');
legend('x ideal r 1','x1');
ylabel('x');
title("ideal reconstruction of the signal x1");
xlim([-40 40]);


figure
plot(t,x_ideal_r_2,"--",'LineWidth',2);
hold on
plot(t,x2);
hold off 
xlabel('t[sec]');
legend('x ideal r 2','x2');
ylabel('x');
title("ideal reconstruction of the signal x2");
xlim([-40 40]);


figure
stairs(t,x1_zoh,"--",'LineWidth',2);
hold on
plot(t,x1);
hold off
xlabel('t[sec]');
legend('x zoh 1','x1');
ylabel('x');
title("zoh reconstruction of the signal x1");
xlim([-40 40]);


figure
stairs(t,x2_zoh,"--",'LineWidth',2);
hold on
plot(t,x2);
hold off
xlabel('t[sec]');
legend('x zoh 2','x2');
ylabel('x');
title("zoh reconstruction of the signal x2");
xlim([-40 40]);

figure
plot(t,x1_foh,"--",'LineWidth',2);
hold on
plot(t,x1);
hold off
xlabel('t[sec]');
legend('x foh 1','x1');
ylabel('x');
title("foh reconstruction of the signal x1");
xlim([-40 40]);

figure
plot(t,x2_foh,"--",'LineWidth',2);
hold on
plot(t,x2);
hold off
xlabel('t[sec]');
legend('x foh 2','x2');
ylabel('x');
title("foh reconstruction of the signal x2");
xlim([-40 40]);


function x_n = x_sample(T,x,y,w)
    x_n = zeros(1,10000);
    for i = 1 : 10000 % sampling the continues signal every T sec  
        x_n(i) = x(i*T);
    end
    X_n = fftshift(fft(x_n));
    figure
    plot(w,abs(X_n));
    title("X" +y);
    xlabel('\Omega [rad/sec]');
    ylabel('| X(e^{jw}) |');
    xlim([-4 4]);
end




