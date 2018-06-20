function [arr, arr2, N] = compScalingExpC(method, option, datafile)
%Uses Angicart data to calculate scale factors and scaling exponents. If method 1, 2, or 4 is used,
%returns an array with scaling exponents. If method 3 is used, returns an array with radius/length.
%
%INPUT
% method: the method of calculating scaling exponents
%         1. Conservation
%         2. Ratio
%         3. Distribution
%         4. Regression
%         5. Hierarchical Averaging
% option: 'r' (radius) or 'l' (length)
% datafile: imported .txt file with Angicart data
%
%OUTPUT
%    an array with scaling exponents if method 1,2,4
%    an array with radius or length if method 3
%
%EX: arr = fillArrC(1, 'r', 'patient10.txt');
%
%Caroline Choi, 3/31/18
%============================================================
[name, len, rad, parent, tips, nchild, children] = importDataC(datafile);
arr = [];
arr2 = [];
N = 0;
num_vessels = length(name);
rk = 0;
lk = 0;
if (method == 1)
    if (option == 'r')
        for i=1:num_vessels
            if (nchild(i)>0 && ~isnan(rad(i)) && rad(i)>0)
                num_children = nchild(i);
                arr_children_rad = [];
                rk = rad(i);
                for j=1:num_children
                    rk1 = rad(find(children(i,j)==name(:)));
                    if (~isnan(rk1) && rk1>0)
                        arr_children_rad = [arr_children_rad, rk1];
                    end
                end
                a = calcConserve(arr_children_rad, rk);
                if (a~=Inf)
                    arr = [arr, a];
                end
            end
        end
    else
        for i=1:num_vessels
            if (nchild(i)>0 && ~isnan(len(i)) && len(i)>0)
                num_children = nchild(i);
                arr_children_len = [];
                lk = len(i);
                for j=1:num_children
                    lk1 = len(find(children(i,j)==name(:)));
                    if (~isnan(lk1) && lk1>0)
                        arr_children_len = [arr_children_len, lk1];
                    end
                end
                b = calcConserve(arr_children_len, lk);
                if (b~=Inf)
                    arr = [arr, b];
                end
            end
        end
    end
elseif (method == 2)
    if (option == 'r')
        for i = 1:num_vessels
            if (nchild(i)==2 && ~isnan(rad(i)) && rad(i)>0)
                rk = rad(i);
                for j = 1:nchild(i)
                    rk1 = rad(find(name(:)==children(i,j)));
                    if (rk1 > 0 && abs(rk1)~=Inf)
                        beta = rk1/rk;
                        arr = [arr, beta];
                        N = N+1;
                    end
                end
            end
        end
    else
        for i = 1:num_vessels
            if (nchild(i)==2 && ~isnan(len(i)) && len(i)>0)
                lk = len(i);
                for j = 1:nchild(i)
                    lk1 = len(find(name(:)==children(i,j)));
                    if (lk1>0 && abs(lk1)~=Inf)
                        gamma = lk1/lk;
                        arr = [arr, gamma];
                        N = N+1;
                    end
                end
            end
        end
    end
elseif (method == 3)
    if (option == 'r')
        for i=1:num_vessels
            if (~isnan(rad(i)) && rad(i)>0)
                a = log(rad(i));
                if (abs(a)~=Inf && a>=0)
                    arr = [arr, a];
                end
            end
        end
    else
        for i=1:num_vessels
            if (~isnan(len(i)) && len(i)>0)
                b = log(len(i));
                if (abs(b)~=Inf && b>=0)
                    arr = [arr, b];
                end
            end
        end
    end
elseif (method == 4)
    if (option == 'r')
        for i=1:num_vessels
            if (~isnan(rad(i)) && rad(i)>0)
                a = log(rad(i));
                a2 = log(tips(i));
                if (abs(a)~=Inf && abs(a2)~=Inf)
                    arr = [arr, a];
                    arr2 = [arr2, a2];
                end
            end
        end
    else
        for i=1:num_vessels
            if (~isnan(len(i)) && len(i)>0)
                b = log(len(i));
                b2 = log(tips(i));
                if (abs(b)~=Inf && abs(b2)~=Inf)
                    arr = [arr, b];
                    arr2 = [arr2, b2];
                end
            end
        end
    end
else
    if (option == 'r')
        for i = 1:num_vessels
            if (~isnan(rad(i)) && rad(i)>0)
                rk = rad(i);
                N = N+1;
                for j = 1:nchild(i)
                    rk1 = rad(find(name(:)==children(i,j)));
                    if (rk1>0)
                        beta = rk1/rk;
                        arr = [arr, beta];
                        a = -log(beta)/log(nchild(i));
                        if (abs(a)~=Inf)
                            arr2 = [arr2, a];
                        end
                    end
                end
            end
        end
    else
        for i = 1:num_vessels
            if (~isnan(len(i)) && len(i)>0)
                lk = len(i);
                N = N+1;
                for j = 1:nchild(i)
                    lk1 = len(find(name(:)==children(i,j)));
                    if (lk1>0)
                        gamma = lk1/lk;
                        arr = [arr, gamma];
                        b = -log(gamma)/log(nchild(i));
                        if (abs(b)~=Inf)
                            arr2 = [arr2, b];
                        end
                    end
                end
            end
        end
    end
end
end