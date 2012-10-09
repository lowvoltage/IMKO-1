EESchema Schematic File Version 2  date Tue 09 Oct 2012 10:55:53 PM EEST
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:o_memory
EELAYER 27 0
EELAYER END
$Descr A2 23386 16535
encoding utf-8
Sheet 1 1
Title "noname.sch"
Date "9 oct 2012"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74LS374 U26
U 1 1 507468D3
P 2200 5750
F 0 "U26" H 2200 5750 60  0000 C CNN
F 1 "74LS374" H 2250 5400 60  0000 C CNN
	1    2200 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 5250 1300 5250
Wire Wire Line
	1500 5350 1300 5350
Wire Wire Line
	1500 5450 1300 5450
Wire Wire Line
	1500 5550 1300 5550
Wire Wire Line
	1500 5650 1300 5650
Wire Wire Line
	1500 5750 1300 5750
Wire Wire Line
	1500 5850 1300 5850
Wire Wire Line
	1500 5950 1300 5950
Text Label 1300 5250 0    60   ~ 0
DB2
Text Label 1300 5450 0    60   ~ 0
DB3
Text Label 1300 5550 0    60   ~ 0
DB1
Text Label 1300 5650 0    60   ~ 0
DB0
Text Label 1300 5750 0    60   ~ 0
DB4
Text Label 1300 5350 0    60   ~ 0
DB5
Text Label 1300 5850 0    60   ~ 0
DB6
Text Label 1300 5950 0    60   ~ 0
DB7
$Comp
L 74LS244 U19
U 1 1 50746D0E
P 4750 5750
F 0 "U19" H 4800 5550 60  0000 C CNN
F 1 "74LS244" H 4850 5350 60  0000 C CNN
	1    4750 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2900 5450 4050 5450
Wire Wire Line
	2900 5550 4050 5550
Wire Wire Line
	3350 5650 4050 5650
Wire Wire Line
	3300 5750 4050 5750
Wire Wire Line
	3250 5850 4050 5850
Wire Wire Line
	3700 5950 4050 5950
Wire Wire Line
	3700 5250 4050 5250
Wire Wire Line
	2900 5350 4050 5350
Wire Wire Line
	5450 5250 5750 5250
Text Label 5500 5250 0    60   ~ 0
VID.D6
Wire Wire Line
	5450 5350 5750 5350
Wire Wire Line
	5450 5450 5750 5450
Wire Wire Line
	5450 5550 5750 5550
Wire Wire Line
	5450 5750 5750 5750
Wire Wire Line
	5450 5850 5750 5850
Wire Wire Line
	5450 5950 5750 5950
Text Label 5500 5350 0    60   ~ 0
VID.D5
Text Label 5500 5450 0    60   ~ 0
VID.D3
Text Label 5500 5550 0    60   ~ 0
VID.D1
Text Label 5500 5750 0    60   ~ 0
VID.D2
Text Label 5500 5850 0    60   ~ 0
VID.D0
Text Label 5500 5950 0    60   ~ 0
VID.D4
Wire Wire Line
	4050 6150 4000 6150
Wire Wire Line
	4000 6150 4000 6250
Wire Wire Line
	4000 6250 4050 6250
$Comp
L 74LS244 U20
U 1 1 50746FB2
P 2500 7300
F 0 "U20" H 2550 7100 60  0000 C CNN
F 1 "74LS244" H 2600 6900 60  0000 C CNN
	1    2500 7300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1800 7000 1450 7000
Text Label 1550 7000 0    60   ~ 0
DB3
Text Label 1550 7100 0    60   ~ 0
DB1
Wire Wire Line
	1800 7100 1450 7100
Text Label 1550 7400 0    60   ~ 0
DB0
Wire Wire Line
	1450 7200 1800 7200
Wire Wire Line
	1450 7300 1800 7300
Wire Wire Line
	1450 7400 1800 7400
Wire Wire Line
	1450 7500 1800 7500
Wire Wire Line
	1450 6800 1800 6800
Wire Wire Line
	1450 6900 1800 6900
Text Label 1550 7300 0    60   ~ 0
DB2
Text Label 1550 6900 0    60   ~ 0
DB5
Text Label 1550 6800 0    60   ~ 0
DB6
Text Label 1550 7500 0    60   ~ 0
DB4
Text Label 1500 7200 0    60   ~ 0
~MEMW
Wire Wire Line
	3200 6800 3500 6800
Text Label 3250 6800 0    60   ~ 0
VID.D6
Wire Wire Line
	3200 6900 3500 6900
Wire Wire Line
	3200 7000 3500 7000
Wire Wire Line
	3200 7100 3500 7100
Wire Wire Line
	3200 7200 3900 7200
Wire Wire Line
	3900 7200 4450 7200
Wire Wire Line
	3200 7300 3500 7300
Wire Wire Line
	3200 7400 3500 7400
Wire Wire Line
	3200 7500 3500 7500
Text Label 3250 6900 0    60   ~ 0
VID.D5
Text Label 3250 7000 0    60   ~ 0
VID.D3
Text Label 3250 7100 0    60   ~ 0
VID.D1
Text Label 3250 7300 0    60   ~ 0
VID.D2
Text Label 3250 7400 0    60   ~ 0
VID.D0
Text Label 3250 7500 0    60   ~ 0
VID.D4
Wire Wire Line
	1800 7700 1750 7700
Wire Wire Line
	1750 7700 1750 7800
Wire Wire Line
	1750 7800 1800 7800
Text Label 3250 7200 0    60   ~ 0
~VID.MEMW
$Comp
L R R16
U 1 1 507470A6
P 3900 6900
F 0 "R16" V 3980 6900 50  0000 C CNN
F 1 "1k" V 3900 6900 50  0000 C CNN
	1    3900 6900
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR01
U 1 1 507470C1
P 3900 6600
F 0 "#PWR01" H 3900 6700 30  0001 C CNN
F 1 "VCC" H 3900 6700 30  0000 C CNN
	1    3900 6600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3900 6600 3900 6650
Wire Wire Line
	3900 7200 3900 7150
Connection ~ 3900 7200
Text Notes 4250 7200 0    60   ~ 0
TODO: To video RAM
Text Notes 1450 7750 0    60   ~ 0
TODO
Wire Wire Line
	2900 5950 3350 5950
Wire Wire Line
	3350 5950 3350 5650
Wire Wire Line
	2900 5250 3300 5250
Wire Wire Line
	3300 5250 3300 5750
Wire Wire Line
	2900 5650 3250 5650
Wire Wire Line
	3250 5650 3250 5850
Wire Wire Line
	2900 5750 3200 5750
Wire Wire Line
	3200 5750 3200 6050
Wire Wire Line
	3200 6050 3700 6050
Wire Wire Line
	3700 6050 3700 5950
Wire Wire Line
	2900 5850 3100 5850
Wire Wire Line
	3100 5850 3100 5150
Wire Wire Line
	3100 5150 3700 5150
Wire Wire Line
	3700 5150 3700 5250
$Comp
L VCC #PWR02
U 1 1 50747698
P 4000 7800
F 0 "#PWR02" H 4000 7900 30  0001 C CNN
F 1 "VCC" H 4000 7900 30  0000 C CNN
	1    4000 7800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR03
U 1 1 507476A0
P 4300 8050
F 0 "#PWR03" H 4300 8050 30  0001 C CNN
F 1 "GND" H 4300 7980 30  0001 C CNN
	1    4300 8050
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG04
U 1 1 507476AF
P 4300 7950
F 0 "#FLG04" H 4300 8045 30  0001 C CNN
F 1 "PWR_FLAG" H 4300 8130 30  0000 C CNN
	1    4300 7950
	1    0    0    -1  
$EndComp
$Comp
L PWR_FLAG #FLG05
U 1 1 507476BC
P 4000 7950
F 0 "#FLG05" H 4000 8045 30  0001 C CNN
F 1 "PWR_FLAG" H 4000 8130 30  0000 C CNN
	1    4000 7950
	-1   0    0    1   
$EndComp
Wire Wire Line
	4000 7950 4000 7800
Wire Wire Line
	4300 7950 4300 8050
Text Notes 5900 5650 0    60   ~ 0
TODO: No D7?
NoConn ~ 5450 5650
$Comp
L GND #PWR06
U 1 1 507478B6
P 1450 6300
F 0 "#PWR06" H 1450 6300 30  0001 C CNN
F 1 "GND" H 1450 6230 30  0001 C CNN
	1    1450 6300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1500 6250 1450 6250
Wire Wire Line
	1450 6250 1450 6300
$Comp
L 82S129 U18
U 1 1 50747E39
P 4650 4050
F 0 "U18" H 4650 4700 60  0000 C CNN
F 1 "82S129" H 4650 3400 60  0000 C CNN
F 4 "128" H 4650 4050 60  0000 C CNN "Field11"
	1    4650 4050
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 3550 3800 3550
Wire Wire Line
	4050 3650 3800 3650
Wire Wire Line
	4050 3750 3800 3750
Wire Wire Line
	4050 3850 3800 3850
Wire Wire Line
	4050 3950 3800 3950
Wire Wire Line
	4050 4050 3800 4050
Wire Wire Line
	4050 4150 3800 4150
Text Label 3800 5250 0    60   ~ 0
V.D6
Text Label 3800 5350 0    60   ~ 0
V.D5
Text Label 3800 5450 0    60   ~ 0
V.D3
Text Label 3800 5550 0    60   ~ 0
V.D1
Text Label 3800 5750 0    60   ~ 0
V.D2
Text Label 3800 5850 0    60   ~ 0
V.D0
Text Label 3800 5950 0    60   ~ 0
V.D4
$Comp
L GND #PWR?
U 1 1 50747FE3
P 4000 4600
F 0 "#PWR?" H 4000 4600 30  0001 C CNN
F 1 "GND" H 4000 4530 30  0001 C CNN
	1    4000 4600
	1    0    0    -1  
$EndComp
Wire Wire Line
	4050 4250 4000 4250
Wire Wire Line
	4000 4250 4000 4450
Wire Wire Line
	4000 4450 4000 4550
Wire Wire Line
	4000 4550 4000 4600
Wire Wire Line
	4050 4450 4000 4450
Connection ~ 4000 4450
Wire Wire Line
	4050 4550 4000 4550
Connection ~ 4000 4550
Text Label 3800 5650 0    60   ~ 0
V.D7
Text Label 3800 3750 0    60   ~ 0
V.D2
Text Label 3800 3550 0    60   ~ 0
V.D0
Text Label 3800 3950 0    60   ~ 0
V.D4
Text Label 3800 3650 0    60   ~ 0
V.D1
Text Label 3800 3850 0    60   ~ 0
V.D3
Text Label 3800 4050 0    60   ~ 0
V.D5
Text Label 3800 4150 0    60   ~ 0
V.D6
$EndSCHEMATC
