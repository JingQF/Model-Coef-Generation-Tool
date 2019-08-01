function [ sMij ] = CalAddedMassInteria(shipName, fileOutput)
% To write the ".SHIP" file for the input of simulation model.
% 2019-07-20
% Brief instructions
% 1. INPUT: shipName = the ship basic data stored in XX.mat in 'ship/' folder. 
% 2. The parameters of .SHIP are from 'shipname.mat' and estimation methods.
% 3.. The estimation methods are applied when the parameters is not given in mat(set zero).
% Version: 1.1
% Author: Jing Qianfeng 

%load mat
shipMatFile = ['ship/',shipName,'.mat'];%input mat
load(shipMatFile);

rou = 1.025; 
g = 9.80665;
%完善估算方法即可
mx = m*0.01*((0.398 + 11.97*Cb*(1.0 + 3.73*d_B) - 2.89*Cb*L_B*(1.0 + 1.13*d_B) + 0.175*Cb*L_B^2*(1.0 + 0.541*d_B) - 1.107*L_B*d_B)); 
my = m*(0.882 - 0.54*Cb*(1 - 1.6*d_B) - 0.156*L_B*(1 - 0.673*Cb) + 0.826*d_B*L_B*(1 - 0.678*d_B) - 0.638*d_B*L_B*(1 - 0.669*d_B));
mz = (0.8*B*Cw*m) / (2.0*dM);
Ixx  = (m / 12)*(B^2 + 4 * zG^2); % Duaer
%Ixx  = m*(B^2*Cw^2 / (11.4*Cb) + D^2 / 12);%Shmanski
%kx = B*(0.3085 + 0.0227*(B / dM) - 0.0043*(Lpp / 10));
%IxxJxx = m*kx^2;
Iyy  = (0.07*Cw*m*Lpp^2) / g; %Bolageviski
Izz  = (0.245*Lpp)^2 *m;
Jxx  = 0.28*Ixx;
Jyy  = (0.83 * B * Cp^2 * (0.25*Lpp)^2 * m) / (dM*2.0);
Jzz  = (0.01*Lpp*(33.0 - 76.85*Cb*(1 - 0.784*Cb) + 3.43*L_B*(1 - 0.63*Cb)))^2*m;

%non-dim
mx = mx / (0.5*rou*Lpp^2*dM);
my = my / (0.5*rou*Lpp^2*dM);
mz = mz / (0.5*rou*Lpp^2*dM);
Ixx = Ixx / (0.5*rou*Lpp^4 * dM);
Iyy = Iyy / (0.5*rou*Lpp^4 * dM);
Izz = Izz / (0.5*rou*Lpp^4 * dM);
Jxx = Jxx / (0.5*rou*Lpp^4 * dM);
Jyy = Jyy / (0.5*rou*Lpp^4 * dM);
Jzz = Jzz / (0.5*rou*Lpp^4 * dM);


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
if exist(fileOutput) == false; mkdir( fileOutput); end
allCoefFile = [fileOutput,'/',shipName,'_mij.csv'];
writetable(Mij_table,allCoefFile);

sMij = struct('mx',mx,'my',my,'mz',mz,'Ixx',Ixx,'Iyy',Iyy,'Izz',Izz,'Jxx',Jxx,'Jyy',Jyy,'Jzz',Jzz);