function [ output ] = drawShape( x0,y0,psi0,scale,interval )
% To visulaize the drift angle in time series
% 2019-07-20
% Brief instructions
% 1. INPUT: shipName = the ship basic data stored in XX.mat in 'ship/' folder. 
% 2. The parameters of .SHIP are from 'shipname.mat' and estimation methods.
% 3.. The estimation methods are applied when the parameters is not given in mat(set zero).
% author: Jing Qianfeng

%default shape
shapeX=[0.000000
    -1.311476
    -3.147541
    -7.081969
    -9.704918
    -12.459017
    -14.163935
    -15.475411
    -16.000000
    -16.000000
    -16.000000
    -16.000000
    -16.000000
    -15.737705
    -15.213116
    -14.163935
    -13.639344
    0.000000
    13.639344
    14.163935
    15.213116
    15.737705
    16.000000
    16.000000
    16.000000
    16.000000
    16.000000
    15.475411
    14.163935
    12.459017
    9.704918
    7.081969
    3.147541
    1.311476
    0.000000
    ];
shapeY=[97.000000
    96.466293
    94.331505
    88.193947
    82.323250
    73.250336
    64.444290
    51.368637
    38.559830
    7.605221
    -22.281986
    -41.495193
    -67.646500
    -74.851456
    -82.590096
    -89.261345
    -97.000008
    -97.000008
    -97.000008
    -89.261345
    -82.590096
    -74.851456
    -67.646500
    -41.495193
    -22.281986
    7.605221
    38.559830
    51.368637
    64.444290
    73.250336
    82.323250
    88.193947
    94.331505
    96.466293
    97.000000
    ];

%scale factor
shapeX = shapeX./scale;
shapeY=shapeY./scale;
numShape = length(shapeX);

%interval
x0draw=x0(1:interval:end);
y0draw=y0(1:interval:end);
psi0draw = psi0(1:interval:end);
numPt = length(x0draw);

%points to show
xTR = zeros(numShape,numPt);
yTR = zeros(numShape,numPt);

%move and rotate all shape
for j=1:numPt
    for i=1:numShape
        %move
        xT = shapeX(i)+x0draw(j);
        yT = shapeY(i) + y0draw(j);
        Course = psi0draw(j)*pi / 180;
        shipPos=[x0draw(j),y0draw(j)];
        cc = cos(Course);
        sc = sin(Course);
        xTR(i,j) = (cc*(xT - shipPos(1)) + sc*(yT - shipPos(2)) + shipPos(1));
        yTR(i,j) = (-sc*(xT - shipPos(1)) + cc*(yT - shipPos(2)) + shipPos(1));
    end
end

plot(xTR,yTR,'g');axis equal

%sample
% x = [1 2 3 4 5];
% y = [100 200 300 300 400];
% psi = [10 20 40 90 120];
% drawShape(x,y,psi,100,1 )
