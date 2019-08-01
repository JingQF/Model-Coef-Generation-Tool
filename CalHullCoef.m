function [ hullCoef ] = CalHullCoef( shipName, hullNonX, hullLinYN , hullNonYN, fileOutput)
% To write the ".COEF" file for the input of simulation model.
% 2019-07-20
% Brief instructions
% 1. INPUT:  (1) shipName = the ship basic data stored in XX.mat in 'ship/' folder. 
%                (2) hullLinear = linear method
%                (3) hullNonX = non-linear method X
%                (3) hullNonYN = non-linear method Y and N
% 2. 这里只能估算部分系数，一些关于横摇的可以直接手动输入 COEF 文件.
% author: Jing Qianfeng

disp('· Step 3 : Load shipName.mat -> estimate hydro coef -> create shipName.COEF file' );

%load mat
shipMatFile = ['ship/',shipName,'.mat'];%input mat
load(shipMatFile);
%run script
sN_X = HydroCoef_NL_X(shipName, hullNonX );
sL_YN = HydroCoef_L(shipName, hullLinYN );
sN_YN = HydroCoef_NL_YN(shipName, hullNonYN );
sMij = CalAddedMassInteria(shipName);
nNL_X = hullNonX; nL_YN=hullLinYN; nNL_YN=hullNonYN;

%make file path
hullCoef = ['         | --- writing all static coef to result/',shipName,'.COEF'];%output information
disp(hullCoef);
if exist(fileOutput) == false; mkdir(fileOutput); end
outputPath = [fileOutput,'/',shipName,'.COEF'];

%open and write '.COEF' file
fileCoef = fopen(outputPath,'w');
fprintf(fileCoef,'%d \t #nNL_X     	\n', nNL_X     );
fprintf(fileCoef,'%d \t #nL_YN     	\n', nL_YN     );
fprintf(fileCoef,'%d \t #nNL_YN    \n', nNL_YN     );
%mij
fprintf(fileCoef,'%.5f\t#mx     	\n', sMij.mx     );
fprintf(fileCoef,'%.5f\t#my         \n', sMij.my      );
fprintf(fileCoef,'%.5f\t#mz         \n', sMij.mz      );
fprintf(fileCoef,'%.5f\t#Ixx        \n', sMij.Ixx     );
fprintf(fileCoef,'%.5f\t#Iyy        \n', sMij.Iyy     );
fprintf(fileCoef,'%.5f\t#Izz        \n', sMij.Izz     );
fprintf(fileCoef,'%.5f\t#Jxx        \n', sMij.Jxx     );
fprintf(fileCoef,'%.5f\t#Jyy        \n', sMij.Jyy     );
fprintf(fileCoef,'%.5f\t#Jzz        \n', sMij.Jzz     );
%Non-lin X
fprintf(fileCoef,'%.5f\t#Xvv        \n',sN_X.Xvv     );
fprintf(fileCoef,'%.5f\t#Xvr        \n', sN_X.Xvr     );
fprintf(fileCoef,'%.5f\t#Xrr		\n', sN_X.Xrr	);
fprintf(fileCoef,'%.5f\t#Xvvvv      \n', sN_X.Xvvvv   );
fprintf(fileCoef,'%.5f\t#Xvphi      \n', sN_X.Xvphi   );
fprintf(fileCoef,'%.5f\t#Xrphi      \n', sN_X.Xrphi   );
fprintf(fileCoef,'%.5f\t#Xphiphi    \n',sN_X.Xphiphi );
%Lin YN
fprintf(fileCoef,'%.5f\t#Yv         \n',sL_YN.Yv      );
fprintf(fileCoef,'%.5f\t#Yr         \n',sL_YN.Yr      );
fprintf(fileCoef,'%.5f\t#Nv         \n',sL_YN.Nv      );
fprintf(fileCoef,'%.5f\t#Nr         \n',sL_YN.Nr      );
fprintf(fileCoef,'%.5f\t#Yb         \n',sL_YN.Yb      );
fprintf(fileCoef,'%.5f\t#Nb         \n',sL_YN.Nb      );
%Non-lin YN
fprintf(fileCoef,'%.5f\t#Yvv     \n',sN_YN.Yvv     );
fprintf(fileCoef,'%.5f\t#Yrr     \n',sN_YN.Yrr     );
fprintf(fileCoef,'%.5f\t#Yvr     \n',sN_YN.Yvr     );
fprintf(fileCoef,'%.5f\t#Nvv     \n',sN_YN.Nvv     );
fprintf(fileCoef,'%.5f\t#Nrr     \n',sN_YN.Nrr     );
fprintf(fileCoef,'%.5f\t#Nvr     \n',sN_YN.Nvr     );
fprintf(fileCoef,'%.5f\t#Yvvr    \n',sN_YN.Yvvr    );
fprintf(fileCoef,'%.5f\t#Yvrr    \n',sN_YN.Yvrr    );
fprintf(fileCoef,'%.5f\t#Nvvr    \n',sN_YN.Nvvr    );
fprintf(fileCoef,'%.5f\t#Nvrr    \n',sN_YN.Nvrr    );
fprintf(fileCoef,'%.5f\t#Ybb     \n',sN_YN.Ybb     );
fprintf(fileCoef,'%.5f\t#Ybr     \n',sN_YN.Ybr     );
fprintf(fileCoef,'%.5f\t#Nbb     \n',sN_YN.Nbb     );
fprintf(fileCoef,'%.5f\t#Nbr     \n',sN_YN.Nbr     );
fprintf(fileCoef,'%.5f\t#Ybbr    \n',sN_YN.Ybbr    );
fprintf(fileCoef,'%.5f\t#Ybrr    \n',sN_YN.Ybrr    );
fprintf(fileCoef,'%.5f\t#Nbbr    \n',sN_YN.Nbbr    );
fprintf(fileCoef,'%.5f\t#Nbrr    \n',sN_YN.Nbrr    );
fprintf(fileCoef,'%.5f\t#ax2     \n',sN_YN.ax2     );
fprintf(fileCoef,'%.5f\t#ax4     \n',sN_YN.ax4     );
fprintf(fileCoef,'%.5f\t#bx1     \n',sN_YN.bx1     );
fprintf(fileCoef,'%.5f\t#bx2     \n',sN_YN.bx2     );
fprintf(fileCoef,'%.5f\t#ay1     \n',sN_YN.ay1     );
fprintf(fileCoef,'%.5f\t#ay3     \n',sN_YN.ay3     );
fprintf(fileCoef,'%.5f\t#ay5     \n',sN_YN.ay5     );
fprintf(fileCoef,'%.5f\t#cy1     \n',sN_YN.cy1     );
fprintf(fileCoef,'%.5f\t#dy1     \n',sN_YN.dy1     );
fprintf(fileCoef,'%.5f\t#ey1     \n',sN_YN.ey1     );
fprintf(fileCoef,'%.5f\t#an2     \n',sN_YN.an2     );
fprintf(fileCoef,'%.5f\t#an4     \n',sN_YN.an4     );
fprintf(fileCoef,'%.5f\t#cn2     \n',sN_YN.cn2     );
fprintf(fileCoef,'%.5f\t#dn0     \n',sN_YN.dn0     );
fprintf(fileCoef,'%.5f\t#dn2     \n',sN_YN.dn2     );
fprintf(fileCoef,'%.5f\t#en0     \n',sN_YN.en0     );
fprintf(fileCoef,'%.5f\t#Yvvv    \n',sN_YN.Yvvv    );
fprintf(fileCoef,'%.5f\t#Yrrr    \n',sN_YN.Yrrr    );
fprintf(fileCoef,'%.5f\t#Nvvv    \n',sN_YN.Nvvv    );
fprintf(fileCoef,'%.5f\t#Nrrr    \n',sN_YN.Nrrr    );
fprintf(fileCoef,'%.5f\t#Yphi    \n',sN_YN.Yphi    );
fprintf(fileCoef,'%.5f\t#Yvvphi  \n',sN_YN.Yvvphi  );
fprintf(fileCoef,'%.5f\t#Yvphiphi\n',sN_YN.Yvphiphi);
fprintf(fileCoef,'%.5f\t#Yrrphi  \n',sN_YN.Yrrphi  );
fprintf(fileCoef,'%.5f\t#Yrphiphi\n',sN_YN.Yrphiphi);
fprintf(fileCoef,'%.5f\t#Nphi    \n',sN_YN.Nphi    );
fprintf(fileCoef,'%.5f\t#Nvvphi  \n',sN_YN.Nvvphi  );
fprintf(fileCoef,'%.5f\t#Nvphiphi\n',sN_YN.Nvphiphi);
fprintf(fileCoef,'%.5f\t#Nrrphi  \n',sN_YN.Nrrphi  );
fprintf(fileCoef,'%.5f\t#Nrphiphi',sN_YN.Nrphiphi);
fclose(fileCoef);


