
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental C:/CSEE4280Workpace/5_Exercise/Vivado/projectVivado/projectVivado.srcs/utils_1/imports/synth_1/topModule.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2n
lC:/CSEE4280Workpace/5_Exercise/Vivado/projectVivado/projectVivado.srcs/utils_1/imports/synth_1/topModule.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
e
Command: %s
53*	vivadotcl24
2synth_design -top topModule -part xc7a100tcsg324-1Z4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
{
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2

xc7a100tZ17-347h px� 
k
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2

xc7a100tZ17-349h px� 
E
Loading part %s157*device2
xc7a100tcsg324-1Z21-403h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
47108Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:02 ; elapsed = 00:00:06 . Memory (MB): peak = 1050.145 ; gain = 468.969
h px� 
�
*overwriting previous definition of %s '%s'6131*oasys2
module2
pwm2(
$C:/CSEE4280Workpace/5_Exercise/pwm.v2
2248@Z8-9873h px� 
�
2previous definition of design element '%s' is here6195*oasys2
pwm2(
$C:/CSEE4280Workpace/5_Exercise/pwm.v2
2248@Z8-9937h px� 
�
*overwriting previous definition of %s '%s'6131*oasys2
module2
pwm2(
$C:/CSEE4280Workpace/5_Exercise/pwm.v2
2248@Z8-9873h px� 
�
2previous definition of design element '%s' is here6195*oasys2
pwm2(
$C:/CSEE4280Workpace/5_Exercise/pwm.v2
2248@Z8-9937h px� 
�
*overwriting previous definition of %s '%s'6131*oasys2
module2
led2(
$C:/CSEE4280Workpace/5_Exercise/led.v2
1258@Z8-9873h px� 
�
2previous definition of design element '%s' is here6195*oasys2
led2(
$C:/CSEE4280Workpace/5_Exercise/led.v2
1258@Z8-9937h px� 
�
*overwriting previous definition of %s '%s'6131*oasys2
module2
ssd2(
$C:/CSEE4280Workpace/5_Exercise/ssd.v2
308@Z8-9873h px� 
�
2previous definition of design element '%s' is here6195*oasys2
ssd2(
$C:/CSEE4280Workpace/5_Exercise/ssd.v2
308@Z8-9937h px� 
�
synthesizing module '%s'%s4497*oasys2
	topModule2
 2+
'C:/CSEE4280Workpace/5_Exercise/topMod.v2
38@Z8-6157h px� 
|
synthesizing module '%s'%s4497*oasys2
led2
 2(
$C:/CSEE4280Workpace/5_Exercise/led.v2
28@Z8-6157h px� 
|
synthesizing module '%s'%s4497*oasys2
pwm2
 2(
$C:/CSEE4280Workpace/5_Exercise/pwm.v2
28@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
pwm2
 2
02
12(
$C:/CSEE4280Workpace/5_Exercise/pwm.v2
28@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
outRST2
pwm2
rLight2(
$C:/CSEE4280Workpace/5_Exercise/led.v2
368@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
rLight2
pwm2
82
72(
$C:/CSEE4280Workpace/5_Exercise/led.v2
368@Z8-7023h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
outRST2
pwm2
gLight2(
$C:/CSEE4280Workpace/5_Exercise/led.v2
468@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
gLight2
pwm2
82
72(
$C:/CSEE4280Workpace/5_Exercise/led.v2
468@Z8-7023h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
outRST2
pwm2
bLight2(
$C:/CSEE4280Workpace/5_Exercise/led.v2
568@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
bLight2
pwm2
82
72(
$C:/CSEE4280Workpace/5_Exercise/led.v2
568@Z8-7023h px� 
q
default block is never used226*oasys2(
$C:/CSEE4280Workpace/5_Exercise/led.v2
778@Z8-226h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
led2
 2
02
12(
$C:/CSEE4280Workpace/5_Exercise/led.v2
28@Z8-6155h px� 
|
synthesizing module '%s'%s4497*oasys2
ssd2
 2(
$C:/CSEE4280Workpace/5_Exercise/ssd.v2
18@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
ssd2
 2
02
12(
$C:/CSEE4280Workpace/5_Exercise/ssd.v2
18@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	topModule2
 2
02
12+
'C:/CSEE4280Workpace/5_Exercise/topMod.v2
38@Z8-6155h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
	state_reg2(
$C:/CSEE4280Workpace/5_Exercise/pwm.v2
438@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
	state_reg2(
$C:/CSEE4280Workpace/5_Exercise/pwm.v2
508@Z8-6014h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:03 ; elapsed = 00:00:07 . Memory (MB): peak = 1157.051 ; gain = 575.875
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:03 ; elapsed = 00:00:07 . Memory (MB): peak = 1157.051 ; gain = 575.875
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:03 ; elapsed = 00:00:07 . Memory (MB): peak = 1157.051 ; gain = 575.875
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0192

1157.0512
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
|
Parsing XDC File [%s]
179*designutils2;
7C:/CSEE4280Workpace/5_Exercise/Nexys-A7-100T-Master.xdc8Z20-179h px� 
�
No ports matched '%s'.
584*	planAhead2
AN[7]2;
7C:/CSEE4280Workpace/5_Exercise/Nexys-A7-100T-Master.xdc2
728@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property2;
7C:/CSEE4280Workpace/5_Exercise/Nexys-A7-100T-Master.xdc2
728@Z17-55h px�
�
Finished Parsing XDC File [%s]
178*designutils2;
7C:/CSEE4280Workpace/5_Exercise/Nexys-A7-100T-Master.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project29
7C:/CSEE4280Workpace/5_Exercise/Nexys-A7-100T-Master.xdc2
.Xil/topModule_propImpl.xdcZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1245.8282
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.0072

1245.8282
0.000Z17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:07 ; elapsed = 00:00:15 . Memory (MB): peak = 1245.828 ; gain = 664.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Loading part: xc7a100tcsg324-1
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:07 ; elapsed = 00:00:15 . Memory (MB): peak = 1245.828 ; gain = 664.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:07 ; elapsed = 00:00:15 . Memory (MB): peak = 1245.828 ; gain = 664.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:08 ; elapsed = 00:00:15 . Memory (MB): peak = 1245.828 ; gain = 664.652
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   33 Bit       Adders := 18    
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	               33 Bit    Registers := 15    
h p
x
� 
H
%s
*synth20
.	               30 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                7 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                6 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                3 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 11    
h p
x
� 
-
%s
*synth2
+---Multipliers : 
h p
x
� 
F
%s
*synth2.
,	               8x30  Multipliers := 6     
h p
x
� 
F
%s
*synth2.
,	              30x33  Multipliers := 6     
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   7 Input   33 Bit        Muxes := 15    
h p
x
� 
F
%s
*synth2.
,	   2 Input   33 Bit        Muxes := 15    
h p
x
� 
F
%s
*synth2.
,	   2 Input    6 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit        Muxes := 33    
h p
x
� 
F
%s
*synth2.
,	   4 Input    3 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   3 Input    3 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   3 Input    2 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   7 Input    1 Bit        Muxes := 27    
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 4     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
q
%s
*synth2Y
WPart Resources:
DSPs: 240 (col length:80)
BRAMs: 270 (col length: RAMB18 80 RAMB36 40)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
W
%s
*synth2?
=DSP Report: Generating DSP onTime1, operation Mode is: A2*B.
h p
x
� 
U
%s
*synth2=
;DSP Report: register onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
b
%s
*synth2J
HDSP Report: Generating DSP onTime1, operation Mode is: (PCIN>>17)+A2*B.
h p
x
� 
Z
%s
*synth2B
@DSP Report: register tickTime_reg is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
V
%s
*synth2>
<DSP Report: Generating DSP onTime1, operation Mode is: A*B.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
a
%s
*synth2I
GDSP Report: Generating DSP onTime1, operation Mode is: (PCIN>>17)+A*B.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
X
%s
*synth2@
>DSP Report: Generating DSP offTime1, operation Mode is: A*B2.
h p
x
� 
[
%s
*synth2C
ADSP Report: register tickTime_reg is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
c
%s
*synth2K
IDSP Report: Generating DSP offTime1, operation Mode is: (PCIN>>17)+A*B2.
h p
x
� 
[
%s
*synth2C
ADSP Report: register tickTime_reg is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
X
%s
*synth2@
>DSP Report: Generating DSP offTime1, operation Mode is: A2*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: register offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
c
%s
*synth2K
IDSP Report: Generating DSP offTime1, operation Mode is: (PCIN>>17)+A2*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: register offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: Generating DSP offTime1, operation Mode is: A*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
b
%s
*synth2J
HDSP Report: Generating DSP offTime1, operation Mode is: (PCIN>>17)+A*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: Generating DSP offTime1, operation Mode is: A*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
b
%s
*synth2J
HDSP Report: Generating DSP offTime1, operation Mode is: (PCIN>>17)+A*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: Generating DSP onTime1, operation Mode is: A2*B.
h p
x
� 
U
%s
*synth2=
;DSP Report: register onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
b
%s
*synth2J
HDSP Report: Generating DSP onTime1, operation Mode is: (PCIN>>17)+A2*B.
h p
x
� 
U
%s
*synth2=
;DSP Report: register onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
V
%s
*synth2>
<DSP Report: Generating DSP onTime1, operation Mode is: A*B.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
a
%s
*synth2I
GDSP Report: Generating DSP onTime1, operation Mode is: (PCIN>>17)+A*B.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
X
%s
*synth2@
>DSP Report: Generating DSP offTime1, operation Mode is: A*B2.
h p
x
� 
W
%s
*synth2?
=DSP Report: register offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
X
%s
*synth2@
>DSP Report: Generating DSP offTime1, operation Mode is: A2*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: register offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
c
%s
*synth2K
IDSP Report: Generating DSP offTime1, operation Mode is: (PCIN>>17)+A2*B.
h p
x
� 
V
%s
*synth2>
<DSP Report: register onTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: Generating DSP offTime1, operation Mode is: A*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: Generating DSP offTime1, operation Mode is: A*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
b
%s
*synth2J
HDSP Report: Generating DSP offTime1, operation Mode is: (PCIN>>17)+A*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
�
RFound unconnected internal register '%s' and it is trimmed from '%s' to '%s' bits.3455*oasys2	
onTime12
172
162(
$C:/CSEE4280Workpace/5_Exercise/pwm.v2
1318@Z8-3936h px� 
W
%s
*synth2?
=DSP Report: Generating DSP onTime1, operation Mode is: A2*B.
h p
x
� 
U
%s
*synth2=
;DSP Report: register onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
b
%s
*synth2J
HDSP Report: Generating DSP onTime1, operation Mode is: (PCIN>>17)+A2*B.
h p
x
� 
U
%s
*synth2=
;DSP Report: register onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
V
%s
*synth2>
<DSP Report: Generating DSP onTime1, operation Mode is: A*B.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
a
%s
*synth2I
GDSP Report: Generating DSP onTime1, operation Mode is: (PCIN>>17)+A*B.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
U
%s
*synth2=
;DSP Report: operator onTime1 is absorbed into DSP onTime1.
h p
x
� 
X
%s
*synth2@
>DSP Report: Generating DSP offTime1, operation Mode is: A*B2.
h p
x
� 
W
%s
*synth2?
=DSP Report: register offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
X
%s
*synth2@
>DSP Report: Generating DSP offTime1, operation Mode is: A2*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: register offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
c
%s
*synth2K
IDSP Report: Generating DSP offTime1, operation Mode is: (PCIN>>17)+A2*B.
h p
x
� 
V
%s
*synth2>
<DSP Report: register onTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: Generating DSP offTime1, operation Mode is: A*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: Generating DSP offTime1, operation Mode is: A*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
b
%s
*synth2J
HDSP Report: Generating DSP offTime1, operation Mode is: (PCIN>>17)+A*B.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
W
%s
*synth2?
=DSP Report: operator offTime1 is absorbed into DSP offTime1.
h p
x
� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/rDutyCycle_reg__62
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/rDutyCycle_reg__72
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/rDutyCycle_reg__82
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/rDutyCycle_reg__92
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/rDutyCycle_reg__102
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/gDutyCycle_reg__62
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/gDutyCycle_reg__72
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/gDutyCycle_reg__82
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/gDutyCycle_reg__92
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/gDutyCycle_reg__102
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/bDutyCycle_reg__62
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/bDutyCycle_reg__72
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/bDutyCycle_reg__82
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/bDutyCycle_reg__92
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/bDutyCycle_reg__102
	topModuleZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2
leftLED/bDutyCycle_reg__112
	topModuleZ8-3332h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:12 ; elapsed = 00:00:24 . Memory (MB): peak = 1261.297 ; gain = 680.121
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
V
%s
*synth2>
< Sort Area is  offTime1_c : 0 0 : 3119 6173 : Used 1 time 0
h p
x
� 
V
%s
*synth2>
< Sort Area is  offTime1_c : 0 1 : 3054 6173 : Used 1 time 0
h p
x
� 
V
%s
*synth2>
< Sort Area is  offTime1_6 : 0 0 : 3101 6137 : Used 1 time 0
h p
x
� 
V
%s
*synth2>
< Sort Area is  offTime1_6 : 0 1 : 3036 6137 : Used 1 time 0
h p
x
� 
W
%s
*synth2?
= Sort Area is  offTime1_19 : 0 0 : 3119 5120 : Used 1 time 0
h p
x
� 
W
%s
*synth2?
= Sort Area is  offTime1_19 : 0 1 : 2001 5120 : Used 1 time 0
h p
x
� 
W
%s
*synth2?
= Sort Area is  offTime1_21 : 0 0 : 3119 5120 : Used 1 time 0
h p
x
� 
W
%s
*synth2?
= Sort Area is  offTime1_21 : 0 1 : 2001 5120 : Used 1 time 0
h p
x
� 
W
%s
*synth2?
= Sort Area is  offTime1_16 : 0 0 : 3101 5085 : Used 1 time 0
h p
x
� 
W
%s
*synth2?
= Sort Area is  offTime1_16 : 0 1 : 1984 5085 : Used 1 time 0
h p
x
� 
W
%s
*synth2?
= Sort Area is  offTime1_1e : 0 0 : 3101 5085 : Used 1 time 0
h p
x
� 
W
%s
*synth2?
= Sort Area is  offTime1_1e : 0 1 : 1984 5085 : Used 1 time 0
h p
x
� 
V
%s
*synth2>
< Sort Area is  offTime1_f : 0 0 : 2474 4917 : Used 1 time 0
h p
x
� 
V
%s
*synth2>
< Sort Area is  offTime1_f : 0 1 : 2443 4917 : Used 1 time 0
h p
x
� 
V
%s
*synth2>
< Sort Area is  offTime1_9 : 0 0 : 2460 4889 : Used 1 time 0
h p
x
� 
V
%s
*synth2>
< Sort Area is  offTime1_9 : 0 1 : 2429 4889 : Used 1 time 0
h p
x
� 
U
%s
*synth2=
; Sort Area is  onTime1_3 : 0 0 : 1641 3165 : Used 1 time 0
h p
x
� 
U
%s
*synth2=
; Sort Area is  onTime1_3 : 0 1 : 1524 3165 : Used 1 time 0
h p
x
� 
U
%s
*synth2=
; Sort Area is  onTime1_0 : 0 0 : 1623 3133 : Used 1 time 0
h p
x
� 
U
%s
*synth2=
; Sort Area is  onTime1_0 : 0 1 : 1510 3133 : Used 1 time 0
h p
x
� 
V
%s
*synth2>
< Sort Area is  onTime1_14 : 0 0 : 1641 2550 : Used 1 time 0
h p
x
� 
U
%s
*synth2=
; Sort Area is  onTime1_14 : 0 1 : 909 2550 : Used 1 time 0
h p
x
� 
V
%s
*synth2>
< Sort Area is  onTime1_1d : 0 0 : 1641 2550 : Used 1 time 0
h p
x
� 
U
%s
*synth2=
; Sort Area is  onTime1_1d : 0 1 : 909 2550 : Used 1 time 0
h p
x
� 
V
%s
*synth2>
< Sort Area is  onTime1_12 : 0 0 : 1623 2518 : Used 1 time 0
h p
x
� 
U
%s
*synth2=
; Sort Area is  onTime1_12 : 0 1 : 895 2518 : Used 1 time 0
h p
x
� 
V
%s
*synth2>
< Sort Area is  onTime1_1c : 0 0 : 1623 2518 : Used 1 time 0
h p
x
� 
U
%s
*synth2=
; Sort Area is  onTime1_1c : 0 1 : 895 2518 : Used 1 time 0
h p
x
� 
W
%s
*synth2?
= Sort Area is  offTime1_1b : 0 0 : 2474 2474 : Used 1 time 0
h p
x
� 
W
%s
*synth2?
= Sort Area is  offTime1_18 : 0 0 : 2460 2460 : Used 1 time 0
h p
x
� 
W
%s
*synth2?
= Sort Area is  offTime1_22 : 0 0 : 1720 1720 : Used 1 time 0
h p
x
� 
W
%s
*synth2?
= Sort Area is  offTime1_1f : 0 0 : 1706 1706 : Used 1 time 0
h p
x
� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
v
%s*synth2^
\
DSP: Preliminary Mapping Report (see note below. The ' indicates corresponding REG is set)
h px� 
�
%s*synth2�
�+------------+-----------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+
h px� 
�
%s*synth2�
�|Module Name | DSP Mapping     | A Size | B Size | C Size | D Size | P Size | AREG | BREG | CREG | DREG | ADREG | MREG | PREG | 
h px� 
�
%s*synth2�
�+------------+-----------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+
h px� 
�
%s*synth2�
�|pwm         | A2*B            | 18     | 9      | -      | -      | 48     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A2*B | 14     | 9      | -      | -      | 48     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A*B             | 18     | 9      | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A*B  | 14     | 9      | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A*B2            | 18     | 14     | -      | -      | 48     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A*B2 | 17     | 14     | -      | -      | 48     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A2*B            | 18     | 18     | -      | -      | 48     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A2*B | 18     | 17     | -      | -      | 48     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A*B             | 18     | 14     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A*B  | 17     | 14     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A*B             | 18     | 18     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A*B  | 18     | 17     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A2*B            | 18     | 9      | -      | -      | 48     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A2*B | 14     | 9      | -      | -      | 16     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A*B             | 18     | 9      | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A*B  | 14     | 9      | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A*B2            | 18     | 14     | -      | -      | 48     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A2*B            | 18     | 18     | -      | -      | 48     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A2*B | 16     | 16     | -      | -      | 16     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A*B             | 18     | 14     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A*B             | 18     | 18     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A*B  | 16     | 16     | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A2*B            | 18     | 9      | -      | -      | 48     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A2*B | 14     | 9      | -      | -      | 16     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A*B             | 18     | 9      | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A*B  | 14     | 9      | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A*B2            | 16     | 14     | -      | -      | 16     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A2*B            | 18     | 18     | -      | -      | 48     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A2*B | 16     | 16     | -      | -      | 16     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A*B             | 16     | 14     | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | A*B             | 18     | 18     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�|pwm         | (PCIN>>17)+A*B  | 16     | 16     | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h px� 
�
%s*synth2�
�+------------+-----------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+

h px� 
�
%s*synth2�
�Note: The table above is a preliminary report that shows the DSPs inferred at the current stage of the synthesis flow. Some DSP may be reimplemented as non DSP primitives later in the synthesis flow. Multiple instantiated DSPs are reported only once.
h px� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
h px� 
l
%s*synth2T
R---------------------------------------------------------------------------------
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:17 ; elapsed = 00:00:33 . Memory (MB): peak = 1426.859 ; gain = 845.684
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
~Finished Timing Optimization : Time (s): cpu = 00:00:25 ; elapsed = 00:00:49 . Memory (MB): peak = 1604.523 ; gain = 1023.348
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Technology Mapping : Time (s): cpu = 00:00:27 ; elapsed = 00:00:53 . Memory (MB): peak = 1622.512 ; gain = 1041.336
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2y
wFinished IO Insertion : Time (s): cpu = 00:00:29 ; elapsed = 00:00:57 . Memory (MB): peak = 1773.938 ; gain = 1192.762
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:29 ; elapsed = 00:00:57 . Memory (MB): peak = 1773.938 ; gain = 1192.762
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:31 ; elapsed = 00:00:58 . Memory (MB): peak = 1773.938 ; gain = 1192.762
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:31 ; elapsed = 00:00:58 . Memory (MB): peak = 1773.938 ; gain = 1192.762
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:31 ; elapsed = 00:00:58 . Memory (MB): peak = 1773.938 ; gain = 1192.762
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:31 ; elapsed = 00:00:58 . Memory (MB): peak = 1773.938 ; gain = 1192.762
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
W
%s
*synth2?
=
DSP Final Report (the ' indicates corresponding REG is set)
h p
x
� 
�
%s
*synth2�
~+------------+---------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+
h p
x
� 
�
%s
*synth2�
|Module Name | DSP Mapping   | A Size | B Size | C Size | D Size | P Size | AREG | BREG | CREG | DREG | ADREG | MREG | PREG | 
h p
x
� 
�
%s
*synth2�
~+------------+---------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+
h p
x
� 
�
%s
*synth2�
|pwm         | A'*B'         | 7      | 7      | -      | -      | 48     | 1    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | PCIN>>17+A*B' | 0      | 7      | -      | -      | 16     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A*B'          | 7      | 7      | -      | -      | 48     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | PCIN>>17+A*B' | 0      | 7      | -      | -      | 16     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A*B           | 30     | 0      | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A'*B          | 7      | 17     | -      | -      | 48     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | PCIN>>17+A'*B | 7      | 16     | -      | -      | 16     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A*B           | 30     | 0      | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A*B           | 7      | 17     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | PCIN>>17+A*B  | 7      | 16     | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A'*B'         | 7      | 7      | -      | -      | 48     | 1    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | PCIN>>17+A*B' | 0      | 7      | -      | -      | 16     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A*B'          | 7      | 7      | -      | -      | 48     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | PCIN>>17+A*B' | 0      | 7      | -      | -      | 16     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A*B           | 30     | 0      | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A'*B          | 7      | 17     | -      | -      | 48     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | PCIN>>17+A'*B | 7      | 16     | -      | -      | 16     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A*B           | 30     | 0      | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A*B           | 7      | 17     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | PCIN>>17+A*B  | 7      | 16     | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A'*B'         | 7      | 7      | -      | -      | 48     | 1    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | PCIN>>17+A*B' | 0      | 7      | -      | -      | 16     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A*B'          | 7      | 7      | -      | -      | 48     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | PCIN>>17+A*B' | 0      | 7      | -      | -      | 16     | 0    | 1    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A*B           | 30     | 0      | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A'*B          | 7      | 17     | -      | -      | 48     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | PCIN>>17+A'*B | 7      | 16     | -      | -      | 16     | 1    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A*B           | 30     | 0      | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | A*B           | 7      | 17     | -      | -      | 48     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
|pwm         | PCIN>>17+A*B  | 7      | 16     | -      | -      | 16     | 0    | 0    | -    | -    | -     | 0    | 0    | 
h p
x
� 
�
%s
*synth2�
+------------+---------------+--------+--------+--------+--------+--------+------+------+------+------+-------+------+------+

h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
| |BlackBox name |Instances |
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
3
%s*synth2
+------+--------+------+
h px� 
3
%s*synth2
|      |Cell    |Count |
h px� 
3
%s*synth2
+------+--------+------+
h px� 
3
%s*synth2
|1     |BUFG    |     1|
h px� 
3
%s*synth2
|2     |CARRY4  |  1275|
h px� 
3
%s*synth2
|3     |DSP48E1 |    30|
h px� 
3
%s*synth2
|7     |LUT1    |   392|
h px� 
3
%s*synth2
|8     |LUT2    |  1916|
h px� 
3
%s*synth2
|9     |LUT3    |  2203|
h px� 
3
%s*synth2
|10    |LUT4    |  1250|
h px� 
3
%s*synth2
|11    |LUT5    |   570|
h px� 
3
%s*synth2
|12    |LUT6    |  1348|
h px� 
3
%s*synth2
|13    |FDRE    |   234|
h px� 
3
%s*synth2
|14    |IBUF    |    18|
h px� 
3
%s*synth2
|15    |OBUF    |    17|
h px� 
3
%s*synth2
+------+--------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:31 ; elapsed = 00:00:58 . Memory (MB): peak = 1773.938 ; gain = 1192.762
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
a
%s
*synth2I
GSynthesis finished with 0 errors, 0 critical warnings and 18 warnings.
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Runtime : Time (s): cpu = 00:00:27 ; elapsed = 00:00:57 . Memory (MB): peak = 1773.938 ; gain = 1103.984
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:31 ; elapsed = 00:00:59 . Memory (MB): peak = 1773.938 ; gain = 1192.762
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0732

1788.1602
0.000Z17-268h px� 
V
-Analyzing %s Unisim elements for replacement
17*netlist2
1305Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1791.8482
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

e2263e4cZ4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
342
272
52
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:352

00:01:062

1791.8482

1419.844Z17-268h px� 
c
%s6*runtcl2G
ESynthesis results are not added to the cache due to CRITICAL_WARNING
h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0322

1791.8482
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2^
\C:/CSEE4280Workpace/5_Exercise/Vivado/projectVivado/projectVivado.runs/synth_1/topModule.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2]
[report_utilization -file topModule_utilization_synth.rpt -pb topModule_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Thu Feb 13 23:46:13 2025Z17-206h px� 


End Record