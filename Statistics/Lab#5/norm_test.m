clc
clear
pkg load statistics

function norm_test(n, m, a, sigma)
  Xtemp = normrnd(a, sigma, n, m);
  theory = sqrt([sigma^2 / n, pi * sigma^2 / (2 * n), 0.4 * sigma^2 / log(n)]);
  practice = [std(mean(X)), std(median(X)), std((max(X) - min(X)) / 2)];
  printf("Нормальное распределение N(%g, %g):\n", a, sigma)
  printf("n = %g\tm = %g\n", n, m)
  printf("Теоретическое: \t%g\t%g\t%g\n", theory(1), theory(2), theory(3))
  printf("Практическое: \t%g\t%g\t%g\n", practice(1), practice(2), practice(3))
endfunction

norm_test(100, 100, 1, 3)
norm_test(100, 10000, 1, 3)
