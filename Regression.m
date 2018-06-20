%Plots ln(number of endpoints) vs ln(radius) or ln(length)

%Caroline Choi, 8/24/17
%============================================================

% Radius Scaling Exponent a

%Compute scaling exponents.
[rad_log, tips_log, N] = compScalingExpC(4, 'r', datafile);
[bins, frequency] = getBinsFrequency(rad_log, tips_log, 4);

%Plot a scatter plot of scaling exponents and a best-fit line.
figure
scatter(bins, frequency);
title('Regression-Based Calculation of a','fontweight','bold');
xlabel('ln(Number of endpoints)','fontweight','bold')
ylabel('ln(radius)','fontweight','bold')
p_a = polyfit(bins, frequency, 1);
x_axis = linspace(min(bins(:)), max(bins(:)), length(bins));
y_axis = polyval(p_a, x_axis);
hold on;
plot(x_axis, y_axis, 'r-', 'LineWidth', 1);

%Compute statistical information.
[b,bint]=regress(frequency(:),bins(:));
CI = (bint(2)-bint(1))/2;
yfit = polyval(p_a, tips_log);
yresid = rad_log-yfit;
SSresid = sum(yresid.^2);
SStotal = (length(rad_log)-1)*var(rad_log);
r2 = 1-SSresid/SStotal;
[b,bint,r,rint,stats]=regress(frequency(:),bins(:),95);
a = p_a(1);

%Print statistical data.
formatSpec = 'N = %4.2f\n';
fprintf(formatSpec, [length(bins)]);
formatSpec = 'a = %4.2f\n';
fprintf(formatSpec, a);
formatSpec = 'CI = %4.2f\n';
fprintf(formatSpec, CI);
formatSpec = 'R^2 = %4.2f\n';
fprintf(formatSpec, r2);

% Length Scaling Exponent b

%Compute scaling exponents.
[len_log, tips_log] = compScalingExpC(4, 'l', datafile);
[bins, frequency] = getBinsFrequency(len_log, tips_log, 4);

%Plot a scatter plot of scaling exponents and a best-fit line.
figure
scatter(bins, frequency);
title('Regression-Based Calculation of b','fontweight','bold');
xlabel('ln(Number of endpoints)','fontweight','bold')
ylabel('ln(length)','fontweight','bold')
p_b = polyfit(bins, frequency, 1);
x_axis = linspace(min(bins(:)), max(bins(:)), length(bins));
y_axis = polyval(p_b, x_axis);
hold on;
plot(x_axis, y_axis, 'r-', 'LineWidth', 1);

%Compute statistical information.
[b,bint]=regress(frequency(:),bins(:));
CI = (bint(2)-bint(1))/2;
yfit = polyval(p_b, tips_log);
yresid = len_log-yfit;
SSresid = sum(yresid.^2);
SStotal = (length(len_log)-1)*var(len_log);
r2 = 1-SSresid/SStotal;
b = p_b(1);

%Print statistical data.
formatSpec = 'N = %4.2f\n';
fprintf(formatSpec, [length(bins)]);
formatSpec = 'b = %4.2f\n';
fprintf(formatSpec, b);
formatSpec = 'CI = %4.2f\n';
fprintf(formatSpec, CI);
formatSpec = 'R^2 = %4.2f\n';
fprintf(formatSpec, r2);