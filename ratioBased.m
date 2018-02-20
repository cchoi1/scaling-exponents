% ratioBased: plots scale factor vs. relative frequency	
%
%	Caroline Choi, 8/24/17
%============================================================
datafile = 'NewberryPaperData.txt';

% Scaling exponent a
figure
arr = fillArr(2, 'r', datafile);
[bins, frequency] = getBinFreq(arr, 2);
bar(bins, frequency, 1);
title('Ratio-based calculation of a','fontweight','bold');
xlabel('Radius scale factor, \beta','fontweight','bold')         
ylabel('Relative frequency','fontweight','bold')          
arr2 = [-log(arr)/log(2)];
x1 = mean(arr);
x1a = mean(arr2);
y1 = get(gca,'ylim');
hold on
a1 = plot([x1 x1],y1, 'r-', 'LineWidth', 1);
x2 = median(arr);
x2b = median(arr2);
y2 = get(gca,'ylim');
a2 = plot([x2 x2],y2, '-.g', 'LineWidth', 1);
legend('Relative frequency','mean', 'median');
[b,bint] = regress(frequency(:), bins(:));
CI = (abs(bint(1)) + abs(bint(2)))/2;
[b,bint,r,rint,stats] = regress(frequency(:), bins(:), 95);
S = std(arr);
       
formatSpec = 'N = %4.2f\n';         %prints additional data
fprintf(formatSpec,[length(arr)]);
formatSpec = 'a = %4.2f (mean)\n';
fprintf(formatSpec, x1a)
formatSpec = 'a = %4.2f (median)\n';
fprintf(formatSpec, x2b)
formatSpec = '95 CI = %4.2f\n';
fprintf(formatSpec,[CI]);
formatSpec = 'Std Dev = %4.2f\n';
fprintf(formatSpec,S);

% Scaling exponent b
figure
arr = fillArr(2, 'l', datafile);
[bins, frequency] = getBinFreq(arr, 2);
bar(bins, frequency, 1);
title('Ratio-based calculation of b','fontweight','bold');
xlabel('Length scale factor, \gamma','fontweight','bold')         
ylabel('Relative frequency','fontweight','bold') 
arr2 = [-log(arr)/log(2)];
x1 = mean(arr);
x1a = mean(arr2);
y1 = get(gca,'ylim');
hold on
a1 = plot([x1 x1],y1, 'r-', 'LineWidth', 1);
x2 = median(arr);
x2b = median(arr2);
y2=get(gca,'ylim');
a2 = plot([x2 x2],y2, '-.g', 'LineWidth', 1);
legend('Relative frequency','mean', 'median');
[b,bint] = regress(frequency(:), bins(:));
CI = (abs(bint(1)) + abs(bint(2)))/2;
[b,bint,r,rint,stats] = regress(frequency(:), bins(:), 95);
S = std(arr);

formatSpec = 'N = %4.2f\n';         %prints additional data
fprintf(formatSpec,[length(arr)]);
formatSpec = 'b = %4.2f (mean)\n';
fprintf(formatSpec, x1a)
formatSpec = 'b = %4.2f (median)\n';
fprintf(formatSpec, x2b)
formatSpec = '95 CI = %4.2f\n'; %change w/ more sig figs
fprintf(formatSpec,[CI]);
formatSpec = 'Std Dev = %4.2f\n';
fprintf(formatSpec,S);