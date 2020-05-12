%T = readtable('../CFD/FinalProject/CFD-Final-Project/cylinder_data_2.csv');
T = readtable('../CFD/FinalProject/CFD-Final-Project/cylinder_data_1_40.csv');
w=40; %define the angular velocity

X = T.Points_0(:);
Y = T.Points_1(:);
P = T.p(:);
r = 0.5; %radius of cylinder

Theta = atan2(Y,X);
for i=1:length(Theta)
    if Theta(i)<0
        Theta(i) = Theta(i) + 2*pi;
    end
end

%resort coordinates and pressure vector according to increasing angle
[Theta, I] = sort(Theta);
X = X(I);
Y = Y(I);
P = P(I);
%we are assuming that the angles are equally spaced
h = Theta(2) - Theta(1);
dTheta = Theta(2:end)-Theta(1:(end-1));

%% calculate the lift using composite simpsons
%add on force components from theta=0 and theta=2pi (which have the same
%pressure value)
Fx = 2*(-P(1)*r*h/3);
Fy = 0; %since sin(0)=0
Test = 2*1*h/3;
for i=2:length(Theta)
    if (mod(i-1,2)==0)
        Fx = Fx - 2*r*P(i)*cos(Theta(i))*(h/3);
        Fy = Fy - 2*r*P(i)*sin(Theta(i))*(h/3);
        Test = Test+2*h/3;
    else
        Fx = Fx - 4*r*P(i)*cos(Theta(i))*(h/3);
        Fy = Fy - 4*r*P(i)*sin(Theta(i))*(h/3);
        Test = Test+4*h/3;
    end
end
TheoreticalLift = 2*pi*r^2*w;
disp('Lift: ' + string(Fy))
disp('Theoretial Lift: ' + string(TheoreticalLift))
disp('Lift Error: ' + string((Fy-TheoreticalLift)/(TheoreticalLift)))
disp('Test error: ' + string((Test-2*pi)/(2*pi)))