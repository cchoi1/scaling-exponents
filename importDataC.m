function [name, len, rad, parent, tips, nchild, children] = importDataC (datafile)
%importDataC: a function that extracts vessel data from Angicart C++ .tsv output files.
%Reads in a .txt file containing Angicart data. Computes the number of tips downstream of each vessel.
%Returns column vectors of name, length, radius, parent, tips.
%
%INPUT: datafile
% A .txt file containing Angicart data
%
%OUTPUT: [name, len, rad, parent, tips]
% Returns the name, length, radius, parent, tips of vessel, each of which
% are column vectors.
%
%EX:
% [name, len, rad, parent, tips, nchild, children] = importDataC (datafile)
%	
%Caroline Choi, last edited 4/2/18
% ==========================================================================
% Read in the .txt data file.
dataPath = [datafile];
[allDataStructure] = tdfread(dataPath, '\t');
num_vessels = length(allDataStructure.name);
num_cols = 10;

%Create a 2D array, mat, which contains the data from the .txt file.
mat = zeros(num_vessels, num_cols);
for k=1:num_vessels
    mat(k,1) = allDataStructure.name(k);
end
for k=1:num_vessels
    mat(k,3) = allDataStructure.len(k);
end
for k=1:num_vessels
    mat(k,4) = allDataStructure.rad1(k);
end
for k=1:num_vessels
    mat(k,6) = allDataStructure.parent(k);
end
for k=1:num_vessels
    mat(k,7) = allDataStructure.nchild(k);
end
for k=1:num_vessels
    mat(k,8) = allDataStructure.child1(k);
end
for k=1:num_vessels
    mat(k,9) = allDataStructure.child2(k);
end
for k=1:num_vessels
    mat(k,10) = allDataStructure.child3(k);
end
% for k=1:num_vessels
%     mat(k,11) = allDataStructure.child4(k);
% end
% for k=1:num_vessels
%     mat(k,12) = allDataStructure.child5(k);
% end
% for k=1:num_vessels
%     mat(k,13) = allDataStructure.child6(k);
% end

%Returns a column vector containing the number of tips downstream from each vessel in the
%network.
    function [tips] = findAllTips()
        tips = [];
        for x=1:num_vessels
            count_tips = findTips(mat(x,1));
            tips = [tips, count_tips];
        end
        tips = transpose(tips);
    end

%A recursive function that returns the number of tips downstream from one
%vessel, denoted by its name.
    function [count_tips] = findTips(top_name)
        i = find(top_name==mat(:,1));
        count_tips=0;
        if (mat(i,7)<1)    %if has no children
            count_tips=1;
        else
            num_children = allDataStructure.nchild(i);
            for j=1:num_children
                count_tips=count_tips+findTips(mat(find(name(:)==mat(i,j+7),1)));
            end
        end
    end

%Create column vectors name, length, radius, parent, nchild, tips data and a 2D array
%of the children names.
name = allDataStructure.name;
len = allDataStructure.len;
rad = allDataStructure.rad1;
parent = allDataStructure.parent;
nchild = allDataStructure.nchild;
tips = findAllTips();
temp = zeros(num_vessels, num_cols-7);
for r=1:num_vessels
    temp(r,1)=allDataStructure.child1(r);
    temp(r,2)=allDataStructure.child2(r);
    temp(r,3)=allDataStructure.child3(r);
    %temp(r,4)=allDataStructure.child4(r);
    %temp(r,5)=allDataStructure.child5(r);
    %temp(r,6)=allDataStructure.child6(r);
end
children = temp;
end