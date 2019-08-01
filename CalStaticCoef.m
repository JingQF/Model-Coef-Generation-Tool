function [ staticSHIP ] = CalStaticCoef( shipName, fileOutput )
% To write the ".SHIP" file for the input of simulation model.
% 2019-07-20
% Brief instructions
% 1.  INPUT: shipName = the ship basic data stored in XX.mat in 'ship/' folder. 
% 2. The parameters of .SHIP are from 'shipname.mat' and estimation methods.
% 3. The estimation methods are applied when the parameters is not given in mat(set zero).
% author: Jing Qianfeng

disp('· Step 2 : Load shipName.mat -> calculate basic parameters -> create shipName.SHIP file' );

%load mat
shipMatFile = ['ship/',shipName,'.mat'];%input mat
load(shipMatFile);
%make file path
staticSHIP = ['         | --- writing all static coef to result/',shipName,'.SHIP'];%output information
disp(staticSHIP);

if exist(fileOutput) == false; mkdir(fileOutput); end
outputPath = [fileOutput,'/',shipName,'.SHIP'];


%cal parameters if zero
if GM_L == 0
    GM_L = Cw^2*Lpp^2 / (14 * Cb*dM);
end

if WSA == 0
    WSA = 3.4*m^(2.0 / 3.0) + 0.485*Lpp*m^(1.0 / 3.0); % Froude
end
if wp0 == 0
    wp0 = 0.77*Cp - 0.18;
end
if tp0 ==0
    tp0 = 0.5*Cp - 0.12;
end
    
if gammaA == 0
    gammaA = (B / Lpp) / (1.3*(1 - Cb) - 3.11*(xB / Lpp)*100);
end
if wR0 == 0
    wR0=0.0066*(gammaA*Lpp / Dp) + 0.34;
end
if epsilon==0
    epsilon = -156.2*(Cb*B / Lpp)^2 + 41.6*(Cb*B / Lpp) - 1.76;
end

if gRminus ==0 || gRplus==0
    gRminus = -22.2*(Cb*B/Lpp)^2 + 0.02*(Cb*B/Lpp) + 0.68;
    gRplus=gRminus;
end
if lamdaR==0
    lamdaR = HR / BR;
end
if f_alfa == 0
    f_alfa = (6.13*lamdaR) / (2.25 + lamdaR);
end
if tR ==0
    tR =1- ( 0.28*m_cSt.Cb + 0.55);%待核实
    %tR = 0.7382 - 0.0539*m_cSt.Cb + 0.1755*pow(m_cSt.Cb, 2);
end
if aH == 0
    aH = 0.6784 - 1.3374*Cb + 1.8891*Cb^2;
end
if eta == 0
    eta = Dp / HR;
end
if lR == 0
    lR = -0.9;%yasukawa
end
if zR == 0
    zR = 0.57*dM;
end
if xH ==0
    xH = -(0.4 + 0.1*Cb)*Lpp;
end
    
    
%open and write
fileSHIP = fopen(outputPath,'w');
%write '.SHIP' file
fprintf(fileSHIP,'%d \t #Loading Condition \n',loading);
fprintf(fileSHIP,'%d \t#ShipType \n',shiptype);
fprintf(fileSHIP,'%.4f \t#Volume\n',Vol); 
fprintf(fileSHIP,'%.4f \t#Displacement\n',m);  
fprintf(fileSHIP,'%.4f \t#Lpp\n',Lpp);  
fprintf(fileSHIP,'%.4f \t#Loa\n',Loa);  
fprintf(fileSHIP,'%.4f \t#B\n',B);  	
fprintf(fileSHIP,'%.4f \t#Depth\n',D);  
fprintf(fileSHIP,'%.4f \t#DraftFore\n',dF);  
fprintf(fileSHIP,'%.4f \t#DraftAft\n',dA);
fprintf(fileSHIP,'%.4f \t#DraftMean\n',dM);  
fprintf(fileSHIP,'%.4f \t#Trim\n',Trim);  
fprintf(fileSHIP,'%.4f \t#xB\n',xB);  
fprintf(fileSHIP,'%.4f \t#xF\n',xf);  
fprintf(fileSHIP,'%.4f \t#xG\n',xG);  
fprintf(fileSHIP,'%.4f \t#zH\n',zH);%--只能从 yasu估算
fprintf(fileSHIP,'%.4f \t#a\n',a_roll); %-- 	只能从 yasu估算
fprintf(fileSHIP,'%.4f \t#b\n',b_roll);  %--只能从 yasu估算	
fprintf(fileSHIP,'%.4f \t#KB\n',KB);  %-- 浮心高度
fprintf(fileSHIP,'%.4f \t#TKM\n',GM_T);  
fprintf(fileSHIP,'%.4f \t#LKM\n',GM_L);  %est
fprintf(fileSHIP,'%.4f \t#WSA\n',WSA);  %est
fprintf(fileSHIP,'%.4f \t#WPA\n',WPA);  
fprintf(fileSHIP,'%.4f \t#MIDA\n',MIDA);  
fprintf(fileSHIP,'%.4f \t#Cb\n',Cb);  
fprintf(fileSHIP,'%.4f \t#Cp\n',Cp);  %可互相转换
fprintf(fileSHIP,'%.4f \t#Cw\n',Cw);  
fprintf(fileSHIP,'%.4f \t#Cm\n',Cm);  %可互相转换
fprintf(fileSHIP,'%.4f \t#KG\n',zG);  
fprintf(fileSHIP,'%.4f \t#G0M\n',G0M);  
fprintf(fileSHIP,'%.4f \t#Dp\n',Dp);  % necessary
fprintf(fileSHIP,'%.4f \t#Znum\n',Znum);  
fprintf(fileSHIP,'%.4f \t#Pitch\n',Pitch);  % necessary
fprintf(fileSHIP,'%.4f \t#Panratio\n',PanRatio);
fprintf(fileSHIP,'%.4f \t#Pitchratio\n',PitchRatio); 
fprintf(fileSHIP,'%.4f \t#wp0;\n',wp0); %est
fprintf(fileSHIP,'%.4f \t#tp0;\n',tp0);  %est
fprintf(fileSHIP,'%.4f \t#k2;\n',k2);  % necessary
fprintf(fileSHIP,'%.4f \t#k1;\n',k1);  % necessary
fprintf(fileSHIP,'%.4f \t#k0;\n',k0);  % necessary
fprintf(fileSHIP,'%.4f \t#lP;\n',lP);  % -0.5
fprintf(fileSHIP,'%.4f \t#zP;\n',zP);  %???est 只能从 yasu估算
fprintf(fileSHIP,'%.4f \t#HR\n',HR);  % necessary
fprintf(fileSHIP,'%.4f \t#AR\n',AR);  % necessary
fprintf(fileSHIP,'%.4f \t#BR\n',BR);  % necessary
fprintf(fileSHIP,'%.4f \t#lamdaR\n',lamdaR); %est 
fprintf(fileSHIP,'%.4f \t#f_alfa\n',f_alfa); %est 
fprintf(fileSHIP,'%.4f \t#tR\n',tR);  %est 
fprintf(fileSHIP,'%.4f \t#aH\n',aH);  %est 
fprintf(fileSHIP,'%.4f \t#xH\n',xH);  %est 
fprintf(fileSHIP,'%.4f \t#xR\n',xR);  %-0.5
fprintf(fileSHIP,'%.4f \t#zR\n',zR);  %??est 只能从 yasu估算
fprintf(fileSHIP,'%.4f \t#lR\n',lR);  %est -0.9
fprintf(fileSHIP,'%.4f \t#kappa\n',kappa); %est 
fprintf(fileSHIP,'%.4f \t#eta\n',eta);  %est
fprintf(fileSHIP,'%.4f \t#epsilon\n',epsilon);%est
fprintf(fileSHIP,'%.4f \t#gammaA\n',gammaA);%est
fprintf(fileSHIP,'%.4f \t#gRminus\n',gRminus);%est
fprintf(fileSHIP,'%.4f \t#gRplus\n',gRplus); %est
fprintf(fileSHIP,'%.4f \t#AF\n',AF);  %est 如果没有只能从形状粗略估算
fprintf(fileSHIP,'%.4f \t#AA\n',AA);  %est 如果没有只能从形状粗略估算
fprintf(fileSHIP,'%.4f \t#AB\n',AB);  %est 如果没有只能从形状粗略估算
fprintf(fileSHIP,'%.4f \t#centAA\n',centAA); 
fprintf(fileSHIP,'%.4f \t#centAB\n',centAB); 
fprintf(fileSHIP,'%.4f \t#zAB\n',zAB); 
fprintf(fileSHIP,'%.4f \t#R0', R0);
fclose(fileSHIP);


end