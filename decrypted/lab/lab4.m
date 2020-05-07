%% Rectangle
Drawing(1).name='Rectangle';
Drawing(1).function(1).name='hole';
Drawing(1).function(1).fnc=@(data)circle(data(1),data(2),data(3));
Drawing(1).function(2).name='edge';
Drawing(1).function(2).fnc=@(data)line(data(1),data(2),data(3),data(4));
Drawing(1).color.off=color.lightBlue;
Drawing(1).color.on=color.lightRed;
Drawing(1).color.fix=color.black;
Drawing(1).color.joint=color.lightGreen;

Drawing(1).contextMenu = uicontextmenu;
FixDraw1=uiFix(Drawing(1).contextMenu);
uiFixAdd(FixDraw1);
uiUnFixAdd(FixDraw1)
ConDraw1=uiCon(Drawing(1).contextMenu);
uiConAdd(ConDraw1);
uiUnConAdd(ConDraw1)


accComp=0;

for ihole=1:2
    accComp=accComp+1;
dl=-11;
r=0.5;
y=8;
x0=8;
Drawing(1).component(accComp).name=['topHole_',num2str(ihole)];
Drawing(1).component(accComp).fnc=Drawing(1).function(1).fnc;
Drawing(1).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:2
    accComp=accComp+1;
dl=-9;
r=0.5;
y=2;
x0=7;
Drawing(1).component(accComp).name=['bottomHole_',num2str(ihole)];
Drawing(1).component(accComp).fnc=Drawing(1).function(1).fnc;
Drawing(1).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=0;
r=0.5;
y=4.994026;
x0=2.491039;
Drawing(1).component(accComp).name=['cdgHole_',num2str(ihole)];
Drawing(1).component(accComp).fnc=Drawing(1).function(1).fnc;
Drawing(1).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=0;
r=0.5;
y=6.111142;
x0=4.166713;
Drawing(1).component(accComp).name=['innerHole_',num2str(ihole)];
Drawing(1).component(accComp).fnc=Drawing(1).function(1).fnc;
Drawing(1).component(accComp).data=[x0+dl*(ihole-1),y,r];
end


accComp=accComp+1;

Drawing(1).component(accComp).name=['Edge_',1];
Drawing(1).component(accComp).fnc=Drawing(1).function(2).fnc;
Drawing(1).component(accComp).data=[-5,10,10,10];

accComp=accComp+1;

Drawing(1).component(accComp).name=['Edge_',2];
Drawing(1).component(accComp).fnc=Drawing(1).function(2).fnc;
Drawing(1).component(accComp).data=[10,10,10,0];

accComp=accComp+1;

Drawing(1).component(accComp).name=['Edge_',3];
Drawing(1).component(accComp).fnc=Drawing(1).function(2).fnc;
Drawing(1).component(accComp).data=[10,-5,0,0];

accComp=accComp+1;

Drawing(1).component(accComp).name=['Edge_',4];
Drawing(1).component(accComp).fnc=Drawing(1).function(2).fnc;
Drawing(1).component(accComp).data=[-5,-5,0,10];


%% Weight
for i=1:1

Drawing(1+i).name=sprintf('Weight_%i',i);

Drawing(1+i).color.off=color.lightyellow;
Drawing(1+i).color.on=color.lightRed;
Drawing(1+i).color.fix=color.black;
Drawing(1+i).color.joint=color.lightGreen;

Drawing(1+i).contextMenu = uicontextmenu;
%FixDraw3=uiFix(Drawing(3).contextMenu);
%uiFixAdd(FixDraw3);
%uiUnFixAdd(FixDraw3)
ConDraw3(i).ui=uiCon(Drawing(1+i).contextMenu);
uiConWeightAdd(ConDraw3(i).ui);
uiUnConWeightAdd(ConDraw3(i).ui);
uiSetWeight(Drawing(1+i).contextMenu);

accComp=0;
accComp=accComp+1;

Drawing(1+i).component(accComp).name=['WeightEdge_',1];
Drawing(1+i).component(accComp).fnc=@(data)quadrilater(data(1),data(2),data(3),data(4));
Drawing(1+i).component(accComp).data=[2,1,5*(i-1)+0,-20];

accComp=accComp+1;

Drawing(1+i).component(accComp).name=['WeightHole_',1];
Drawing(1+i).component(accComp).fnc=Drawing(1).function(1).fnc;
Drawing(1+i).component(accComp).data=[5*(i-1)+0,-20,0.5];

end

%% T-Beam
Drawing(3).name='T-Beam';
Drawing(3).function(1).name='hole';
Drawing(3).function(1).fnc=@(data)circle(data(1),data(2),data(3));
Drawing(3).function(2).name='edge';
Drawing(3).function(2).fnc=@(data)line(data(1),data(2),data(3),data(4));
Drawing(3).color.off=color.lightBlue;
Drawing(3).color.on=color.lightRed;
Drawing(3).color.fix=color.black;
Drawing(3).color.joint=color.lightGreen;

Drawing(3).contextMenu = uicontextmenu;
FixDraw1=uiFix(Drawing(3).contextMenu);
uiFixAdd(FixDraw1);
uiUnFixAdd(FixDraw1)
ConDraw1=uiCon(Drawing(3).contextMenu);
uiConAdd(ConDraw1);
uiUnConAdd(ConDraw1)


accComp=0;

for ihole=1:2
    accComp=accComp+1;
dl=6;
dy=-1;
r=0.5;
y=13;
x0=17;
Drawing(3).component(accComp).name=['topHole_',num2str(ihole)];
Drawing(3).component(accComp).fnc=Drawing(3).function(1).fnc;
Drawing(3).component(accComp).data=[x0+dl*(ihole-1),y+dy*(ihole-1),r];
end

for ihole=1:1
    accComp=accComp+1;
dl=0;
r=0.5;
y=2.727142;
x0=20;
Drawing(3).component(accComp).name=['bottomHole_',num2str(ihole)];
Drawing(3).component(accComp).fnc=Drawing(3).function(1).fnc;
Drawing(3).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=0;
r=0.5;
y=8.75;
x0=20;
Drawing(3).component(accComp).name=['cdgHole_',num2str(ihole)];
Drawing(3).component(accComp).fnc=Drawing(3).function(1).fnc;
Drawing(3).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=0;
r=0.5;
y=7.272858;
x0=20;
Drawing(3).component(accComp).name=['innerHole_',num2str(ihole)];
Drawing(3).component(accComp).fnc=Drawing(3).function(1).fnc;
Drawing(3).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

accComp=accComp+1;

Drawing(3).component(accComp).name=['Edge_',1];
Drawing(3).component(accComp).fnc=Drawing(3).function(2).fnc;
Drawing(3).component(accComp).data=[15,25,15,15];

accComp=accComp+1;

Drawing(3).component(accComp).name=['Edge_',2];
Drawing(3).component(accComp).fnc=Drawing(3).function(2).fnc;
Drawing(3).component(accComp).data=[25,25,15,10];

accComp=accComp+1;

Drawing(3).component(accComp).name=['Edge_',3];
Drawing(3).component(accComp).fnc=Drawing(3).function(2).fnc;
Drawing(3).component(accComp).data=[25,22.5,10,10];

accComp=accComp+1;

Drawing(3).component(accComp).name=['Edge_',4];
Drawing(3).component(accComp).fnc=Drawing(3).function(2).fnc;
Drawing(3).component(accComp).data=[22.5,22.5,10,0];

accComp=accComp+1;

Drawing(3).component(accComp).name=['Edge_',5];
Drawing(3).component(accComp).fnc=Drawing(3).function(2).fnc;
Drawing(3).component(accComp).data=[22.5,17.5,0,0];

accComp=accComp+1;

Drawing(3).component(accComp).name=['Edge_',6];
Drawing(3).component(accComp).fnc=Drawing(3).function(2).fnc;
Drawing(3).component(accComp).data=[17.5,17.5,0,10];

accComp=accComp+1;

Drawing(3).component(accComp).name=['Edge_',7];
Drawing(3).component(accComp).fnc=Drawing(3).function(2).fnc;
Drawing(3).component(accComp).data=[17.5,15,10,10];

accComp=accComp+1;

Drawing(3).component(accComp).name=['Edge_',8];
Drawing(3).component(accComp).fnc=Drawing(3).function(2).fnc;
Drawing(3).component(accComp).data=[15,15,10,15];


%% DoubleT-Beam
Drawing(4).name='DoubleT-Beam';
Drawing(4).function(1).name='hole';
Drawing(4).function(1).fnc=@(data)circle(data(1),data(2),data(3));
Drawing(4).function(2).name='edge';
Drawing(4).function(2).fnc=@(data)line(data(1),data(2),data(3),data(4));
Drawing(4).color.off=color.lightBlue;
Drawing(4).color.on=color.lightRed;
Drawing(4).color.fix=color.black;
Drawing(4).color.joint=color.lightGreen;

Drawing(4).contextMenu = uicontextmenu;
FixDraw1=uiFix(Drawing(4).contextMenu);
uiFixAdd(FixDraw1);
uiUnFixAdd(FixDraw1)
ConDraw1=uiCon(Drawing(4).contextMenu);
uiConAdd(ConDraw1);
uiUnConAdd(ConDraw1)


accComp=0;

for ihole=1:2
    accComp=accComp+1;
dl=6;
dy=-1;
r=0.5;
y=13.5;
x0=-18;
Drawing(4).component(accComp).name=['topHole_',num2str(ihole)];
Drawing(4).component(accComp).fnc=Drawing(4).function(1).fnc;
Drawing(4).component(accComp).data=[x0+dl*(ihole-1),y+dy*(ihole-1),r];
end

for ihole=1:2
    accComp=accComp+1;
dl=2;
dy=-0.5;
r=0.5;
y=1.75;
x0=-16;
Drawing(4).component(accComp).name=['bottomHole_',num2str(ihole)];
Drawing(4).component(accComp).fnc=Drawing(4).function(1).fnc;
Drawing(4).component(accComp).data=[x0+dl*(ihole-1),y+dy*(ihole-1),r];
end

for ihole=1:1
    accComp=accComp+1;
dl=0;
r=0.5;
y=8.195710;
x0=-15;
Drawing(4).component(accComp).name=['innerHole_',num2str(ihole)];
Drawing(4).component(accComp).fnc=Drawing(4).function(1).fnc;
Drawing(4).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=0;
r=0.5;
y=9.688737;
x0=-15;
Drawing(4).component(accComp).name=['cdgHole_',num2str(ihole)];
Drawing(4).component(accComp).fnc=Drawing(4).function(1).fnc;
Drawing(4).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

accComp=accComp+1;

Drawing(4).component(accComp).name=['Edge_',1];
Drawing(4).component(accComp).fnc=Drawing(4).function(2).fnc;
Drawing(4).component(accComp).data=[-20,-10,15,15];

accComp=accComp+1;

Drawing(4).component(accComp).name=['Edge_',2];
Drawing(4).component(accComp).fnc=Drawing(4).function(2).fnc;
Drawing(4).component(accComp).data=[-10,-10,15,11];

accComp=accComp+1;

Drawing(4).component(accComp).name=['Edge_',3];
Drawing(4).component(accComp).fnc=Drawing(4).function(2).fnc;
Drawing(4).component(accComp).data=[-10,-14,11,11];

accComp=accComp+1;

Drawing(4).component(accComp).name=['Edge_',4];
Drawing(4).component(accComp).fnc=Drawing(4).function(2).fnc;
Drawing(4).component(accComp).data=[-14,-14,11,3];

accComp=accComp+1;

Drawing(4).component(accComp).name=['Edge_',5];
Drawing(4).component(accComp).fnc=Drawing(4).function(2).fnc;
Drawing(4).component(accComp).data=[-14,-13,3,3];

accComp=accComp+1;

Drawing(4).component(accComp).name=['Edge_',6];
Drawing(4).component(accComp).fnc=Drawing(4).function(2).fnc;
Drawing(4).component(accComp).data=[-13,-13,3,0];

accComp=accComp+1;

Drawing(4).component(accComp).name=['Edge_',7];
Drawing(4).component(accComp).fnc=Drawing(4).function(2).fnc;
Drawing(4).component(accComp).data=[-13,-17,0,0];

accComp=accComp+1;

Drawing(4).component(accComp).name=['Edge_',8];
Drawing(4).component(accComp).fnc=Drawing(4).function(2).fnc;
Drawing(4).component(accComp).data=[-17,-17,0,3];

accComp=accComp+1;

Drawing(4).component(accComp).name=['Edge_',9];
Drawing(4).component(accComp).fnc=Drawing(4).function(2).fnc;
Drawing(4).component(accComp).data=[-17,-16,3,3];

accComp=accComp+1;

Drawing(4).component(accComp).name=['Edge_',10];
Drawing(4).component(accComp).fnc=Drawing(4).function(2).fnc;
Drawing(4).component(accComp).data=[-16,-16,3,11];

accComp=accComp+1;

Drawing(4).component(accComp).name=['Edge_',11];
Drawing(4).component(accComp).fnc=Drawing(4).function(2).fnc;
Drawing(4).component(accComp).data=[-16,-20,11,11];

accComp=accComp+1;

Drawing(4).component(accComp).name=['Edge_',12];
Drawing(4).component(accComp).fnc=Drawing(4).function(2).fnc;
Drawing(4).component(accComp).data=[-20,-20,11,15];

%% Triangle
Drawing(5).name='Triangle';
Drawing(5).function(1).name='hole';
Drawing(5).function(1).fnc=@(data)circle(data(1),data(2),data(3));
Drawing(5).function(2).name='edge';
Drawing(5).function(2).fnc=@(data)line(data(1),data(2),data(3),data(4));
Drawing(5).color.off=color.lightBlue;
Drawing(5).color.on=color.lightRed;
Drawing(5).color.fix=color.black;
Drawing(5).color.joint=color.lightGreen;

Drawing(5).contextMenu = uicontextmenu;
FixDraw1=uiFix(Drawing(5).contextMenu);
uiFixAdd(FixDraw1);
uiUnFixAdd(FixDraw1)
ConDraw1=uiCon(Drawing(5).contextMenu);
uiConAdd(ConDraw1);
uiUnConAdd(ConDraw1)


accComp=0;

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-9.5;
x0=0;
Drawing(5).component(accComp).name=['topHole_',num2str(ihole)];
Drawing(5).component(accComp).fnc=Drawing(5).function(1).fnc;
Drawing(5).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:2
    accComp=accComp+1;
dl=6;
r=0.5;
y=-13.5;
x0=-3;
Drawing(5).component(accComp).name=['bottomHole_',num2str(ihole)];
Drawing(5).component(accComp).fnc=Drawing(5).function(1).fnc;
Drawing(5).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=0;
r=0.5;
y=-11.646229;
x0=0;
Drawing(5).component(accComp).name=['cdgHole_',num2str(ihole)];
Drawing(5).component(accComp).fnc=Drawing(5).function(1).fnc;
Drawing(5).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

accComp=accComp+1;

Drawing(5).component(accComp).name=['Edge_',1];
Drawing(5).component(accComp).fnc=Drawing(5).function(2).fnc;
Drawing(5).component(accComp).data=[0,6,-5,-15];

accComp=accComp+1;

Drawing(5).component(accComp).name=['Edge_',2];
Drawing(5).component(accComp).fnc=Drawing(5).function(2).fnc;
Drawing(5).component(accComp).data=[6,-6,-15,-15];

accComp=accComp+1;

Drawing(5).component(accComp).name=['Edge_',3];
Drawing(5).component(accComp).fnc=Drawing(5).function(2).fnc;
Drawing(5).component(accComp).data=[-6,0,-15,-5];


%% Romboid
Drawing(6).name='Romboid';
Drawing(6).function(1).name='hole';
Drawing(6).function(1).fnc=@(data)circle(data(1),data(2),data(3));
Drawing(6).function(2).name='edge';
Drawing(6).function(2).fnc=@(data)line(data(1),data(2),data(3),data(4));
Drawing(6).color.off=color.lightBlue;
Drawing(6).color.on=color.lightRed;
Drawing(6).color.fix=color.black;
Drawing(6).color.joint=color.lightGreen;

Drawing(6).contextMenu = uicontextmenu;
FixDraw1=uiFix(Drawing(6).contextMenu);
uiFixAdd(FixDraw1);
uiUnFixAdd(FixDraw1)
ConDraw1=uiCon(Drawing(6).contextMenu);
uiConAdd(ConDraw1);
uiUnConAdd(ConDraw1)


accComp=0;

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-7;
x0=15;
Drawing(6).component(accComp).name=['topHole_',num2str(ihole)];
Drawing(6).component(accComp).fnc=Drawing(6).function(1).fnc;
Drawing(6).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-22;
x0=15;
Drawing(6).component(accComp).name=['bottomHole_',num2str(ihole)];
Drawing(6).component(accComp).fnc=Drawing(6).function(1).fnc;
Drawing(6).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-10;
x0=11.5;
Drawing(6).component(accComp).name=['leftHole_',num2str(ihole)];
Drawing(6).component(accComp).fnc=Drawing(6).function(1).fnc;
Drawing(6).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-10;
x0=18.5;
Drawing(6).component(accComp).name=['rightHole_',num2str(ihole)];
Drawing(6).component(accComp).fnc=Drawing(6).function(1).fnc;
Drawing(6).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-10.686839;
x0=15;
Drawing(6).component(accComp).name=['innerHole_',num2str(ihole)];
Drawing(6).component(accComp).fnc=Drawing(6).function(1).fnc;
Drawing(6).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=0;
r=0.5;
y=-13.045820;
x0=15;
Drawing(6).component(accComp).name=['cdgHole_',num2str(ihole)];
Drawing(6).component(accComp).fnc=Drawing(6).function(1).fnc;
Drawing(6).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

accComp=accComp+1;

Drawing(6).component(accComp).name=['Edge_',1];
Drawing(6).component(accComp).fnc=Drawing(6).function(2).fnc;
Drawing(6).component(accComp).data=[15,20,-5,-10];

accComp=accComp+1;

Drawing(6).component(accComp).name=['Edge_',2];
Drawing(6).component(accComp).fnc=Drawing(6).function(2).fnc;
Drawing(6).component(accComp).data=[20,15,-10,-24];

accComp=accComp+1;

Drawing(6).component(accComp).name=['Edge_',3];
Drawing(6).component(accComp).fnc=Drawing(6).function(2).fnc;
Drawing(6).component(accComp).data=[15,10,-24,-10];

accComp=accComp+1;

Drawing(6).component(accComp).name=['Edge_',4];
Drawing(6).component(accComp).fnc=Drawing(6).function(2).fnc;
Drawing(6).component(accComp).data=[10,15,-10,-5];

%% Bolus
Drawing(7).name='Bolus';
Drawing(7).function(1).name='hole';
Drawing(7).function(1).fnc=@(data)circle(data(1),data(2),data(3));
Drawing(7).function(2).name='edge';
Drawing(7).function(2).fnc=@(data)line(data(1),data(2),data(3),data(4));
Drawing(7).color.off=color.lightBlue;
Drawing(7).color.on=color.lightRed;
Drawing(7).color.fix=color.black;
Drawing(7).color.joint=color.lightGreen;

Drawing(7).contextMenu = uicontextmenu;
FixDraw1=uiFix(Drawing(7).contextMenu);
uiFixAdd(FixDraw1);
uiUnFixAdd(FixDraw1)
ConDraw1=uiCon(Drawing(7).contextMenu);
uiConAdd(ConDraw1);
uiUnConAdd(ConDraw1)


accComp=0;

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-7;
x0=-16 ;
Drawing(7).component(accComp).name=['topLHole_',num2str(ihole)];
Drawing(7).component(accComp).fnc=Drawing(7).function(1).fnc;
Drawing(7).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-8;
x0=-12;
Drawing(7).component(accComp).name=['topRHole_',num2str(ihole)];
Drawing(7).component(accComp).fnc=Drawing(7).function(1).fnc;
Drawing(7).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-12;
x0=-14;
Drawing(7).component(accComp).name=['innerHole_',num2str(ihole)];
Drawing(7).component(accComp).fnc=Drawing(7).function(1).fnc;
Drawing(7).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=0;
r=0.5;
y=-13.143990;
x0=-14;
Drawing(7).component(accComp).name=['cdgHole_',num2str(ihole)];
Drawing(7).component(accComp).fnc=Drawing(7).function(1).fnc;
Drawing(7).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-19;
x0=-16;
Drawing(7).component(accComp).name=['bottomLHole_',num2str(ihole)];
Drawing(7).component(accComp).fnc=Drawing(7).function(1).fnc;
Drawing(7).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-18;
x0=-12;
Drawing(7).component(accComp).name=['bottomRHole_',num2str(ihole)];
Drawing(7).component(accComp).fnc=Drawing(7).function(1).fnc;
Drawing(7).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-20;
x0=-14;
Drawing(7).component(accComp).name=['bottomCHole_',num2str(ihole)];
Drawing(7).component(accComp).fnc=Drawing(7).function(1).fnc;
Drawing(7).component(accComp).data=[x0+dl*(ihole-1),y,r];
end


accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',1];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-15,-13,-5,-5];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',2];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-13,-11,-5,-6];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',3];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-11,-10,-6,-9];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',4];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-10,-11,-9,-11];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',5];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-11,-12,-11,-12];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',6];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-12,-13,-12,-14];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',7];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-13,-10,-14,-16];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',8];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-10,-10,-16,-19];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',9];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-10,-12,-19,-21];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',10];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-12,-16,-21,-21];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',11];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-16,-18,-21,-19];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',12];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-18,-18,-19,-16];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',13];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-18,-15,-16,-14];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',14];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-15,-16,-14,-12];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',15];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-16,-17,-12,-11];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',16];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-17,-18,-11,-9];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',17];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-18,-17,-9,-6];

accComp=accComp+1;

Drawing(7).component(accComp).name=['Edge_',18];
Drawing(7).component(accComp).fnc=Drawing(7).function(2).fnc;
Drawing(7).component(accComp).data=[-17,-15,-6,-5];

%% Arrow
Drawing(8).name='Arrow';
Drawing(8).function(1).name='hole';
Drawing(8).function(1).fnc=@(data)circle(data(1),data(2),data(3));
Drawing(8).function(2).name='edge';
Drawing(8).function(2).fnc=@(data)line(data(1),data(2),data(3),data(4));
Drawing(8).color.off=color.lightBlue;
Drawing(8).color.on=color.lightRed;
Drawing(8).color.fix=color.black;
Drawing(8).color.joint=color.lightGreen;

Drawing(8).contextMenu = uicontextmenu;
FixDraw1=uiFix(Drawing(8).contextMenu);
uiFixAdd(FixDraw1);
uiUnFixAdd(FixDraw1)
ConDraw1=uiCon(Drawing(8).contextMenu);
uiConAdd(ConDraw1);
uiUnConAdd(ConDraw1)


accComp=0;

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-11;
x0=26 ;
Drawing(8).component(accComp).name=['topLHole_',num2str(ihole)];
Drawing(8).component(accComp).fnc=Drawing(8).function(1).fnc;
Drawing(8).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-12;
x0=28;
Drawing(8).component(accComp).name=['topRHole_',num2str(ihole)];
Drawing(8).component(accComp).fnc=Drawing(8).function(1).fnc;
Drawing(8).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-18;
x0=27;
Drawing(8).component(accComp).name=['innerHole_',num2str(ihole)];
Drawing(8).component(accComp).fnc=Drawing(8).function(1).fnc;
Drawing(8).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=0;
r=0.5;
y=-16.170419;
x0=27;
Drawing(8).component(accComp).name=['cdgHole_',num2str(ihole)];
Drawing(8).component(accComp).fnc=Drawing(8).function(1).fnc;
Drawing(8).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-17;
x0=24;
Drawing(8).component(accComp).name=['bottomLHole_',num2str(ihole)];
Drawing(8).component(accComp).fnc=Drawing(8).function(1).fnc;
Drawing(8).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-16;
x0=30;
Drawing(8).component(accComp).name=['bottomRHole_',num2str(ihole)];
Drawing(8).component(accComp).fnc=Drawing(8).function(1).fnc;
Drawing(8).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:1
    accComp=accComp+1;
dl=6;
r=0.5;
y=-21;
x0=27;
Drawing(8).component(accComp).name=['bottomCHole_',num2str(ihole)];
Drawing(8).component(accComp).fnc=Drawing(8).function(1).fnc;
Drawing(8).component(accComp).data=[x0+dl*(ihole-1),y,r];
end


accComp=accComp+1;

Drawing(8).component(accComp).name=['Edge_',1];
Drawing(8).component(accComp).fnc=Drawing(8).function(2).fnc;
Drawing(8).component(accComp).data=[25,29,-10,-10];

accComp=accComp+1;

Drawing(8).component(accComp).name=['Edge_',2];
Drawing(8).component(accComp).fnc=Drawing(8).function(2).fnc;
Drawing(8).component(accComp).data=[29,29,-10,-15];

accComp=accComp+1;

Drawing(8).component(accComp).name=['Edge_',3];
Drawing(8).component(accComp).fnc=Drawing(8).function(2).fnc;
Drawing(8).component(accComp).data=[29,22,-15,-15];

accComp=accComp+1;

Drawing(8).component(accComp).name=['Edge_',4];
Drawing(8).component(accComp).fnc=Drawing(8).function(2).fnc;
Drawing(8).component(accComp).data=[33,27,-15,-23];

accComp=accComp+1;

Drawing(8).component(accComp).name=['Edge_',5];
Drawing(8).component(accComp).fnc=Drawing(8).function(2).fnc;
Drawing(8).component(accComp).data=[27,21,-23,-15];

accComp=accComp+1;

Drawing(8).component(accComp).name=['Edge_',6];
Drawing(8).component(accComp).fnc=Drawing(8).function(2).fnc;
Drawing(8).component(accComp).data=[21,25,-15,-15];

accComp=accComp+1;

Drawing(8).component(accComp).name=['Edge_',7];
Drawing(8).component(accComp).fnc=Drawing(8).function(2).fnc;
Drawing(8).component(accComp).data=[25,25,-15,-10];



