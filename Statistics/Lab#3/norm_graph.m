clc;
clear;
pkg load statistics;

function norm_task()
  a = 1;
  sigma = 3;
  n = 100;
  
  x = [-8:0.1:10];
  y = normcdf(x, a, sigma);
 
  x_emp = sort(normrnd(a, sigma, 1, n));
  y_emp = [0: 1/n : 1-1/n];
  [xs, ys] = stairs(x_emp, y_emp);
  
  u = 1.36;
  right = max(0, ys - u / sqrt(n));
  left = min(1, ys + u / sqrt(n));
  
  plot(x, y, xs, ys, xs, left, xs, right), grid;
endfunction;

norm_task();