function [ sL_YN ] = HydroCoef_L( shipName, hullLinear)
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

%*********************Linear Hydro Coef***************************%
Yv_JS_Yang = -1.0*( pi*0.5*lamda + 1.4*Cb*B / Lpp )*(1 + 0.67*tao);
Yr_JS_Yang = 0.25*pi*lamda*(1 + 0.8*tao);
Nv_JS_Yang = -1.0*lamda*(1 - 0.27*tao / lv);
Nr_JS_Yang = -1.0*(0.54*lamda - lamda^2)*(1 + 0.3*tao);
%  b,r , b = beta
Yb_JS = 1.0*( (pi*0.5*lamda) + 1.4*Cb*(B / Lpp) )*(1 + (2/3)*tao);
Yr_JS = 0.25*pi*lamda*(1 + 0.8*tao);
Nb_JS = lamda*(1 - 0.27*tao / lv);
Nr_JS = -1.0*(0.54*lamda - lamda^2)*(1 + 0.3*tao);
%table
L_JS_Yang_1981 = ['Yv';'Yr';'Nv';'Nr'];
L_JS_Yang_Val = [Yv_JS_Yang;Yr_JS_Yang;Nv_JS_Yang;Nr_JS_Yang];
L_JS_1981 = ['Yb';'Yr';'Nb';'Nr'];
L_JS_Val = [Yb_JS;Yr_JS;Nb_JS;Nr_JS];

% =====================================================
Yv_WS = -1.59*pi*d_L;
Yr_WS = 0.32*pi*d_L;
Nv_WS = -0.62*pi*d_L;
Nr_WS = -0.21*pi*d_L;
%table
L_WS_197X = ['Yv';'Yr';'Nv';'Nr'];
L_WS_Val = [Yv_WS;Yr_WS;Nv_WS;Nr_WS];

% =====================================================
CbB_pidm = Cb*B / (dM*pi);
Yv_NB = -1.0*pi*d_L*(1.69 + 0.08*CbB_pidm);
Yr_NB = -1.0*pi*d_L*(-0.645 + 0.38*CbB_pidm);
Nv_NB = -1.0*pi*d_L*(0.64 - 0.04*CbB_pidm);
Nr_NB = -1.0*pi*d_L*(0.47 - 0.18*CbB_pidm);
%table
L_NB_1970 = ['Yv';'Yr';'Nv';'Nr'];
L_NB_Val = [Yv_NB;Yr_NB;Nv_NB;Nr_NB];

% =====================================================
Yv_CK = -1.0*pi*d_L*(1.0 + 0.4*Cb*B_d);
Yr_CK = -1.0*pi*d_L*(-0.5 + 2.2*B_L + 0.08*B_d);
Nv_CK = -1.0*pi*d_L*(0.5 + 0.24*d_L);
Nr_CK = -1.0*pi*d_L*(0.25 - 0.56*B_L + 0.039*B_d);
%table
L_CK_1983 = ['Yv';'Yr';'Nv';'Nr'];
L_CK_Val = [Yv_NB;Yr_NB;Nv_NB;Nr_NB];

% =====================================================
Yb_KJ_1990 = (0.5*pi*k+1.4*Cb*B_L)*(1 + (25*Cb*B_L-2.25)*tao);
Yr_KJ_1990 = (m_d + mx_d)+(-1.5*Cb*B_L)*(1 + ( 571*(dM*(1-Cb)/B)^2 - 81*dM*(1-Cb)/B + 2.1 )*tao ) ;
Nb_KJ_1990 =k*(1-tao);
Nr_KJ_1990 = (-0.54*k+k^2)*(1 + (34*Cb*B_L-3.4)*tao );
%table
L_KJ_1990 = ['Yb';'Yr';'Nb';'Nr'];
L_KJ_1990_Val = [Yb_KJ_1990;Yr_KJ_1990;Nb_KJ_1990;Nr_KJ_1990];

% =====================================================
Yb_KJ_2002 = (0.5*pi*k + 1.9257*Cb*B*ea_/Lpp)*(1 + (26.059* (dM*Cb / B)*sgm_a - 2.425)*tao);
Yr_KJ_2002 = (m_d + mx_d) + (0.25*pi*k + 0.052*ea_ - 0.457)*(1 - 0.307*tao);
Nb_KJ_2002 = (k*(150.668*(dM*(1 - Cb)*ea_*K / B)^2 - 23.819*(dM*(1 - Cb)*ea_*K / B) + 1.802))*(1 - 0.935*tao);
Nr_KJ_2002 = (-0.54*k + k^2 - 0.048*ea_*K + 0.037)*(1 + (0.917*Cb*ea_ - 2.5625)*tao);
%table
L_KJ_2002 = ['Yb';'Yr';'Nb';'Nr'];
L_KJ_2002_Val = [Yb_KJ_2002;Yr_KJ_2002;Nb_KJ_2002;Nr_KJ_2002];

% =====================================================
Yv_Lee = -(0.145+2.25*d_L);
Yr_Lee = -(0.282*d_L + 0.004)/d_L + m_d;
Nv_Lee = -(0.222*d_L + 0.00484)/d_L;
Nr_Lee = -(0.0424*d_L - 0.00027)/d_L;
%table
L_Lee_2003 = ['Yv';'Yr';'Nv';'Nr'];
L_Lee_Val = [Yv_Lee;Yr_Lee;Nv_Lee;Nr_Lee];

% =====================================================
Yv_VA = -pi*d_L*(2.8-8*B_L);
Yr_VA = pi*d_L*(0.5-0.5*B_L);
Nv_VA = -1.6*(d_L)/sqrt(Cb);
Nr_VA = Yv_VA*(0.185-2.5*pi*d_L);
%table
L_VA_2006 = ['Yv';'Yr';'Nv';'Nr'];
L_VA_Val = [Yv_VA;Yr_VA;Nv_VA;Nr_VA];

% =====================================================
Yb_YandM = (0.5*pi*k+1.4*Cb/L_B)*(1 + 0.6*tao^2);
Yr_YandM =  (0.5*Cb/L_B)*(0.4+1.8*tao^2) + mx_d;
Nb_YandM = k*(1 - 0.9*tao);
Nr_YandM = -0.54*k + k^2;
%table
L_YandM_2003 = ['Yb';'Yr';'Nb';'Nr'];
L_YandM_Val = [Yb_YandM;Yr_YandM;Nb_YandM;Nr_YandM];

% =====================================================
Yb_Ma_1993 = (0.5*pi*k+1.4*Cb/L_B)*(1 + (25*Cb*B_L-2.25)*tao);
Yr_Ma_1993 =  (0.25*pi*k)*(1 + ( 571*(dM*(1-Cb)/B)^2 - 81*dM*(1-Cb)/B + 2.1 )*tao )+(m_d + mx_d);
Nb_Ma_1993 = k*(1 - tao);
Nr_Ma_1993 = (-0.54*k + k^2)*(1 + (34*Cb*B_L-3.4)*tao );
%table
L_Ma_1993 = ['Yb';'Yr';'Nb';'Nr'];
L_Ma_1993_Val = [Yb_Ma_1993;Yr_Ma_1993;Nb_Ma_1993;Nr_Ma_1993];

allcoefNotice = ['         | --- writing all Linear YH,NH ceof to result/',shipName,'L_YN.csv'];
disp(allcoefNotice);

LinearCoef_Full = table(...
    L_JS_Yang_1981, L_JS_Yang_Val,...
    L_JS_1981,          L_JS_Val,...
    L_WS_197X,       L_WS_Val,...
    L_NB_1970,        L_NB_Val,...
    L_CK_1983,        L_CK_Val,...
    L_KJ_1990,         L_KJ_1990_Val,...
    L_KJ_2002,        L_KJ_2002_Val,...
    L_Lee_2003,      L_Lee_Val,...
    L_VA_2006,       L_VA_Val,...
    L_YandM_2003, L_YandM_Val,...
    L_Ma_1993,       L_Ma_1993_Val );



%new folder according to create time(sec)
timeCreate=datevec(datestr(now));
month = num2str(timeCreate(2));
day = num2str(timeCreate(3));
hor = num2str(timeCreate(4));
mint = num2str(timeCreate(5));
secd = num2str(timeCreate(6));
newFolder = ['result/',shipName,'_',month,'_',day,'_',hor,'_',mint,'_',secd];
if exist(newFolder) == false; mkdir(newFolder); end
allCoefFile = [newFolder,'/',shipName,'_L_YN.csv'];
writetable(LinearCoef_Full,allCoefFile);

%output final coef
switch(hullLinear)
    case '1'
        fprintf('         | --- Linear YH,NH refer to¡¾ JS_Yang_1981¡¿\n' );
        Yv      =0;
        Yr      =0;
        Nv      =0;
        Nr      =0;
    case '2'
        fprintf('         | --- Linear YH,NH refer to¡¾ JS_1981¡¿\n' );
        Yv      =0;
        Yr      =0;
        Nv      =0;
        Nr      =0;
    case '3'
        fprintf('         | --- Linear YH,NH refer to¡¾ WS_197X¡¿ \n' );
        Yv      =0;
        Yr      =0;
        Nv      =0;
        Nr      =0;
    case '4'
        fprintf('         | --- Linear YH,NH refer to¡¾ NB_1970¡¿\n' );
        Yv      =0;
        Yr      =0;
        Nv      =0;
        Nr      =0;
    case '5'
        fprintf('         | --- Linear YH,NH refer to¡¾ CK_1983¡¿\n' );
        Yv      =0;
        Yr      =0;
        Nv      =0;
        Nr      =0;
    case '6'
        fprintf('         | --- Linear YH,NH refer to¡¾ KJ_1990¡¿\n' );
        Yv      =0;
        Yr      =0;
        Nv      =0;
        Nr      =0;
    case '7'
        fprintf('         | --- Linear YH,NH refer to¡¾ KJ_2002¡¿\n' );
        Yv      =0;
        Yr      =0;
        Nv      =0;
        Nr      =0;
    case '8'
        fprintf('         | --- Linear YH,NH refer to¡¾ Lee_2003¡¿\n' );
        Yv      =0;
        Yr      =0;
        Nv      =0;
        Nr      =0;
    case '9'
        fprintf('         | --- Linear YH,NH refer to¡¾ VA_2006 ¡¿\n' );
        Yv      =0;
        Yr      =0;
        Nv      =0;
        Nr      =0;
    case '10'
        fprintf('         | --- Linear YH,NH refer to¡¾ YandM_2003¡¿\n' );
        Yv      =0;
        Yr      =0;
        Nv      =0;
        Nr      =0;
    case '11'
        fprintf('         | --- Linear YH,NH refer to¡¾ Ma_1993¡¿ \n' );
        Yv      =0;
        Yr      =0;
        Nv      =0;
        Nr      =0;
    otherwise
        fprintf('         | --- Linear YH,NH refer to¡¾ JS_Yang_1981 ¡¿\n' );
        Yv      =0;
        Yr      =0;
        Nv      =0;
        Nr      =0;
end




sL_YN = struct('Yv',Yv,'Yr',Yr,'Nv',Nv,'Nr',Nr);