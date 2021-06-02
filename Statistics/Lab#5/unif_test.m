clc
clear
pkg load statistics

function unif_test(n, m, a, b)
  X = unifrnd(a - b / 2, a + b / 2, n, m);
  theory = sqrt([b^2 / (12 * n), b^2 / (4 * n), b^2 / (2 * n^2)]);
  practice = [std(mean(X)), std(median(X)), std((max(X) - min(X))/2)];
  printf("Равномерное распределение U(%d, %d):\n", a - b / 2, a + b / 2)
  printf("n = %g\tm = %g\n", n, m)
  printf("Теоретическое: \t%g\t%g\t%g\n", theory(1), theory(2), theory(3))
  printf("Практическое: \t%g\t%g\t%g\n", practice(1), practice(2), practice(3))
endfunction

unif_test(100, 100, 1, 3)
unif_test(10000, 100, 1, 3)