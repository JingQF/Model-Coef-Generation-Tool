%   ------- Ship Maneuvering Model Coefficients Generation Tool -------
%   
%   The program aim to compare the existing estimation method 
%   of both linear and non-linear hydrodynamic coefficients and 
%   generate input file (.SHIP, .COEF) for c++ simulation code. 
%   Basic framework is shown below:
%   1. Write shipname.mat
%   2. Write static.SHIP
%   3. Write hull.COEF
%   4. Write waveforce.WAVE
%   5. Visualization of simulation results (refer to )
%   6. Cal factors and cretia of Turning and Zigzag (refer to )
%
%   Version: 1.1  
%   Revised: 2019-07-31  
%   Author: Jing QF 
%   
%
%   This program comes with ABSOLUTELY NO WARRANTY. 

disp('·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-');
disp(' ★ Maneuvering Simulation Input Files Generation ★ ');
%disp(' ★ Detailed information please refer to <a href = "https://github.com/jqf64078/Model-Coef-Generation-Tool">My Github Website</a> ★ ');
disp('·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-·-');

shipName = 'Clipper_Full';
timeCreate=datevec(datestr(now));
month = num2str(timeCreate(2));
day = num2str(timeCreate(3));
hor = num2str(timeCreate(4));
mint = num2str(timeCreate(5));
secd = num2str(timeCreate(6));
OutFolder = ['result/',shipName,'_',month,'_',day,'_',hor,'_',mint,'_',secd];

disp(['·Result folder: ',OutFolder]);
% Create .SHIP and .COEF for specfic ship
NonX_method = 1;
LinYN_method = 1; 
NonYN_method= 1;
[ shipFile,shipCoef ] = WriteInput( shipName,NonX_method, LinYN_method, NonYN_method ,OutFolder);

%Select hydrodynamic coefficients



% Instruction for method
% X 方向非线性
% Non-linear X Method
% 1.   uvr - Yang Yansheng 1983
% 2.   uvr - Norihiro Matsumoto 1983
% 3.   uvr - Kazuhiko Hasegawa 1980
% 4.   uvr - Kijima Katsuro 1990
% 5.   uvr - Tae-II Lee 2003
% 6.   /   - Kang_2007 
% Df.  uvr - Yang Yansheng 1983
% 
% 
% YN 方向线性
% Linear YN Method
% 1.   uvr - JS_Yang_1981
% 2.   br  - JS_1981
% 3.   uvr - WS_197X
% 4.   uvr - NB_1970
% 5.   uvr - CK_1983
% 6.   br  - KJ_1990
% 7.   br  - KJ_2002
% 8.   uvr - Lee_2003
% 9.   uvr - VA_2006
% 10.  br  - YandM_2003
% 11.  br  - Ma_1993
% Df.  uvr - JS_Yang_1981
% 
% YN 方向非线性
% Non-linear YN Method
% 1.   uvr - ZZM_1983
% 2.   uvr - LW_1985
% 3.   uvr - LZJ_1987
% 4.   br  - KJ_1990
% 5.   br  - KJ_2002
% 6.   br  - Ma_1993
% 7.   /   - Kang_2007
% 8.   uvr - Lee_2003
% Df.  uvr - LZJ_1987
% 
% 注：如果选择了YN = 7，那么nonX输出的值就不再考虑，直接设为0

