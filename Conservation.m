% Plots all conservation-based scaling exponents (a or b) vs. frequency
%	
% Caroline Choi, last edited 3/30/18
%============================================================

% Radius Scaling Exponent a

%Compute scaling exponents.
[arr, arr2, N] = compScalingExpC(1, 'r', datafile);
[bins, frequency] = getBinsFrequency(arr, arr2, 1);

%Plot a histogram of conservation-based scaling exponent values with
%lines for the mean and median.
figure
bar(bins, frequency, 1);
title('Conservation-Based Calculation of a','fontweight','bold');
xlabel('Radius Scaling Exponent a','fontweight','bold')            
ylabel('Relative Frequency','fontweight','bold')                  
a_mean = mean(arr);
y_mean = get(gca,'ylim');
hold on
plot([a_mean a_mean], y_mean, 'r-', 'LineWidth', 1);
a_median = median(arr);
y_median = get(gca,'ylim');
plot([a_median a_median], y_median, '-.g', 'LineWidth', 1);
legend('Relative Frequency','Mean', 'Median');

%Compute statistical information.
s = std(arr);
[b,bint] = regress(frequency(:), bins(:));
CI = (bint(2)-bint(1))/2;

%Print statistical data.
formatSpec = 'a = %4.2f (mean)\n';
fprintf(formatSpec,a_mean);
formatSpec = 'a = %4.2f (median)\n';
fprintf(formatSpec,a_median);
formatSpec = 'N = %4.2f \n';
fprintf(formatSpec,length(arr));
formatSpec = 'Std Deviation = %4.2f \n';
fprintf(formatSpec,s);
formatSpec = '95 CI = %4.5f \n';
fprintf(formatSpec,[CI]);

% Length Scaling Exponent b

%Compute scaling exponents.
[arr, arr2, N] = compScalingExpC(1, 'l', datafile);
[bins, frequency] = getBinsFrequency(arr, arr2, 1);

%Produces a histogram of conservation-based scaling exponent values with
%lines for the mean and median.
figure
bar(bins, frequency, 1);
title('Conservation-Based Calculation of b','fontweight','bold');
xlabel('Length Scaling Exponent b','fontweight','bold')         
ylabel('Relative Frequency','fontweight','bold')               
b_mean = mean(arr);
y_mean = get(gca,'ylim');
hold on
plot([b_mean b_mean], y_mean, 'r-', 'LineWidth', 1);
b_median = median(arr);
y_median = get(gca,'ylim');
plot([b_median b_median], y_median, '-.g', 'LineWidth', 1);
legend('Relative Frequency','Mean', 'Median');

%Compute statistical information.
s = std(arr);
[b,bint] = regress(frequency(:), bins(:));
CI = (bint(2)-bint(1))/2;

%Print statistical data.
formatSpec = 'b = %4.2f (mean)\n';
fprintf(formatSpec,b_mean);
formatSpec = 'b = %4.2f (median)\n';
fprintf(formatSpec,b_median);
formatSpec = 'N = %4.2f \n';
fprintf(formatSpec,length(arr));
formatSpec = 'Std Deviation = %4.2f \n';
fprintf(formatSpec,s);
formatSpec = '95 CI = %4.5f \n';
fprintf(formatSpec,[CI]);