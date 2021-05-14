clc;
clear;
pkg load statistics;

function [norm_statistics] = norm_statistics(n, a, sigma, offset)
  i = 1 : n;
  FX = (normcdf(sort(normrnd(a, sigma, n, 1)), a + offset, sigma))';
  dn = sqrt(n) * max (max(abs(FX(i) - i / n)), max(abs(FX(i) - (i - 1) / n)));
  wn = 1 / (12 * n) + sum((FX(i) - (2 * i - 1) / (2 * n)).^2);
  
  norm_statistics = [dn, wn];
endfunction

function [uni_statistics] = uni_statistics(n, a, b, offset)
  i = 1 : n;
  FX = (unifcdf(sort(unifrnd(a, b, n, 1)), a + offset, b))';
  dn = sqrt(n) * max (max(abs(FX(i) - i / n)), max(abs(FX(i) - (i - 1) / n)));
  wn = 1 / (12 * n) + sum((FX(i) - (2 * i - 1) / (2 * n)).^2);
   
  uni_statistics = [dn, wn];
endfunction

function check()
  n_check_1 = 10^4;
  n_check_2 = 10^6;
  
  a = 1;
  sigma = 3;  
  printf("Нормальное распределение:\nПри n = %d\nKalmagorov = %g\nSmirnov = %g\n", n_check_1, norm_statistics(n_check_1, a, sigma, 0));
  printf("Нормальное распределение:\nПри n = %d\nKalmagorov = %g\nSmirnov = %g\n\n", n_check_2, norm_statistics(n_check_2, a, sigma, 0));

  
  a = 1;
  b = 3;
  printf("Равномерное распределение:\nПри n = %d\nKalmagorov = %g\nSmirnov = %g\n", n_check_1, uni_statistics(n_check_1, a, b, 0));
  printf("Равномерное распределение:\nПри n = %d\nKalmagorov = %g\nSmirnov = %g\n\n", n_check_2, uni_statistics(n_check_2, a, b, 0));

endfunction;

check();