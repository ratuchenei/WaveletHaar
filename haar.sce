clear 
clc


//-- Setup do sinal original ---------------------------------------------------

N = 1024;
x = linspace(0, 1, N);
a(:,1) = 20*(x.^2).*(1-x).^4.*cos(12*%pi*x);

//a(:,1) = [60,40,8,24,48,58,40,16,30,15,29,16,28,17,25,18];
//N = length(a)
//x = linspace(0, 1, N);

nivel = log2(N);



//-- Plot sinal original -------------------------------------------------------

scf(1); 
subplot(3, 1, 1); 
plot(x, a(:, 1), 'r-');
xlabel('g(x)'); 
ylabel('x'); 
legend('Sinal1 Original');

//-- Compressão nível n --------------------------------------------------------

for n = 1 : nivel
    for m = 1 : N/2^n 
        a(m,n+1)=(a(2*m-1, n)+a(2*m, n))/sqrt(2);
        d(m,n+1)=(a(2*m-1, n)-a(2*m, n))/sqrt(2);
    end    
end


//-- Plot nivel n --------------------------------------------------------------

s = cat(1, a(1:N/2^nivel, nivel+1), d(1:N/2^nivel, nivel+1), a(N/2^(nivel-1)+1:N, nivel+1));

subplot(3, 1, 2);
plot(x, s, 'r-');
xlabel(strcat(['a^', string(nivel) ,'(x) . d^', string(nivel), '(x)']));
ylabel('x'); 
legend(strcat(['Nível', ' ', string(nivel)]));


//-- Descompressão nível n -----------------------------------------------------

a_c(1, nivel+1) = a(1, nivel+1);

for n = nivel: -1 : 1
    for m = 1 : N/2^n
        a_c(2*m-1, n) = (a_c(m, n+1)+d(m, n+1))/sqrt(2);
        a_c(2*m, n) = (a_c(m, n+1)-d(m, n+1))/sqrt(2);
    end;
end


//-- Plot sinal reconstruído ---------------------------------------------------

subplot(3, 1, 3);
plot(x, a_c(:, 1), 'b-');
xlabel('g_r (x)');
ylabel('x'); 
legend('Sinal reconstruído');


