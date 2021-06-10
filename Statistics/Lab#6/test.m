clc 
clear 
pkg load statistics 
#pkg load plot 

printf("\nLine function \n")
printf("y = 3.1 + 2.4x \n");

xmin = -1;   
xmax = 5;    
n = 80;      
c1 = 3.1;   
c2 = 2.4;    
s = 1.4;    
m = 1;      

Theta = [c1, c2];
X = linspace(xmin, xmax, n)'; 
A = zeros(n, m + 1);
i = 1:(m + 1);
A(:, i) = X.^(i - 1);     
y = A * Theta';             
Z = normrnd(0, s, n, 1);        
Y = y + Z;

cov_x_y = X' * Y / n - mean(X) * mean(Y);
var_x = X' * X / n - (mean(X))^2;   
covariance = [mean(Y) - cov_x_y / var_x * mean(X); cov_x_y / var_x];

teorAn = polyfit(X, Y, m);         
experementalAn = (A' * A)^-1 * A' * Y;  

printf("Theoretical: \t\t %.8g \t %.8g \n", fliplr(teorAn));
printf("Experemental: \t\t %.8g \t %.8g \n", experementalAn');
printf("Covariance: \t\t %.8g \t %.8g \n", covariance(1), covariance(2));

Y_n_1 = polyval(teorAn, X);      
Y_n_2 = A * experementalAn;     

r = Y_n_2 - Y;
sExperemental = sqrt(r' * r / (n - 3));
orthogonality = r' * Y_n_2;
printf("Orthogonality: (Y_n_2 - Y)' * Y_n_2 = %d \n", orthogonality);    
printf("Experemental S = %d\n", sExperemental);

printf("\nQuadratic function \n")
printf("y = 2.2 + 1.8x + 0\n");

xmin = -1;
xmax = 5;
n = 80;
a1 = 0;
a2 = 1.8;
a3 = 2.2;
s = 1.4;
m = 2;

Theta = [a1, a2, a3];
X = linspace(xmin, xmax, n)';
A = zeros(n, m + 1);
i = 1:(m + 1);
A(:, i) = X.^(i - 1);
y = A * Theta';
Z = normrnd(0, s, n, 1);
Y = y + Z;
teorAn = polyfit(X, Y, m);
experementalAn = (A' * A)^-1 * A' * Y;

printf("Theoretical: \t %.8g \t %.8g \t %.8g \n", fliplr(teorAn));
printf("Experemental: \t %.8g \t %.8g \t %.8g \n", experementalAn');

Y_n = A * experementalAn;
Y_n_1 = polyval(teorAn, X);

graph = plot(
    X, Y, '.', "MarkerFaceColor", "r", 'MarkerSize', 10,
    X, Y_n, 'o', "MarkerFaceColor", "g", 'MarkerSize', 4,
    X, Y_n_1, 'x', "MarkerFaceColor", "k", 'MarkerSize', 4,
    X, y
    );
legend("Y", "Y_n", "Y_n_1", "y");

r = Y_n - Y;
sExperemental = sqrt(r' * r / (n - 3));
orthogonality = r' * Y_n;
printf("Orthogonality: (Y_n - Y)' * Y_n = %d \n", orthogonality);
printf("Experemental S = %d\n", sExperemental);
