clc

X = [0,0,0,0] ;
Y = [0,0,0,0] ;
l4 = 1.72;
l3 = 3.7;
l2 = 1.72;
l1 = 4.44;
theta1 = 0;
theta2 = 36;
A = 2*l1*l4*cosd(theta1)-2*l2*l4*cosd(theta2);
B = 2*l1*l4*sind(theta1)-2*l2*l4*sind(theta2);
C = l1^2 + l2^2 + l4^2 - l3^2 - 2*l1*l2*(cosd(theta1)*cosd(theta2)+sind(theta1)*sind(theta2));
theta3 = 2*atand((-B + sqrt(B^2 - C^2 + A^2))/(C-A))
%theta3 = 313;
theta4 = 69.47;
X(2) = l2*cosd(theta2) 
Y(2) = l2*sind(theta2)
X(3) = X(2) + l3*cosd(theta3) 
Y(3) = Y(2) + l3*sind(theta3)
X(4) = X(3) + l4*cosd(theta4)
Y(4) = Y(3) + l4*sind(theta4)

plot(X,Y);
