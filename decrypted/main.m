clear all;clc;close all force;w = warning ('off','all');

addpath('lab');
global labNum;
display('Laboratory:');
display('   1 - Equilibrium of Forces ')
display('   2 - Equilibrium of Moments ')
display('   3 - Lever and Beam Reactions ')
display('   4 - Centroids and Centre of Gravity ')
display('   5 - Dry Friction ')
if (false)
    labNum=3;
else
    labNum=input('Select from 1 to 5 which laboratory you want to load: ');
end
clc
h_fig=figure(1);clf;

p = uipanel('Parent',h_fig,'Title','App','Position',[0.0 0.0 1.0 1.0]);
sp = uipanel('Parent',p,'Title','Control','Position',[0.0 0.9 1.0 0.1]);
sf = uipanel('Parent',p,'Title','Simulator','Position',[0.0 0.0 1.0 0.9]);
ax=axes(sf);
%%

global linkShp UnLinkContextMenu Fixation;
run render.m
global shp;
global state;
state.type='null';

%{
uicontrol('Style', 'Pushbutton', 'String', 'Hello', ...
          'TooltipString', ['This is the Tooltip string!', char(10), ...
          'And a 2nd line also.']);
%}


%% input drawing

% board dimensions
global xdim ydim;
xdim =[-30,30];
ydim=[-30,10];
run drawing;

%%
%w = waitforbuttonpress;h
%{
x=1;y=1;
while(x>0.5&&y>0.5&&false)
%[x, y] = ginput(1);
x_ = get(figure(1),'CurrentPoint'); x=x_(1);y=x_(2);
c= get(figure(1),'CurrentCharacter');
display(sprintf('x=%f\ty=%f\tc=%s',x,y,c));
w = waitforbuttonpress;
end
%}
shp=PlotIt(Drawing);
set (h_fig, 'WindowButtonMotionFcn', mouseMove);
set (h_fig, 'WindowButtonDownFcn', mouseClickDown);
set (h_fig, 'WindowButtonUpFcn', mouseClickUp);
set (h_fig, 'WindowScrollWheelFcn', mouseScrollWheel);
set (ax,'uicontextmenu',rightClickMenu);

%catch err
   % display(err);

%end

display('Loading...');

pause(5);
clc;
display('Loaded');


