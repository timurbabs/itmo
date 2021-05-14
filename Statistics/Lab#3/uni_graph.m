clc;
clear;
pkg load statistics;

function uni_task()
  a = 1;
  b = 3;
  n = 100;
  
  x = [1:0.01:3];
  y = unifcdf(x, a, b);
 
  x_emp = sort(unifrnd(a, b, n, 1));
  y_emp = [0: 1/n : 1-1/n];
  [xs, ys] = stairs(x_emp, y_emp);
  
  u = 1.36;
  right = max(0, ys - u / sqrt(n));
  left = min(1, ys + u / sqrt(n));
  
  plot(x, y, xs, ys, xs, left, xs, right), grid;
endfunction;

uni_task();