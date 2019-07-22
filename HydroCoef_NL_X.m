function [ sN_X ] = HydroCoef_NL_X( shipName, hullNonX)
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


% Hull forces and moments compare

%*********************Non-Linear Hydro Coef***************************%
% u,v,r
Xvr_SB = 1.11*Cb-0.07;
Xvv_SB = 0.4*(dM*B/Lpp^2)-0.006;
Xrr_SB = 0.0003;
Xvvvv_SB = 4*(dM*B/Lpp^2)-0.002;
%table
N_X_SB_1983 = {'Xvr' ; 'Xvv' ; 'Xrr' ; 'Xvvvv' };
N_X_SB = [Xvr_SB;Xvv_SB;Xrr_SB;Xvvvv_SB];

% =====================================================
% u,v,r
Xvr_CGC = 1.75*Cb-0.525;
Xvv_CGC = 0;
Xrr_CGC = 0;
Xvvvv_CGC = 0;
%table
N_X_CGC_1980 = {'Xvr' ; 'Xvv' ; 'Xrr' ; 'Xvvvv' };
N_X_CGC = [Xvr_CGC;Xvv_CGC;Xrr_CGC;Xvvvv_CGC];

% =====================================================
%  u,v,r
Xvr_KJ = (1.11*Cb-0.07)*(1+0.208*tao);
Xvv_KJ = 0;
Xrr_KJ = 0;
Xvvvv_KJ = 0;
%table
N_X_KJ_1990 = {'Xvr' ; 'Xvv' ; 'Xrr' ; 'Xvvvv' };
N_X_KJ = [Xvr_KJ;Xvv_KJ;Xrr_KJ;Xvvvv_KJ];

% =====================================================

Xvr_Lee =(0.12*Cb*B_L+0.443*d_L-0.018)/d_L;
Xvv_Lee =(0.223*d_L-0.011)/d_L;
Xrr_Lee = (0.038*d_L-0.001)/d_L;
Xvvvv_Lee = 0;

%table
N_X_Lee_2003 = {'Xvr' ; 'Xvv' ; 'Xrr' ; 'Xvvvv' };
N_X_Lee_Val = [Xvr_Lee;Xvv_Lee;Xrr_Lee;Xvvvv_Lee];

allcoefNotice = ['         | --- writing all Non-Linear XH coef to result/',shipName,'_NL_X.csv'];
disp(allcoefNotice);
%=====Write Table
NonLinearCoef_X_Full = table(...
    N_X_SB_1983,        N_X_SB,...
    N_X_CGC_1980,     N_X_CGC,...
    N_X_Lee_2003,      N_X_Lee_Val);

%new folder according to create time(sec)
timeCreate=datevec(datestr(now));
month = num2str(timeCreate(2));
day = num2str(timeCreate(3));
hor = num2str(timeCreate(4));
mint = num2str(timeCreate(5));
secd = num2str(timeCreate(6));
newFolder = ['result/',shipName,'_',month,'_',day,'_',hor,'_',mint,'_',secd];
if exist(newFolder) == false; mkdir(newFolder); end
allCoefFile = [newFolder,'/',shipName,'_NL_X.csv'];
writetable(NonLinearCoef_X_Full,allCoefFile);
    

%output final coef
switch(hullNonX)
    case '1'
        fprintf('         | --- Non-Linear XH refer to¡¾ Norihiro Matsumoto 1983 ¡¿\n' );
        Xvv     =0;
        Xvr     =0;
        Xrr	    =0;
        Xvvvv   =0;
    case '2'
        fprintf('         | --- Non-Linear XH refer to¡¾ Kazuhiko Hasegawa 1980 ¡¿\n' );
        Xvv     =0;
        Xvr     =0;
        Xrr	    =0;
        Xvvvv   =0;
    case '3'
        fprintf('         | --- Non-Linear XH refer to¡¾ Kijima Katsuro 1990 ¡¿\n' );
        Xvv     =0;
        Xvr     =0;
        Xrr	    =0;
        Xvvvv   =0;
    case '4'
        fprintf('         | --- Non-Linear XH refer to¡¾ Tae-II Lee 2003 ¡¿\n' );
        Xvv     =0;
        Xvr     =0;
        Xrr	    =0;
        Xvvvv   =0;
    otherwise
        fprintf('         | --- Non-Linear XH refer to¡¾ Norihiro Matsumoto 1983 ¡¿\n' );
        Xvv     =0;
        Xvr     =0;
        Xrr	    =0;
        Xvvvv   =0;
end


%by hand
Xvphi=0;
Xrphi=0;
Xphiphi=0;


sN_X = struct('Xvv',Xvv,'Xvr',Xvr,'Xrr',Xrr,'Xvvvv',Xvvvv,'Xvphi',Xvphi,'Xrphi',Xrphi,'Xphiphi',Xphiphi);

