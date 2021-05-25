clc;
clear;
pkg load statistics;

function norm_sum = norm_statistics(n, a, sigma, offset)
  m = ceil(n^(1/3));
  x = sort(normrnd(a, sigma, 1, n));
  n_j = hist(x, m) / 1;
  h = (max(x) - min(x)) / m; 
  F_x = [min(x) + h/2:h:max(x) - h/2];
  p_j = normpdf(F_x, a + offset, sigma) * h;
  norm_sum = sum((n_j - n * p_j).^2 ./ (n * p_j));
endfunction

function uni_sum = uni_statistics(n, a, b, offset)
  m = ceil(n^(1/3));
  x = sort(unifrnd(a, b, n, 1));
  n_j = hist(x, m) / 1;
  h = (max(x) - min(x)) / m; 
  F_x = [min(x) + h/2:h:max(x) - h/2];
  p_j = unifpdf(F_x, a + offset, b) * h;
  uni_sum = sum((n_j - n * p_j).^2 ./ (n * p_j));
endfunction

function check()
  quantiles = [chi2inv(0.90,97), chi2inv(0.95,97), chi2inv(0.99,97)];
  
  n_norm = 10^6;
  a_norm = 1;
  sigma = 3;
  m_norm = ceil(n_norm^(1/3));
  ans_norm = norm_statistics(n_norm, a_norm, sigma, 0);
  printf("Нормальное распределение.\n");
  printf("Кол-во степеней свободы: %g\n", m_norm - 3);
  printf("Статистика хи-квадрат: %g\n", ans_norm);
  printf("Квантили для 0.90, 0.95, 099: %g %g %g\n", quantiles);
  printf("Принята ли гипотеза: %g %g %g\n\n", ans_norm > quantiles);

  n_unif = 10^6;
  a_unif = 1;
  b = 3;
  m_unif = ceil(n_norm^(1/3));
  ans_unif = uni_statistics(n_unif, a_unif, b, 0);
  printf("Равномерное распределение.\n");
  printf("Кол-во степеней свободы: %g\n", m_unif - 3);
  printf("Статистика хи-квадрат: %g\n", ans_unif);
  printf("Квантили для 0.90, 0.95, 099: %g %g %g\n", quantiles);
  printf("Принята ли гипотеза: %g %g %g\n\n", ans_unif > quantiles);
endfunction;

check();