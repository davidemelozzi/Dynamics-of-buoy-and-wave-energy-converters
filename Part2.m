close all
clear variables
clc

%problem parameters
Dbuoy=2.5; %m
wchain=800; %N/m
ro=1025; %kg/m3
Cd=0.9;
Ucurrent=3; %m/s
Tbuoy=10; %m/s

%letter a and b
Drag=0.5*Cd*ro*Tbuoy*Ucurrent^2; %N/m  kg*m*m2/(m3*s2) kg*m/s2
TH=Drag*Dbuoy; %total horizontal force N

%letter c
fairlead_angle=pi/4;
Tz=tan(fairlead_angle)*TH;
s=Tz/wchain; %minimum length of the chain
x=(TH/wchain)*asinh(s*wchain/TH); %horizontal distance
h=(TH/wchain)*(cosh(wchain*x/TH)-1); %vertical distance
Tension_buoy=TH/cos(fairlead_angle); %tension at the buoy

%letter d
stifness=3240*10^3; %N stiffness=A*E/L
x_elastic=x+TH*s/stifness;

%letter e
M_buoy=10^-3*(-wchain*s+ro*9.81*Tbuoy*pi*0.25*Dbuoy^2)/9.81; %ton