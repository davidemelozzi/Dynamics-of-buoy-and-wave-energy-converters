close all
clear variables
clc

data=load('NOAAwave_1979010103to2007123121.txt');
year=data(1:end,1); %year;
month=data(1:end,2);%month
day=data(1:end,3);%day
hour=data(1:end,4);%hour
Hs=data(1:end,5);
Tp=data(1:end,6);
Dp=data(1:end,7);

%Exercise 1
Hs_edges=(0:0.5:11.5);
Tp_edges=(0:1:22);
Dp_edges=(0:20:360);
[Scatter1] = histcounts2(Hs,Tp,Hs_edges,Tp_edges); %Hs edge is the number of rows and Tp edge is the colum
[Scatter2] = histcounts2(Hs,Dp,Hs_edges,Dp_edges);
[Scatter3] = histcounts2(Tp,Dp,Tp_edges,Dp_edges);

%Exercise 2
ro=1025; %kg/m3
g=9.81; %m/s2
Pw_total_avr=(ro*g*g/(64*pi))*mean(Hs(:)).^2*0.9.*mean(Tp(:))*10^-3; %MW/m
Hs_winter=[];
Ts_winter=[];
Hs_summer=[];
Ts_summer=[];
Hs_spring=[];
Ts_spring=[];
Hs_autumn=[];
Ts_autumn=[];
for i=1:length(Hs)
    if month(i)==1 || month(i)==2 || month(i)==12
        Hs_winter=cat(2,Hs_winter,Hs(i));
        Ts_winter=cat(2,Ts_winter,Tp(i));
    elseif month(i)==3 || month(i)==4 || month(i)==5
        Hs_spring=cat(2,Hs_spring,Hs(i));
        Ts_spring=cat(2,Ts_spring,Tp(i));
    elseif month(i)==6 || month(i)==7 || month(i)==8
        Hs_summer=cat(2,Hs_summer,Hs(i));
        Ts_summer=cat(2,Ts_summer,Tp(i));
    else
        Hs_autumn=cat(2,Hs_autumn,Hs(i));
        Ts_autumn=cat(2,Ts_autumn,Tp(i));
    end
end
Pw_winter_avr=(ro*g*g/(64*pi))*mean(Hs_winter(:)).^2*mean(0.9.*Ts_winter(:))*10^-3;%MW/m
Pw_spring_avr=(ro*g*g/(64*pi))*mean(Hs_spring(:)).^2*0.9.*mean(Ts_spring(:))*10^-3;%MW/m
Pw_summer_avr=(ro*g*g/(64*pi))*mean(Hs_summer(:)).^2*0.9.*mean(Ts_summer(:))*10^-3;%MW/m
Pw_autumn_avr=(ro*g*g/(64*pi))*mean(Hs_autumn(:)).^2*0.9.*mean(Ts_autumn(:))*10^-3;
T=table({'Winter';'Spring';'Summer';'Autunm';'Average'},[Pw_winter_avr;Pw_spring_avr;Pw_summer_avr;Pw_autumn_avr;Pw_total_avr]);
T.Properties.VariableNames = {'Season','Average_Power'};
disp(T)
Pw=zeros(length(Hs_edges)-1,length(Tp_edges)-1);
Scatter1=histcounts2(Hs,Tp,Hs_edges,Tp_edges,'Normalization','probability');
for i=1:length(Hs_edges)-1
    for j=1:length(Tp_edges)-1
        Pw(i,j)=Scatter1(i,j)*(ro*g*g/(64*pi))*Hs_edges(i+1)^2*0.9*Tp_edges(j+1); %use max value of Hs and Tp in each section kW/m
    end
end
% Pw_table=table(Pw);
% writetable(Pw_table,'Pw.xls')

%Exercise 3
pelamis=load('Pelamis.txt');
Hs_pelamis=pelamis(1:end,1);
Tp_pelamis=(4.5:0.5:13);
pij_pelamis=pelamis(2:end,2:end);
Scatter_pelamis=histcounts2(Hs,Tp,Hs_pelamis,Tp_pelamis,'Normalization','probability');

AquaBuoy=load('AquaBuoy.txt');
Hs_AquaBuoy=AquaBuoy(2:end,1);
Tp_AquaBuoy=AquaBuoy(1,2:end);
pij_AquaBuoy=AquaBuoy(2:end,2:end);
Scatter_AquaBouy=histcounts2(Hs,Tp,Hs_AquaBuoy,Tp_AquaBuoy,'Normalization','probability');

WaveDragon=load('WaveDragon.txt');
Hs_WaveDragon=WaveDragon(2:end,1);
Tp_WaveDragon=WaveDragon(1,2:end);
pij_WaveDragon=WaveDragon(2:end,2:end);
Scatter_WaveDragon=histcounts2(Hs,Tp,Hs_WaveDragon,Tp_WaveDragon,'Normalization','probability');
