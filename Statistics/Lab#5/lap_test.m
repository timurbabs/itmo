clc
clear
pkg load statistics

function lap_test(n, m, a, u)
  X = a + exprnd(u, n, m) - exprnd(u,n,m);
  theory = sqrt([2 * u^2 / n, u^2 / n, 0.9 * u^2]);
  practice = [std(mean(X)), std(median(X)), std((max(X) - min(X)) / 2)];
  printf("Распределение лапласа L(%g, %g):\n", a, u)
  printf("n = %g\tm = %g\n", n, m)
  printf("Теоретическое: \t%g\t%g\t%g\n", theory(1), theory(2), theory(3))
  printf("Практическое: \t%g\t%g\t%g\n", practice(1), practice(2), practice(3))
endfunction

lap_test(100, 100, 1, 3)
lap_test(10000, 100, 1, 3)