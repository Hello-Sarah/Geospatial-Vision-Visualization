clc;
clear;
close all;

Path = 'C:\MATLABR2016a\bin\myworkspace\CS513\sample_drive\';
Dir = dir(Path);
for i = 1:length(Dir)
    %skip non-folders******************************************************
    if(isequal(Dir(i).name,'.')||...
            isequal(Dir(i).name,'..')||...
            ~Dir(i).isdir)
        continue;
    end
    %end skip non-folders**************************************************
    foldername = [Path Dir(i).name '\'];
    display(foldername);
    SmearDetector(foldername, Dir(i).name);
end
