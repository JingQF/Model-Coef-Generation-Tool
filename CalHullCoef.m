function [ hullCoef ] = CalHullCoef( shipName, hullLinear, hullNonX, hullNonYN)
% To write the ".COEF" file for the input of simulation model.
% 2019-07-20
% Brief instructions
% 1. INPUT:  (1) shipName = the ship basic data stored in XX.mat in 'ship/' folder. 
%                (2) hullLinear = linear method
%                (3) hullNonX = non-linear method X
%                (3) hullNonYN = non-linear method Y and N
% 2. only X,Y,N£¬roll related coef edit by hand
% author: Jing Qianfeng

disp('¡¤ Step 3 : Load shipName.mat -> estimate hydro coef -> create shipName.COEF file' );

%load mat
shipMatFile = ['ship/',shipName,'.mat'];%input mat
load(shipMatFile);
%run script
sL_YN = HydroCoef_L(shipName, hullLinear );
sN_X = HydroCoef_NL_X(shipName, hullNonX );
sN_YN = HydroCoef_NL_YN(shipName, hullNonYN );
sMij = CalAddedMassInteria(shipName);

%make file path
hullCoef = [shipName,'.SHIP'];%output
timeCreate=datevec(datestr(now));
month = num2str(timeCreate(2));
day = num2str(timeCreate(3));
hor = num2str(timeCreate(4));
mint = num2str(timeCreate(5));
secd = num2str(timeCreate(6));
newFolder = ['result/',shipName,'_',month,'_',day,'_',hor,'_',mint,'_',secd];
if exist(newFolder) == false; mkdir(newFolder); end
outputPath = [newFolder,'/',shipName,'.COEF'];

%open and write '.COEF' file
fileCoef = fopen(outputPath,'w');
fprintf(fileCoef,'%d	#mx     	\n', sMij.mx     );
fprintf(fileCoef,'%d	#my         \n', sMij.my      );
fprintf(fileCoef,'%d	#mz         \n', sMij.mz      );
fprintf(fileCoef,'%d	#Ixx        \n', sMij.Ixx     );
fprintf(fileCoef,'%d	#Iyy        \n', sMij.Iyy     );
fprintf(fileCoef,'%d	#Izz        \n', sMij.Izz     );
fprintf(fileCoef,'%d	#Jxx        \n', sMij.Jxx     );
fprintf(fileCoef,'%d	#Jyy        \n', sMij.Jyy     );
fprintf(fileCoef,'%d	#Jzz        \n', sMij.Jzz     );
fprintf(fileCoef,'%d	#Xvv        \n',sN_X.Xvv     );
fprintf(fileCoef,'%d	#Xvr        \n', sN_X.Xvr     );
fprintf(fileCoef,'%d	#Xrr		\n', sN_X.Xrr	);
fprintf(fileCoef,'%d	#Xvvvv      \n', sN_X.Xvvvv   );
fprintf(fileCoef,'%d	#Xvphi      \n', sN_X.Xvphi   );
fprintf(fileCoef,'%d	#Xrphi      \n', sN_X.Xrphi   );
fprintf(fileCoef,'%d	#Xphiphi    \n',sN_X.Xphiphi );
fprintf(fileCoef,'%d	#Yv         \n',sL_YN.Yv      );
fprintf(fileCoef,'%d	#Yr         \n',sL_YN.Yr      );
fprintf(fileCoef,'%d	#Yvvv       \n', sN_YN.Yvvv    );
fprintf(fileCoef,'%d	#Yvvr       \n', sN_YN.Yvvr    );
fprintf(fileCoef,'%d	#Yvrr       \n', sN_YN.Yvrr    );
fprintf(fileCoef,'%d	#Yrrr       \n', sN_YN.Yrrr    );
fprintf(fileCoef,'%d	#Yphi       \n', sN_YN.Yphi    );
fprintf(fileCoef,'%d	#Yvvphi     \n', sN_YN.Yvvphi  );
fprintf(fileCoef,'%d	#Yvphiphi   \n', sN_YN.Yvphiphi);
fprintf(fileCoef,'%d	#Yrrphi     \n', sN_YN.Yrrphi  );
fprintf(fileCoef,'%d	#Yrphiphi   \n', sN_YN.Yrphiphi);
fprintf(fileCoef,'%d	#Yvr        \n', sN_YN.Yvr     );
fprintf(fileCoef,'%d	#Yvv        \n', sN_YN.Yvv     );
fprintf(fileCoef,'%d	#Yrr        \n', sN_YN.Yrr     );
fprintf(fileCoef,'%d	#Nv         \n',sL_YN.Nv      );
fprintf(fileCoef,'%d	#Nr         \n',sL_YN.Nr      );
fprintf(fileCoef,'%d	#Nvvv       \n', sN_YN.Nvvv    );
fprintf(fileCoef,'%d	#Nvvr       \n', sN_YN.Nvvr    );
fprintf(fileCoef,'%d	#Nvrr       \n', sN_YN.Nvrr    );
fprintf(fileCoef,'%d	#Nrrr       \n', sN_YN.Nrrr    );
fprintf(fileCoef,'%d	#Nphi       \n', sN_YN.Nphi    );
fprintf(fileCoef,'%d	#Nvvphi     \n', sN_YN.Nvvphi  );
fprintf(fileCoef,'%d	#Nvphiphi   \n', sN_YN.Nvphiphi);
fprintf(fileCoef,'%d	#Nrrphi     \n', sN_YN.Nrrphi  );
fprintf(fileCoef,'%d	#Nrphiphi   \n', sN_YN.Nrphiphi);
fprintf(fileCoef,'%d	#Nvr        \n', sN_YN.Nvr     );
fprintf(fileCoef,'%d	#Nvv        \n', sN_YN.Nvv     );
fprintf(fileCoef,'%d	#Nrr        \n', sN_YN.Nrr     );
fclose(fileCoef);


