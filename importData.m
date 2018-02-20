function [ name, len, rad, parent, tips, nchild ] = importData (datafile)
%importData: a function that extracts vessel data from Angicart txt file  
%and places in an array with the name, length, radius, parent, tips
%
%INPUT: datafile: text file containing Angicart data
%
%OUTPUT: [name, len, rad, parent, tips]
% Returns the name, length, radius, parent, tips of vessel, each of which
% are column vectors
%
%EX:
% [name, len, rad, parent, tips] = importData (datafile)
%	
%	Caroline Choi, 8/19/17
% ==========================================================================
dataPath = [datafile];
[allDataStructure] = tdfread(dataPath, '\t');
name = cellstr(allDataStructure.name);
len = num2cell(allDataStructure.len);
rad = num2cell(allDataStructure.rad);
parent = cellstr(allDataStructure.parent);
tips = num2cell(allDataStructure.tips);
nchild = num2cell(allDataStructure.nchild);
end