function [ sMij ] = CalAddedMassInteria(shipName)
% To write the ".SHIP" file for the input of simulation model.
% 2019-07-20
% Brief instructions
% 1. INPUT: shipName = the ship basic data stored in XX.mat in 'ship/' folder. 
% 2. The parameters of .SHIP are from 'shipname.mat' and estimation methods.
% 3.. The estimation methods are applied when the parameters is not given in mat(set zero).
% author: Jing Qianfeng

%load mat
shipMatFile = ['ship/',shipName,'.mat'];%input mat
load(shipMatFile);

%完善估算方法即可
mx    	=0; 
my      =0;
mz      =0;
Ixx     =0;
Iyy     =0;
Izz     =0;
Jxx     =0;
Jyy     =0;
Jzz     =0;

m_ij =  [ 'mx'; 'my' ; 'mz' ];
m_ij_val = [ mx ; my ; mz ];
I_ij = [ 'Ixx' ; 'Iyy' ; 'Izz' ];
I_ij_val = [ Ixx ; Iyy ; Izz ];
J_ij = [ 'Jxx';'Jyy';'Jzz'];
J_ij_val = [ Jxx ; Jyy ; Jzz ];
Mij_table = table(...
    m_ij, m_ij_val,...
    I_ij,   I_ij_val,...
    J_ij,   J_ij_val);

allcoefNotice = ['         | --- writing all added mass/moment of inertia to result/',shipName,'_m_ij.csv'];
disp(allcoefNotice);

%new folder according to create time(sec)
timeCreate=datevec(datestr(now));
month = num2str(timeCreate(2));
day = num2str(timeCreate(3));
hor = num2str(timeCreate(4));
mint = num2str(timeCreate(5));
secd = num2str(timeCreate(6));
newFolder = ['result/',shipName,'_',month,'_',day,'_',hor,'_',mint,'_',secd];
if exist(newFolder) == false; mkdir(newFolder); end
allCoefFile = [newFolder,'/',shipName,'_mij.csv'];
writetable(Mij_table,allCoefFile);

sMij = struct('mx',mx,'my',my,'mz',mz,'Ixx',Ixx,'Iyy',Iyy,'Izz',Izz,'Jxx',Jxx,'Jyy',Jyy,'Jzz',Jzz);