function [ sN_YN ] = HydroCoef_NL_YN( shipName, hullNonYN, fileOutput)
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

% Hull forces and moments compare



% =====================================================
%  周昭明  原作类型 u,v,r  
% 对应文献：1983 多用途货船的操纵性预报计算
% 简介：回归井上非线性的图谱
Yvv_ZZM = 0.048265 - 6.293*(1-Cb)*d_B;
Yrr_ZZM = 0.0045 - 0.445*(1-Cb)*d_B;
Yvr_ZZM = -0.3791 + 1.28*(1-Cb)*d_B;
Nvv_ZZM = 0;
Nrr_ZZM = -0.0805 + 8.6092*(Cb*B_L)^2-36.9816*(Cb*B_L)^3;
Nvr_ZZM = 0;
Yvvr_ZZM= 0;
Yvrr_ZZM= 0;
Nvvr_ZZM= -6.0856 + 137.4735*(Cb*B_L)-1039.514*(Cb*B_L)^2 + 2480.6082*(Cb*B_L)^3;
Nvrr_ZZM=-0.0635 + 0.04414*(Cb*B_L);
%table
ZZM_1983 = {'Yvv';'Yrr';'Yvr';'Nvv';'Nrr';'Nvr';'Yvvr';'Yvrr';'Nvvr';'Nvrr';'\';'\';'\';'\';'\';'\'};
ZZM_val = [Yvv_ZZM;Yrr_ZZM;Yvr_ZZM;Nvv_ZZM;Nrr_ZZM;Nvr_ZZM;Yvvr_ZZM;Yvrr_ZZM;Nvvr_ZZM;Nvrr_ZZM;0;0;0;0;0;0];

% =====================================================
%  Lewis  原作类型 u,v,r  
% 对应文献：1985 A Computer program to predict ship maneuvering in the horizontal plane.
% 简介：回归井上非线性的图谱
Yvv_LW = 0.07-6.48*(1-Cb)*d_B;
Yrr_LW = -0.45*(1-Cb)*d_B;
Yvr_LW = -0.45+1.65*(1-Cb)*d_B;
Nvv_LW = 0;
Nrr_LW = -0.135+1.555*(Cb*B_L)-5.01*(Cb*B_L)^2;
Nvr_LW = 0;
Yvvr_LW= 0;
Yvrr_LW= 0;
if (Cb*B_L <= 0.122)
    Nvvr_LW= -4.12+75.9*(Cb*B_L)-354.3*(Cb*B_L)^2;
else
    Nvvr_LW=-0.332+4.861*(Cb*B_L)-23.62*(Cb*B_L)^2;
end
Nvrr_LW=-0.06+0.45*(Cb*d_B)^3;
%table
LW_1985 = {'Yvv';'Yrr';'Yvr';'Nvv';'Nrr';'Nvr';'Yvvr';'Yvrr';'Nvvr';'Nvrr';'\';'\';'\';'\';'\';'\'};
LW_val = [Yvv_LW;Yrr_LW;Yvr_LW;Nvv_LW;Nrr_LW;Nvr_LW;Yvvr_LW;Yvrr_LW;Nvvr_LW;Nvrr_LW;0;0;0;0;0;0];

% =====================================================
%  刘正江  原作类型 u,v,r  
% 对应文献：1987 倒车停船性能实用预报的研究
% 简介：回归井上和周昭明非线性的图谱
Yvv_LZJ = 0.048265 - 6.293*(1-Cb)*d_B;
Yrr_LZJ = 0.0045 - 0.445*(1-Cb)*d_B;
Yvr_LZJ = -0.3791 + 1.28*(1-Cb)*d_B;
Nvv_LZJ = 0;
Nrr_LZJ = -0.0805 + 8.6092*(Cb*B_L)^2-36.9816*(Cb*B_L)^3;
Nvr_LZJ = 0;
Yvvr_LZJ= 0;
Yvrr_LZJ= 0;
Nvvr_LZJ=-0.42361 + 3.5193*(Cb*B_L)+135.4668*(Cb*B_L)^2 - 686.3107*(Cb*B_L)^3;
Nvrr_LZJ=-0.05877 + 0.43958*(Cb*B_L);
%table
LZJ_1987 = {'Yvv';'Yrr';'Yvr';'Nvv';'Nrr';'Nvr';'Yvvr';'Yvrr';'Nvvr';'Nvrr';'\';'\';'\';'\';'\';'\'};
LZJ_val = [Yvv_LZJ;Yrr_LZJ;Yvr_LZJ;Nvv_LZJ;Nrr_LZJ;Nvr_LZJ;Yvvr_LZJ;Yvrr_LZJ;Nvvr_LZJ;Nvrr_LZJ;0;0;0;0;0;0];

% =====================================================
%  貴島 勝郎 Kijima Katsuro  原作类型 beta,r  
% 对应文献：1990 Theory and observations on the use of a mathematical model for ship manoeuvring in deep and confined waters. 
% 简介：考虑船尾形状修正，1990的试验船整体Cb符合，而且有压载满载半载不同状态
Ybb_KJ_1990 = (2.5*dM*(1-Cb)/B+0.5)*(1-(35.7*Cb*B_L -2.5)*tao );
Yrr_KJ_1990 = (0.343*dM*Cb/B-0.07)*( 1+(45*Cb*B_L -8.1)*tao );
Ybr_KJ_1990 = 0;
Nbb_KJ_1990 = (-0.96*dM*(1-Cb)/B+0.066);
Nrr_KJ_1990 = (0.5*Cb*B_L-0.09);
Nbr_KJ_1990 = 0;
Ybbr_KJ_1990= (1.5*dM*Cb/B-0.65)*( 1+(110*dM*(1-Cb)/B -9.7)*tao );
Ybrr_KJ_1990= (5.95*dM*(1-Cb)/B)*( 1+(40*dM*(1-Cb)/B -2)*tao );
Nbbr_KJ_1990= (-57.5*(Cb*B_L)^2 - 18.4*Cb*B_L + 1.6)*(1 + (3*Cb*B_L-1)*tao );%跟2002差很多
Nbrr_KJ_1990= (-0.5*dM*Cb/B-0.05)*(1 + (48*(Cb*B_L)^2 -16*Cb*B_L +1.3) *100*tao ) ;
%table
KJ_1990 = {'Ybb';'Yrr';'Ybr';'Nbb';'Nrr';'Nbr';'Ybbr';'Ybrr';'Nbbr';'Nbrr';'\';'\';'\';'\';'\';'\'};
KJ_1990_val = [Ybb_KJ_1990;Yrr_KJ_1990;Ybr_KJ_1990;Nbb_KJ_1990;Nrr_KJ_1990;Nbr_KJ_1990;Ybbr_KJ_1990;Ybrr_KJ_1990;Nbbr_KJ_1990;Nbrr_KJ_1990;0;0;0;0;0;0];

% =====================================================
%  貴島 勝郎 Kijima Katsuro  原作类型 beta,r  
% 对应文献：2002 On the Practical Prediction Method for Ship Manoeuvring Characteristics
% 简介：Cb较大的船更多一些，相比1990没有载态的考察
Ybb_KJ_2002 = (4.17*k*Cb*ea_ - 0.4475)*(1 - (1.736*B_d*sgm_a - 1.42)*tao);
Yrr_KJ_2002 = (0.24267*dM*Cb/B*ea_-0.13108)*(1-(236.693*dM*Cb/B*sgm_a - 22.2244)*tao );
Ybr_KJ_2002 = 0;
Nbb_KJ_2002 = (43.857*(dM*(1-Cb)/B*ea_*K)^2 - 3.671*(dM*(1-Cb)/B*ea_*K) + 0.086);
Nrr_KJ_2002 = (0.15*K - 0.068)*(1 + 0.173*tao);
Nbr_KJ_2002 = 0;
Ybbr_KJ_2002= (-42.6537*Cb*B_L + 5.9)*(1-(6.124*Cb*ea_-15.488)*tao);
Ybrr_KJ_2002= (-1.38643*Cb*ea_*K+1.29)*(1-(96.5785*k*Cb - 4.23)*tao);
Nbbr_KJ_2002=  (-0.4086*Cb + 0.27)*(1-0.39*tao);
Nbrr_KJ_2002=(-0.826*(dM*(1-Cb)/B)*ea_-0.026)*(1- ( 1.98*ea_^2 - 14.648*ea_ + 27.311)*tao);
%table
KJ_2002 = {'Ybb';'Yrr';'Ybr';'Nbb';'Nrr';'Nbr';'Ybbr';'Ybrr';'Nbbr';'Nbrr';'\';'\';'\';'\';'\';'\'};
KJ_2002_val = [Ybb_KJ_2002;Yrr_KJ_2002;Ybr_KJ_2002;Nbb_KJ_2002;Nrr_KJ_2002;Nbr_KJ_2002;Ybbr_KJ_2002;Ybrr_KJ_2002;Nbbr_KJ_2002;Nbrr_KJ_2002;0;0;0;0;0;0];

% =====================================================
%  松永 昌樹 Masaki Matsunaga  原作类型 beta,r 
% 对应文献：1993 Method of Predicting Ship Manoeuvrability in Deep and shallow Waters as a Function of Loading Conditiont
% 简介：考量载态并考量浅水，这里不计算浅水，浅水单独算一个文件
Ybb_Ma_1993 = (2.5*dM*(1-Cb)/B+0.5)*(1-(35.7*Cb*B_L-2.5)*tao);
Yrr_Ma_1993 = (0.343*dM*Cb/B-0.07)*(1 + (45*Cb*B_L-8.1)*tao);
Ybr_Ma_1993 = 0;
Nbb_Ma_1993 = (78.0*(dM*(1-Cb)/B)^2 - 19.0*dM*(1-Cb)/B + 1.0);
Nrr_Ma_1993 = 0.473*Cb*B_L - 0.089;
Nbr_Ma_1993 = 0;
Ybbr_Ma_1993= (-1.14*100*(dM*Cb/B)^2 + 62.12*dM*Cb/B - 8.2)*(1+(110*dM*(1-Cb)/B-9.7 )*tao );
Ybrr_Ma_1993= (5.95*dM*(1-Cb)/B)*(1+(40*dM*(1-Cb)/B-2 )*tao );
Nbbr_Ma_1993=  ( -(120*(Cb*B_L)^2 - 35.22*Cb*B_L + 2.72) )*(1 + (3*Cb*B_L -1)*tao );
Nbrr_Ma_1993= (-(0.5*dM*Cb/B -0.05 ))*(1 + (48*(Cb*B_L)^2 - 16*Cb*B_L + 1.3 )*100*tao);
%table
Ma_1993 = {'Ybb';'Yrr';'Ybr';'Nbb';'Nrr';'Nbr';'Ybbr';'Ybrr';'Nbbr';'Nbrr';'\';'\';'\';'\';'\';'\'};
Ma_1993_val = [Ybb_Ma_1993;Yrr_Ma_1993;Ybr_Ma_1993;Nbb_Ma_1993;Nrr_Ma_1993;Nbr_Ma_1993;Ybbr_Ma_1993;Ybrr_Ma_1993;Nbbr_Ma_1993;Nbrr_Ma_1993;0;0;0;0;0;0];

% =====================================================
%  Kang  原作类型 beta,r  Cb非常接近
% 对应文献：2007 Prediction method of hydrodynamic forces acting on the hull of a blunt-body ship in the even keel condition
% 简介：这个方法的Zigzag非常好，旋回应该也不错，但是舵正之后船走不直，为什么呢？？
ax2 = B_L*(-0.54867+11.791*d_L);
ax4 = k*(-0.07237-0.52608*B_L);
bx1 = 0.01835-1.2425*d_L;
bx2 = -0.0333 - 0.55842*d_L;
ay1 = 0.50194+5.3541*d_L;
ay3 = -0.08788 + 0.73174*Cb*B_L*K;
ay5 = -0.10285+1.9317*d_B*(1-Cb)*K;
cy1 = k*(12.69-131.63*Cb*B_L + 430.7*(Cb*B_L)^2 );
dy1 = B_L*(-0.53782+6.6751*k);
ey1 = -0.09165 + 0.16968*Cb*d_B*ea_;
an2 = B_L*(0.07093+1.1936*d_B);
an4 = K*(-0.052545 + 0.42428*Cb*B_L*K);
cn2 = d_B*(-0.14737 + 0.43812*d_B*(1-Cb)*ea_);
dn0 = -0.06338 - 1.253*d_B*(1-Cb)*K;
dn2 = k*(0.46815 - 0.82503*Cb*ea_*k);
en0 = -0.04755+0.10488*K;
%table
Kang_2007 = {'ax2';'ax4';'bx1';'bx2';'ay1';'ay3';'ay5';'cy1';'dy1';'ey1';'an2';'an4';'cn2';'dn0';'dn2';'en0'};
Kang_Val = [ax2;ax4;bx1;bx2;ay1;ay3;ay5;cy1;dy1;ey1;an2;an4;cn2;dn0;dn2;en0];

% =====================================================
%  Tae II Lee  原作类型 u,v,r 不可靠因为ballast才好用
% 对应文献：2003 Tae-II Lee-On an empirical prediction of hydrodynamic coefficients for modern ship hulls
% 简介：考量船尾形状和载态，但是参数不好获得，但是罕见的可以估计压载和满载的
Yvvv_Lee =(1.281*d_L+0.031)/d_L;
Yrrr_Lee = (0.029*Cb*B_L-0.004)/d_L;
Yvvr_Lee = (0.628*Cb*B_L-0.066)/d_L;
Yvrr_Lee = (0.4*d_L+0.007)/d_L;
Nvvv_Lee = (0.188*d_L-0.01)/d_L;
Nrrr_Lee = (0.014*Cb*B_L-0.002)/d_L;
Nvvr_Lee = (0.178*Cb*B_L-0.037)/d_L;
Nvrr_Lee = (0.158*d_L-0.005)/d_L;
%table
Lee_2003 = {'Yvvv';'Yrrr';'Yvvr';'Yvrr';'Nvvv';'Nrrr';'Nvvr';'Nvrr';'\';'\';'\';'\';'\';'\';'\';'\'};
Lee_Val = [Yvvv_Lee;Yrrr_Lee;Yvvr_Lee;Yvrr_Lee;Nvvv_Lee;Nrrr_Lee;Nvvr_Lee;Nvrr_Lee;0;0;0;0;0;0;0;0];

allcoefNotice = ['         | --- writing all Non-Linear YH,NH coef to result/',shipName,'_NL_YN.csv'];
disp(allcoefNotice);
%=====Write Table
NonLinearCoef_YN_Full = table(...
    Kang_2007,        Kang_Val,...
    ZZM_1983,         ZZM_val,...
    LW_1985,           LW_val,...
    LZJ_1987,           LZJ_val,...
    KJ_1990,             KJ_1990_val,...
    KJ_2002,            KJ_2002_val,...
    Lee_2003,          Lee_Val,...
    Ma_1993,           Ma_1993_val);

%new folder according to create time(sec)
if exist(fileOutput) == false; mkdir(fileOutput); end
allCoefFile = [fileOutput,'/',shipName,'_NL_YN.csv'];
writetable(NonLinearCoef_YN_Full,allCoefFile);

flag = 0; % uvr
%output final coef
switch(hullNonYN)
    case 1
        fprintf('         | --- Non-Linear YH,NH refer to【 ZZM_1983 】\n' );
         YN  = ZZM_val;
    case 2
        fprintf('         | --- Non-Linear YH,NH refer to【 LW_1985 】\n' );
        YN  = LW_val;
    case 3
        fprintf('         | --- Non-Linear YH,NH refer to【 LZJ_1987 】\n' );
        YN  = LZJ_val;
    case 4
        fprintf('         | --- Non-Linear YH,NH refer to【 KJ_1990 】\n' );
        YN  = KJ_1990_val;
        flag = 1; % beta
    case 5
        fprintf('         | --- Non-Linear YH,NH refer to【 KJ_2002  】\n' );
        YN  = KJ_2002_val;
        flag = 1; % beta
    case 6
        fprintf('         | --- Non-Linear YH,NH refer to【 Ma_1993 】\n' );
        YN  = Ma_1993_val;
        flag = 1; % beta
    case 7
        fprintf('         | --- Non-Linear YH,NH refer to【 Kang_2007 】\n' );
        flag = 2; 
        YN  = Kang_Val;
    case 8
        fprintf('         | --- Non-Linear YH,NH refer to【 Lee_2003 】\n' );
        flag = 3; 
        YN  = Lee_Val;
    otherwise
        fprintf('         | --- Non-Linear YH,NH refer to【 LZJ_1987 】\n' );
        YN  = LZJ_val;
end

%all coef
Yvv  =0;Yrr  =0;Yvr  =0;Nvv  =0;Nrr  =0;Nvr  =0;
Yvvr =0;Yvrr =0;Nvvr =0;Nvrr =0;
Ybb  =0;Ybr  =0;Nbb  =0;Nbr  =0;
Ybbr =0;Ybrr =0;Nbbr =0;Nbrr =0;
ax2  =0;ax4  =0;bx1  =0;bx2  =0;
ay1  =0;ay3  =0;ay5  =0;cy1  =0;
dy1  =0;ey1  =0;an2  =0;an4  =0;
cn2  =0;dn0  =0;dn2  =0;en0  =0;
Yvvv =0;Yrrr =0;
Nvvv =0;Nrrr =0;

%完善程序逻辑
%uvr
if (flag == 0)
    Yvv=YN(1);  Yrr=YN(2); Yvr=YN(3); Nrr=YN(5); Nvvr=YN(9); Nvrr=YN(10); 
end
%beta,r
if (flag == 1)
    Ybb=YN(1);  Yrr=YN(2);  Nbb=YN(4);  Nrr = YN(5);
    Ybbr=YN(7);  Ybrr=YN(8);  Nbbr=YN(9);  Nbrr=YN(10);   
end
%kang
if (flag == 2)
    ax2=YN(1);
    ax4=YN(2);
    bx1=YN(3);
    bx2=YN(4);
    ay1=YN(5);
    ay3=YN(6);
    ay5=YN(7);
    cy1=YN(8);
    dy1=YN(9);
    ey1=YN(10);
    an2=YN(11);
    an4=YN(12);
    cn2=YN(13);
    dn0=YN(14);
    dn2=YN(15);
    en0=YN(16);
end
%Lee 
if (flag == 3)
    Yvvv =YN(1) ;
    Yrrr = YN(2);
    Yvrr = YN(4);
    Yvvr = YN(3);
    Nvvv=YN(5);
    Nrrr=YN(6);
    Nvrr=YN(8);
    Nvvr=YN(7);
end

%by hand
Yphi  =0;Yvvphi  =0;Yvphiphi=0;Yrrphi  =0;Yrphiphi=0;
Nphi  =0;Nvvphi  =0;Nvphiphi=0;Nrrphi  =0;Nrphiphi=0;



sN_YN = struct('Yvv',Yvv    ,... 
'Yrr',Yrr    ,...
'Yvr',Yvr    ,...
'Nvv',Nvv    ,...
'Nrr',Nrr    ,...
'Nvr',Nvr    ,...
'Yvvr',Yvvr   ,...
'Yvrr',Yvrr   ,...
'Nvvr',Nvvr   ,...
'Nvrr',Nvrr   ,...
'Ybb',Ybb    ,...
'Ybr',Ybr    ,...
'Nbb',Nbb    ,...
'Nbr',Nbr    ,...
'Ybbr',Ybbr   ,...
'Ybrr',Ybrr   ,...
'Nbbr',Nbbr   ,...
'Nbrr',Nbrr   ,...
'ax2',ax2    ,...
'ax4',ax4    ,...
'bx1',bx1    ,...
'bx2',bx2    ,...
'ay1',ay1    ,...
'ay3',ay3    ,...
'ay5',ay5    ,...
'cy1',cy1    ,...
'dy1',dy1    ,...
'ey1',ey1    ,...
'an2',an2    ,...
'an4',an4    ,...
'cn2',cn2    ,...
'dn0',dn0    ,...
'dn2',dn2    ,...
'en0',en0    ,...
'Yvvv',Yvvv   ,...
'Yrrr',Yrrr   ,...
'Nvvv',Nvvv   ,...
'Nrrr',Nrrr   ,...
'Yphi',Yphi   ,...
'Yvvphi',Yvvphi ,...
'Yvphiphi',Yvphiphi,...
'Yrrphi',Yrrphi ,...
'Yrphiphi',Yrphiphi,...
'Nphi',Nphi   ,...
'Nvvphi',Nvvphi ,...
'Nvphiphi',Nvphiphi,...
'Nrrphi',Nrrphi ,...
'Nrphiphi',Nrphiphi);