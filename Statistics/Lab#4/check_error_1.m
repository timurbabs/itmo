clc;
clear;
pkg load statistics;

function check_error_1(gamma, n, n_exp)
  a = 1;
  b = 3;
  
  uni_count = 0;
  norm_count = 0;
  quantile = 0;
  
  if (gamma == 0.95)
    quantile = chi2inv(0.95, ceil(n^(1/3)) - 3);
  elseif (gamma == 0.9)
    quantile = chi2inv(0.9, ceil(n^(1/3)) - 3);
  elseif (gamma == 0.99)
    quantile = chi2inv(0.99, ceil(n^(1/3)) - 3);
  endif
  
  for (i = 1:n_exp)
    res_uni = uni_statistics(n, a, b, 0);    
    if(res_uni >= quantile)
      uni_count += 1;
    endif
    
    res_norm = norm_statistics(n, a, b, 0);
    if(res_norm >= quantile)
      norm_count += 1;
    endif
  endfor
  
  printf("Равномерное распределение.\nОбъём выборки: %g\nКоличество опытов: %g\nКоличество степеней свободы: %g\nУровень значимости: %g\nКвантиль: %g\nВероятность ошибки 1 рода: %g\n<---------------------------------->\n", n, n_exp, ceil(n^(1/3)) - 3, gamma, quantile, uni_count / n_exp);
  printf("Нормальное распределение.\nОбъём выборки: %g\nКоличество опытов: %g\nКоличество степеней свободы: %g\nУровень значимости: %g\nКвантиль: %g\nВероятность ошибки 1 рода: %g\n<---------------------------------->\n", n, n_exp, ceil(n^(1/3)) - 3, gamma, quantile, norm_count / n_exp);
endfunction

check_error_1(0.90, 10^4, 100)
check_error_1(0.95, 10^4, 100)
check_error_1(0.99, 10^4, 100)
check_error_1(0.90, 10^6, 100)
check_error_1(0.95, 10^6, 100)
check_error_1(0.99, 10^6, 100)