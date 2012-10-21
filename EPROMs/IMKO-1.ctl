;
; DZ80 configuration file for IMKO-1.bin 
;
;
; Labels and comments
;

L 0000 RST0
! 0000 Set stack base at memory address 1470
! 0003 A := 0xAA

L 0008 RST1
L 0010 RST2
L 0018 RST3
L 0020 RST4
L 0028 RST5
L 0030 RST6
L 0038 RST7

L 003E writeToUART
L 003F writeToUARTloop
# 003E
# 003E Waits for "Transmission-buffer empty" (TBMT)
# 003E and outputs the contents of A to the UART (IO address 0x02)
# 003E
! 003E Backup A
! 003F Read UART status byte
! 0041 Check for TBMT flag
! 0043 Jump back if TBMT flag is not set
! 0046 Restore A
! 0047 Write A to UART

L 004E init
L 0084 checkMemLoop
L 008F endOfMem
# 004E
# 004E Continues the system initialization, started in RST0
# 004E This includes:
# 004E * Setting up JMP instructions in RAM for RST3 ~ RST7
# 004E * Setting up JMP instructions in RAM for ????
# 004E * Determining the amount of installed RAM
# 004E * TODO: More
# 004E
! 004E mem[1401] := 0xAA
! 0051 Setup jumps to 0x0174 at memory addesses 1430, 1433, 1436, 1439 and 143C
! 005A Setup jumps to 0x015B at memory addesses 1473, 1476 and 1479 (147C and 147F are not used?)
! 0063 mem[1476] actually jumps to 0x01BF
! 0069 mem[1479] actually jumps to 0x0104
! 006F mem[1402] := 0x02F1 - something to do with timing TODO: What?
! 0075 A := 0x80
! 0077 mem[1472] := 0x80
! 007A Write 0x80 to the parallel-out (IO-3)
! 007C A := 0x00
! 007D Write 0x00 to IO-6
! 007F Write 0x00 to IO-7 TODO: What are these IOs?
! 0081 Set the memory address to 0x14FF, the last of the first 256 bytes of RAM
! 0084 Backup the contents of the current memory address
! 0085 Write A (0x00) to memory
! 0086 Read back from memory and compare with A
! 0087 If values differ, this is an end-of-memory address
! 008A If values are the same, restore memory contents
! 008B Advance to the next memory address
! 008C Jump back and redo the check
! 008F Set 0x00 to the lower byte of the memory address [H, L] 
! 0090 Store the max memory address at mem[1481]
! 009A TODO: Is this line reachable?

L 009B fillMem5
L 009D fillMemLoop
# 009B
# 009B Fills five sets of consecutive memory addresses with "C3 [E] [D]" triplets,
# 009B which decode to "JMP [DE]" instructions 
# 009B
! 009B B := 5
! 009D mem[H++] := 0xC3
! 00A0 mem[H++] := E
! 00A2 mem[H++] := D
! 00A4 --B
! 00A5 Jump back if B != 0

L 00BF cmpDH
# 00BF
# 00BF 16-bit compare of [D, E] and [H, L]
# 00BF
! 00BF Compare the higher bytes, D and H
! 00C1 Return if different
! 00C2 Compare the lower bytes, E and L

L 00C5 delay2047
L 00C9 delay2047Loop
# 00C5
# 00C5 Performs 2047 calls to delay1()
# 00C5 TODO: Actual duration in machine cycles / seconds?
# 00C5
! 00C5 Backup D
! 00C6 D := 2047
! 00CC --D
! 00CD A := High(D) | Low(D)
! 00CF Jump back if D != 0
! 00D2 Restore D

L 014A delay1
L 014D delay1Loop
# 014A
# 014A Performs 256 iterations of a 2x NOP loop
# 014A TODO: Actual duration in machine cycles / seconds?
# 014A
! 014A Backup D
! 014B D := 0
! 014D --D
! 014E 2x NO-OP
! 0150 Jump back if D != 0
! 0153 Restore D

L 01B3 delay1402
L 01B7 delay1402loop
# 01B3
# 01B3 Performs mem[1402] iterations of an empty loop
# 01B3
! 01B3 Backup [H, L]
! 01B4 [H, L] := mem[1402]
! 01B7 Decrement [H, L]
! 01B8 A := H | L
! 01BA Jump back if [H, L] != 0x0000
! 01BD Restore [H, L]

L 01E2 toggleLetterCase
L 01F3 toLowerCase
# 01E2
# 01E2 Switches the case of the Latin letter character stored in A
# 01E2 A <-> a ... Z <-> z, all other characters remain unchanged
# 01E2
! 01E2 If ASCII code is less-than 0x41 ('A'), return unchanged
! 01E5 If code is less-than 0x5B ('['), i.e. an uppercase letter, convert to lowercase and return
! 01EA If ASCII code is less-than 0x61 ('a'), return unchanged
! 01ED If ASCII code is >= 0x7B ('{'), return unchanged
! 01F0 It's a lowercase letter. Convert to uppercase by subtracting 0x20
! 01F3 Convert to lowercase by adding 0x20

# 02AB
# 02AB Does something (output) first with the upper nibble of A, then with the lower nibble of A
# 02AB 

# 02B4
# 02B4 Converts the lower nibble of A from 0x00 ~ 0x0F to a '0' ~ 'F' ASCII char. 
# 02B4 The result remains in A.
# 02B4

L 0E62 readFromUART
# 0E62
# 0E62 Waits for "Data Available" (DAV) and reads the UART data byte to A (IO address 0x04)
# 0E62
! 0E62 Read UART status byte
! 0E64 Check for DAV flag
! 0E66 Jump back if DAV flag is not set
! 0E69 Read UART data byte



;
; Text areas
;
T 037A-037E	; 'READ'
T 0E40-0E46	; 'MORE?'
T 0E47-0E4C	; '\nEND'
T 0E4D-0E50	; 'TO:'
T 0EC0-0EC7	; 'PROGRAM'
T 0EC8-0ED5	; 'HLDEBCASTART:'
T 0ED6-0EDC	; ' ERROR'
T 0EDD-0EFB	; 'FUNCTION? ENTER MONITOR OPTION'
T 0F02-0F0E	; 'FILES FOUND:'
T 0FB2-0FB7	; 'BYTE:'
T 0FB8-0FC9	; 'ITKROM V1.2 \n END:'
T 0FCA-0FCF	; 'PORT:'
T 0FD0-0FDC	; 'TAPE HEADER:'
T 0FDD-0FFB	; 'A  C  B  E  D  L  H  SP   PC \n'

;
; Forced code regions
;
C 009A
C 00BE
C 014F

;
; Ignored regions
;
;I 0400-0BFF	; N/A EPROMs
;I 0FFC-0FFF	; Last four bytes
