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
%   Version: 1.0  
%   First release: 2019-07-22  
%   Author: Jing QF 
%   
%
%   This program comes with ABSOLUTELY NO WARRANTY. 

disp('，-，-，-，-，-，-，-，-，-，-，-，-，-，-，-，-，-，-，-，-');
disp(' ￥ Maneuvering Simulation Input Files Generation ￥ ');
disp(' ￥ Detailed information please refer to <a href = "...">My Github Website</a> ￥ ');
disp('，-，-，-，-，-，-，-，-，-，-，-，-，-，-，-，-，-，-，-，-');


% Create .SHIP and .COEF for specfic ship
% xxxx is your shipName
[ shipFile,shipCoef ] = WriteInput( 'XXXXX','1', '2', '3' );

%Select hydrodynamic coefficients
%developing..

