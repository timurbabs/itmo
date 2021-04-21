pkg load statistics;
clc;

function calculate_b(n)
  right = sqrt(2);
  left = -3;
  y = 0.95;
  
  T = norminv((1 + y) / 2);
  X = normrnd(left, right, 1, n);
  F_x = 2 * sqrt(pi) * cos(X);
  V = mean(F_x);
  D = std(F_x) * T / sqrt(n);
  
  printf("Значение 'N' = %d\n", n);
  printf("Значение 'V' = %g\n", V);
  printf("Дельта 'D' = %g\n", D);
  printf("Интервал = [%g, %g]\n", [V - D, V + D]);
  printf("Длина интервала = %g\n", (V + D) - (V - D));
  printf("Истинное значение = %g\n", quad('cos(x) * exp((-(x+3)^2) / 4)', -inf, inf));
endfunction
