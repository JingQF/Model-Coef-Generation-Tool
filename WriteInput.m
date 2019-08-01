function [ shipFile,shipCoef ] = WriteInput( shipName, hullNonX, hullLinYN , hullNonYN, fileOutput)
% To write the '.SHIP' and '.COEF' file for the input of simulation model.
% 2019-07-20
% Brief instructions:
% 1. INPUT: (1) shipName = the ship basic data stored in XX.mat in 'ship/' folder. 
%               (2) hullMethod = the estimation method selected for hull coefficients
% 2. Run the script of 'shipname' at first to write the shipname.mat
% 3. Call the CalStaticCoef and CallHullCoef
% Version: 1.1
% Author: Jing Qianfeng 

%make mat
disp('¡¤ Step 1 : Run the shipName.m script  ->  create shipName.mat' );
eval(shipName);

%input check
hullNonX = 5;
hullLinYN = 11;
hullNonYN = 8;


%write SHIP
[ shipFile ] = CalStaticCoef( shipName, fileOutput );
%write COEF
[ shipCoef ] = CalHullCoef( shipName, hullNonX, hullLinYN, hullNonYN, fileOutput );


