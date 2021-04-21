pkg load statistics;
clc;

function calculate_a(n)
  right = 5;
  left = 2;
  y = 0.95;
  
  T = norminv((1 + y) / 2);
  X = unifrnd(left, right, 1, n);
  F_x = log(X.^2 + 1) * (right - left);
  V = mean(F_x);
  D = std(F_x) * T / sqrt(n);
  
  printf("Значение 'N' = %d\n", n);
  printf("Значение 'V' = %g\n", V);
  printf("Дельта 'D' = %g\n", D);
  printf("Интервал = [%g, %g]\n", [V - D, V + D]);
  printf("Длина интервала = %g\n", (V + D) - (V - D));
  printf("Истинное значение = %g\n", quad('log(1 + x^2)', 2, 5));
endfunction
  