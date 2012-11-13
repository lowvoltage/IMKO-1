EESchema Schematic File Version 2  date 13.11.2012 г. 23:54:52
LIBS:74xx
LIBS:conn
LIBS:AY-5-1013A
LIBS:power
LIBS:transistors
LIBS:linear
LIBS:device
LIBS:IMKO-1-IO-cache
EELAYER 25  0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "noname.sch"
Date "13 nov 2012"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 74LS244 U47
U 1 1 506202E9
P 8900 2650
F 0 "U47" H 8950 2450 60  0000 C CNN
F 1 "74LS244" H 9000 2250 60  0000 C CNN
	1    8900 2650
	1    0    0    -1  
$EndComp
$Comp
L 74LS374 U48
U 1 1 50620333
P 8950 4250
F 0 "U48" H 8950 4250 60  0000 C CNN
F 1 "74LS374" H 9000 3900 60  0000 C CNN
	1    8950 4250
	1    0    0    -1  
$EndComp
$Comp
L 74LS75 U46
U 1 1 506203CC
P 8950 5600
F 0 "U46" H 8950 5700 60  0000 C CNN
F 1 "74LS75" H 8950 5500 60  0000 C CNN
	1    8950 5600
	1    0    0    -1  
$EndComp
Text Label 9650 2850 0    60   ~ 0
DB4
Entry Wire Line
	9850 2850 9950 2750
Entry Wire Line
	9850 2750 9950 2650
Text Label 9650 2750 0    60   ~ 0
DB5
Entry Wire Line
	9850 2650 9950 2550
Text Label 9650 2650 0    60   ~ 0
DB6
Entry Wire Line
	9850 2550 9950 2450
Text Label 9650 2550 0    60   ~ 0
DB7
Entry Wire Line
	9850 2450 9950 2350
Text Label 9650 2450 0    60   ~ 0
DB0
Entry Wire Line
	9850 2350 9950 2250
Text Label 9650 2350 0    60   ~ 0
DB2
Entry Wire Line
	9850 2250 9950 2150
Text Label 9650 2250 0    60   ~ 0
DB1
Entry Wire Line
	9850 2150 9950 2050
Text Label 9650 2150 0    60   ~ 0
DB3
$Comp
L DB9 J7
U 1 1 506210AF
P 6950 2450
F 0 "J7" H 6950 3000 70  0000 C CNN
F 1 "DB9" H 6950 1900 70  0000 C CNN
	1    6950 2450
	-1   0    0    -1  
$EndComp
Text Label 8000 2550 0    60   ~ 0
J7.DB7
Text Label 8000 2450 0    60   ~ 0
J7.DB0
Text Label 8000 2350 0    60   ~ 0
J7.DB2
Text Label 8000 2250 0    60   ~ 0
J7.DB1
Text Label 8000 2150 0    60   ~ 0
J7.DB3
Text Label 8000 2650 0    60   ~ 0
J7.DB6
Text Label 8000 2750 0    60   ~ 0
J7.DB5
Text Label 8000 2850 0    60   ~ 0
J7.DB4
$Comp
L DB9 J8
U 1 1 50621612
P 10700 4100
F 0 "J8" H 10700 4650 70  0000 C CNN
F 1 "DB9" H 10700 3550 70  0000 C CNN
	1    10700 4100
	1    0    0    -1  
$EndComp
Entry Wire Line
	7900 4350 8000 4450
Entry Wire Line
	7900 4250 8000 4350
Entry Wire Line
	7900 4150 8000 4250
Entry Wire Line
	7900 4050 8000 4150
Entry Wire Line
	7900 3950 8000 4050
Entry Wire Line
	7900 3850 8000 3950
Entry Wire Line
	7900 3750 8000 3850
Entry Wire Line
	7900 3650 8000 3750
Text Label 8000 3750 0    60   ~ 0
DB7
Text Label 8000 3850 0    60   ~ 0
DB6
Text Label 8000 3950 0    60   ~ 0
DB5
Text Label 8000 4050 0    60   ~ 0
DB4
Text Label 8000 4150 0    60   ~ 0
DB3
Text Label 8000 4250 0    60   ~ 0
DB2
Text Label 8000 4350 0    60   ~ 0
DB1
Text Label 8000 4450 0    60   ~ 0
DB0
Text Label 9650 3750 0    60   ~ 0
J8.DB7
Text Label 9650 3850 0    60   ~ 0
J8.DB6
Text Label 9650 3950 0    60   ~ 0
J8.DB5
Text Label 9650 4050 0    60   ~ 0
J8.DB4
Text Label 9650 4450 0    60   ~ 0
J8.DB0
Text Label 9650 4350 0    60   ~ 0
J8.DB1
Text Label 9650 4250 0    60   ~ 0
J8.DB2
Text Label 9650 4150 0    60   ~ 0
J8.DB3
Wire Wire Line
	9600 2850 9850 2850
Wire Bus Line
	9950 1900 9950 2750
Wire Wire Line
	9600 2750 9850 2750
Wire Wire Line
	9600 2650 9850 2650
Wire Wire Line
	9600 2550 9850 2550
Wire Wire Line
	9600 2450 9850 2450
Wire Wire Line
	9600 2350 9850 2350
Wire Wire Line
	9600 2250 9850 2250
Wire Wire Line
	9600 2150 9850 2150
Wire Wire Line
	8200 3050 8200 3150
Wire Wire Line
	8250 4450 8000 4450
Wire Bus Line
	7900 3500 7900 4350
Wire Wire Line
	8000 3750 8250 3750
Wire Wire Line
	8000 3850 8250 3850
Wire Wire Line
	8000 3950 8250 3950
Wire Wire Line
	8000 4050 8250 4050
Wire Wire Line
	8000 4150 8250 4150
Wire Wire Line
	8000 4250 8250 4250
Wire Wire Line
	8000 4350 8250 4350
Wire Wire Line
	8250 5250 8000 5250
Wire Wire Line
	9650 4450 10000 4450
Wire Wire Line
	10000 4450 10000 4400
Wire Wire Line
	10000 4400 10250 4400
Wire Wire Line
	9650 4350 10100 4350
Wire Wire Line
	10100 4350 10100 4200
Wire Wire Line
	10100 4200 10250 4200
Wire Wire Line
	9650 4250 10050 4250
Wire Wire Line
	10050 4250 10050 4000
Wire Wire Line
	10050 4000 10250 4000
Wire Wire Line
	9650 4150 10000 4150
Wire Wire Line
	10000 4150 10000 3800
Wire Wire Line
	10000 3800 10250 3800
Wire Wire Line
	9650 4050 9950 4050
Wire Wire Line
	9950 4050 9950 3900
Wire Wire Line
	9950 3900 10250 3900
Wire Wire Line
	9650 3950 10150 3950
Wire Wire Line
	10150 3950 10150 4100
Wire Wire Line
	10150 4100 10250 4100
Wire Wire Line
	9650 3850 10200 3850
Wire Wire Line
	10200 3850 10200 4300
Wire Wire Line
	10200 4300 10250 4300
Wire Wire Line
	9650 3750 9900 3750
Wire Wire Line
	9900 3750 9900 4500
Wire Wire Line
	9900 4500 10250 4500
Wire Wire Line
	7400 2850 7950 2850
Wire Wire Line
	7950 2850 7950 2150
Wire Wire Line
	7950 2150 8200 2150
Wire Wire Line
	7400 2450 7750 2450
Wire Wire Line
	7750 2450 7750 2350
Wire Wire Line
	7750 2350 8200 2350
Wire Wire Line
	8200 2450 7800 2450
Wire Wire Line
	7800 2450 7800 2250
Wire Wire Line
	7800 2250 7400 2250
Wire Wire Line
	8200 2550 7700 2550
Wire Wire Line
	7700 2550 7700 2150
Wire Wire Line
	7700 2150 7400 2150
Wire Wire Line
	7400 2650 7850 2650
Wire Wire Line
	7850 2650 7850 2250
Wire Wire Line
	7850 2250 8200 2250
Wire Wire Line
	8200 2650 7900 2650
Wire Wire Line
	7900 2650 7900 2300
Wire Wire Line
	7900 2300 7400 2300
Wire Wire Line
	7400 2300 7400 2350
Wire Wire Line
	7400 2550 7650 2550
Wire Wire Line
	7650 2550 7650 2750
Wire Wire Line
	7650 2750 8200 2750
Wire Wire Line
	8200 2850 8000 2850
Wire Wire Line
	8000 2850 8000 2900
Wire Wire Line
	8000 2900 7450 2900
Wire Wire Line
	7450 2900 7450 2750
Wire Wire Line
	7450 2750 7400 2750
$Comp
L AY-5-1013A U10
U 1 1 506DEA0A
P 5300 4300
F 0 "U10" H 5350 4350 50  0000 C CNN
F 1 "AY-5-1013A" H 5300 4400 50  0000 C CNN
F 2 "MODULE" H 5300 4300 50  0001 C CNN
F 3 "DOCUMENTATION" H 5300 4300 50  0001 C CNN
	1    5300 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	4550 3750 4350 3750
Entry Wire Line
	4250 3650 4350 3750
Wire Bus Line
	4250 3100 4250 4450
Text Label 4400 3750 0    60   ~ 0
DB7
Wire Wire Line
	4550 3850 4350 3850
Wire Wire Line
	4550 3950 4350 3950
Wire Wire Line
	4550 4050 4350 4050
Wire Wire Line
	4550 4150 4350 4150
Wire Wire Line
	4550 4250 4350 4250
Wire Wire Line
	4550 4350 4350 4350
Wire Wire Line
	4550 4450 4350 4450
Entry Wire Line
	4250 3750 4350 3850
Entry Wire Line
	4250 3850 4350 3950
Entry Wire Line
	4250 3950 4350 4050
Entry Wire Line
	4250 4050 4350 4150
Entry Wire Line
	4250 4150 4350 4250
Entry Wire Line
	4250 4250 4350 4350
Entry Wire Line
	4250 4350 4350 4450
Text Label 4400 3850 0    60   ~ 0
DB6
Text Label 4400 3950 0    60   ~ 0
DB5
Text Label 4400 4050 0    60   ~ 0
DB4
Text Label 4400 4150 0    60   ~ 0
DB3
Text Label 4400 4250 0    60   ~ 0
DB2
Text Label 4400 4350 0    60   ~ 0
DB1
Text Label 4400 4450 0    60   ~ 0
DB0
Wire Wire Line
	4550 4550 4350 4550
Entry Wire Line
	4250 4450 4350 4550
Text Label 4400 4550 0    60   ~ 0
DB1
Wire Wire Line
	6050 3350 6400 3350
Wire Wire Line
	6400 3350 6400 5700
Wire Wire Line
	6400 5700 4300 5700
Wire Wire Line
	4300 5700 4300 4950
Wire Wire Line
	4300 4950 4550 4950
$Comp
L DIN_5 P?
U 1 1 50A2BC1A
P 9950 9900
F 0 "P?" H 9950 9900 70  0000 C CNN
F 1 "DIN_5" H 9950 9750 70  0000 C CNN
	1    9950 9900
	1    0    0    -1  
$EndComp
$Comp
L LM555N U?
U 1 1 50A2BD6F
P 4600 9000
F 0 "U?" H 4600 9100 70  0000 C CNN
F 1 "LM555N" H 4600 8900 70  0000 C CNN
	1    4600 9000
	1    0    0    -1  
$EndComp
$Comp
L R R38
U 1 1 50A2BDA2
P 9100 9900
F 0 "R38" V 9180 9900 50  0000 C CNN
F 1 "1k" V 9100 9900 50  0000 C CNN
	1    9100 9900
	0    -1   -1   0   
$EndComp
$Comp
L R R39
U 1 1 50A2BDF3
P 9350 10150
F 0 "R39" V 9430 10150 50  0000 C CNN
F 1 "1k" V 9350 10150 50  0000 C CNN
	1    9350 10150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 50A2BEA4
P 9350 10400
F 0 "#PWR?" H 9350 10400 30  0001 C CNN
F 1 "GND" H 9350 10330 30  0001 C CNN
	1    9350 10400
	1    0    0    -1  
$EndComp
$Comp
L R R36
U 1 1 50A2BEB3
P 8850 10150
F 0 "R36" V 8930 10150 50  0000 C CNN
F 1 "22k" V 8850 10150 50  0000 C CNN
	1    8850 10150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 50A2BECE
P 8850 10400
F 0 "#PWR?" H 8850 10400 30  0001 C CNN
F 1 "GND" H 8850 10330 30  0001 C CNN
	1    8850 10400
	1    0    0    -1  
$EndComp
$Comp
L C C23
U 1 1 50A2BEDD
P 8600 10150
F 0 "C23" H 8650 10250 50  0000 L CNN
F 1 "15nf" H 8650 10050 50  0000 L CNN
	1    8600 10150
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 9950 8600 9900
Wire Wire Line
	8600 9900 8850 9900
$Comp
L GND #PWR?
U 1 1 50A2BF44
P 8600 10400
F 0 "#PWR?" H 8600 10400 30  0001 C CNN
F 1 "GND" H 8600 10330 30  0001 C CNN
	1    8600 10400
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 10400 8600 10350
$Comp
L R R35
U 1 1 50A2BFCB
P 8350 9900
F 0 "R35" V 8430 9900 50  0000 C CNN
F 1 "22k" V 8350 9900 50  0000 C CNN
	1    8350 9900
	0    -1   -1   0   
$EndComp
$Comp
L C C22
U 1 1 50A2BFEB
P 7900 9900
F 0 "C22" H 7950 10000 50  0000 L CNN
F 1 "10nf" H 7950 9800 50  0000 L CNN
	1    7900 9900
	0    -1   -1   0   
$EndComp
$Comp
L 74LS74 U43
U 1 1 50A2C01C
P 6900 9700
F 0 "U43" H 7050 10000 60  0000 C CNN
F 1 "74LS74" H 7200 9405 60  0000 C CNN
	1    6900 9700
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 9500 7700 9500
$Comp
L C C26
U 1 1 50A2C0EE
P 7700 10100
F 0 "C26" H 7750 10200 50  0000 L CNN
F 1 "C" H 7750 10000 50  0000 L CNN
	1    7700 10100
	1    0    0    -1  
$EndComp
$Comp
L BC237 Q?
U 1 1 50A2C109
P 7600 10500
F 0 "Q?" H 7800 10400 50  0000 C CNN
F 1 "BC237" H 7850 10650 50  0000 C CNN
F 2 "TO92-EBC" H 7790 10500 30  0001 C CNN
	1    7600 10500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR?
U 1 1 50A2C11D
P 7700 10750
F 0 "#PWR?" H 7700 10750 30  0001 C CNN
F 1 "GND" H 7700 10680 30  0001 C CNN
	1    7700 10750
	1    0    0    -1  
$EndComp
Wire Wire Line
	7700 10700 7700 10750
$Comp
L 74LS74 U43
U 2 1 50A2C18B
P 6900 10900
F 0 "U43" H 7050 11200 60  0000 C CNN
F 1 "74LS74" H 7200 10605 60  0000 C CNN
	2    6900 10900
	1    0    0    -1  
$EndComp
Wire Wire Line
	7700 9500 7700 9900
Wire Wire Line
	7500 9900 7600 9900
Wire Wire Line
	7600 9900 7600 9300
Wire Wire Line
	7600 9300 6300 9300
Wire Wire Line
	6300 9300 6300 9500
Wire Wire Line
	6300 10700 6150 10700
Wire Wire Line
	6150 10700 6150 11400
Wire Wire Line
	6150 11400 7500 11400
Wire Wire Line
	7500 11400 7500 11100
Wire Wire Line
	6900 11450 7600 11450
Wire Wire Line
	7600 11450 7600 10800
Wire Wire Line
	7600 10800 7300 10800
Wire Wire Line
	7300 10800 7300 10500
Wire Wire Line
	7300 10500 7400 10500
$EndSCHEMATC
