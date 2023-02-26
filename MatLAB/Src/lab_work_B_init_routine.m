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

blue=[0, 0.4470, 0.7410];
red=[0.8500, 0.3250, 0.0980];
yellow=[0.9290, 0.6940, 0.1250];