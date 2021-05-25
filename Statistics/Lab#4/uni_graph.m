clc;
clear;
pkg load statistics;

function uni_task()
  a = 1;
  b = 3;
  n = 10^4;
  m = 100;
  
  x = [1-0.5:0.01:3+0.5];
  y = unifpdf(x, a, b);

  X = unifrnd(a, b, 1, n);
  h = (max(X) - min(X)) / m;     
  F_n = hist(X, m) / 1;
  F_x = min(X):h:max(X) - h; 
  F_y = F_n / h / n;
  
  [a,b] = bar(F_x, F_y);
  for i = 1:2
    subplot(2,2, i);
    plot(x, y, a, b), grid;
    [a, b] = stairs(F_x, F_y);
  endfor
endfunction;

uni_task();