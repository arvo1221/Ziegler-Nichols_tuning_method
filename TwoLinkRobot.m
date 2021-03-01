function dydt = TwoLinkRobot(t,y)

global m1 m2 l1 l2 g u1 u2;

H11 = (m1+m2)*l1^2 + m2*l2^2 + 2*m2*l1*l2*cos(y(2));
H12 = m2*l2^2 + m2*l1*l2*cos(y(2));
H21 = m2*l2^2 + m2*l1*l2*cos(y(2));
H22 = m2*l2^2;

C1 = -m2*l1*l2*sin(y(2))*(2*y(3)*y(4)+y(4)^2);
C2 = -m2*l1*l2*sin(y(2))*y(3)*y(4);

G1 = (m1+m2)*g*l1*cos(y(1))+m2*g*l2*cos(y(1)+y(2));
G2 = m2*g*l2*cos(y(1)+y(2));

H = [H11 H12; H21 H22];
C = [C1; C2];
G = [G1; G2];

tau_f = [0.5*sign(y(3)); 0.5*sign(y(4))];
tau = [u1 ; u2];

dydt = [y(3);y(4);H\(tau -C-G-tau_f)];
;


