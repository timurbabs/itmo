clc;
clear;
pkg load statistics;

function check_error_2(gamma, offset, n, n_exp)
  a = 1;
  b = 3;
  
  uni_count_dn = 0;
  uni_count_wn = 0;
  norm_count_dn = 0;
  norm_count_wn = 0;
  quantile_dn = 1.358;
  quantile_wn = 0.46;
  
  if (gamma == 0.95)
    quantile_dn = 1.358;
    quantile_wn = 0.46;
  elseif (gamma == 0.9)
    quantile_dn = 1.224;
    quantile_wn = 0.35;
  elseif (gamma == 0.99)
    quantile_dn = 1.628;
    quantile_wn = 0.84;
  endif
  
  for (i = 1:n_exp)
    res_uni = uni_statistics(n, a, b, offset);
    if(res_uni(1) < quantile_dn)
      uni_count_dn += 1;
    endif
    if(res_uni(2) < quantile_wn)
      uni_count_wn += 1;
    endif
    
    res_norm = norm_statistics(n, a, b, offset);
    if(res_norm(1) < quantile_dn)
      norm_count_dn += 1;
    endif
    if(res_norm(2) < quantile_wn)
      norm_count_wn += 1;
    endif
  endfor
  
  printf("При n = %g\nТочность: %g\nКоличество опытов: %g\nВероятность ошибки 2 рода равномерного распределения:\nКритерий Кaлмогорова: %g\nКритерий Смирнова : %g\n\n", n, gamma, n_exp, uni_count_dn / n_exp, uni_count_wn / n_exp);
  printf("При n = %g\nТочность: %g\nКоличество опытов: %g\nВероятность ошибки 2 рода нормального распределения:\nКритерий Кaлмогорова: %g\nКритерий Смирнова : %g\n\n", n, gamma, n_exp, norm_count_dn / n_exp, norm_count_wn / n_exp);
endfunction

check_error_2(0.9, 0.01, 10^4, 100);
check_error_2(0.95, 0.01, 10^4, 100);
check_error_2(0.99, 0.01, 10^4, 100);
check_error_2(0.9, 0.01, 10^6, 100);
check_error_2(0.95, 0.01, 10^6, 100);
check_error_2(0.99, 0.01, 10^6, 100);