%Plots ln(r or l) vs ln(frequency).
%
%Caroline Choi, 8/24/17
%========================================================================

% Radius Scaling Exponent a

%Compute scaling exponents.
[arr, arr2, N] = compScalingExpC(3, 'r', datafile);
[bins,frequency] = getBinsFrequency(arr, arr2, 3);

%Plot a scatter plot of scaling exponents and a best-fit line.
figure
scatter(bins, frequency);
title('Distribution-Based Calculation of a','fontweight','bold');
xlabel('ln(radius)','fontweight','bold')            
ylabel('ln(relative frequency)','fontweight','bold') 
p_a = polyfit(bins, frequency, 1);
x_axis = linspace(min(bins(:)), max(bins(:)), length(bins));
y_axis = polyval(p_a, x_axis);
hold on;
plot(x_axis, y_axis, 'r-', 'LineWidth', 1);

%Compute statistical information.
[x,bint] = regress(frequency(:), bins(:));
CI = (bint(2)-bint(1))/2;
a = -1/(p_a(1));
[x,bint,r,rint,stats] = regress(frequency(:), bins(:));
yfit = polyval(p_a, bins);
yresid = frequency-yfit;
SSresid = sum(yresid.^2);
SStotal = (length(frequency)-1)*var(frequency);
r2 = 1-SSresid/SStotal;

%Print statistical data.
formatSpec = 'N = %4.2f\n';
fprintf(formatSpec, [length(arr)]);
formatSpec = 'a = %4.2f\n';
fprintf(formatSpec, a);
formatSpec = 'CI = %4.2f\n';
fprintf(formatSpec,[CI]);
formatSpec = 'R^2 = %4.2f\n';
fprintf(formatSpec,[r2]);

% Length Scaling Exponent b

%Compute scaling exponents.
[arr, arr2, N] = compScalingExpC(3, 'l', datafile);
[bins,frequency] = getBinsFrequency(arr, arr2, 3);

%Plot a scatter plot of scaling exponents and a best-fit line.
figure
scatter(bins, frequency);
title('Distribution-Based Calculation of b','fontweight','bold');
xlabel('ln(length)','fontweight','bold')            
ylabel('ln(relative frequency)','fontweight','bold') 
p_b = polyfit(bins, frequency, 1);
x_axis = linspace(min(bins(:)), max(bins(:)), length(bins));
y_axis = polyval(p_b, x_axis);
hold on;
plot(x_axis, y_axis, 'r-', 'LineWidth', 1);

%Compute statistical information.
[x,bint] = regress(frequency(:), bins(:));
CI = (bint(2)-bint(1))/2;
[x,bint,r,rint,stats] = regress(frequency(:), bins(:));
b = -1/(p_b(1));
yfit = polyval(p_b, bins);
yresid = frequency-yfit;
SSresid = sum(yresid.^2);
SStotal = (length(frequency)-1)*var(frequency);
r2 = 1-SSresid/SStotal;

%Print statistical data.
formatSpec = 'N = %4.2f\n';
fprintf(formatSpec, [length(arr)]);
formatSpec = 'b = %4.2f\n';
fprintf(formatSpec, b);
formatSpec = 'CI = %4.2f\n';
fprintf(formatSpec,[CI]);
formatSpec = 'R^2 = %4.2f\n';
fprintf(formatSpec,[r2]);