% Plots hierarchical average scale factor vs. relative frequency.
%
% Caroline Choi, 3/30/18
%========================================================================
[name, len, rad, parent, tips, nchild, children] = importDataC (datafile);

% Radius Scaling Exponent a
% Compute scaling exponents.
[arr_beta, arr_a, N] = compScalingExpC(5, 'r', datafile);
n_bins_a = ceil(sqrt(N));
rad_a = zeros(size(rad,2),2);
for i=1:length(arr_a)
    rad_a(i,1) = rad(i);
    rad_a(i,2) = arr_a(i);
end
rad_a = sortrows(rad_a);
count_n = hist(rad_a(:,1),n_bins_a);
count_n(find(count_n==0))=[];
ari_means_a = mean(rad_a(1:count_n(1),2));
for i=2:length(count_n)
    bin_range=(sum(count_n(1:(i-1)))+1):sum(count_n(1:i));
    ari_means_a=[ari_means_a, mean(rad_a(bin_range,2))];
end
a_median = median(ari_means_a);
a_HA = mean(ari_means_a);
[numPerBin, bins] = histcounts(rad_a(:,1), 15);
frequency = numPerBin/length(rad_a);
frequency = [frequency, 0];

%Plot a histogram of HA-based scaling exponent values with
%lines for the mean and median.
figure
bar(bins, frequency, 1);
text(bins(:), frequency(:), num2str(bins','%0.2f'), 'HorizontalAlignment','center','VerticalAlignment','bottom');
title('Hierarchical Averaging-Based Calculation of a','fontweight','bold');
xlabel('Hierarchical Average Radii','fontweight','bold')         
ylabel('Relative Frequency','fontweight','bold')   
y1 = get(gca,'ylim');
y2 = get(gca,'ylim');
hold on
a1 = plot([a_HA a_HA],y1, 'r-', 'LineWidth', 1);
a2 = plot([a_median a_median],y2, '-.g', 'LineWidth', 1);
legend('Relative Frequency','Mean','Median');

%Calculate statistical information.
[x,bint] = regress(frequency(:), bins(:));
CI = (bint(2)-bint(1))/2;
[x,bint,r,rint,stats] = regress(frequency(:), bins(:), 95);
s = std(arr_a);

%Print statistical data.
formatSpec = 'N = %4.2f\n';         %prints additional data
fprintf(formatSpec,[length(arr_a)]);
formatSpec = 'a = %4.2f (mean)\n';
fprintf(formatSpec, a_HA)
formatSpec = 'a = %4.2f (median)\n';
fprintf(formatSpec, a_median)
formatSpec = '95 CI = %4.2f\n';
fprintf(formatSpec,[CI]);
formatSpec = 'Std Deviation = %4.2f\n';
fprintf(formatSpec,s);

% Length Scaling Exponent b

%Compute scaling exponents.
[arr_gamma, arr_b, N] = compScalingExpC(5, 'r', datafile);
n_bins_b = ceil(sqrt(N));
len_b = zeros(size(rad,2),2);
for i=1:length(arr_b)
    len_b(i,1) = len(i);
    len_b(i,2) = arr_b(i);
end
len_b = sortrows(len_b);
count_n = hist(len_b(:,1),n_bins_b);
count_n(find(count_n==0))=[];
ari_means_b = mean(len_b(1:count_n(1),2));
for i=2:length(count_n)
    bin_range=(sum(count_n(1:(i-1)))+1):sum(count_n(1:i));
    ari_means_b=[ari_means_a, mean(rad_a(bin_range,2))];
end
b_median = median(ari_means_b);
b_HA = mean(ari_means_b);
[numPerBin, bins] = histcounts(len_b(:,1), 15);
frequency = numPerBin/length(len_b(:,1));
frequency = [frequency, 0];

%Plot a histogram of HA-based scaling exponent values with
%lines for the mean and median.
figure
bar(bins, frequency, 1);
text(bins(:), frequency(:), num2str(bins','%0.1f'), 'HorizontalAlignment','center','VerticalAlignment','bottom');
title('Hierarchical Averaging-Based Calculation of b','fontweight','bold');
xlabel('Hierarchical Average Lengths','fontweight','bold')         
ylabel('Relative Frequency','fontweight','bold')
y1 = get(gca,'ylim');
y2 = get(gca,'ylim');
hold on
a1 = plot([b_HA b_HA],y1, 'r-', 'LineWidth', 1);
a2 = plot([b_median b_median],y1, 'g-', 'LineWidth', 1);
legend('Relative Frequency','Mean', 'Median');

%Calculate statistical information.
[x,bint] = regress(frequency(:), bins(:));
CI = (bint(2)-bint(1))/2;
[x,bint,r,rint,stats] = regress(frequency(:), bins(:), 95);
s = std(arr_b);

%Print statistical data.
formatSpec = 'N = %4.2f\n';         %prints additional data
fprintf(formatSpec,[length(arr_b)]);
formatSpec = 'b = %4.2f (mean)\n';
fprintf(formatSpec, b_HA)
formatSpec = 'b = %4.2f (median)\n';
fprintf(formatSpec, b_median)
formatSpec = '95 CI = %4.2f\n';
fprintf(formatSpec,[CI]);
formatSpec = 'Std Deviation = %4.2f\n';
fprintf(formatSpec,s);