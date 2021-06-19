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
w = linspace(-pi,pi,length(n));
x1_n = x_sample(T,x1,1,w);
x2_n = x_sample(T,x2,2,w);


%Part c question e 
Omega = w/T ;
x1_new = zeros(1,20000);
x2_new = zeros(1,20000);
x1_foh = zeros(1,20000);
x2_foh = zeros(1,20000);
h_r = sinc(t/T);
h_0 = zeros(1,20000);
h_0(1:T+1) = 1;


for i = 1 : 20000 
    if (mod(i,T) == 0)
        x1_new(i) = x1_n(i/T);
        x2_new(i) = x2_n(i/T);
    end
end
x_ideal_r_1 = conv(x1_new,h_r,'same');
x_ideal_r_2 = conv(x2_new,h_r,'same'); 
x1_zoh = conv(x1_new,h_0,'same');
x2_zoh = conv(x2_new,h_0,'same');
figure
% stairs(t,x_ideal_r_1);
% hold on 
% plot(t,x_ideal_r_2);
stairs(t,x1_zoh);
hold on
plot(t,x2_zoh);
% stairs(t,x1);
% plot(t,x2);
hold off 
xlabel('t[sec]');
% legend('x ideal r 1','x ideal r 2','x1 zoh','x2 zoh','x1','x2');
ylabel('x');
title("reconstructions of the signals x1 and x2");
ylim([-5*10^-5 5*10^-4])
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
end

