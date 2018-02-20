function [ name, len, rad, parent, tips ] = importDataC (datafile)
B = table2array(importfile23(datafile));
A = double(B);
numOfCol = size(A);
numOfCol = numOfCol(2);
    name   = (A(1:length(A),1));
    len = (A(1:length(A),3));
    rad = (A(1:length(A),4));
    parent = (A(1:length(A),6));
    num_child = (A(1:length(A),7));
childArr = linspace(8,numOfCol, numOfCol-7);
maxNumOfChildren = length(childArr);
nchild = [];
numOfVessels = length(name);
vesselChildren = zeros(numOfVessels, maxNumOfChildren+1);
vesselName = [];
tips = [];
for k = 1:numOfVessels
     nchild = [nchild, num_child(k,1)];
end
for j = 1:numOfVessels
    thisName = name(j,1);
    vesselName = [vesselName, thisName];
    parent(j,1) = 0;
     for j1 = 1:numOfVessels
         if (j == j1)
             continue
         end
        found = 0;
        for k = 1:nchild(j1)
            nmchild = A(j1, k + 7);
            if (thisName == nmchild(1,1))
                found = 1;
                indexparent = j1;
                break
            end
        end
        if (found == 1)
            break
        end
    end
    if (found == 1)
        nfound = vesselChildren(indexparent, 1);
        vesselChildren(indexparent, 1) = nfound + 1;
        vesselChildren(indexparent, nfound + 2) = j;
        parent(j,1) = indexparent;
    end
end
k = 0;
for m = 1:numOfVessels    % begin to find tips
    if nchild(m) < 1
        k = k + 1;
        tips = [tips m];             % tips becomes an array of vessels that have no children
    end
end
p = size(tips);
p = p(2);
for m = 1:numOfVessels
    c = 1;
    for n = 1:p
        x = tips(n);
        while (parent(x) > 0)
            if parent(x) == m
                c = c + 1;
                break
            end
            x = parent(x);
        end
    end
    tips(m) = c;
end
tips = num2cell(transpose(tips));
name   = num2cell(A(1:length(A),1));
len = num2cell(A(1:length(A),3));
rad = num2cell(A(1:length(A),4));
parent = num2cell(A(1:length(A),6));
end