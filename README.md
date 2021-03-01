# Ziegler-Nichols_tuning_method
PID Control Simulation for 2-DOF Robot Manipulator 

<img src="https://user-images.githubusercontent.com/54099930/109504364-d207ff80-7ade-11eb-95ac-ff875979cc07.jpg" width="550">

![opi](https://user-images.githubusercontent.com/54099930/109515807-db976480-7aea-11eb-8f8a-24683b5d026e.gif)

## 2-Link Robot Arm Dynamics(RR)
Lagrangian mechanics를 사용하여 Manipulator Dynamics를 풀이한다.
각 Joint의 위치를 (x1,y1), (x2,y2)로 정의하고 이를 데카르트 좌표계로 나타내면

<img src="https://user-images.githubusercontent.com/54099930/109504886-62464480-7adf-11eb-8155-3a57728ed130.jpg" width="480">

Kinetic Energy 와 Potential Energy를 구한 뒤 Lagrangian을 풀이하면

<img src="https://user-images.githubusercontent.com/54099930/109505738-44c5aa80-7ae0-11eb-9d0f-a9135214a228.jpg" width="850">

위와 같이 나타낼 수 있다. 이 때 H는 Inertia C는 Coriolis G는 중력에 대한 텀이다.

두 Joint의 각도를 제어하고자 한다. 이 때 PID 제어기만으로는 오차가 발생하는데, 이는 비선형 시스템에 선형 제어기를 사용하기 때문이다. 오차를 삭제하기 위해서는 비선형 요소를 선형화 한 뒤 PID 제어기를 사용해야 한다.

## ziegler-nichols tuning method

PID 제어기를 구성하는데 있어서 적절한 gain을 구하는 것은 필수적이다. 적절한 gain을 구하여야 system이 stable 하며 사용자가 원하는 성능을 출력할 수 있기 때문이다.
Ziegler-Nichols Tuning Method는 제어기의 파라미터를 선정하는 방법 중 하나로 실제 제어 시스템에서 몇 차례의 사전 실험을 진행하고, 실험 결과를 사용하여 gain을 선정하는 실험적 방법이다. 단 모든 시스템에서 stable하지 않으며, 최적의 성능 또한 보장하지 않는다. 추가로 최대 25%의 Overshoot이 발생할 수 있음을 인지해야 한다.

<img src="https://user-images.githubusercontent.com/54099930/109508500-4644a200-7ae3-11eb-915d-6f0e17f532ba.jpg" width="580">

### First method

step response를 사용하는 방법으로, 적분기가 없고, stable한 system에서 적용이 가능하다. S형태로 특정 값에 수렴하지 못하고 발산하거나, 감소한 상태로 수렴한다면 gain을 선정할 수 없다. S형태의 모습을 나타내면 다음과 같은 방법으로 선정할 수 있다. 우선 그래프의 변곡점 다시 말해 이계도 함수가 0이 되는 시간t를 계산한 다음 그래프에서 (t,y)를 지나가는 접선의 방정식을 구한다. 이 때 접선이므로 기울기는 그래프의 1차 미분 함수에 t를 대입하여 구할 수 있다. 접선의 방정식과 시간축의 교점의 좌표를 계산할 수 있는데 이 때 교점의 시간축은 L 시스템이 시간이 충분히 흘러 수렴할 때의 값을 K 접선의 방정식의 y가 K가 되는 시간에서 L을 뺀 값이 T 이다. 여기서 구한 3개의 값을 좌측의 표를 사용하여 gain을 구한다.

2-DOF Robot Manipulator에 적용해보면

<img src="https://user-images.githubusercontent.com/54099930/109509531-53ae5c00-7ae4-11eb-8aea-a0826877c892.jpg" width="580">

수렴하지 못하는 모습을 확인할 수 있다. 따라서 위의 방법으로는 제어기의 gain을 구할 수 없다.

### Second method

Ki와 Kd를 0으로 설정한 뒤 P Gain을 조절하며 출력이 일정하게 진동하도록 한다. 이 때 시스템의 출력이 발산하지 않고, 진동하는 최댓값인 Ku(Kcr)를 찾는다. 출력의 진동 주기인 Tu(Pcr)를 찾는다. 두 개의 값을 구하면 우측의 표에 대입하여 P,I,D 이득값을 선정한다. 만약 어떠한 Kp에서도 진동하지 않는다면 gain을 구할 수 없다.

2-DOF Robot Manipulator에 적용해보면

<img src="https://user-images.githubusercontent.com/54099930/109511962-f2d45300-7ae6-11eb-96f8-1c7621a65250.jpg" width="580">
<img src="https://user-images.githubusercontent.com/54099930/109512055-097aaa00-7ae7-11eb-8e00-cf389a3031d9.jpg" width="580">

Ku는 1050으로 선정한다. 이 때 Tu = 1.99-1.77 = 0.22
따라서 Kp = 630 Ki = 0.11 Kd = 0.0275로 선정할 수 있다. 이 때 Joint의 Desired Angle을 pi/6으로 설정하면

<img src="https://user-images.githubusercontent.com/54099930/109512677-b0f7dc80-7ae7-11eb-82de-5c9c3d62a8db.jpg" width="580">

진동하는 모습을 확인할 수 있다. 다시 말해 Z-N tuning method로 gain 선정에 실패했음을 알 수 있다.

### Trial and Error

Ziegler-Nichols_tuning_method는 gain 선정 방법 중 하나일 뿐 모든 시스템의 stable을 유도하는 방법은 아니다. 하지만 실험을 통해 구한 gain을 활용하여 제어기를 튜닝하면 더 적은 시행착오로 gain을 구할 수 있다. second method에서 구한 gain을 활용하여 제어기를 완성해본다.

시스템이 계속해서 진동하므로 Kp는 이보다 작게 선정하며, Ki와 Kd는 더 큰 값을 사용한다. 단. 위 실험에서 Ki가 Kd보다 큰 값을 사용했으며, Kd는 고주파 노이즈에 취약한 점을 고려해야 한다.
Kp = 315 , Ki = 84.0829, Kd = 17.9 를 사용하면

1) desired q1 = 0 desired q2 = pi/2

<img src="https://user-images.githubusercontent.com/54099930/109515807-db976480-7aea-11eb-8f8a-24683b5d026e.gif" width="600">
<img src="https://user-images.githubusercontent.com/54099930/109515920-fa95f680-7aea-11eb-9445-aaea48f4aeac.jpg" width="660">

2) desired q1,q2 = -0.05pisin(0.75pi*t)

<img src="https://user-images.githubusercontent.com/54099930/109515869-ebaf4400-7aea-11eb-9265-e250ab17036d.gif" width="600">
<img src="https://user-images.githubusercontent.com/54099930/109516010-10a3b700-7aeb-11eb-8aaa-8533fc6cabac.jpg" width="660">

