% sample ship parameters
% 2019-07-22
% Brief instructions
% parameters could not obtained from document will be set zero
% author: Jing QF

Shipname= 'Sample';
disp(['         | --- writing basic ship parameters to ship/',Shipname,'.mat']);

loading = 0;%0-full 1-ballast
shiptype = 0;
Vol = 34830; %(m^3)
m = 34757; %(t)
Lpp = 160.4;
Loa = 169.37;
B = 27.2;
D = 13.6;
dF = 9.82;
dA = 10.5;
dM = 9.81;
Trim = dA-dF;
Cb = 0.7906;
Cm = 0.9898;
Cw = 0.8847;
Cp = 0.7987;
AW= 3865;
KM_ = 11.42;
GM_T = 3.36;
GM_L = 185.459;
G0M=0;%--
WSA = 6159.89;
WPA=0;%--
MIDA=0;%--
lamdaH = 0.122319;
xf = 1.07;
xG = -2.18;
xB = -3.9;
zG = 10.55;
zH=0;%--
a_roll=0;%--
b_roll=0;%--
KB=0;%--
R0 = 0;%yasukawa
%propeller
k0=0;
k1=0;
k2=0;
wp0 = 0;
tp0 = 0;
Dp = 5.25;
Znum = 4;
PanRatio = 0.51;
Pitch = 3.6857;
PitchRatio = 0.702;
lP=-0.5;
zP=0;
%rudder
wR0 =0;
HR = 6.95;
AR = 26.396;
BR = 3.4125;
lamdaR = 2.03663;
f_alfa = 0;
tR = 0.194717;
aH = 0.80183;
xH = -76.8412;
xR = -0.5;
kappa = 0.339194;
eta = 0.755396;
epsilon = 1.7689;
gammaA = 0;
gRminus = 0.4646;
gRplus = 0.4646;
lR = -0.9;%
zR = 0;%--
%non-dim added mass / mass
mx_d = 0.0188712; 
my_d = 0.152795;
m_d = m/(0.5*1.025*Lpp^2*dM);

%wind
AF=0;
AA=0;
AB=0;
centAA=0;
centAB=0;
zAB=0;

%For Kijima
Cpa = 0.714;
Cwa = 0.89;
ea = (Lpp/B)*(1 - Cpa);
ea_ = ea / sqrt(    (0.25 + (1 / (B / dM)^2))  );
sgm_a = (1 - Cwa) / (1 - Cpa);
K = (1 / ea_ + 1.5 / (Lpp / B) - 0.33)*(0.95*sgm_a + 0.4);

%repeat calculations
B_L = B / Lpp;
L_B = Lpp/B;
d_B = dM/B;
tao = (dA - dF) / dM;
lamda = (2 * dM) / Lpp;
k = lamda;
lv = lamda / (0.5*pi*lamda + 1.4*Cb*(B / Lpp));
d_L = dM / Lpp;
B_d = B/dM;

if exist('ship')==0; mkdir('ship'); end
savePath = ['ship/',mfilename];
save (savePath);