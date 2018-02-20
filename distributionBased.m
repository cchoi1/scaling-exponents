% distributionBased: plots ln(r or l) vs ln(frequency)

%      Caroline Choi, 8/24/17
%========================================================================

datafile = 'NewberryPaperData.txt';

% Scaling exponent a
[arr, N] = fillArr(3, 'r', datafile);
[bins,frequency] = getBinFreq(arr, 3);
for i=1:5
    bins(1) = [];
end

figure
scatter(bins, frequency);
title('Distribution-based calculation of a','fontweight','bold');
xlabel('ln(radius)','fontweight','bold')            
ylabel('ln(relative frequency)','fontweight','bold') 
coefficients = polyfit(bins, frequency, 1);
fittedX = linspace(min(bins), max(bins), length(frequency));
fittedY = polyval(coefficients, fittedX);
hold on;
plot(fittedX, fittedY, 'r-', 'LineWidth', 1);

[a,bint,r,rint,stats] = regress(bins(:), frequency(:)); %bint(1), bint(2) return the lower & upper 95% confidence intervals
CI = abs(bint(1)-bint(2))/2;
x1a = -1/(coefficients(1));
                                  %prints additional data
formatSpec = 'N = %4.2f\n';
fprintf(formatSpec, N);
formatSpec = 'a = %4.2f\n';
fprintf(formatSpec, [x1a]);
formatSpec = 'CI = %4.2f\n';
fprintf(formatSpec,[CI]);
rsq = stats(1);
formatSpec = 'R^2 = %4.2f\n';
fprintf(formatSpec,[rsq]);

% Scaling exponent b
[arr, N] = fillArr(3, 'l', datafile);
[bins, frequency] = getBinFreq(arr, 3);
for i=1:7
    bins(1) = [];
    frequency(1) = [];
end

figure
scatter(bins, frequency);
title('Distribution-based calculation of b','fontweight','bold');
xlabel('ln(radius)','fontweight','bold')            
ylabel('ln(relative frequency)','fontweight','bold') 
coefficients = polyfit(bins, frequency, 1);
fittedX = linspace(min(bins), max(bins), length(frequency));
fittedY = polyval(coefficients, fittedX);
hold on;
plot(fittedX, fittedY, 'r-', 'LineWidth', 1);

[b,bint,r,rint,stats] = regress(bins(:), frequency(:));
CI = (abs(bint(1) - bint(2)))/2;
x1b = -1/(coefficients(1));
                              %prints additional data
formatSpec = 'N = %4.2f\n';
fprintf(formatSpec, N);
formatSpec = 'b = %4.2f\n';
fprintf(formatSpec, x1b);
formatSpec = 'CI = %4.2f\n';
fprintf(formatSpec,[CI]);
rsq = stats(1);
formatSpec = 'R^2 = %4.2f\n';
fprintf(formatSpec,[rsq]);
