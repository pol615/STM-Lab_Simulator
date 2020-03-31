%% Balance
Drawing(1).name='Lever';
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




for ihole=1:6
    accComp=accComp+1;
dl=2;
r=0.5;
y=8;
x0=-16+1;
Drawing(1).component(accComp).name=['leftHole_',num2str(ihole)];
Drawing(1).component(accComp).fnc=Drawing(1).function(1).fnc;
Drawing(1).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:6
    accComp=accComp+1;
dl=-2;
r=0.5;
y=8;
x0=16-1;
Drawing(1).component(accComp).name=['rightHole_',num2str(ihole)];
Drawing(1).component(accComp).fnc=Drawing(1).function(1).fnc;
Drawing(1).component(accComp).data=[x0+dl*(ihole-1),y,r];
end

for ihole=1:3
    accComp=accComp+1;
dl=2;
r=0.5;
y0=0+1;
x=0;
Drawing(1).component(accComp).name=['verticalHole_',num2str(ihole)];
Drawing(1).component(accComp).fnc=Drawing(1).function(1).fnc;
Drawing(1).component(accComp).data=[x,y0+dl*(ihole-1),r];
end

for ihole=1:1
    accComp=accComp+1;
dl=2;
r=0.3;
y=7;
x=0;
Drawing(1).component(accComp).name=['pinHole_',num2str(ihole)];
Drawing(1).component(accComp).fnc=Drawing(1).function(1).fnc;
Drawing(1).component(accComp).data=[x,y,r];
end


accComp=accComp+1;

Drawing(1).component(accComp).name=['Edge_',1];
Drawing(1).component(accComp).fnc=Drawing(1).function(2).fnc;
Drawing(1).component(accComp).data=[-16,16,9,9];

accComp=accComp+1;

Drawing(1).component(accComp).name=['Edge_',2];
Drawing(1).component(accComp).fnc=Drawing(1).function(2).fnc;
Drawing(1).component(accComp).data=[16,16,9,7];

accComp=accComp+1;

Drawing(1).component(accComp).name=['Edge_',3];
Drawing(1).component(accComp).fnc=Drawing(1).function(2).fnc;
Drawing(1).component(accComp).data=[16,1,7,7];

accComp=accComp+1;

Drawing(1).component(accComp).name=['Edge_',4];
Drawing(1).component(accComp).fnc=Drawing(1).function(2).fnc;
Drawing(1).component(accComp).data=[1,1,7,0];

accComp=accComp+1;

Drawing(1).component(accComp).name=['Edge_',5];
Drawing(1).component(accComp).fnc=Drawing(1).function(2).fnc;
Drawing(1).component(accComp).data=[1,-1,0,0];

accComp=accComp+1;

Drawing(1).component(accComp).name=['Edge_',6];
Drawing(1).component(accComp).fnc=Drawing(1).function(2).fnc;
Drawing(1).component(accComp).data=[-1,-1,0,7];

accComp=accComp+1;

Drawing(1).component(accComp).name=['Edge_',7];
Drawing(1).component(accComp).fnc=Drawing(1).function(2).fnc;
Drawing(1).component(accComp).data=[-1,-16,7,7];

accComp=accComp+1;

Drawing(1).component(accComp).name=['Edge_',8];
Drawing(1).component(accComp).fnc=Drawing(1).function(2).fnc;
Drawing(1).component(accComp).data=[-16,-16,7,9];



error("Implement Ring mechanism");





%% Pulley
DRAWINGCNT=1;

for iDRAWING=1:4
    DRAWINGCNT=1+DRAWINGCNT;
    
Drawing(DRAWINGCNT).name=sprintf('Pulley_',iDRAWING);

Drawing(DRAWINGCNT).color.off=color.lightBlue;
Drawing(DRAWINGCNT).color.on=color.lightRed;
Drawing(DRAWINGCNT).color.fix=color.black;
Drawing(DRAWINGCNT).color.joint=color.lightGreen;

Drawing(DRAWINGCNT).contextMenu = uicontextmenu;
FixDraw2=uiFix(Drawing(DRAWINGCNT).contextMenu);
uiFixAdd(FixDraw2);
uiUnFixAdd(FixDraw2)
ConDraw2=uiConPulley(Drawing(DRAWINGCNT).contextMenu);
uiConPulleyAdd(ConDraw2);
uiUnConPulleyAdd(ConDraw2)

Drawing(DRAWINGCNT).con.contextMenu=uicontextmenu;

accComp=0;
accComp=accComp+1;

Drawing(DRAWINGCNT).component(accComp).name=[sprintf('PulleyEdge_%i_',DRAWINGCNT),1];
Drawing(DRAWINGCNT).component(accComp).fnc=Drawing(1).function(1).fnc;
Drawing(DRAWINGCNT).component(accComp).data=[-16+6*(iDRAWING-1),-14,2.5];

accComp=accComp+1;

Drawing(DRAWINGCNT).component(accComp).name=[sprintf('PulleyHole_%i_',DRAWINGCNT),1];
Drawing(DRAWINGCNT).component(accComp).fnc=Drawing(1).function(1).fnc;
Drawing(DRAWINGCNT).component(accComp).data=[-16+6*(iDRAWING-1),-14,1];

end


%% Weight

for i=1:5
DRAWINGCNT=1+DRAWINGCNT;
    
Drawing(DRAWINGCNT).name=sprintf('Weight_%i',i);

Drawing(DRAWINGCNT).color.off=color.lightyellow;
Drawing(DRAWINGCNT).color.on=color.lightRed;
Drawing(DRAWINGCNT).color.fix=color.black;
Drawing(DRAWINGCNT).color.joint=color.lightGreen;

Drawing(DRAWINGCNT).contextMenu = uicontextmenu;
%FixDraw3=uiFix(Drawing(3).contextMenu);
%uiFixAdd(FixDraw3);
%uiUnFixAdd(FixDraw3)
ConDraw3(i).ui=uiCon(Drawing(DRAWINGCNT).contextMenu);
uiConWeightAdd(ConDraw3(i).ui);
uiUnConWeightAdd(ConDraw3(i).ui);
uiSetWeight(Drawing(DRAWINGCNT).contextMenu);

accComp=0;
accComp=accComp+1;

Drawing(DRAWINGCNT).component(accComp).name=['WeightEdge_',1];
Drawing(DRAWINGCNT).component(accComp).fnc=@(data)quadrilater(data(1),data(2),data(3),data(4));
Drawing(DRAWINGCNT).component(accComp).data=[2,1,5*(i-1)+0,-20];

accComp=accComp+1;

Drawing(DRAWINGCNT).component(accComp).name=['WeightHole_',1];
Drawing(DRAWINGCNT).component(accComp).fnc=Drawing(1).function(1).fnc;
Drawing(DRAWINGCNT).component(accComp).data=[5*(i-1)+0,-20,0.5];

end
