%% UI
rightClickMenu = uicontextmenu;
m1 = uimenu(rightClickMenu,'Label','Reset View','Callback',@ZoomReset);

run simulate.m

global Fixation;
uicontrol('Parent',sp,'Style', 'Pushbutton', 'String', 'Reset App','Units', 'normal','Position',[0.0 0.0 0.15 0.5],"Callback", @StartNew);
uicontrol('Parent',sp,'Style', 'Pushbutton', 'String', 'Simulate','Units', 'normal','Position',[0.15 0.0 0.15 0.5],"Callback", Simulate);
Fixation=uicontrol('Parent',sp,'Style', 'popupmenu','Units', 'normal','Position',[0.30 0.0 0.15 0.5],"Callback", @SelectionFix);
uicontrol('Parent',sp,'Style', 'Pushbutton', 'String', 'Reset Simulation','Units', 'normal','Position',[0.45 0.0 0.15 0.5],"Callback", resetToOriginalShape);
%% Render

PlotIt=@(Drawing)PlotIt_(Drawing);
mouseMove=@(object, eventdata)mouseMove_(object, eventdata);
mouseClickDown=@(object,eventdata)mouseClickDown_(object,eventdata);
mouseClickUp=@(object,eventdata)mouseClickUp_(object,eventdata);
mouseScrollWheel=@(object,eventdata)mouseScrollWheel_(object,eventdata);

global linkShp;
   
function shp=PlotIt_(Drawing)
    global xdim ydim linkShp Fixation;
    shp.get=[];
    idraw=0;
    for iDraw=Drawing
        idraw=idraw+1;
        clear HoleData MecanismData;
        MecanismData=[];
        HoleData.Hole=[];
        iHole=0;
        for iComp=iDraw.component
            m=iComp.fnc(iComp.data);
            %x=m(1,:);y=m(2,:);
            if (contains(lower(iComp.name),'edge_')) ; 
                MecanismData=[MecanismData;m'];
            elseif (contains(lower(iComp.name),'hole_')); 
                iHole=iHole+1;
                HoleData(iHole).Hole=m';
            end
            
            %hold on
            %plot(x,y,'b');
            %hold off
        end
        MecanismP=polyshape(MecanismData);
        shp(idraw).mecanism=MecanismP;
        DrawP=MecanismP;
        iHole=0;
        for iHoleP=HoleData
            if (isempty(iHoleP.Hole)); continue; end;
            iHole=iHole+1;
            HoleP=polyshape(iHoleP.Hole);
            DrawP=subtract(DrawP,HoleP);
            shp(idraw).hole(iHole).shape=HoleP;
            
        end
        shp(idraw).name=iDraw.name;
        hold on
        shp(idraw).get=plot(DrawP);
        shp(idraw).fix=plot(polyshape([0,0]));
        shp(idraw).con=plot(polyshape([0,0]));
        hold off
        shp(idraw).get.Tag=iDraw.name;
        shp(idraw).color=iDraw.color;
        shp(idraw).pos.x=0;
        shp(idraw).pos.y=0;
        shp(idraw).posPrev.x=0;
        shp(idraw).posPrev.y=0;
        shp(idraw).UserData.weight=[];
        
        if (~isempty(iDraw.contextMenu))
            iDraw.contextMenu.UserData=idraw;
            shp(idraw).get.UIContextMenu=iDraw.contextMenu;
        end
        
    end
    
    global linkShp Fixation;
    Fixation.String=addSelection(shp);
    %hold on
    linkShp.itm.get=[];%plot(polyshape([0,0]));
    %hold off
    linkShp.itm.link.start=[];linkShp.itm.link.end=[];linkShp.cnt=0;
    linkShp.itm.hasWeight.start=[];linkShp.itm.hasWeight.end=[];
    
xlim(xdim);
ylim(ydim);
axis equal manual;
grid on ;
grid minor;
end

function mouseMove_(object, eventdata)
global state shp;
    
    switch (state.type)
        case 'overDrawing'
            C = get (gca, 'CurrentPoint');
            x=C(1,1);y=C(1,2);
            hoverMouse(object,eventdata,x,y);
            mouseToolTip(object, eventdata,x,y)
        case 'null'
            C = get (gca, 'CurrentPoint');
            x=C(1,1);y=C(1,2);
            hoverMouse(object,eventdata,x,y);
            mouseToolTip(object, eventdata,x,y)
        case 'mouseDown'
            
            C = get (gca, 'CurrentPoint');
            x1=C(1,1);y1=C(1,2);
            x0=state.temp;y0=x0(2);x0=x0(1);
            if(~isempty(state.object))
                ishp=shp(state.object);
                moveShape(ishp,x1-x0,y1-y0,false);
            else
                state.type='null';
            end
            %state.type='null';
            state.temp=[x1,y1];
        case 'mousePan'
            C = get (gca, 'CurrentPoint');
            x1=C(1,1);y1=C(1,2);
            x0=state.temp;y0=x0(2);x0=x0(1);
            ax=axis;
            dx=x1-x0;dy=y1-y0;
            axis(ax+[-dx,-dx,-dy,-dy]);
            %state.type='null';
            state.temp=[x1,y1];
        otherwise
    end


end

function hoverMouse(object, eventdata,x,y)
global shp state;
    bool=false;
    state.object=[];iShpCounter=0;
    for ishp=shp
        iShpCounter=iShpCounter+1;
        if(isinterior(ishp.get.Shape,x,y)&&~bool)
            state.object=iShpCounter;
            state.type='overDrawing';
            ishp.get.FaceColor=ishp.color.on;
            bool=true;
            %c='yes';
        else
            ishp.get.FaceColor=ishp.color.off;
            %c='no';
        end    
    end
    %title(gca, ['(X,Y) = (', num2str(x), ', ',num2str(y), ')\t',c]);
end

function moveShape(shapeContainer,dx,dy,bool)
    global shp state linkShp;
    i=state.object;
    shp(i).pos.x=shp(i).pos.x+dx;
    shp(i).pos.y=shp(i).pos.y+dy;
    shapeContainer.get.Shape=translate(shapeContainer.get.Shape,dx,dy);
    shapeContainer.fix.Shape=translate(shapeContainer.fix.Shape,dx,dy);
    shapeContainer.con.Shape=translate(shapeContainer.con.Shape,dx,dy);
    if(bool)
        for ihole=1:length(shp(i).hole)
            shp(i).hole(ihole).shape=translate(shp(i).hole(ihole).shape,...
                shp(state.object).pos.x-shp(state.object).posPrev.x,...
                shp(state.object).pos.y-shp(state.object).posPrev.y);
        end
        for ilink=1:linkShp.cnt
            boolLink=false;
            
                if (isnan(linkShp.itm(ilink).link.start(2)))
                     [xstart, ystart] = centroid(shp(linkShp.itm(ilink).link.start(1)).con.Shape);
                else
                     [xstart, ystart] = centroid(shp(linkShp.itm(ilink).link.start(1)).hole(linkShp.itm(ilink).link.start(2)).shape);
                end
                
                if (isnan(linkShp.itm(ilink).link.end(2)))
                    [xend, yend]     = centroid(shp(linkShp.itm(ilink).link.end(1)).con.Shape);
                else
                    [xend, yend]     = centroid(shp(linkShp.itm(ilink).link.end(1)).hole(linkShp.itm(ilink).link.end(2)).shape);
                end
                
                %display(shp(state.object).pos.x-shp(state.object).posPrev.x)
                %display(shp(state.object).pos.y-shp(state.object).posPrev.y)
            if(linkShp.itm(ilink).link.start(1)==i)   
                %xstart=xstart+shp(state.object).pos.x-shp(state.object).posPrev.x;
                %ystart=ystart+shp(state.object).pos.y-shp(state.object).posPrev.y;
                boolLink=true;
            elseif(linkShp.itm(ilink).link.end(1)==i)
                %xend=xend+shp(state.object).pos.x-shp(state.object).posPrev.x;
                %yend=yend+shp(state.object).pos.y-shp(state.object).posPrev.y;
                boolLink=true;
            end
            if (boolLink)
                linkShp.itm(ilink).get.Shape=polyshape([xstart,ystart;xend,yend;xstart-1e-4,ystart-1e-4]);
            end
        end
            shp(i).posPrev.x=shp(i).pos.x;
            shp(i).posPrev.y=shp(i).pos.y;
    end
end

function mouseClickUp_(object,eventdata)
global state shp;
    switch (state.type)
        case 'overDrawing'
            
        case 'mouseDown'
            C = get (gca, 'CurrentPoint');
            x1=C(1,1);y1=C(1,2);
            x0=state.temp;y0=x0(2);x0=x0(1);
            if(~isempty(state.object))
                ishp=shp(state.object);
                moveShape(ishp,x1-x0,y1-y0,true);
            end
            state.type='null';
        case 'mousePan'
            C = get (gca, 'CurrentPoint');
            x1=C(1,1);y1=C(1,2);
            x0=state.temp;y0=x0(2);x0=x0(1);
            ax=axis;
            dx=x1-x0;dy=y1-y0;
            axis(ax+[-dx,-dx,-dy,-dy]);
            state.type='null';
        otherwise
    end
end

function mouseClickDown_(object,eventdata)
global state;
    switch(object.SelectionType)
        case "normal"
            switch (state.type)
                case 'overDrawing'
                    C = get (gca, 'CurrentPoint');
                    x=C(1,1);y=C(1,2);
                    state.temp=[x,y];
                    state.type='mouseDown';
                otherwise
                    C = get (gca, 'CurrentPoint');
                    x=C(1,1);y=C(1,2);
                    state.temp=[x,y];
                    state.type='mousePan';
            end
        otherwise
            state.type='null';
    end
end

function mouseScrollWheel_(object,eventdata)
global state;
C = get (gca, 'CurrentPoint');
x=C(1,1);y=C(1,2);
ax=axis;

DeltaZoom=0.2;
if(eventdata.VerticalScrollCount<0)
    factor=DeltaZoom*-eventdata.VerticalScrollCount;
elseif(eventdata.VerticalScrollCount>0)
    factor=-DeltaZoom*eventdata.VerticalScrollCount;
end
dxLeft=(x-ax(1))*factor;
dxRight=-(x-ax(2))*factor;
dyBot=(y-ax(3))*factor;
dyTop=-(y-ax(4))*factor;
axis(ax+[+dxLeft,-dxRight,dyBot,-dyTop]);
    %display(eventdata);
end

function mouseToolTip(object, eventdata,x,y)
    global state shp;
    global txtToolTip;
    try
        txtToolTip.delete;
    end
    if (~isempty(state.object))
        txt=shp(state.object).get.Tag;
        dr=0.05;
        ax=axis;
        txtToolTip=text(x+(ax(2)-ax(1))*dr,y+(ax(4)-ax(3))*dr,txt);
    end
end

function StartNew(object,eventdata)
    run main;
end

function ZoomReset(object,eventdata)
    global xdim ydim;
    xlim(xdim);
    ylim(ydim);
    datacursormode off
end

function str=addSelection(shp)
    str={};
    for ishp=shp
        str={str{:},ishp.name};
    end
end

function SelectionFix(src,event)
        %val = c.Value;
        %str = c.String;
        %str{val};
        %disp(['Selection: ' str{val}]);

end


