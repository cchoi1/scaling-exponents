% conservationBased: plots all conservation-based scaling exponents
%                    (a or b) vs frequency
%	
%	Caroline Choi, 8/22/17
%============================================================
datafile = 'NewberryPaperData.txt';

% % Scaling exponent a
% arr = fillArr(1, 'r', datafile);
% [bins, frequency] = getBinFreq(arr, 1);
% 
% figure
% bar(bins, frequency, 1);
% title('Conservation-based calculation of a','fontweight','bold');
% xlabel('Radius scaling exponent a','fontweight','bold')            
% ylabel('Relative frequency','fontweight','bold')                  
% x1 = mean(arr);
% y1 = get(gca,'ylim');
% hold on
% plot([x1 x1], y1, 'r-', 'LineWidth', 1);
% x2 = median(arr);
% y2 = get(gca,'ylim');
% plot([x2 x2], y2, '-.g', 'LineWidth', 1);
% legend('Relative frequency','mean', 'median');
% formatSpec = 'a = %4.2f (mean)\n';
% fprintf(formatSpec,x1);
% formatSpec = 'a = %4.2f (median)\n';
% fprintf(formatSpec,x2);
% formatSpec = 'N = %4.2f \n';
% fprintf(formatSpec,length(arr));

% Scaling exponent b
arr = fillArr(1, 'l', datafile);
[bins, frequency] = getBinFreq(arr, 1);

figure
bar(bins, frequency, 1);
title('Conservation-based calculation of b','fontweight','bold');
xlabel('Length scaling exponent b','fontweight','bold')         
ylabel('Relative frequency','fontweight','bold')               
x1 = mean(arr);
y1 = get(gca,'ylim');
hold on
plot([x1 x1], y1, 'r-', 'LineWidth', 1);
x2 = median(arr);
y2 = get(gca,'ylim');
plot([x2 x2], y2, '-.g', 'LineWidth', 1);
legend('Relative frequency','mean', 'median');
formatSpec = 'b = %4.2f (mean)\n';
fprintf(formatSpec,x1);
formatSpec = 'b = %4.2f (median)\n';
fprintf(formatSpec,x2);
formatSpec = 'N = %4.2f \n';
fprintf(formatSpec,length(arr));