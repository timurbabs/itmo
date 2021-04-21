pkg load statistics;
clear;
clc;

function calculate(n)
  y = 0.95;
  c = 1.4;
  a = 3;
  
  X = rand(n, 6);
  f = X.^a;
  FX = sum(f');
  V = mean(FX <= c);
  T = norminv((y + 1)/2);
  D = T * sqrt(V * (1 - V) / n);
  
  printf ("Значение 'N' = %d\n", n);
  printf ("Значение 'V' = %g\n", V);
  printf ("Интервал [%g, %g]\n", [V - D, V + D]);
  printf ("Длина доверительного интервала = %g \n", (V + D) - (V - D));
  printf ("Дельта 'D' = %g\n\n", D);
endfunction