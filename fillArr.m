function arr = fillArr(method, option, datafile)
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
[S.name, S.len, S.rad, S.parent, S.tips, S.nchild] = importData(datafile);
arr = [];
arr2 = [];
numOfData = length(S.name)-1;
N = 0;
rk = 0;
lk = 0;
if (method == 1)
    if (option == 'r')
        for i=1:numOfData
            numOfChildren = S.nchild{i};
            if (~strcmp(S.name{i}, 'NA') && S.nchild{i}==2)
                arrOfChildrenRad = [];
                count=0;
                for j=1:numOfData
                    if (strcmp(extractBetween(S.parent{j}, 2, length(S.parent{j})-1), S.name{i}))
                        arrOfChildrenRad = [arrOfChildrenRad, S.rad{j}];
                        count=count+1;
                    end
                    if (count==numOfChildren)
                        break
                    end
                end
                a = calcConserve(arrOfChildrenRad, S.rad{i});
                if (a~=Inf)
                    arr = [arr, a];
                end
            end
        end
    else
        for i=1:numOfData
            numOfChildren = S.nchild{i};
            if (~strcmp(S.name{i}, 'NA') && numOfChildren>0)
                parentName = S.name{i};
                parentLen = S.len{i};
                arrOfChildrenLen = [];
                count=0;
                for j=1:numOfData
                    if (strcmp(extractBetween(S.parent{j}, 2, length(S.parent{j})-1), parentName))
                        arrOfChildrenLen = [arrOfChildrenLen, S.len{j}];
                        count=count+1;
                    end
                    if (count==numOfChildren)
                        break
                    end
                end
                a = calcConserve(arrOfChildrenLen, parentLen);
                if (a>0)
                    if (a~=Inf)
                        arr = [arr, a];
                    end
                end
            end
        end
    end
elseif (method == 2)
    if (option == 'r')
        for i = 1:numOfData
            if (~strcmp(S.parent{i}, 'NA'))
                rk1 = cell2mat(S.rad(i));
                for j = 1:numOfData
                    if (strcmp((extractBetween(S.parent{i}, 2, length(S.parent{i})-1)), S.name{j})) %to extract parent name which is strangely in " "
                        rk = cell2mat(S.rad(j));
                        break
                    end
                end
                a = rk1/rk;
                N=N+1;
                if (abs(a) ~= Inf && a~=0 && a<1.7) %remove impossible values and outliers
                    arr = [arr, a];
                end
            end
        end
    else
        for i = 1:numOfData
            if (~strcmp(S.parent{i}, 'NA'))
                lk1 = cell2mat(S.len(i));
                for j = 1:numOfData
                    if (strcmp((extractBetween(S.parent{i}, 2, length(S.parent{i})-1)), S.name{j})) %to extract parent name which is strangely in " "
                        lk = cell2mat(S.len(j));
                        break
                    end
                end
                a = lk1/lk;
                if (abs(a)~=Inf && a~=0 && a<23) %remove impossible values and outliers
                    N=N+1;
                    arr = [arr, a];
                end
            end
        end
    end
elseif (method == 3)
    if (option == 'r')
        for i = 1:numOfData
            if (~strcmp((extractBetween(S.parent{i}, 2, length(S.parent{i})-1)), 'NA') && S.nchild{i}==2)
                a = log(cell2mat(S.rad(i)));
                if (a~=Inf)
                    arr = [arr, a];
                    N=N+1;
                end
            end
        end
    else
        for i = 1:numOfData
            if (~strcmp((extractBetween(S.parent{i}, 2, length(S.parent{i})-1)), 'NA') && S.nchild{i}==2)
                a = log(cell2mat(S.len(i)));
                if (a~=Inf)
                    arr = [arr, a];
                    N=N+1;
                end
            end
        end
    end
    N = N/2;
    arr = real(arr);
else
    if (option == 'r')
        for i = 1:numOfData
            if (~strcmp((extractBetween(S.parent{i}, 2, length(S.parent{i})-1)), 'NA') && S.nchild{i}==2)
                a = log(cell2mat(S.rad(i)));
                if (a~=Inf)
                    arr = [arr, a];
                end
                a2 = log(cell2mat(S.tips(i)));
                if (a2~=Inf)
                    arr2 = [arr2, a2];
                end
                N = N+1;
            end
        end
    else
        for i = 1:numOfData
            if (~strcmp((extractBetween(S.parent{i}, 2, length(S.parent{i})-1)), 'NA') && S.nchild{i}==2)
                a = log(cell2mat(S.len(i)));
                if (a~=Inf)
                    arr = [arr, a];
                end
                a2 = log(cell2mat(S.tips(i)));
                if (a2~=Inf)
                    arr2 = [arr2, a2];
                end
                N = N+1;
            end
        end
    end
end
end