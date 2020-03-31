%% Definitions

color.lightRed      =[0.7410    0.1000    0.0000];
color.lightGreen    =[0.0000    0.4470    0.0000];
color.lightBlue     =[0.0000    0.4470    0.7410];
color.lightyellow   =[1.0000    0.8431    0.0000];
color.black         =[0.0000    0.0000    0.0000] ;

% Fix
uiFix=@(c)uimenu(c,'Label','Fix');
uiFixAdd=@(c)uimenu(c,'Label','Add','Callback',@fixHole);
uiUnFixAdd=@(c)uimenu(c,'Label','Erase','Callback',@unfixHole);

% Connect
uiConWeight=@(c)uimenu(c,'Label','Con');
uiConWeightAdd=@(c)uimenu(c,'Label','Add','Callback',@conWeight);
uiUnConWeightAdd=@(c)uimenu(c,'Label','Erase','Callback',@unconWeight);

% Connect
uiCon=@(c)uimenu(c,'Label','Con');
uiConAdd=@(c)uimenu(c,'Label','Add','Callback',@conHole);
uiUnConAdd=@(c)uimenu(c,'Label','Erase','Callback',@unconHole);

% Connect
uiConPulley=@(c)uimenu(c,'Label','Con');
uiConPulleyAdd=@(c)uimenu(c,'Label','Add','Callback',@conPulley);
uiUnConPulleyAdd=@(c)uimenu(c,'Label','Erase','Callback',@unconPulley);

% Link
global LinkContextMenu UnLinkContextMenu LinkContextMenuPulley stateLbl linkShp;
global LinkContextMenuWeight;

stateLbl.text='Start';

uiLink=@(c)uimenu(c,'Label','Linking');
uiLinkAdd=@(c)uimenu(c,'Label','Start','Callback',@linkHole);
uiUnLink=@(c)uimenu(c,'Label','Erase','Callback',@unLink);

uiLinkAddPulley=@(c)uimenu(c,'Label','Start','Callback',@linkPulley);

uiLinkAddWeight=@(c)uimenu(c,'Label','Start','Callback',@linkWeight);
uiSetWeight=@(c)uimenu(c,'Label','Set Weight','Callback',@linkSetWeight);


LinkContextMenu=uicontextmenu;
LinkDraw=uiLink(LinkContextMenu);
uiLinkAdd(LinkDraw);

LinkContextMenuPulley=uicontextmenu;
LinkDraw=uiLink(LinkContextMenuPulley);
uiLinkAddPulley(LinkDraw);


UnLinkContextMenu=uiUnLink;

LinkContextMenuWeight=uicontextmenu;
LinkDraw2=uiLink(LinkContextMenuWeight);
uiLinkAddWeight(LinkDraw2);


dalpha=0.1;
alpha=0:dalpha:2*pi;

circle=@(x,y,r)([x+r*cos(alpha);y+r*sin(alpha)]);
line=@(x0,x1,y0,y1)([x0,x1;y0,y1]);
quadrilater=@(w,h,x,y)([x-w,x-w,x+w,x+w;y-h,y+h,y+h,y-h]);



run lab2;




function fixHole(object, eventdata)
global shp state;
    waitforbuttonpress
    C = get (gca, 'CurrentPoint');
    x=C(1,1);y=C(1,2);
    ishp=shp(object.Parent.Parent.UserData);
    bool=true;
    for iHole=ishp.hole
        if(isinterior(iHole.shape,x,y))
            state.type='null';state.object=[];
            if(sum(isinterior(ishp.fix.Shape,iHole.shape.Vertices))==0)
                ishp.get.Shape=union(ishp.get.Shape,iHole.shape);
                ishp.fix.Shape=union(ishp.fix.Shape,iHole.shape);
                ishp.fix.FaceColor=ishp.color.fix;
                ishp.fix.FaceAlpha=0.6;
            end
            bool=false;
            break;
        end
    end
    if(bool);display('Point is not inside a hole. Exiting addition of fixation.');end;
end



function unfixHole(object, eventdata)
global shp state;
    waitforbuttonpress
    C = get (gca, 'CurrentPoint');
    x=C(1,1);y=C(1,2);
    ishp=shp(object.Parent.Parent.UserData);
    bool=true;
    for iHole=ishp.hole
        if(isinterior(iHole.shape,x,y))
            state.type='null';state.object=[];
            ishp.get.Shape=subtract(ishp.get.Shape,iHole.shape);
            ishp.fix.Shape=subtract(ishp.fix.Shape,iHole.shape);
            bool=false;
            break;
        end
    end
    if(bool);display('Point is not inside a hole. Exiting erasing of fixation.');end;
end

function conWeight(object,eventdata)
global shp LinkContextMenuWeight;  
    ishp=shp(object.Parent.Parent.UserData);
    bool=true;
    ihole=0;
        ihole=ihole+1;
        iHole=ishp.hole;
            state.type='null';state.object=[];
                %ishp.get.Shape=union(ishp.get.Shape,iHole.shape);
                ishp.con.Shape=union(ishp.con.Shape,iHole.shape);
                ishp.con.FaceColor=ishp.color.joint;
                ishp.con.FaceAlpha=0.6;
                
                %ishp.con.ContextMenu=LinkContextMenuWeight;
                uiLink=@(c)uimenu(c,'Label','Linking');
                uiLinkAddWeight=@(c)uimenu(c,'Label','Start','Callback',@linkWeight);
                
                LinkContextMenuWeight2=uicontextmenu;
                LinkDraw2=uiLink(LinkContextMenuWeight2);
                uiLinkAddWeight(LinkDraw2);
                
                ishp.con.ContextMenu=LinkContextMenuWeight2;
                
                if (isfield(ishp.con.ContextMenu.UserData,'Con'))
                    ishp.con.ContextMenu.UserData.Con=[ishp.con.ContextMenu.UserData.Con;...
                                                object.Parent.Parent.UserData,ihole];
                else
                    ishp.con.ContextMenu.UserData.Con=[object.Parent.Parent.UserData,ihole];
                end
            bool=false;
    if(bool);display('Point is not inside a hole. Exiting addition of connection.');end;
end

function conHole(object, eventdata)
global shp state LinkContextMenu;
    waitforbuttonpress
    C = get (gca, 'CurrentPoint');
    x=C(1,1);y=C(1,2);
    ishp=shp(object.Parent.Parent.UserData);
    bool=true;
    ihole=0;
    for iHole=ishp.hole
        ihole=ihole+1;
        if(isinterior(iHole.shape,x,y))
            state.type='null';state.object=[];
            if(sum(isinterior(ishp.con.Shape,iHole.shape.Vertices))==0)
                %ishp.get.Shape=union(ishp.get.Shape,iHole.shape);
                ishp.con.Shape=union(ishp.con.Shape,iHole.shape);
                ishp.con.FaceColor=ishp.color.joint;
                ishp.con.FaceAlpha=0.6;
                
                ishp.con.ContextMenu=LinkContextMenu;
                if (isfield(ishp.con.ContextMenu.UserData,'Con'))
                    ishp.con.ContextMenu.UserData.Con=[ishp.con.ContextMenu.UserData.Con;...
                                                object.Parent.Parent.UserData,ihole];
                                            
                else
                    ishp.con.ContextMenu.UserData.Con=[object.Parent.Parent.UserData,ihole];
                end
                state.object=[object.Parent.Parent.UserData,ihole];
                
            end
            bool=false;
            break;
        end
    end
    if(bool);display('Point is not inside a hole. Exiting addition of connection.');end;
end

function linkHole(object,eventdata)
global shp state stateLbl linkShp UnLinkContextMenu;
clc;
    display(sprintf('Click on the %s connection...',stateLbl.text));
    waitforbuttonpress
    [x,y]=getMouseXY();
    switch(stateLbl.text)
        case 'Start'
            conHole=object.Parent.Parent.UserData.Con;
            boolFound=false;
            for iConHole=1:size(conHole,1)
                if (isinterior(shp(conHole(iConHole,1)).hole(conHole(iConHole,2)).shape,x,y))
                linkShp.itm(linkShp.cnt+1).link.start=conHole(iConHole,:);
                boolFound=true;
                break
                end
            end
            if (boolFound) stateLbl.text='End'; display('Selected point is correct'); else; display('Not a correct point');end;
        case 'End'
            conHole=object.Parent.Parent.UserData.Con;
            boolFound=false;
            for iConHole=1:size(conHole,1)
                if (isinterior(shp(conHole(iConHole,1)).hole(conHole(iConHole,2)).shape,x,y))
                linkShp.itm(linkShp.cnt+1).link.end=conHole(iConHole,:);
                boolFound=true;
                break
                end
            end
            if (boolFound) 
                display('Selected point is correct');
                if (isnan(linkShp.itm(linkShp.cnt+1).link.start(2)))
                     [xstart, ystart] = centroid(shp(linkShp.itm(linkShp.cnt+1).link.start(1)).con.Shape);
                else
                     [xstart, ystart] = centroid(shp(linkShp.itm(linkShp.cnt+1).link.start(1)).hole(linkShp.itm(linkShp.cnt+1).link.start(2)).shape);
                end
                if (isnan(linkShp.itm(linkShp.cnt+1).link.end(2)))
                    [xend, yend]     = centroid(shp(linkShp.itm(linkShp.cnt+1).link.end(1)).con.Shape);
                else
                    [xend, yend]     = centroid(shp(linkShp.itm(linkShp.cnt+1).link.end(1)).hole(linkShp.itm(linkShp.cnt+1).link.end(2)).shape);
                end
                hold on
                linkShp.itm(linkShp.cnt+1).get=plot(polyshape([xstart,ystart;xend,yend;xstart-1e-4,ystart-1e-4]));
                hold off
                TmpCM=uicontextmenu;
                UnLinkContextMenu(TmpCM);
                linkShp.itm(linkShp.cnt+1).get.ContextMenu=TmpCM;
                linkShp.itm(linkShp.cnt+1).get.ContextMenu.UserData=linkShp.itm(linkShp.cnt+1).get;
                linkShp.cnt=linkShp.cnt+1;
                stateLbl.text='Start'; 
            else; display('Not a correct point');
            end
    end
    for ishp=shp;
        if (~isempty(ishp.con.ContextMenu)) ishp.con.ContextMenu.Children.Children.Text=stateLbl.text; end
    end
    
end

function linkPulley(object,eventdata)
global shp state stateLbl linkShp UnLinkContextMenu;
clc;
    switch(stateLbl.text)
        case 'Start'
            conHole=object.Parent.Parent.UserData.Con;
            linkShp.itm(linkShp.cnt+1).link.start=conHole;
            boolFound=true;
            if (boolFound) stateLbl.text='End'; display('Selected point is correct'); else; display('Not a correct point');end;
        case 'End'
            conHole=object.Parent.Parent.UserData.Con;
            boolFound=false;
            linkShp.itm(linkShp.cnt+1).link.end=conHole;
            boolFound=true;
        if (boolFound) 
            display('Selected point is correct');
            if (isnan(linkShp.itm(linkShp.cnt+1).link.start(2)))
                 [xstart, ystart] = centroid(shp(linkShp.itm(linkShp.cnt+1).link.start(1)).con.Shape);
            else
                 [xstart, ystart] = centroid(shp(linkShp.itm(linkShp.cnt+1).link.start(1)).hole(linkShp.itm(linkShp.cnt+1).link.start(2)).shape);
            end
            if (isnan(linkShp.itm(linkShp.cnt+1).link.end(2)))
                [xend, yend]     = centroid(shp(linkShp.itm(linkShp.cnt+1).link.end(1)).con.Shape);
            else
                [xend, yend]     = centroid(shp(linkShp.itm(linkShp.cnt+1).link.end(1)).hole(linkShp.itm(linkShp.cnt+1).link.end(2)).shape);
            end
            hold on
            linkShp.itm(linkShp.cnt+1).get=plot(polyshape([xstart,ystart;xend,yend;xstart-1e-4,ystart-1e-4]));
            hold off
            TmpCM=uicontextmenu;
            UnLinkContextMenu(TmpCM);
            linkShp.itm(linkShp.cnt+1).get.ContextMenu=TmpCM;
            linkShp.itm(linkShp.cnt+1).get.ContextMenu.UserData=linkShp.itm(linkShp.cnt+1).get;
            linkShp.cnt=linkShp.cnt+1;
            stateLbl.text='Start'; 
        else; display('Not a correct point');
        end
    end
    for ishp=shp;
        if (~isempty(ishp.con.ContextMenu)) ishp.con.ContextMenu.Children.Children.Text=stateLbl.text; end
    end
    
end

function linkWeight(object,eventdata)
global shp state stateLbl linkShp UnLinkContextMenu;
clc;
    switch(stateLbl.text)
        case 'Start'
            conHole=object.Parent.Parent.UserData.Con;
            linkShp.itm(linkShp.cnt+1).link.start=conHole;
            linkShp.itm(linkShp.cnt+1).hasWeight.start=true;
            boolFound=true;
            if (boolFound) stateLbl.text='End'; display('Selected point is correct'); else; display('Not a correct point');end;
        case 'End'
            conHole=object.Parent.Parent.UserData.Con;
            boolFound=false;
            linkShp.itm(linkShp.cnt+1).link.end=conHole;
            linkShp.itm(linkShp.cnt+1).hasWeight.end=true;
            boolFound=true;
        if (boolFound) 
            display('Selected point is correct');
            if (isnan(linkShp.itm(linkShp.cnt+1).link.start(2)))
                 [xstart, ystart] = centroid(shp(linkShp.itm(linkShp.cnt+1).link.start(1)).con.Shape);
            else
                 [xstart, ystart] = centroid(shp(linkShp.itm(linkShp.cnt+1).link.start(1)).hole(linkShp.itm(linkShp.cnt+1).link.start(2)).shape);
            end
            if (isnan(linkShp.itm(linkShp.cnt+1).link.end(2)))
                [xend, yend]     = centroid(shp(linkShp.itm(linkShp.cnt+1).link.end(1)).con.Shape);
            else
                [xend, yend]     = centroid(shp(linkShp.itm(linkShp.cnt+1).link.end(1)).hole(linkShp.itm(linkShp.cnt+1).link.end(2)).shape);
            end
            hold on
            linkShp.itm(linkShp.cnt+1).get=plot(polyshape([xstart,ystart;xend,yend;xstart-1e-4,ystart-1e-4]));
            hold off
            TmpCM=uicontextmenu;
            UnLinkContextMenu(TmpCM);
            linkShp.itm(linkShp.cnt+1).get.ContextMenu=TmpCM;
            linkShp.itm(linkShp.cnt+1).get.ContextMenu.UserData=linkShp.itm(linkShp.cnt+1).get;
            linkShp.cnt=linkShp.cnt+1;
            stateLbl.text='Start'; 
        else; display('Not a correct point');
        end
    end
    for ishp=shp;
        if (~isempty(ishp.con.ContextMenu)) ishp.con.ContextMenu.Children.Children.Text=stateLbl.text; end
    end
    
end

function unLink(object,eventdata)
global linkShp;
    idx=object.Parent.UserData;
    idx.delete
    idel=0;
    for i=1:length(linkShp.itm)
        if (~isvalid(linkShp.itm(i-idel).get))
        linkShp.itm(i-idel)=[];
        linkShp.cnt=linkShp.cnt-1;
        idel=idel+1;
        end
    end
end

function [x,y]=getMouseXY()
    C = get (gca, 'CurrentPoint');
    x=C(1,1);y=C(1,2);
end

function unconHole(object, eventdata)
global shp state;
    waitforbuttonpress
    C = get (gca, 'CurrentPoint');
    x=C(1,1);y=C(1,2);
    ishp=shp(object.Parent.Parent.UserData);
    bool=true;
    ihole=0;
    for iHole=ishp.hole
        ihole=ihole+1;
        if(isinterior(iHole.shape,x,y))
            state.type='null';state.object=[];
            ishp.get.Shape=subtract(ishp.get.Shape,iHole.shape);
            ishp.con.Shape=subtract(ishp.con.Shape,iHole.shape);
            ishp.con.ContextMenu.UserData.Con(find((ishp.con.ContextMenu.UserData.Con(:,2)==ihole)),:)=[];
            bool=false;
            break;
        end
    end
    if(bool);display('Point is not inside a hole. Exiting erasing of connection.');end;
end

function unconWeight(object, eventdata)
global shp state;
    ishp=shp(object.Parent.Parent.UserData);
    bool=true;
    ihole=0;
        ihole=ihole+1;
        iHole=ishp.hole;
            state.type='null';state.object=[];
            ishp.get.Shape=subtract(ishp.get.Shape,iHole.shape);
            ishp.con.Shape=subtract(ishp.con.Shape,iHole.shape);
            ishp.con.ContextMenu.UserData.Con(find((ishp.con.ContextMenu.UserData.Con(:,2)==ihole)),:)=[];
            bool=false;
    if(bool);display('Point is not inside a hole. Exiting erasing of connection.');end;
end

function conPulley(object, eventdata)
global shp state LinkContextMenuPulley;
    ishp=shp(object.Parent.Parent.UserData);
    r=(max(ishp.get.Shape.Vertices(:,1))-min(ishp.get.Shape.Vertices(:,1)))/2;
    dr=0.2;
    dalpha=0.1;
    alpha=0:dalpha:2*pi;
    circle=@(x,y,r)([x+r*cos(alpha);y+r*sin(alpha)]);
    
    if (isempty(ishp.con.Shape.Vertices))
        display('Select where the weight will be hung');
        xl=min(ishp.get.Shape.Vertices(:,1));
        xr=max(ishp.get.Shape.Vertices(:,1));
        y0=(min(ishp.get.Shape.Vertices(:,2))+max(ishp.get.Shape.Vertices(:,2)))/2;
        sl=polyshape(circle(xl,y0,dr*r)');
        sr=polyshape(circle(xr,y0,dr*r)');
        ishpOld=ishp.con.Shape;
        ishp.con.Shape=union(sl,sr);
        ishp.con.FaceColor=ishp.color.joint;
        ishp.con.FaceAlpha=0.6;
        
        waitforbuttonpress;
        C = get (gca, 'CurrentPoint');
        x=C(1,1);y=C(1,2);
        boolreturn=false;
        if (isinterior(sl,x,y))
             ishp.con.Shape=sl;
        elseif(isinterior(sr,x,y))
            ishp.con.Shape=sr;
        else
            ishp.con.Shape=ishpOld;
            display('Selected point is none of the possible joints.');
            boolreturn=true;
        end
        %ishp.get.Shape=union(ishp.get.Shape,ishp.con.Shape);
        if(boolreturn); return; end;
        
        uiLink=@(c)uimenu(c,'Label','Linking');
        uiLinkAddPulley=@(c)uimenu(c,'Label','Start','Callback',@linkPulley);
        LinkContextMenuPulley2=uicontextmenu;
        LinkDraw=uiLink(LinkContextMenuPulley2);
        uiLinkAddPulley(LinkDraw);
        
        ishp.con.ContextMenu=LinkContextMenuPulley2;
        
        if (isfield(ishp.con.ContextMenu.UserData,'Con'))
            ishp.con.ContextMenu.UserData.Con=[ishp.con.ContextMenu.UserData.Con;...
                                        object.Parent.Parent.UserData,NaN];
        else
            ishp.con.ContextMenu.UserData.Con=[object.Parent.Parent.UserData,NaN];
        end
        
    end

end

function unconPulley(object, eventdata)
global shp state;
    ishp=shp(object.Parent.Parent.UserData);
    %ishp.get.Shape=subtract(ishp.get.Shape,ishp.con.Shape);
    ishp.con.Shape=polyshape([0,0]);

end

function linkSetWeight(object,eventdata)
global shp state;
    ishp=object.Parent.UserData;
    mass=input('Insert the weight (mass) in kg:');
    g=9.81;
    shp(ishp).UserData.weight=mass*g;
    
end
