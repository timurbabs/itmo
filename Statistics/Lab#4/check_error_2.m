clc;
clear;
pkg load statistics;

function check_error_2(gamma, offset, n, n_exp)
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
    res_uni = uni_statistics(n, a, b, offset);
    if(res_uni < quantile)
      uni_count += 1;
    endif
    
    res_norm = norm_statistics(n, a, b, offset);
    if(res_norm < quantile)
      norm_count += 1;
    endif
  endfor
  
  printf("Равномерное распределение.\nОбъём выборки: %g\nКоличество опытов: %g\nКоличество степеней свободы: %g\nGamma: %g\nКвантиль: %g\nДельта: %g\nВероятность ошибки 2 рода: %g\n<---------------------------------->\n", n, n_exp, ceil(n^(1/3)) - 3, gamma, quantile, offset, uni_count / n_exp);
  printf("Нормальное распределение.\nОбъём выборки: %g\nКоличество опытов: %g\nКоличество степеней свободы: %g\nGamma: %g\nКвантиль: %g\nДельта: %g\nВероятность ошибки 2 рода: %g\n<---------------------------------->\n", n, n_exp, ceil(n^(1/3)) - 3, gamma, quantile, offset, norm_count / n_exp);
endfunction

check_error_2(0.95, 0.05, 10^6, 100)
check_error_2(0.95, 0.01, 10^6, 100)