% Plots scale factor vs. relative frequency.
%
%Caroline Choi, 8/24/17
%============================================================

%Radius Scaling Exponent a

%Compute scaling exponents.
[arr_beta, arr5, N] = compScalingExpC(2, 'r', datafile); %arr5 is an empty array
[bins, frequency] = getBinsFrequency(arr_beta, [], 2);

%Plot a histogram of ratio-based scaling exponent values with
%lines for the mean and median.
figure
bar(bins, frequency, 1);
text(bins(:), frequency(:), num2str(bins','%0.2f'), 'HorizontalAlignment','center','VerticalAlignment','bottom');
title('Ratio-Based Calculation of a','fontweight','bold');
xlabel('Radius Scale Factor, \beta','fontweight','bold')         
ylabel('Relative Frequency','fontweight','bold')          
arr_a = [-log(arr_beta)/log(2)];
a_mean = mean(arr_a);
beta_mean = mean(arr_beta);
y1 = get(gca,'ylim');
hold on
a1 = plot([beta_mean beta_mean],y1, 'r-', 'LineWidth', 1);
a_median = median(arr_a);
beta_median = median(arr_beta);
y2 = get(gca,'ylim');
a2 = plot([beta_median beta_median],y2, '-.g', 'LineWidth', 1);
legend('Relative Frequency','Mean', 'Median');

%Calculate statistical information.
[b,bint] = regress(frequency(:), bins(:));
CI = (bint(2)-bint(1))/2;
s = std(arr_beta);

%Print statistical data.
formatSpec = 'N = %4.2f\n';
fprintf(formatSpec,[length(arr_beta)]);
formatSpec = 'a = %4.2f (mean)\n';
fprintf(formatSpec, a_mean)
formatSpec = 'a = %4.2f (median)\n';
fprintf(formatSpec, a_median)
formatSpec = '95 CI = %4.2f\n';
fprintf(formatSpec,[CI]);
formatSpec = 'Std Deviation = %4.2f\n';
fprintf(formatSpec,s);

% Length Scaling Exponent b

%Compute scaling exponents.
[arr_gamma, arr5, N] = compScalingExpC(2, 'l', datafile);
[bins, frequency] = getBinsFrequency(arr_gamma, [], 2);

%Plot a histogram of ratio-based scaling exponent values with
%lines for the mean and median.
figure
bar(bins, frequency, 1);
text(bins(:), frequency(:), num2str(bins','%0.1f'), 'HorizontalAlignment','center','VerticalAlignment','bottom');
title('Ratio-Based Calculation of b','fontweight','bold');
xlabel('Length Scale Factor, \gamma','fontweight','bold')         
ylabel('Relative Frequency','fontweight','bold') 
arr_b = [-log(arr_gamma)/log(2)];
gamma_mean = mean(arr_gamma);
b_mean = mean(arr_b);
y1 = get(gca,'ylim');
hold on
a1 = plot([gamma_mean gamma_mean],y1, 'r-', 'LineWidth', 1);
gamma_med = median(arr_gamma);
b_median = median(arr_b);
y2 = get(gca,'ylim');
a2 = plot([gamma_med gamma_med],y2, '-.g', 'LineWidth', 1);
legend('Relative Frequency','Mean', 'Median');

%Compute statistical information.
[b,bint] = regress(frequency(:), bins(:));
CI = (bint(2)-bint(1))/2;
s = std(arr_gamma);

%Print statistical data.
formatSpec = 'N = %4.2f\n';
fprintf(formatSpec,[length(arr_gamma)]);
formatSpec = 'b = %4.2f (mean)\n';
fprintf(formatSpec, b_mean)
formatSpec = 'b = %4.2f (median)\n';
fprintf(formatSpec, b_median)
formatSpec = '95 CI = %4.2f\n';
fprintf(formatSpec,[CI]);
formatSpec = 'Std Deviation = %4.2f\n';
fprintf(formatSpec,s);