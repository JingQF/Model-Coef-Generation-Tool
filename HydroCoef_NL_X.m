function [ sN_X ] = HydroCoef_NL_X( shipName, hullNonX, fileOutput)
% To write the ".SHIP" file for the input of simulation model.
% revised 2019-07-31
% Brief instructions
% 1. INPUT: shipName = the ship basic data stored in XX.mat in 'ship/' folder. 
% 2. The parameters of .SHIP are from 'shipname.mat' and estimation methods.
% 3.. The estimation methods are applied when the parameters is not given in mat(set zero).
% Version: 1.1
% Author: Jing Qianfeng 

%load mat
shipMatFile = ['ship/',shipName,'.mat'];%input mat
load(shipMatFile);

myd = 0.15279;%ZZM clipper
% Hull forces and moments compare

%*********************Non-Linear Hydro Coef***************************%
% =====================================================
% 松本 憲洋 Norihiro Matsumoto  原作类型 u,v,r
% 对应文献：1983-Interference effects between the hull, propeller and rudder of a hydrodynamic mathematical model in maneuvering motion 
% 简介：杨书版本
% 原作 u,v,r
cm1 = (1.11*Cb - 0.07)*(1 + 0.208*tao);
Xvr_Yang = (cm1-1)*myd;
Xvv_Yang = 0.4*B_L - 0.006*L_d;
Xrr_Yang = 0.0003*L_d;
Xvvvv_Yang = 4.0*B_L-0.002*L_d;
%table
N_X_Yang_1983 = {'Xvr' ; 'Xvv' ; 'Xrr' ; 'Xvvvv' };
N_X_Yang = [Xvr_Yang;Xvv_Yang;Xrr_Yang;Xvvvv_Yang];
% =====================================================
% 松本 憲洋 Norihiro Matsumoto  原作类型 u,v,r
% 对应文献：1983-Interference effects between the hull, propeller and rudder of a hydrodynamic mathematical model in maneuvering motion 
% 简介：与杨书中的有区别请注意,杨书是错的，少一个L/d
% 原作 u,v,r
Xvr_SB = 1.11*Cb-0.07;
Xvv_SB = 0.4*(dM*B/Lpp^2)-0.006;
Xrr_SB = 0.0003;
Xvvvv_SB = 4*(dM*B/Lpp^2)-0.002;
%table
N_X_SB_1983 = {'Xvr' ; 'Xvv' ; 'Xrr' ; 'Xvvvv' };
N_X_SB = [Xvr_SB;Xvv_SB;Xrr_SB;Xvvvv_SB];

% =====================================================
% 長谷川 和彦 Kazuhiko Hasegawa  原作类型 u,v,r
% 对应文献：1980-On te Performance Criterion of Autopilot Navigation
% 简介：仅一个cm公式，杨书给做个回归，原作只有图
% 原作 u,v,r
Xvr_CGC = 1.75*Cb-0.525;
Xvv_CGC = 0;
Xrr_CGC = 0;
Xvvvv_CGC = 0;
%table
N_X_CGC_1980 = {'Xvr' ; 'Xvv' ; 'Xrr' ; 'Xvvvv' };
N_X_CGC = [Xvr_CGC;Xvv_CGC;Xrr_CGC;Xvvvv_CGC];

% =====================================================
% 貴島 勝郎 Kijima Katsuro  原作类型 u,v,r
% 对应文献：1990 Theory and observations on the use of a mathematical model for ship manoeuvring in deep and confined waters. 
% 简介：考虑吃水差
% 原作 u,v,r
Xvr_KJ = (1.11*Cb-0.07)*(1+0.208*tao);
Xvv_KJ = 0;
Xrr_KJ = 0;
Xvvvv_KJ = 0;
%table
N_X_KJ_1990 = {'Xvr' ; 'Xvv' ; 'Xrr' ; 'Xvvvv' };
N_X_KJ = [Xvr_KJ;Xvv_KJ;Xrr_KJ;Xvvvv_KJ];

% =====================================================
%  Tae II Lee  原作类型 u,v,r 不可靠因为ballast才好用
% 对应文献：2003 Tae-II Lee-On an empirical prediction of hydrodynamic coefficients for modern ship hulls
% 简介：考量船尾形状和载态，但是参数不好获得，但是罕见的可以估计压载和满载的
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
    N_X_Yang_1983,    N_X_Yang,...
    N_X_SB_1983,        N_X_SB,...
    N_X_CGC_1980,     N_X_CGC,...
    N_X_KJ_1990,         N_X_KJ,...
    N_X_Lee_2003,      N_X_Lee_Val);

%new folder according to create time(sec)
if exist(fileOutput) == false; mkdir(fileOutput); end
allCoefFile = [fileOutput,'/',shipName,'_NL_X.csv'];
writetable(NonLinearCoef_X_Full,allCoefFile);
    

%output final coef
switch(hullNonX)
    case 1
        fprintf('         | --- Non-Linear XH refer to【 Yang Yansheng 1983 】\n' );
        Xvv    = Xvv_Yang;
        Xvr     = Xvr_Yang;
        Xrr	    = Xrr_Yang;
        Xvvvv = Xvvvv_Yang;
    case 2
        fprintf('         | --- Non-Linear XH refer to【 Norihiro Matsumoto 1983 】\n' );
        Xvv    = Xvv_SB;
        Xvr     = Xvr_SB;
        Xrr	    = Xrr_SB;
        Xvvvv = Xvvvv_SB;
    case 3
        fprintf('         | --- Non-Linear XH refer to【 Kazuhiko Hasegawa 1980 】\n' );
        Xvv     =0;
        Xvr     =Xvr_CGC;
        Xrr	    =0;
        Xvvvv   =0;
    case 4
        fprintf('         | --- Non-Linear XH refer to【 Kijima Katsuro 1990 】\n' );
        Xvv     = 0;
        Xvr     = Xvr_KJ;
        Xrr	    = 0;
        Xvvvv   = 0;
    case 5
        fprintf('         | --- Non-Linear XH refer to【 Tae-II Lee 2003 】\n' );
        Xvv     = Xvv_Lee;
        Xvr     = Xvr_Lee;
        Xrr	    = Xrr_Lee;
        Xvvvv   =0;
    case 6
        fprintf('         | --- Non-Linear XH refer to【 Kang 2007 】\n' );
        Xvv     = 0;
        Xvr     = 0;
        Xrr	    = 0;
        Xvvvv   =0;
    otherwise
       fprintf('         | --- Non-Linear XH refer to【 Yang Yansheng 1983 】\n' );
        Xvv    = Xvv_Yang;
        Xvr     = Xvr_Yang;
        Xrr	    = Xrr_Yang;
        Xvvvv = Xvvvv_Yang;
end


%by hand
Xvphi=0;
Xrphi=0;
Xphiphi=0;


sN_X = struct('Xvv',Xvv,'Xvr',Xvr,'Xrr',Xrr,'Xvvvv',Xvvvv,'Xvphi',Xvphi,'Xrphi',Xrphi,'Xphiphi',Xphiphi);

