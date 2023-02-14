% *** Set the path ***
% Get the name oh this file (the full path)
currentFile = mfilename('fullpath');

[pathstr,~,~] = fileparts(currentFile);
cd(pathstr);
cd ..;
cd ..;
addpath(genpath('MatLAB'));
cd MatLAB\;


% *** Adjust the linewidth of every plot ***
set(0,'DefaultLineLineWidth',1.75);