% regressionBased: plots all regression-based scaling exponents
%                  plots ln(number of endpoints) vs ln(r or l)
% HISTORY	
%	Caroline Choi, 8/24/17
%============================================================
datafile = 'NewberryPaperData.txt';

% Scaling exponent a
[arr, arr2] = fillArr(4, 'r', datafile);
[bins, frequency] = getBinFreq(arr, arr2, 4);

figure
scatter(bins, frequency);
title('Regression-based calculation of a','fontweight','bold');
xlabel('ln(Number of endpoints)','fontweight','bold')         
ylabel('ln(radius)','fontweight','bold')                      
coeffs = polyfit(bins, frequency, 1);
fittedX = linspace(min(bins), max(bins), length(frequency));
fittedY = polyval(coeffs, fittedX);
hold on;
plot(fittedX, fittedY, 'r-', 'LineWidth', 1);

[b, bint] = regress(frequency(:),bins(:));
CI = (abs(bint(1)-bint(2)))/2;
[b,bint,r,rint,stats] = regress(frequency(:),bins(:),95);

exp = [b];                      %prints additional data
formatSpec = 'N = %4.2f\n';
fprintf(formatSpec,[length(bins)]);
formatSpec = 'a = %4.2f\n';
fprintf(formatSpec,exp);
formatSpec = 'CI = %4.2f\n';
fprintf(formatSpec,CI);
rsq = [stats(1)];
formatSpec = 'R^2 = %4.2f\n';
fprintf(formatSpec,rsq);

% % Scaling exponent b
% figure
% [arr, arr2] = fillArr(4, 'l', datafile);
% [bins, frequency] = getBinFreq(arr, arr2, 4);
% scatter(bins, frequency);
% title('Regression-based calculation of b','fontweight','bold');
% xlabel('ln(number of endpoints)','fontweight','bold')       
% ylabel('ln(length)','fontweight','bold')                     
% coeffs = polyfit(bins, frequency, 1);
% fittedX = linspace(min(bins), max(bins), length(frequency));
% fittedY = polyval(coeffs, fittedX);
% hold on;
% plot(fittedX, fittedY, 'r-', 'LineWidth', 1);
% 
% [b, bint] = regress(frequency(:),bins(:));
% CI = abs(bint(1) - bint(2))/2;
% [b,bint,r,rint,stats] = regress(frequency(:),bins(:),95);
% 
% exp = [b];                  %prints additional data
% formatSpec = 'N = %4.2f\n';
% fprintf(formatSpec,[length(bins)]);
% formatSpec = 'b = %4.2f\n';
% fprintf(formatSpec,exp);
% formatSpec = 'CI = %4.2f\n';
% fprintf(formatSpec,CI);
% rsq = [stats(1)];
% formatSpec = 'R^2 = %4.2f\n';
% fprintf(formatSpec,rsq);