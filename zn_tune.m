%zn second method 2
%{
close all;
home

s_time = 0.005;
tf = 5;
qd1 = -pi/2; qd2 = 0;
e1 = 0; e2 = 0; e1dot = 0; e2dot = 0; e1int = 0; e2int = 0;
q1_old = -pi/2; qdot1_old = 0;
q2_old = 0; qdot2_old = 0;
Ku = 1050
Tu = 0.22
Kp = Ku*0.6; Kd = Tu/8; Ki = Tu/2;
Kp = Ku; Kd = 0; Ki = 0;

global m1 m2 l1 l2 g u1 u2;
m1 = 1.; m2 = 1.; l1 = 1.; l2=1.; g=9.806; n = 0;

x1 = l1*cos(q1_old);
y1 = l1*sin(q1_old);
x2 = l1*cos(q1_old) + l2*cos(q1_old+q2_old);
y2 = l1*sin(q1_old) + l2*sin(q1_old+q2_old);

figure;
hold on;
axis([-2.5 2.5 -2.5 2.5]);
grid;

Ax1 = [0, x1];
Ay1 = [0, y1];
p1 = line(Ax1,Ay1, 'LineWidth',5,'Color','g');

Ax2 = [x1, x2];
Ay2 = [y1, y2];
p2 = line(Ax2,Ay2, 'LineWidth',4,'Color','b');
for i = 0:s_time:tf
    qd1 = -pi/2;
    qd2 = pi/2;
    e1 = qd1 - q1_old;
    e2 = qd2 - q2_old;
    e1dot = -qdot1_old;
    e2dot = -qdot2_old;
    e1int = e1int + e1*s_time;
    e2int = e2int + e2*s_time;
    
    u1 = Kp*e1 + Ki*e1int + Kd*e1dot;
    u2 = Kp*e2 + Ki*e2int + Kd*e2dot;
    [t,y] = ode45('TwoLinkRobot',[i,i+s_time],[q1_old,q2_old,qdot1_old,qdot2_old]);
    index = size(y);
    q1_old = y(index(1),1);
    q2_old = y(index(1),2);
    qdot1_old = y(index(1),3);
    qdot2_old = y(index(1),4);

    x1 = l1*cos(q1_old);
    y1 = l1*sin(q1_old);
    x2 = l1*cos(q1_old) + l2*cos(q1_old+q2_old);
    y2 = l1*sin(q1_old) + l2*sin(q1_old+q2_old);
    
    Ax1 = [0, x1];
    Ay1 = [0, y1];
    Ax2 = [x1, x2];
    Ay2 = [y1, y2];
    %{
    if rem(n,10) == 0
        set(p1,'X',Ax1,'Y',Ay1);
        set(p2,'X',Ax2,'Y',Ay2);
        drawnow;
    end
    %}
    n = n+1;
    time_s(n,:) = i;
    q2_s(n,:) = q2_old;
    q2_target(n,:) = qd2;
    e2_s(n,:) = qd2-q2_old;
    
end
data = [time_s,q2_s];
graph2 = figure;
plot(time_s,q2_s)
hold on;
grid on;
plot(time_s,q2_target);
title('Kp is : '+ string(Kp));
%}
close all;
home

s_time = 0.005;
tf = 10;
qd1 = 0; qd2 = 0;
e1 = 0; e2 = 0; e1dot = 0; e2dot = 0; e1int = 0; e2int = 0;
q1_old = 0; qdot1_old = 0;
q2_old = 0; qdot2_old = 0;

Kp = 315; Kd = 17.9; Ki = 84.0829;

global m1 m2 l1 l2 g u1 u2;
m1 = 1.; m2 = 1.; l1 = 1.; l2=1.; g=9.806; n = 0;

x1 = l1*cos(q1_old);
y1 = l1*sin(q1_old);
x2 = l1*cos(q1_old) + l2*cos(q1_old+q2_old);
y2 = l1*sin(q1_old) + l2*sin(q1_old+q2_old);

figure;
hold on;
axis([-2.5 2.5 -2.5 2.5]);
grid;

Ax1 = [0, x1];
Ay1 = [0, y1];
p1 = line(Ax1,Ay1, 'LineWidth',5,'Color','g');

Ax2 = [x1, x2];
Ay2 = [y1, y2];

p2 = line(Ax2,Ay2, 'LineWidth',4,'Color','b');
for i = 0:s_time:tf
    w = 0.75*pi;
    %{
    qd1 = 0;
    qd2 = pi/2;
    e1 = qd1 - q1_old;
    e2 = qd2 - q2_old;
    e1dot = -qdot1_old;
    e2dot = -qdot2_old;
    e1int = e1int + e1*s_time;
    e2int = e2int + e2*s_time;
    %}
    
    qd1 = -0.05*pi*sin(w*i);
    qd2 = -0.05*pi*sin(w*i);
    e1 =  qd1 -q1_old;
    e2 =  qd2 -q2_old;
    e1dot = -0.05*pi*w*cos(w*i) -qdot1_old;
    e2dot = -0.05*pi*w*cos(w*i) -qdot2_old;
    e1int = e1int + e1*s_time;
    e2int = e2int + e2*s_time;
    
    u1 = Kp*e1 + Ki*e1int + Kd*e1dot;
    u2 = Kp*e2 + Ki*e2int + Kd*e2dot;
    [t,y] = ode45('TwoLinkRobot',[i,i+s_time],[q1_old,q2_old,qdot1_old,qdot2_old]);
    index = size(y);
    q1_old = y(index(1),1);
    q2_old = y(index(1),2);
    qdot1_old = y(index(1),3);
    qdot2_old = y(index(1),4);

    x1 = l1*cos(q1_old);
    y1 = l1*sin(q1_old);
    x2 = l1*cos(q1_old) + l2*cos(q1_old+q2_old);
    y2 = l1*sin(q1_old) + l2*sin(q1_old+q2_old);
    
    Ax1 = [0, x1];
    Ay1 = [0, y1];
    Ax2 = [x1, x2];
    Ay2 = [y1, y2];
    
    if rem(n,2) == 0
        set(p1,'X',Ax1,'Y',Ay1);
        set(p2,'X',Ax2,'Y',Ay2);
        drawnow;
    end
    n = n+1;
    time_s(n,:) = i;
    q1_s(n,:) = q1_old;
    q2_s(n,:) = q2_old;
    q1_target(n,:) = qd1;
    q2_target(n,:) = qd2;
    e1_s(n,:) = qd1-q1_old;
    e2_s(n,:) = qd2-q2_old;
    
end

graph2 = figure;
subplot(2,2,1);
plot(time_s,q1_s);
hold on;
plot(time_s,q1_target)
legend('current q1','desire q1');
grid on;
hold off;
axis([0 tf -0.4 0.4])

subplot(2,2,2);
plot(time_s,q2_s);
hold on;
plot(time_s,q2_target)
legend('current q2','desire q2');
grid on;
hold off;
axis([0 tf -0.4 0.4])

subplot(2,2,3)
plot(time_s,e1_s);
hold off;
grid on;
axis([0 tf -0.2 0.2])
legend('q1 error');

subplot(2,2,4)
plot(time_s,e2_s);
hold off;
grid on;
axis([0 tf -0.2 0.2])
legend('q2 error');
