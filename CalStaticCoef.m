function [ staticSHIP ] = CalStaticCoef( shipName )
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
timeCreate=datevec(datestr(now));
month = num2str(timeCreate(2));
day = num2str(timeCreate(3));
hor = num2str(timeCreate(4));
mint = num2str(timeCreate(5));
secd = num2str(timeCreate(6));
newFolder = ['result/',shipName,'_',month,'_',day,'_',hor,'_',mint,'_',secd];
if exist(newFolder) == false; mkdir(newFolder); end
outputPath = [newFolder,'/',shipName,'.SHIP'];


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
fprintf(fileSHIP,'%d #Loading Condition \n',loading);
fprintf(fileSHIP,'%d #ShipType \n',shiptype);
fprintf(fileSHIP,'%f #Volume\n',Vol); 
fprintf(fileSHIP,'%f #Displacement\n',m);  
fprintf(fileSHIP,'%f #Lpp\n',Lpp);  
fprintf(fileSHIP,'%f #Loa\n',Loa);  
fprintf(fileSHIP,'%f #B\n',B);  	
fprintf(fileSHIP,'%f #Depth\n',D);  
fprintf(fileSHIP,'%f #DraftFore\n',dF);  
fprintf(fileSHIP,'%f #DraftAft\n',dA);
fprintf(fileSHIP,'%f #DraftMean\n',dM);  
fprintf(fileSHIP,'%f #Trim\n',Trim);  
fprintf(fileSHIP,'%f #xB\n',xB);  
fprintf(fileSHIP,'%f #xF\n',xf);  
fprintf(fileSHIP,'%f #xG\n',xG);  
fprintf(fileSHIP,'%f #zH\n',zH);%--
fprintf(fileSHIP,'%f #a\n',a_roll); %-- 	
fprintf(fileSHIP,'%f #b\n',b_roll);  %--
fprintf(fileSHIP,'%f #KB\n',KB);  %-- 
fprintf(fileSHIP,'%f #TKM\n',GM_T);  
fprintf(fileSHIP,'%f #LKM\n',GM_L);  %est
fprintf(fileSHIP,'%f #WSA\n',WSA);  %est
fprintf(fileSHIP,'%f #WPA\n',WPA);  
fprintf(fileSHIP,'%f #MIDA\n',MIDA);  
fprintf(fileSHIP,'%f #Cb\n',Cb);  
fprintf(fileSHIP,'%f #Cp\n',Cp);  %可互相转换
fprintf(fileSHIP,'%f #Cw\n',Cw);  
fprintf(fileSHIP,'%f #Cm\n',Cm);  %可互相转换
fprintf(fileSHIP,'%f #KG\n',zG);  
fprintf(fileSHIP,'%f #G0M\n',G0M);  
fprintf(fileSHIP,'%f #Dp\n',Dp);  % necessary
fprintf(fileSHIP,'%f #Znum\n',Znum);  
fprintf(fileSHIP,'%f #Pitch\n',Pitch);  % necessary
fprintf(fileSHIP,'%f #Panratio\n',PanRatio);
fprintf(fileSHIP,'%f #Pitchratio\n',PitchRatio); 
fprintf(fileSHIP,'%f #wp0;\n',wp0); %est
fprintf(fileSHIP,'%f #tp0;\n',tp0);  %est
fprintf(fileSHIP,'%f #k2;\n',k2);  % necessary
fprintf(fileSHIP,'%f #k1;\n',k1);  % necessary
fprintf(fileSHIP,'%f #k0;\n',k0);  % necessary
fprintf(fileSHIP,'%f #lP;\n',lP);  % -0.5
fprintf(fileSHIP,'%f #zP;\n',zP);  %???est 
fprintf(fileSHIP,'%f #HR\n',HR);  % necessary
fprintf(fileSHIP,'%f #AR\n',AR);  % necessary
fprintf(fileSHIP,'%f #BR\n',BR);  % necessary
fprintf(fileSHIP,'%f #lamdaR\n',lamdaR); %est 
fprintf(fileSHIP,'%f #f_alfa\n',f_alfa); %est 
fprintf(fileSHIP,'%f #tR\n',tR);  %est 
fprintf(fileSHIP,'%f #aH\n',aH);  %est 
fprintf(fileSHIP,'%f #xH\n',xH);  %est 
fprintf(fileSHIP,'%f #xR\n',xR);  %-0.5
fprintf(fileSHIP,'%f #zR\n',zR);  %??est 
fprintf(fileSHIP,'%f #lR\n',lR);  %est -0.9
fprintf(fileSHIP,'%f #kappa\n',kappa); %est 
fprintf(fileSHIP,'%f #eta\n',eta);  %est
fprintf(fileSHIP,'%f #epsilon\n',epsilon);%est
fprintf(fileSHIP,'%f #gammaA\n',gammaA);%est
fprintf(fileSHIP,'%f #gRminus\n',gRminus);%est
fprintf(fileSHIP,'%f #gRplus\n',gRplus); %est
fprintf(fileSHIP,'%f #AF\n',AF);  %est 
fprintf(fileSHIP,'%f #AA\n',AA);  %est 
fprintf(fileSHIP,'%f #AB\n',AB);  %est 
fprintf(fileSHIP,'%f #centAA\n',centAA); 
fprintf(fileSHIP,'%f #centAB\n',centAB); 
fprintf(fileSHIP,'%f #zAB\n',zAB); 
fprintf(fileSHIP,'%f #R0\n', R0);
fclose(fileSHIP);


end