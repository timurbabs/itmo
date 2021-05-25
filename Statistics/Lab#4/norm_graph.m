clc;
clear;
pkg load statistics;

function norm_task()
  a = 1;
  sigma = 3;
  n = 10^6;
  m = 100;
  
  x = [-8:0.1:10];
  y = normpdf(x, a, sigma);

  X = normrnd(a, sigma, 1, n);
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

norm_task();