function [ bins, frequency ] = getBinsFrequency(arr, arr2, method)
%getBinFreq: A function that puts the scaling exponent values into bins and
%and determines their relative frequency.
%
%INPUT
%  arr: an array containing the scaling exponents a and b
%  method: a number denoting the method of calculating scaling exponents
%         1 Conservation
%         2 Ratio
%         3 Distribution
%         4 Regression
%         5 Hierarchical-averaging
%OUTPUT
%  bins: an array containing the intervals in which the scaling exponents
%  are divided up
%  frequency: an array containing the number of times a scaling exponent lies
%  in each interval
%EX
%  [bins, frequency] = getBinFreq(arr, method);
%	
%Caroline Choi, last edited 4/1/18
%======================================================================
 frequency = [];
 bins = [];
if(method == 1 || method == 2 || method == 5)
    [numPerBin, binIntervals] = histcounts(arr, 14);
    frequency = numPerBin/(length(arr));
    frequency = [frequency, 0];
    bins = binIntervals;
elseif(method == 3)
    n = ceil(sqrt(length(arr)));
    [numPerBin, binIntervals] = histcounts(arr, n);
    for i=1:n
        bins(i) = (binIntervals(i)+binIntervals(i+1))/2;
    end
    frequency = numPerBin/(length(arr));
    %Remove values where frequency = 0 and log(frequency) = Inf.
    x = size(frequency);
    length_freq = x(2);
    i = 1;
    while (i<=length_freq)
        if(frequency(i)==0)
            frequency(i)=[];
            bins(i)=[];
            length_freq=length_freq-1;
        else
            i=i+1;
        end
    end
    frequency = log(frequency);
elseif(method == 4)
    bins = arr2;
    frequency = arr;
else
    n_bins = ceil(sqrt(length(arr)));
    [numPerBin, binIntervals] = histcounts(arr, n_bins);
    frequency = numPerBin/(length(arr));
    frequency = [frequency, 0];
    bins = binIntervals;
end
end