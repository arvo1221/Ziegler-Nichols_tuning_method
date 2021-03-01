# Ziegler-Nichols_tuning_method
PID Control Simulation for 2-DOF Robot Manipulator 

<img src="https://user-images.githubusercontent.com/54099930/109504364-d207ff80-7ade-11eb-95ac-ff875979cc07.jpg" width="550">

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

<img src="https://user-images.githubusercontent.com/54099930/109508500-4644a200-7ae3-11eb-915d-6f0e17f532ba.jpg" width="450">

