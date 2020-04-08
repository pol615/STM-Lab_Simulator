function [t,y]=rigidBodySolver(y0,theta0,Load,theta)
clc;
display('Calculating...')
tmax=50;
t0=tmax*0.01;
alpha0=1;
alpha=@(t,t0)alpha0+(1-alpha0)*erf(t-t0);

opts = odeset('RelTol',1e-1,'AbsTol',1e-2);

m=[1,1];b=[2,100];k=[0,0];
tspan = [0 tmax];
y0=[y0;theta0];
a=[k',b',m'];

   global tplot dtplot;
   tplot=0;
   dtplot=0.25;


[t,y] = ode45(@(t,y) odefcn(t,y,t0,a,Load,theta,alpha), tspan, y0);

    y(1,3)=y0(3);
    y(1,6)=y0(6);
    %for i=2:length(t)
        %y(i,3)=acc(y(i,1:3)',y(i,4:6)',alpha,t(i),t0,a(1,:),F);
    %    y(i,4)=atan2(sin(y(i,4)),cos(y(i,4)));
        %y(i,6)=accAng(y(i,1:3)',y(i,4:6)',alpha,t(i),t0,a(2,:),M);
    %end
    
    %postprocess(Load,theta,y(end,1),y(end,4))
    
end

function dydt = odefcn(t,y,t0,a,Load,theta,alpha)
    dydt = zeros(6,1);
    
    [F,M]=giveLoads(t,y,y(4:6),Load,theta);
    
    dydt(1,:) = y(2);
    dydt(2,:) = acc(y(1:3),y(4:6),alpha,t,t0,a(1,:),F);
    dydt(3,:) = 0;
    
    %y(4)=atan2(sin(y(4)),cos(y(4)));
    
    dydt(4,:) = y(5);
    dydt(5,:) = accAng(y(1:3),y(4:6),alpha,t,t0,a(2,:),M);
    dydt(6,:) = 0;

end

function a=acc(y,theta,alpha,t,t0,a,F)
    a=y(3)*(1-alpha(t,t0))+alpha(t,t0)*(-a(1,1:2)*y(1:2,1)+F)/a(3);
end
function alpha=accAng(y,theta,alpha,t,t0,a,M)
    alpha=theta(3)*(1-alpha(t,t0))+alpha(t,t0)*(-a(1,1:2)*theta(1:2,1)+M)/a(3);
end

function [F,M]=giveLoads(t,y,theta,Load,Theta)
    global tplot dtplot;
    F_=zeros(1,length(Load));F=0;
    M_=zeros(1,length(Load));M=0;
    global Mom Forc Time;
    if(isfield(Load,'Children'))
        for i=1:length(Load)
            % r0(theta)
            F_(i)=giveF(y,Load(i).Children,Theta(i).eps(theta(1)));
            %M__=F_(i)*norm(Theta(i).r0)*sin(Theta(i).fnc(theta(1))+atan2(Theta(i).r0(2),Theta(i).r0(1)));
            M__=cross([Theta(i).r(theta(1))',0],[[cos(Theta(i).fnc(theta(1))),sin(Theta(i).fnc(theta(1)))]*F_(i),0]);
            M_(i)=M__(3);
            
            F=F_(i)+F; M=M_(i)+M;
            
        end
        
        if false && t>tplot
            tplot=tplot+dtplot;
            run testCrossProd.m
        end
            Time=[Time,t];
            Forc=[Forc;F_];
            Mom=[Mom;M_];
    end
end

function F=giveF(y,Load,eps)
    F=0;
    if(isfield(Load,'Children'))
        for i=1:length(Load)
            F=F+giveF(y,Load(i).Children,eps);
        end
    else
        F=F+Load(eps);
    end
end

function postprocess(Load,Theta,y,theta)
    global shp;
    
end