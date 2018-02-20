function arr = fillArrC(method, option, datafile)
%fillArr: uses Angicart data and fills array with scaling exponents if method 1,2,4 is used,
%or fills array with radius/length if method 3 is used
%
%INPUT:
% method: which method of calculating scaling exponents
%         1 Conservation-based
%         2 Ratio-based
%         3 Distribution-based
%         4 Regression-based
% option: 'r' (radius) or 'l' (length)
% datafile: text file with Angicart data
%
%OUTPUT: array with scaling exponents if method 1,2,4
%        array with radius or length if method 3
%
%EX: arr = fillArr(1, 'r', 'patient10.txt');
%
%	Caroline Choi, 8/22/17
%============================================================
[S.name, S.len, S.rad, S.parent, S.tips] = importDataC(datafile);
arr = [];
numOfData = length(S.name)-1;
N = 0;
rk = 0;
lk = 0;
if (method == 1)
    if (option == 'r')
        arrOfChildrenRad = [];
        for i = 1:numOfData
            par = S.parent(i);
            idx_par = find(round(cell2mat(S.name(:))) == cell2mat(par));
            if (~strcmp(S.parent{i}, 'NaN'))
                rk1 = cell2mat(S.rad(i));
                rk = cell2mat(S.rad(idx_par));
                if (rk1 < rk)
                    a = calcConserve(rk, rk1);
                    if (abs(a) ~= Inf)
                        arr = [arr, a];
                    end
                end
            end
        end
    else
        for i = 1:numOfData
            par = S.parent(i);
            idx_par = find(round(cell2mat(S.name(:))) == cell2mat(par));
            if (~strcmp(S.parent{i}, 'NaN'))
                lk1 = cell2mat(S.len(i));
                lk = cell2mat(S.len(idx_par));
                if (lk1 < lk)
                    a = calcConserve(lk, lk1);
                    if (abs(a) ~= Inf)
                        arr = [arr, a];
                    end
                end
            end
        end
    end
elseif (method == 2)
    if (option == 'r')
        for i = 1:numOfData
            par = S.parent(i);
            idx_par = find(round(cell2mat(S.name(:))) == cell2mat(par));
            if (~strcmp(S.parent{i}, 'NA'))
                rk1 = cell2mat(S.rad(i));
                rk = cell2mat(S.rad(idx_par))
                if (rk1 < rk)
                    a = rk1/rk;
                    if (abs(a) ~= Inf)
                        arr = [arr, a];
                        N = N+1;
                    end
                end
            end
        end
    else
        for i = 1:numOfData
            par = S.parent(i);
            idx_par = find(round(cell2mat(S.name(:))) == cell2mat(par));
            if (~strcmp(S.parent{i}, 'NA'))
                lk1 = cell2mat(S.len(i));
                lk = cell2mat(S.len(idx_par))
                if (lk1 < lk)
                    a = lk1/lk;
                    if (abs(a) ~= Inf)
                        arr = [arr, a];
                        N = N+1;
                    end
                end
            end
        end
    end
elseif (method == 3)
    if (option == 'r')
        for i = 1:numOfData
            if (~strcmp(S.parent{i}, 'NA'))
                a = cell2mat(S.rad(i));
                if (abs(a) ~= 0)
                    arr = [arr, a];
                end
            end
        end
    else
        for i = 1:numOfData
            if (~strcmp(S.parent{i}, 'NA'))
                a = cell2mat(S.len(i));
                if (abs(a) ~= 0)
                    arr = [arr, a];
                end
            end
        end
    end
else
    if (option == 'r')
        for i = 1:numOfData
            if (~strcmp(S.parent{i}, 'NA'))
                a = log(cell2mat(S.rad(i)));
                arr = [arr, a];
                a2 = log(cell2mat(S.tips(i)));
                arr = [arr, a2];
                N = N+1;
            end
        end
    else
        for i = 1:numOfData
            if (~strcmp(S.parent{i}, 'NA'))
                a = log(cell2mat(S.len(i)));
                arr = [arr, a];
                a2 = log(cell2mat(S.tips(i)));
                arr = [arr, a2];
                N = N+1;
            end
        end
    end
end
end