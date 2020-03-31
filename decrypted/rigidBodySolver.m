function [t,y]=rigidBodySolver(y0,theta0,Load,theta)
clc;
display('Calculating...')
tmax=50;
t0=tmax*0.01;
alpha0=1;
alpha=@(t,t0)alpha0+(1-alpha0)*erf(t-t0);

opts = odeset('RelTol',1e-1,'AbsTol',1e-2);

m=[1,1];b=[2,2];k=[0,0];
tspan = [0 tmax];
%y0 = [0,0,0];   theta0 = [0,0,0];
y0=[y0;theta0];
a=[k',b',m'];
%fc=3.5;
%F=@(t,y,theta)0;
%M=@(t,y,theta)1*cos(theta(1))-2*cos(theta(1));
%F=@(t,y,theta)[-1,0,0]*(y-sin(theta))*1+0*t+[-fc,0,0]*(y+0.75*sin(theta))-2;
%M=@(t,y,theta)[-1*(y(1)-sin(theta(1))),0,0]*cos(theta)+0*t+[fc*0.75*(y(1)+0.75*sin(theta(1))),0,0]*cos(theta)-2*0.25;
%F=@(t,y)[-0.5,0,0]*y+0*t+[-0.1,0,0]*y+20;


%%
%global acc accAng;
%acc=@(y,theta,alpha,t,t0,a,F)y(3)*(1-alpha(t,t0))+alpha(t,t0)*(-a(1,1:2)*y(1:2,1)+F(t,y,theta))/a(3);
%accAng=@(y,theta,alpha,t,t0,a,M)theta(3)*(1-alpha(t,t0))+alpha(t,t0)*(-a(1,1:2)*theta(1:2,1)+M(t,y,theta))/a(3);

[t,y] = ode45(@(t,y) odefcn(t,y,t0,a,Load,theta,alpha), tspan, y0);


    y(3)=y0(3);
    y(6)=y0(6);
    for i=2:length(t)
        %y(i,3)=acc(y(i,1:3)',y(i,4:6)',alpha,t(i),t0,a(1,:),F);
        y(i,4)=atan2(sin(y(i,4)),cos(y(i,4)));
        %y(i,6)=accAng(y(i,1:3)',y(i,4:6)',alpha,t(i),t0,a(2,:),M);
    end
end

function dydt = odefcn(t,y,t0,a,Load,theta,alpha)
%global acc accAng;
    dydt = zeros(6,1);
    
    [F,M]=giveLoads(y,y(4:6),Load,theta);
    
    dydt(1,:) = y(2);
    dydt(2,:) = acc(y(1:3),y(4:6),alpha,t,t0,a(1,:),F);
    dydt(3,:) = 0;
    
    y(4)=atan2(sin(y(4)),cos(y(4)));
    
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

function [F,M]=giveLoads(y,theta,Load,Theta)
    F_=zeros(1,length(Load));F=0;
    M_=F_;M=0;
    if(isfield(Load,'Children'))
        for i=1:length(Load)
            F_(i)=giveF(y,Load(i).Children,Theta(i).eps(theta(1)));
            M__=cross([[cos(Theta(i).fnc(theta(1))),sin(Theta(i).fnc(theta(1)))]*F_(i),0],[Theta(i).r0',0]);
            M_(i)=M__(3);
            
            F=F_(i)+F; M=M_(i)+M;
        end
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
