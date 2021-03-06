Simulate=@(object,eventdata)simulate_(object,eventdata);
resetToOriginalShape=@(object,eventdata)resetToOriginalShape_(object,eventdata);

global OriginalShape;




function simulate_(object,eventdata)
adjustLink();

global labNum;
    switch (labNum)
        case 1
            
        case 2
            %run simulate2
            simulateRigidBody();
            display('End Calculation.');
        case 3
            simulateRigidBody();
            display('End Calculation.');
        case 4
            simulateRigidBody();
            display('End Calculation.');
    end
end

function resetToOriginalShape_(object,eventdata)
global OriginalShape;
if (~isempty(OriginalShape))
    angle=OriginalShape.angle;
    x=OriginalShape.x(1);
    y=OriginalShape.x(2);
    iFix=OriginalShape.iFix;
    rotateShape(iFix,-angle,x,y);
    OriginalShape=[];
end
end

function adjustLink()
global shp linkShp state;
if linkShp.cnt>0
    
    for itm=linkShp.itm;
        
        [xstart,ystart] = givePoint(itm.link.start(1),itm.link.start(2));
        [xend,yend]     = givePoint(itm.link.end(1),itm.link.end(2));
        
        dx=[xend-xstart,yend-ystart];
        
        if(isfield(itm.hasWeight,"start"))
            if(itm.hasWeight.start)
                moveShape(itm.link.start(1),shp(itm.link.start(1)),dx(1),dx(2)-norm(dx),true);
            end
        end
        
        if(isfield(itm.hasWeight,"end"))
            if(itm.hasWeight.end)
                moveShape(itm.link.end(1),shp(itm.link.end(1)),-dx(1),-dx(2)-norm(dx),true);
            end
        end
    end
end
    
end

function [x,y]=givePoint(Mech,SubPart)
global shp;
         if(isnan(SubPart))
            
            switch(contains(shp(Mech).name,'Pulley'))
                case 0
                    [x,y]=centroid(shp(Mech).get.Shape);
                case 1
                    [x,y]=centroid(shp(Mech).con.Shape);
            end
        else
            [x,y]=centroid(shp(Mech).hole(SubPart).shape);
        end
end

function moveShape(i,shapeContainer,dx,dy,bool)
    global shp state linkShp;
    shp(i).pos.x=shp(i).pos.x+dx;
    shp(i).pos.y=shp(i).pos.y+dy;
    shapeContainer.get.Shape=translate(shapeContainer.get.Shape,dx,dy);
    shapeContainer.fix.Shape=translate(shapeContainer.fix.Shape,dx,dy);
    shapeContainer.con.Shape=translate(shapeContainer.con.Shape,dx,dy);
    if(bool)
        for ihole=1:length(shp(i).hole)
            shp(i).hole(ihole).shape=translate(shp(i).hole(ihole).shape,...
                shp(i).pos.x-shp(i).posPrev.x,...
                shp(i).pos.y-shp(i).posPrev.y);
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

function rotateShape(i,theta,x,y)
global shp linkShp;

if linkShp.cnt>0  
    UnknownLink=findLinksInCon(i,-1);

    for ilink=1:UnknownLink.cnt
        ILINK=UnknownLink.itm(ilink);
        [xstart,ystart]=givePoint(ILINK.start(1),ILINK.start(2));
        r0=[xstart-x;ystart-y];
        [xend,yend]=givePoint(ILINK.end(1),ILINK.end(2));
        r1=[xend-x;yend-y];
        dx=[cos(theta),-sin(theta);sin(theta),cos(theta)]*r1 + [x,y]';
        xend=dx(1);yend=dx(2);
        
        linkShp.itm(ILINK.link).get.Shape=polyshape(...
            [xstart,ystart;xend,yend;xstart-1e-4,ystart-1e-4]);
    end
end
    rotateShapeAll(shp(i).get,theta*180/pi,x,y);
    rotateShapeAll(shp(i).fix,theta*180/pi,x,y);
    rotateShapeAll(shp(i).con,theta*180/pi,x,y);
    for ihole=1:length(shp(i).hole)
        shp(i).hole(ihole).shape=rotate(shp(i).hole(ihole).shape,theta*180/pi,[x,y]);
    end

    adjustLink()

     
    
end

function rotateShapeAll(ishp,theta,x,y)
    ishp.Shape=rotate( ishp.Shape,theta,[x,y]);
end

function simulateRigidBody()
global Fixation OriginalShape shp linkShp;
    iFix=Fixation.Value;
    
    [x0,y0]=centroid(shp(iFix).fix.Shape);
    [xg,yg]=centroid(subtract(shp(iFix).get.Shape,shp(iFix).fix.Shape));
    if (sum(isnan([x0,y0])));x0=xg;y0=yg;end;
if linkShp.cnt>0    
    [Load,theta]=ObtainLoad(iFix,x0,y0);
else
    Load=[];theta=[];
end    
    [Load,theta]=ObtainCoG(iFix,Load,theta,x0,y0,xg,yg);
    
    
    
    global Mom Forc Time;
    Mom=[];Forc=[];Time=[];
    
    [t,y]=rigidBodySolver([0,0,0],[0,0,0],Load,theta);
    %{
    t=0:0.01:pi/6;
    zeros(length(t),6);
    y_=@(t)-sin(t);
    y(:,4)=y_(t);
    %}
    
    if (true)
    N=100;
    xi=0:1/N:1;
    Acof=4;
    nlim=length(t);
    idx=unique(round((0+(exp(Acof*xi)-1)./(exp(Acof)-1))*nlim,0));
    idx(1)=1;
    for i=1:length(idx)-1
        dy=y(idx(i+1),4)-y(idx(i),4);
        if(i==1); dy=dy+y(1,4);end;
        if (abs(dy)<1e-3 && idx(i)/(length(t)-1)>0.3)
            dy=y(end,4)-y(idx(i),4);
            rotateShape(iFix,dy,x0,y0);
            drawnow limitrate nocallbacks
            pause(0.05)
            break; 
        end
        rotateShape(iFix,dy,x0,y0);
        drawnow limitrate nocallbacks
        pause(0.05)
    end
    else
    
    rotateShape(iFix,y(end,4),x0,y0);
    drawnow update
    pause(0.05)
    
    figure(2)
    plot(t,y(:,4));
    figure(3);clf;
    subplot(1,2,1)
    title('Forces');
    hold on
    plot(Time,Forc(:,1),'-r');
    plot(Time,Forc(:,2),'--b');
    hold off
    subplot(1,2,2)
    title('Moments');
    hold on
    plot(Time,Mom(:,1),'-r');
    plot(Time,Mom(:,2),'--b');
    hold off
    end
    
    OriginalShape.angle=y(end,4);
    OriginalShape.x=[x0,y0];
    OriginalShape.iFix=iFix;
    
end

function [Load,theta]=ObtainCoG(iFix,Load,theta,x0,y0,xg,yg)
global shp;

    A=area(subtract(shp(iFix).get.Shape,shp(iFix).fix.Shape));
    t=3e-3;
    rho=7800;
    
    cnt=length(Load);
    Load(cnt+1).Children=@(u)-rho*A*t;
    theta(cnt+1).r0=[xg-x0,yg-y0]';
    theta(cnt+1).r1=[0,0]';
    theta(cnt+1).r=@(beta,r0)GiveDistance(beta,theta(cnt+1).r0);
    theta(cnt+1).eps=@(beta)ExternalU(beta,theta(cnt+1).r0,theta(cnt+1).r1,'Weight_CoG');
    theta(cnt+1).fnc=@(beta)ExternalForce(beta,theta(cnt+1).r0,theta(cnt+1).r1,'Weight_CoG');
    
    
end


function [Load,theta]=ObtainLoad(iFix,x0,y0,iLink)
    if nargin==4
        UnknownLink=findLinksInCon(iFix,iLink);
        theta=[];
    else
        UnknownLink=findLinksInCon(iFix,-1);
        theta=ObtainAngles(UnknownLink,x0,y0);
    end
    if (UnknownLink.cnt>0)
    for iUnknownLink=1:UnknownLink.cnt
        [Load(iUnknownLink).Children,~]=ObtainLoad(UnknownLink.itm(iUnknownLink).mech,x0,y0,UnknownLink.itm(iUnknownLink).link);
    end
    else
       Load=SetLoad(iFix); 
    end
    
end

%{
function r=giveDistance(UnknownLink)
     for ilink=1:UnknownLink.cnt
         ILINK=UnknownLink.itm(ilink);
        [x0,y0]=centroid(shp(ILINK.start(1)).fix.Shape);
     end
end
%}

function Load=SetLoad(iFix)
global shp;

    if (contains(shp(iFix).name,'Lever'))
        nan;
    elseif(contains(shp(iFix).name,'Pulley'))
        nan;
    elseif(contains(shp(iFix).name,'Weight'))
        if (isempty(shp(iFix).UserData.weight));error('CUSTOM ERROR:   Weight: %s has no weight assigned',shp(iFix).name);end;
        Load=@(u)-shp(iFix).UserData.weight;
    elseif(contains(shp(iFix).name,'Dynamometer'))
        Load=@(u)DynamometerTagModification(u,iFix);
    end
end

function F=DynamometerTagModification(u,ishp)
    global shp;
    k=-10;
    F=k*u;
    shp(ishp).get.Tag=sprintf('%s = %f N',shp(ishp).name,-F);
end

function theta=ObtainAngles(UnknownLink,x0,y0)
global shp linkShp;
    for ilink=1:UnknownLink.cnt
        
        ILINK=UnknownLink.itm(ilink);
        %[x0,y0]=centroid(shp(ILINK.end(1)).fix.Shape);
        [x,y]=givePoint(ILINK.end(1),ILINK.end(2));
        theta(ilink).r0=[x-x0;y-y0];
        [x,y]=givePoint(ILINK.start(1),ILINK.start(2));
        theta(ilink).r1=[x-x0;y-y0];
        theta(ilink).r=@(beta,r0)GiveDistance(beta,theta(ilink).r0);
        theta(ilink).eps=@(beta)ExternalU(beta,theta(ilink).r0,theta(ilink).r1,...
            shp(ILINK.start(1)).name);
        theta(ilink).fnc=@(beta)ExternalForce(beta,theta(ilink).r0,theta(ilink).r1,...
            shp(ILINK.start(1)).name);
    end
end

function theta=ExternalForce(beta,r0,r1,str)
    if (contains(str,'Pulley'))
        dx=[cos(beta),-sin(beta);sin(beta),cos(beta)]*r0 - r1;
        theta=atan2(dx(2),dx(1));
    elseif(contains(str,'Dynamometer'))
        dx=[cos(beta),-sin(beta);sin(beta),cos(beta)]*r0 - r1;
        theta=atan2(dx(2),dx(1));
    else
        theta=pi/2;
    end
end

function u=ExternalU(beta,r0,r1,str)
    if (contains(str,'Pulley'))
        dx=[cos(beta),-sin(beta);sin(beta),cos(beta)]*r0 - r1;
        dx0=r0 - r1;
        u=norm(dx)-norm(dx0);
    elseif(contains(str,'Dynamometer'))
        dx=[cos(beta),-sin(beta);sin(beta),cos(beta)]*r0 - r1;
        dx0=r0 - r1;
        u=norm(dx)-norm(dx0);
    else
        u=0;
    end
end

function r=GiveDistance(beta,r0)
        r=[cos(beta),-sin(beta);sin(beta),cos(beta)]*r0;
end


function UnknownLink=findLinksInCon(ishp_,iilinkRef)
global shp linkShp;
    UnknownLink.cnt=0;
    iilink=0;
if linkShp.cnt>0  
    for ilink=linkShp.itm
        iilink=iilink+1;
        if (iilink==iilinkRef);continue;end;
        if(ilink.link.start(1)==ishp_)
            UnknownLink.itm(UnknownLink.cnt+1).mech=ilink.link.end(1);
            UnknownLink.itm(UnknownLink.cnt+1).link=iilink;
            UnknownLink.itm(UnknownLink.cnt+1).start=ilink.link.end;
            UnknownLink.itm(UnknownLink.cnt+1).end=ilink.link.start;
            UnknownLink.cnt=UnknownLink.cnt+1;
        elseif(ilink.link.end(1)==ishp_)
            UnknownLink.itm(UnknownLink.cnt+1).mech=ilink.link.start(1);
            UnknownLink.itm(UnknownLink.cnt+1).link=iilink;
            UnknownLink.itm(UnknownLink.cnt+1).start=ilink.link.start;
            UnknownLink.itm(UnknownLink.cnt+1).end=ilink.link.end;
            UnknownLink.cnt=UnknownLink.cnt+1;
        end
    end
end

end
