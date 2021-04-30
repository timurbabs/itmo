pkg load statistics
clc

function count = calculate_norm(gamma, a, b, x, graph)
  selection = 10^2;
  volume = 10^4;
  
  Fxt0 = normcdf(x, a, b);
  
  eval = normrnd(a, b, volume, selection);
  
  Fn = mean(eval < 1);
  
  d = norminv((1 + gamma) / 2) * sqrt(Fn.*(1 - Fn) / volume);
  
  left = Fn - d;
  right = Fn + d;
  
  count = 0;
  for(i = 1:selection)
    if(left(i) > Fxt0)
      count++;
    elseif (right(i) < Fxt0)
      count++;
    endif
  endfor
  
  if (strcmp(graph, "on") == 1)
    plot(1:selection, left, 1:selection, right, 1:selection, linspace(Fxt0, Fxt0, selection)), grid;
  endif
endfunction

function last_task_norm()
  for(i = 0:9)
    count = 0;
    gamma = 0.9 + i * 10^(-2);
    for(j = 1:100)
      count = count + calculate_norm(gamma, 0, 2, 1, "off");
    endfor
    printf("Gamma = %g\n", gamma);
    printf("Average = %g\n\n", count/100);
    count = 0;
  endfor
endfunction